Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5301866E115
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjAQOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjAQOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:42:36 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CC3E613;
        Tue, 17 Jan 2023 06:42:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg4oEK/eMbKT3o4O5xe1d/yelw7LGp4Fb2ewDU2v5A2s0U5RdZ7D0RlKiqktHYiTc6+rc5+6ATZMazN76JW/agnayMNtSNV168dg1I+U10bzw1r0/otKs7tLS9Zd/j1DC2paBR3ZS0S4KosZJ3ugDl6yfUfeJCDADKtesLDMGrBNO16Zh3vclXtm5XbTiiRuGolCdR436bl2M9+RZMHu6oSMYr0bLYzb0AMJoQkrDx00Ud6rQXnjrCe5bSBQMDdrxJClzsWrrXsHTNSrgDTdUOgTjh9zGKSWh8wXAB97cP99jtv4m3QZL6xihEdwusqd63hMb+gGItnmrjynspx28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD3GWF+5xyA5QBxvsgwp1LHApn7XLZBe12uaYoI+zbQ=;
 b=DnMx6+oWhtFAwxssGYkIlooLX1tbyFHsF10DjgIYiIK5r7g+FEBq5tBjyDdevvwyU42QJh41VsjjfHT/qLi+U/8I+hW2MZfKWZN1F+KxfzxILHpdv66/SqPT2O0s9yoFhqmU289PaAWV36/sVEz2qRLM2CJoU4Yhz2PSdUITJygk7/6J3i8V27rSK0M1VZn8VTNSjkLvm3YE7qYckn9oqi+XYkPLmzN8/g+0Ip/f0sqI5vXJVD0srIFfODiTKXUozs/MG0uTNQbwXVZpErefQkj4q/z/tSOx4t4EpqSWpOGSCksrNRkYcVzZ4C8EI9k6SNeBC9V4JJwAIAW1u0aRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD3GWF+5xyA5QBxvsgwp1LHApn7XLZBe12uaYoI+zbQ=;
 b=2EzOci5e316swDdE/wLToK5SB/duByui3aBvxy5qi2A66OR06VqELvgT1l2BhhEX2jDVzl+210auA7dFmdnezduQ74z1hWL62GLjC9GlzhJugCh+HMbkLzWG81a9fzCePN2USL9tRIsnc4wXDuxYg6OtqwVQh8OlTbUIrKNjl60=
