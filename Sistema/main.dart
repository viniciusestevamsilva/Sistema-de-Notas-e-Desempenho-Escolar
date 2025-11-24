import 'dart:io';

void main() {
  List<Map<String, dynamic>> alunos = [];

  while (true) {
    print('//' * 70);
    print('\n Gestor de Alunos \n');
    print('==' * 70);
    print('A → Cadastrar Alunos e Notas');
    print('S → Visualisar Alunos');
    print('D → Situação do Aluno');
    print('E → Atualizar Notas');
    print('W → Sair');
    print('==' * 70);
    stdout.write('');
    String? opcao = stdin.readLineSync();

    stdout.write('\x1B[2J\x1B[0;0H');

    if (opcao == null || opcao.isEmpty || opcao.toUpperCase() != 'A' && opcao.toUpperCase() != 'S' && opcao.toUpperCase() != 'D' && opcao.toUpperCase() != 'W' && opcao.toUpperCase() != 'E') {

      print('\n' + '__' * 70);
      print('ERRO: Entrada inválida. Tente novamente.');
      print('__' * 70 + '\n');
      continue;
    }

    //  -------------------------------------- CADASTRAR ALUNO  ---------------------------------------

    if (opcao.toUpperCase() == 'A') {
      stdout.write('\x1B[2J\x1B[0;0H');

      if (alunos.isEmpty) {

        print('\nNenhum aluno cadastrado.\n');

      } else {

        for (int i = 0; i < alunos.length; i++) {

          var aluno = alunos[i];
          print( '${i + 1}. Nome: ${aluno['nome']}, notas: ${aluno['notas']}');
        }
      }
      

      print('__' * 70);
      print('\nCadastramento de Alunos e notas \n(Digite qualquer número para sair)');
      print('__' * 70);
      stdout.write('Digite o nome do aluno: ');

      String? nome = stdin.readLineSync();

      if (nome == null || nome.isEmpty) {
        print('\nERRO: Nome inválido! Não pode ser número.\n');
        continue;
      }

      if (double.tryParse(nome) != null) {
        print('\nVoltando pro menu inicial.\n');
        continue;
      }
      List<double> notas = [];

      //  -------------------------------------- ADICIONANDO NOTAS  ---------------------------------------
      for (int i = 1; i <= 4; i++) {

        stdout.write('Digite a nota $i: ');
        String? entrada = stdin.readLineSync();
        double? nota;

        if (entrada != null && entrada.isNotEmpty) {
          nota = double.tryParse(entrada);
        } else {
          nota = null;
        }

        if (nota == null) {

          print('\nERRO: Valor inválido! \nA nota não pode ser vazia ou Letras.\n');

          continue;
        }
        notas.add(nota);
      }

      double media = notas.reduce((a, b) => a + b) / notas.length;

      //  -------------------------------------- SITUAÇÃO DO ALUNO ---------------------------------------
      String situacao = '';
      if (media >= 7) {

        situacao = 'Aprovado';

      } else if (media >= 5) {

        situacao = 'Recuperação';

      } else {

        situacao = 'Reprovado';
      }

      alunos.add({
        'nome': nome,
        'notas': notas,
        'media': media,
        'situacao': situacao,
      });

      stdout.write('\x1B[2J\x1B[0;0H');

      print('__' * 70);
      print('\nAluno cadastrado com sucesso!');
      print('Nome: $nome');
      print('Notas: $notas');
      print('Média: ${media.toStringAsFixed(2)}');
      print('Situação: $situacao');
      print('__' * 70);

    } else if (opcao.toUpperCase() == 'S') {
      print('__' * 70);
      print('\nVisualizar Alunos');
      print('__' * 70);

      stdout.write('\x1B[2J\x1B[0;0H');

      if (alunos.isEmpty) { //  -------------------------------------- VENDO SE TEM ALUNOS CADASTRADOS  ---------------------------------------

        print('\nNenhum aluno cadastrado.\n');

      } else {

        print('__' * 70);
        print('\nLista de Alunos cadastrados');
        print('__' * 70);

        //  -------------------------------------- EXIBINDO ALUNO  ---------------------------------------
        for (int i = 0; i < alunos.length; i++) {

          var aluno = alunos[i];
          print( '${i + 1}. Nome: ${aluno['nome']}, notas: ${aluno['notas']}, Média: ${aluno['media'].toStringAsFixed(2)}');
        }
        print('');
      }

      //  -------------------------------------- EXIBINDO A SITUAÇÃO  ---------------------------------------
    }  else if (opcao.toUpperCase() == 'D') {
      stdout.write('\x1B[2J\x1B[0;0H');

      print('__' * 70);
      print('\nSituação dos Alunos');
      print('__' * 70);

      if (alunos.isEmpty) {

        print('\nNenhum aluno cadastrado.\n');
      } else {

        for (var tipo in ['Aprovado', 'Recuperação', 'Reprovado']) {

          print('\n$tipo');

          print('__' * 70);

          var filtrados = alunos.where((aluno) => aluno['situacao'] == tipo).toList();

          if (filtrados.isEmpty) {

            print('Nenhum aluno nesta categoria.\n');

          } else {

            for (var aluno in filtrados) {
              
              print('Nome: ${aluno['nome']}, Média: ${aluno['media'].toStringAsFixed(2)}');
            }
          }
        }
        
      }
      //  -------------------------------------- BUSCANDO ALUNOS ---------------------------------------
    } else if (opcao.toUpperCase() == 'E') {

      stdout.write('\x1B[2J\x1B[0;0H');

      if (alunos.isEmpty) {

        print('\nNenhum aluno cadastrado.\n');

      } else {

        for (int i = 0; i < alunos.length; i++) {

          var aluno = alunos[i];
          print( '${i + 1}. Nome: ${aluno['nome']}, notas: ${aluno['notas']}');
        }

        print('');
        print('__' * 70);
        print('\nAtualizar as Notas de um aluno cadastrado');
        print('__' * 70);
        stdout.write('Nome do Aluno: ');
        String? busca = stdin.readLineSync();

        if (busca == null || busca.isEmpty) {
          print('\nERRO: Entrada inválida. Tente novamente.\n');
          continue;
        }

        var alunoEncontrado = alunos.firstWhere((aluno) => aluno['nome'].toString().toLowerCase() == busca.toLowerCase(),
          orElse: () {
            print('\n Aluno não encontrado\n');
            return {};
          },
        );

        print('-' * 70);
        print('\nAluno encontrado: ${alunoEncontrado['nome']}');
        print('Notas atuais: ${alunoEncontrado['notas']}\n');
        print('-' * 70);


        List<double> novasNotas = [];
        for (int i = 1; i <= 4; i++) {
          stdout.write('Digite a nova nota $i: ');
          String? entrada = stdin.readLineSync();

          if (entrada == null || entrada.isEmpty) {
            print('\nERRO: Valor inválido! A nota não pode ser vazia.\n');
            i--;
            continue;
          }

          double? nota = double.tryParse(entrada);
          if (nota == null) {
            print('\nERRO: Valor inválido! A nota deve ser um número.\n');
            i--;
            continue;
          }

          novasNotas.add(nota);
        }
        alunoEncontrado.update('notas', (_) => novasNotas);

        double media = novasNotas.reduce((a, b) => a + b) / novasNotas.length;
        alunoEncontrado.update('media', (_) => media);
      
        String situacao = '';
        if (media >= 7) {
          situacao = 'Aprovado';
        } else if (media >= 5) {
          situacao = 'Recuperação';
        } else {
          situacao = 'Reprovado';
        }
        alunoEncontrado.update('situacao', (_) => situacao);

        stdout.write('\x1B[2J\x1B[0;0H');
        print('__' * 70);
        print('\nNotas atualizadas com sucesso!');
        print('Nome: ${alunoEncontrado['nome']}');
        print('Novas notas: $novasNotas');
        print('Nova média: ${media.toStringAsFixed(2)}');
        print('Nova situação: $situacao');
        print('__' * 70);

        }

      //  -------------------------------------- ENCERRANDO O SISTEMA  ---------------------------------------
    } else if (opcao.toUpperCase() == 'W') {
      stdout.write('\x1B[2J\x1B[0;0H');


      print('');
      print('Encerrando o programa...');
      print('');

      break;
    }
  }
}