Received: from DM6PR07CA0049.namprd07.prod.outlook.com (2603:10b6:5:74::26) by
 MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 14:42:32 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::51) by DM6PR07CA0049.outlook.office365.com
 (2603:10b6:5:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 14:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Tue, 17 Jan 2023 14:42:32 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 08:42:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 06:42:31 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 08:42:31 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs/sp_SP: Add process email-clients translation
Date:   Tue, 17 Jan 2023 08:42:30 -0600
Message-ID: <20230117144230.28626-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 59264842-18b0-4f6c-894f-08daf89910c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tpgG/NXIRcic/AGFlb0STTPoRWR3xck0E8/jXF0eA5AO8oOKzsaa/0EMVn8w1S7H7WSFXxbdZqK8Ocy1lis1JSKLEhrXHfKdvJ8NF843IPbyQU9T45tx3MRHS9UKuiR5SXMMYieRQ4s5RRCDvMDuAM2mgkdFBbOj8Cxsvxy2EHtSZa18YNXBxAR1HPd2jEZNLiyAjxSKFPgG2jbVca83hlfAHm07hD2fsAnfwJZh6u+ff+frez3VXOdTwjQr8TLICel3Cx/LFBKoajBaAi1UWJXtfaUIgdLo6zxl9UkGudtzM42brkBNtmxLonYPYg4m7OeagIe1juy2huIOhveTrDGc5e+/AT4FldvBqZpJqf2SKPDFj0QLhZl3rR2EcfqI4r4NOXFXkvtjV5uqPy7thCbFE38uY5WhUbrudqYoiniFU59YU9ASVQ+bUXdq/ELgOmyIGeGf9pl0l4Ggg2uVB5fWnX3qJhmP67mXQdk7WvE5Teh7m16URAdNwoXVnbDM03c2mHJHpBDprB8O/jzSyJAYjmMweZr1VCWdj7mQvlyIIbdv4ZEH3B33yDGib6X+H+16zcoN0KhoeiL+lPYkcKsDzobqGhc0te7hA+vCEOQqkXcNg6L5mTOYIXoYUgF5GseAWpUGvXyUPLo0+O6qYOQtjqvtBF8Z8yj7SmKJXmVu2E5ei7DnoT8fTWXPJtgTBax/98sshDvXkIACxvE7zsGvQjSnAKfVroOPLHSaIK6LEyKsRWejkPJnGskusP9znsujFyDz6jS669feFgAe2MwCmdcN8E6STduBiBGJd4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(6916009)(82310400005)(47076005)(426003)(70206006)(66574015)(26005)(70586007)(41300700001)(186003)(8676002)(4326008)(2616005)(86362001)(36756003)(36860700001)(336012)(5660300002)(82740400003)(1076003)(8936002)(54906003)(45080400002)(478600001)(83380400001)(316002)(40480700001)(7696005)(30864003)(966005)(81166007)(40460700003)(2906002)(356005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 14:42:32.0605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59264842-18b0-4f6c-894f-08daf89910c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the following document into Spanish:

- process/email-clients.rst

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../sp_SP/process/email-clients.rst           | 378 ++++++++++++++++++
 .../translations/sp_SP/process/index.rst      |   1 +
 2 files changed, 379 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/email-clients.rst

diff --git a/Documentation/translations/sp_SP/process/email-clients.rst b/Documentation/translations/sp_SP/process/email-clients.rst
new file mode 100644
index 000000000000..cfe92041e91d
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/email-clients.rst
@@ -0,0 +1,378 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
+:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+
+.. _sp_email_clients:
+
+Información de clientes de correo electrónico para Linux
+========================================================
+
+Git
+---
+
+A día de hoy, la mayoría de los desarrolladores usan ``git send-email`` en
+lugar de los clientes de correo electrónico normales. La página de manual
+para esto es bastante buena. En la recepción del correo, los maintainers
+usan ``git am`` para aplicar los parches.
+
+Si es usted nuevo en ``git`` entonces envíese su primer parche. Guárdelo
+como texto sin formato, incluidos todos los encabezados. Ejecute ``git am raw_email.txt``
+y luego revise el registro de cambios con ``git log``. Cuando eso funcione,
+envíe el parche a la(s) lista(s) de correo apropiada(s).
+
+Preferencias Generales
+----------------------
+
+Los parches para el kernel de Linux se envían por correo electrónico,
+preferiblemente como texto en línea en el cuerpo del correo electrónico.
+Algunos maintainers aceptan archivos adjuntos, pero entonces los archivos
+adjuntos deben tener tipo de contenido ``text/plain``. Sin embargo, los
+archivos adjuntos generalmente están mal vistos porque hacen que citar
+partes del parche sea más difícil durante el proceso de revisión del
+parche.
+
+También se recomienda encarecidamente que utilice texto sin formato en el
+cuerpo del correo electrónico, para parches y otros correos electrónicos
+por igual. https://useplaintext.email puede ser útil para obtener
+información sobre cómo configurar su cliente de correo electrónico
+preferido, así como una lista de clientes de correo electrónico
+recomendados si aún no tiene una preferencia.
+
+Los clientes de correo electrónico que se utilizan para los parches del
+kernel Linux deben enviar el texto del parche intacto. Por ejemplo, no
+deben modificar ni eliminar pestañas o espacios, incluso al principio o al
+final de las líneas.
+
+No envíe parches con ``format=flowed``. Esto puede causar saltos de línea
+no deseados e inesperados.
+
+No deje que su cliente de correo electrónico ajuste automáticamente las
+palabras por usted. Esto también puede corromper su parche.
+
+Los clientes de correo electrónico no deben modificar la codificación del
+de caracteres del texto. Los parches enviados por correo electrónico deben
+estar en codificación ASCII o UTF-8 únicamente. Si configura su cliente de
+correo electrónico para enviar correos electrónicos con codificación UTF-8,
+evite algunos posibles problemas con los caracteres.
+
+Los clientes de correo electrónico deben generar y mantener los
+encabezados "References:" o "In-Reply-To:"  para que el hilo de correo no
+se rompa.
+
+Copiar y pegar (o cortar y pegar) generalmente no funciona para los
+parches, porque las tabulaciones se convierten en espacios. Utilizar
+xclipboard, xclip y/o xcutsel puede funcionar, pero es mejor probarlo usted
+mismo o simplemente evitar copiar y pegar.
+
+No utilice firmas PGP/GPG en el correo que contiene parches.
+Esto rompe muchos scripts que leen y aplican los parches.
+(Esto debería ser reparable.)
+
+Es una buena idea enviarse un parche a sí mismo, guardar el mensaje
+recibido, y aplicarlo con éxito con 'patch' antes de enviar el parche a las
+listas de correo de Linux.
+
+Algunas sugerencias para el cliente de correo electrónico (MUA)
+---------------------------------------------------------------
+
+Here are some specific MUA configuration hints for editing and sending
+patches for the Linux kernel.  These are not meant to be complete
+software package configuration summaries.
+
+Aquí hay algunos consejos específicos de configuración de MUA para editar y
+enviar parches para el kernel de Linux. Estos no pretenden cubrir todo
+detalle de configuración de los paquetes de software.
+
+Leyenda:
+
+- TUI = text-based user interface (interfaz de usuario basada en texto)
+- GUI = graphical user interface (interfaz de usuario gráfica)
+
+Alpine (TUI)
+************
+
+Opciones de configuración:
+
+En la sección :menuselection:`Sending Preferences`:
+
+- :menuselection: `Do Not Send Flowed Text` debe estar ``enabled``
+- :menuselection:`Strip Whitespace Before Sending` debe estar ``disabled``
+
+Al redactar el mensaje, el cursor debe colocarse donde el parche debería
+aparecer, y luego presionando :kbd:`CTRL-R` se le permite especificar e
+archivo de parche a insertar en el mensaje.
+
+Claws Mail (GUI)
+****************
+
+Funciona. Algunos usan esto con éxito para los parches.
+
+Para insertar un parche haga :menuselection:`Message-->Insert File` (:kbd:`CTRL-I`)
+o use un editor externo.
+
+Si el parche insertado debe editarse en la ventana de composición de Claws
+"Auto wrapping" en
+:menuselection:`Configuration-->Preferences-->Compose-->Wrapping` debe
+permanecer deshabilitado.
+
+Evolution (GUI)
+***************
+
+Algunos usan esto con éxito para sus parches.
+
+Cuando escriba un correo seleccione: Preformat
+  desde :menuselection:`Format-->Paragraph Style-->Preformatted` (:kbd:`CTRL-7`)
+  o en la barra de herramientas
+
+Luego haga:
+:menuselection:`Insert-->Text File...` (:kbd:`ALT-N x`)
+para insertar el parche.
+
+También puede hacer ``diff -Nru old.c new.c | xclip``, seleccione
+:menuselection:`Preformat`, luego pege con el boton del medio.
+
+Kmail (GUI)
+***********
+
+Algunos usan Kmail con éxito para los parches.
+
+La configuración predeterminada de no redactar en HTML es adecuada; no haga
+cambios en esto.
+
+Al redactar un correo electrónico, en las opciones, desmarque "word wrap".
+La única desventaja es que cualquier texto que escriba en el correo
+electrónico no se ajustará a cada palabra, por lo que tendrá que ajustar
+manualmente el texto antes del parche. La forma más fácil de evitar esto es
+redactar su correo electrónico con Word Wrap habilitado, luego guardar
+como borrador. Una vez que lo vuelva a sacar de sus borradores, estará
+envuelto por palabras y puede desmarcar "word wrap" sin perder el existente
+texto.
+
+En la parte inferior de su correo electrónico, coloque el delimitador de
+parche de uso común antes de insertar su parche:  tres guiones (``---``).
+
+Luego desde la opción de menu :menuselection:`Message` seleccione
+:menuselection:`insert file` y busque su parche.
+De forma adicional, puede personalizar el menú de la barra de herramientas
+de creación de mensajes y poner el icono :menuselection:`insert file`.
+
+Haga que la ventana del editor sea lo suficientemente ancha para que no se
+envuelva ninguna línea. A partir de KMail 1.13.5 (KDE 4.5.4), KMail
+aplicará ajuste de texto al enviar el correo electrónico si las líneas se
+ajustan en la ventana del redactor. Tener ajuste de palabras deshabilitado
+en el menú Opciones no es suficiente. Por lo tanto, si su parche tiene
+líneas muy largas, debe hacer que la ventana del redactor sea muy amplia
+antes de enviar el correo electrónico. Consulte: https://bugs.kde.org/show_bug.cgi?id=174034
+
+You can safely GPG sign attachments, but inlined text is preferred for
+patches so do not GPG sign them.  Signing patches that have been inserted
+as inlined text will make them tricky to extract from their 7-bit encoding.
+
+Puede firmar archivos adjuntos con GPG de forma segura, pero se prefiere el
+texto en línea para parches, así que no los firme con GPG. Firmar parches
+que se han insertado como texto en línea hará que sea difícil extraerlos de
+su codificación de 7 bits.
+
+Si es absolutamente necesario enviar parches como archivos adjuntos en
+lugar de como texto en línea, haga clic con el botón derecho en el archivo
+adjunto y seleccione :menuselection:`properties`, y luego
+:menuselection:`Suggest automatic display` para hacer que el archivo
+adjunto esté en línea para que sea más visible.
+
+Al guardar parches que se envían como texto en línea, seleccione el correo
+electrónico que contiene el parche del panel de la lista de mensajes, haga
+clic con el botón derecho y seleccione :menuselection:`save as`.  Puede usar
+todo el correo electrónico sin modificar como un parche de estar bien
+compuesto. Los correos electrónicos se guardan como lectura y escritura
+solo para el usuario, por lo que tendrá que cambiarlos para que sean
+legibles en grupo y en todo el mundo si copia estos en otro lugar.
+
+Notas de Lotus (GUI)
+********************
+
+Huya de este.
+
+IBM Verse (Web GUI)
+*******************
+
+Vea notas sobre Lotus.
+
+Mutt (TUI)
+**********
+
+Muchos desarrolladores de Linux usan ``mutt``, por lo que debe funcionar
+bastante bien.
+
+Mutt no viene con un editor, por lo que cualquier editor que use debe ser
+utilizado de forma que no haya saltos de línea automáticos. La mayoría de
+los editores tienen una opción :menuselection:`insert file` que inserta el
+contenido de un archivo inalterado.
+
+Para usar ``vim`` con mutt::
+
+  set editor="vi"
+
+Si utiliza xclip, escriba el comando::
+
+  :set paste
+
+antes del boton del medio o shift-insert o use::
+
+  :r filename
+
+si desea incluir el parche en línea.
+(a)ttach (adjuntar) funciona bien sin ``set paste``.
+
+También puedes generar parches con ``git format-patch`` y luego usar Mutt
+para enviarlos::
+
+    $ mutt -H 0001-some-bug-fix.patch
+
+Opciones de configuración:
+
+Debería funcionar con la configuración predeterminada.
+Sin embargo, es una buena idea establecer ``send_charset`` en:
+
+  set send_charset="us-ascii:utf-8"
+
+Mutt es altamente personalizable. Aquí tiene una configuración mínima para
+empezar a usar Mutt para enviar parches a través de Gmail::
+
+  # .muttrc
+  # ================  IMAP ====================
+  set imap_user = 'suusuario@gmail.com'
+  set imap_pass = 'sucontraseña'
+  set spoolfile = imaps://imap.gmail.com/INBOX
+  set folder = imaps://imap.gmail.com/
+  set record="imaps://imap.gmail.com/[Gmail]/Sent Mail"
+  set postponed="imaps://imap.gmail.com/[Gmail]/Drafts"
+  set mbox="imaps://imap.gmail.com/[Gmail]/All Mail"
+
+  # ================  SMTP  ====================
+  set smtp_url = "smtp://username@smtp.gmail.com:587/"
+  set smtp_pass = $imap_pass
+  set ssl_force_tls = yes # Requerir conexión encriptada
+
+  # ================  Composición  ====================
+  set editor = `echo \$EDITOR`
+  set edit_headers = yes  # Ver los encabezados al editar
+  set charset = UTF-8     # valor de $LANG; also fallback for send_charset
+  # El remitente, la dirección de correo electrónico y la línea de firma deben coincidir
+  unset use_domain        # Porque joe@localhost es simplemente vergonzoso
+  set realname = "SU NOMBRE"
+  set from = "username@gmail.com"
+  set use_from = yes
+
+Los documentos Mutt tienen mucha más información:
+
+    https://gitlab.com/muttmua/mutt/-/wikis/UseCases/Gmail
+
+    http://www.mutt.org/doc/manual/
+
+Pine (TUI)
+**********
+
+Pine ha tenido algunos problemas de truncamiento de espacios en blanco en
+el pasado, pero estos todo debería estar arreglados ahora.
+
+Use alpine (sucesor de pino) si puede.
+
+Opciones de configuración:
+
+- ``quell-flowed-text`` necesitado para versiones actuales
+- la opción ``no-strip-whitespace-before-send`` es necesaria
+
+
+Sylpheed (GUI)
+**************
+
+- Funciona bien para insertar texto (o usar archivos adjuntos).
+- Permite el uso de un editor externo.
+- Es lento en carpetas grandes.
+- No realizará la autenticación TLS SMTP en una conexión que no sea SSL.
+- Tiene una útil barra de reglas en la ventana de redacción.
+- Agregar direcciones a la libreta de direcciones no las muestra
+  adecuadamente.
+
+Thunderbird (GUI)
+*****************
+
+Thunderbird es un clon de Outlook al que le gusta alterar el texto, pero
+hay formas para obligarlo a comportarse.
+
+Después de hacer las modificaciones, que incluye instalar las extensiones,
+necesita reiniciar Thunderbird.
+
+- Permitir el uso de un editor externo:
+
+  Lo más fácil de hacer con Thunderbird y los parches es usar extensiones
+  que abran su editor externo favorito.
+
+  Aquí hay algunas extensiones de ejemplo que son capaces de hacer esto.
+
+  - "External Editor Revived"
+
+    https://github.com/Frederick888/external-editor-revived
+
+    https://addons.thunderbird.net/en-GB/thunderbird/addon/external-editor-revived/
+
+    Requiere instalar un "native messaging host".
+    Por favor, lea la wiki que se puede encontrar aquí:
+    https://github.com/Frederick888/external-editor-revived/wiki
+
+  - "External Editor"
+
+    https://github.com/exteditor/exteditor
+
+    Para hacer esto, descargue e instale la extensión, luego abra la ventana
+    :menuselection:`compose`, agregue un botón para ello usando
+    :menuselection:`View-->Toolbars-->Customize...`
+    luego simplemente haga clic en el botón nuevo cuando desee usar el editor
+    externo.
+
+    Tenga en cuenta que "External Editor" requiere que su editor no haga
+    fork, o en otras palabras, el editor no debe regresar antes de cerrar.
+    Es posible que deba pasar flags adicionales o cambiar la configuración
+    de su editor. En particular, si está utilizando gvim, debe pasar la
+    opción -f a gvim poniendo ``/usr/bin/gvim --nofork"`` (si el binario
+    está en ``/usr/bin``) al campo del editor de texto en los ajustes
+    :menuselection:`external editor`. Si está utilizando algún otro editor,
+    lea su manual para saber cómo hacer esto.
+
+Para sacarle algo de sentido al editor interno, haga esto:
+
+- Edite sus ajustes de configuración de Thunderbird para que no utilice ``format=flowed``!
+  Vaya a su ventana principal y busque el botón de su menú desplegable principal.
+  :menuselection:`Main Menu-->Preferences-->General-->Config Editor...`
+  para abrir el editor de registro de Thunderbird.
+
+  - Seleccione ``mailnews.send_plaintext_flowed`` como ``false``
+
+  - Seleccione ``mailnews.wraplength`` de ``72`` a ``0``
+
+- ¡No escriba mensajes HTML! Acuda a la ventana principal
+  :menuselection:`Main Menu-->Account Settings-->youracc@server.something-->Composition & Addressing`!
+  Ahí puede deshabilitar la opción "Compose messages in HTML format".
+
+- ¡Abra mensajes solo como texto sin formato! Acuda a la ventana principal
+  :menuselection:`Main Menu-->View-->Message Body As-->Plain Text`!
+
+TkRat (GUI)
+***********
+
+Funciona.  Utilice "Insert file..." o un editor externo.
+
+Gmail (Web GUI)
+***************
+
+No funciona para enviar parches.
+
+El cliente web de Gmail convierte las tabulaciones en espacios automáticamente.
+
+Al mismo tiempo, envuelve líneas cada 78 caracteres con saltos de línea de
+estilo CRLF aunque el problema de tab2space se puede resolver con un editor
+externo.
+
+Otro problema es que Gmail codificará en base64 cualquier mensaje que tenga
+un carácter no ASCII. Eso incluye cosas como nombres europeos.
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index f7e1f3d814f2..ca95cd296ee1 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -15,3 +15,4 @@
    coding-style
    code-of-conduct
    kernel-enforcement-statement
+   email-clients
-- 
2.34.1

