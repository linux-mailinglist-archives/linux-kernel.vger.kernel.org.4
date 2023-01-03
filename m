Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4265C450
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjACQ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbjACQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:56:18 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE19FEE33;
        Tue,  3 Jan 2023 08:56:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmuXsuCQe4S6b8eDPLlSgnraNQSuPjo4wpitwVGUNrL1lj1m/FpljEJRl7Bc/nUJz2lYhuhVOXh6ISeUyWM8kBJkKNonwqi9PZevratTGN4iQiAeJO6FOyWsiFGOarWUQ5TcB8upF/+w28yFBf8ASpMt6EbF7mnkaQq5sEThCU7TzA7WqkZwd7kLh68pWQypCZH3yiFfArJgYzJUgfcQslDJGgSycaDs+wGWE4DGNpV7NaUhGjP0NE/eANpQjjmvo7yDDSis9hiu2VsSyovzJyLWDclkVOHQRx4QgVLQqJMuwCsuiveA40f4XYX5EdOY39syy/u4db0nyf6xUcnqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot7h0iBnMWtlflEcItg9xfJ0FqhQH4aVqSpYNuZ5Tj4=;
 b=Wl4BQ1ByPSpD5rP2BVSNP3xd4oR5n7o6I9brvFHdd9KpaZMhoDndu4zBm5DxrQ3yj4xHAvPb7tVy3ZsUI7Inck2m/+6YwaqRRVyPrxWhwW0IHssxoawmhHGv3lpPXyRoPQ8l7TO6inmkIgl7OoaimaDbAmAsiecDJDxLEPOUl4M/uAQ+KhkUpyac7hr1JvOorEAGgDCiApg1upTCUIdSLNZepnFJkqiNX4BxK3RFmkko19DY+sa41+iTy/0Xc2TDjiwPIX1ykfOZu5EJVcbk+fMrJiWHjCYAH2nhZvneXJ8t/TrmflShr/CJjk++o50USQaQMb/2bqN9UNWACrUw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot7h0iBnMWtlflEcItg9xfJ0FqhQH4aVqSpYNuZ5Tj4=;
 b=p/sHFbvwgzECwj03M3err1p3RAsUw+vLa+98P4ZDACZzbx0kdgscs6xE2J6FyPZAf+FupUMn3scHI5N5yhlshTZsPGcKqdbUpEph4TpiIDH/IEvMqolNjebjMvqb7/JPxWZPVFjFYeAB8dkDvhK5+8nSPWN3ePqDZfPLnjgRQxM=
Received: from BN7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:20::19)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:56:10 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::7b) by BN7PR02CA0006.outlook.office365.com
 (2603:10b6:408:20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 16:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.14 via Frontend Transport; Tue, 3 Jan 2023 16:56:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 10:56:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 10:56:09 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Jan 2023 10:56:09 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <bilbao@vt.edu>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs/sp_SP: Add process kernel-enforcement-statement.rst translation
Date:   Tue, 3 Jan 2023 10:56:08 -0600
Message-ID: <20230103165608.134190-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 086441c4-650f-461b-3856-08daedab69ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPznb0E6NYz1BNsKabTLSsrQ3REj1RkHorkcSVsu7+zOZh4bYaoVHWOExhDPzeCtA/ygTfwSyOtx+d7NATSGTRQbdyyuf2REq7McaVQ760KZAMpWmaALSg9VsteFyqndb19+Cbi17KaVX+C94JYsHjfwRZ00+xRhVAsGHQ3u2IhxjA0QIelBN0vtzx1EapyTV+CWwGln4LLe7P650ZVaq0pGoZpg4HBdzsvW2UkTkYrqIRD1ahytsqlDeaROApxCTj3TEu5Ion7nVZKPPiHgVfYO34fBOqyzZQicepzLDOf9lc4zI4aBe6LTwsYX+DYmpADKffkFpF1tntcs8H8d6hyzC6YsYpjp1uesScJxatjKx7di3Z2fg1ekdSUWMskr7Bn222hqpOG2lY9FDajHllk7N6j4Gk+48vII93IhWIiIbWTIejG+lnXPARmHbEPBZGxEUFEEg0S0NxRaFLg1EsXcKExrnF3sh5BF8IH7epqb046K1VLPThReSj9p6E0J8iqwzSYRpwbLpfWhanrpOYJe2NiVegFd5toaXgD5KrlooFeUpa/y56dDiZOT2WbT9aPGPIonlglmEfA9kiLzPs8inL44EMPjnMHjkcpHv2aiMqhxW5Vj09t02zWrZZhVgwLt09E3UKYphTNl6RWaP4VtqdLoB8ba3owtvNVH79To92yhYWEyxTQIPoXIXhaqwytmVa+G97F3oM317gCIUB8MGUqglbOuoaXviouK/h6AlARYb0iXijZUxOMC+CaxhT67om1jw37mTsR66rHrHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(2616005)(1076003)(336012)(36860700001)(426003)(47076005)(40480700001)(86362001)(40460700003)(82310400005)(356005)(81166007)(82740400003)(36756003)(5660300002)(54906003)(316002)(2906002)(41300700001)(44832011)(4326008)(8936002)(70586007)(8676002)(70206006)(186003)(26005)(478600001)(6916009)(45080400002)(7696005)(22166006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 16:56:09.8025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086441c4-650f-461b-3856-08daedab69ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018
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

- process/kernel-enforcement-statement.rst

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../translations/sp_SP/process/index.rst      |   1 +
 .../process/kernel-enforcement-statement.rst  | 174 ++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst

diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index 0998cc15d274..f7e1f3d814f2 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -14,3 +14,4 @@
    kernel-docs
    coding-style
    code-of-conduct
+   kernel-enforcement-statement
diff --git a/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
new file mode 100644
index 000000000000..d66902694089
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/kernel-enforcement-statement.rst
@@ -0,0 +1,174 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
+:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+
+.. _sp_process_statement_kernel:
+
+Aplicación de la licencia en el kernel Linux
+============================================
+
+Como desarrolladores del kernel Linux, tenemos un gran interés en cómo se
+se utiliza nuestro software y cómo se aplica la licencia de nuestro software.
+El cumplimiento de las obligaciones de intercambio recíproco de GPL-2.0 son
+fundamentales en el largo plazo para la sostenibilidad de nuestro software
+y comunidad.
+
+Aunque existe el derecho de hacer valer un copyright distinto en las
+contribuciones hechas a nuestra comunidad, compartimos el interés de
+asegurar que las acciones individuales para proteger estos se lleven a cabo
+de una manera que beneficia a nuestra comunidad y no tenga un indeseado
+impacto negativo en la salud y crecimiento de nuestro ecosistema de software.
+Con el fin de disuadir la aplicación inútil de acciones, estamos de acuerdo
+en que es en el mejor interés de nuestro desarrollo como comunidad asumir
+el siguiente compromiso con los usuarios del kernel Linux, en nombre
+nuestro y de cualquier sucesor de nuestros derechos de autor (copyright):
+
+    Sin perjuicio de las disposiciones de terminación de GPL-2.0, aceptamos
+    que es en el mejor interés de nuestra comunidad de desarrollo adoptar
+    las siguientes disposiciones de GPL-3.0 como permisos adicionales bajo
+    nuestra licencia, con respecto a cualquier interposición de alegación
+    de infringimiento (en inglés, "non-defensive assertion") de los
+    derechos bajo la licencia.
+
+	Sin embargo, si deja de violar esta Licencia, entonces su licencia
+	de copyright como particular se restablece (a) provisionalmente,
+	a menos que y hasta que el titular de los derechos de autor explícita
+	y finalmente rescinda su licencia, y (b) de forma permanente, si el
+	titular de los derechos de autor no le notifica la violación por algún
+	medio razonable antes de 60 días después del cese.
+
+	Además, su licencia de un titular de derechos de autor en particular es
+	restablecida permanentemente si el titular de los derechos de autor le
+	notifica de la violación por algún medio razonable, esta es la primera
+	vez que ha recibido notificación de violación de esta Licencia (para
+	cualquier trabajo) de ese titular de los derechos de autor, y subsana
+	la infracción antes de los 30 días posteriores de recibir el aviso.
+
+Nuestra intención al proporcionar estas garantías es fomentar un mayor uso
+del software. Queremos que empresas y particulares utilicen, modifiquen y
+distribuyan este software. Queremos trabajar con los usuarios de forma
+abierta y transparente para eliminar cualquier incertidumbre sobre nuestras
+expectativas con respecto al cumplimiento que podría limitar la adopción de
+nuestro software. Entendemos la acción legal como último recurso, que se
+iniciará solo cuando otros esfuerzos de la comunidad no hayan podido
+resolver el problema.
+
+Finalmente, una vez que se resuelva un problema de incumplimiento,
+esperamos que el usuario se sienta bienvenido a unirse a nosotros en
+nuestros esfuerzos con este proyecto. Trabajando juntos, somos más fuertes.
+
+Excepto donde se indica a continuación, hablamos solo por nosotros mismos y
+no por ninguna compañía donde puede que trabajemos hoy, o hayamos trabajado
+en el pasado, o trabajaremos en el futuro.
+
+- Laura Abbott
+- Bjorn Andersson (Linaro)
+- Andrea Arcangeli
+- Neil Armstrong
+- Jens Axboe
+- Pablo Neira Ayuso
+- Khalid Aziz
+- Ralf Baechle
+- Felipe Balbi
+- Arnd Bergmann
+- Ard Biesheuvel
+- Tim Bird
+- Paolo Bonzini
+- Christian Borntraeger
+- Mark Brown (Linaro)
+- Paul Burton
+- Javier Martinez Canillas
+- Rob Clark
+- Kees Cook (Google)
+- Jonathan Corbet
+- Dennis Dalessandro
+- Vivien Didelot (Savoir-faire Linux)
+- Hans de Goede
+- Mel Gorman (SUSE)
+- Sven Eckelmann
+- Alex Elder (Linaro)
+- Fabio Estevam
+- Larry Finger
+- Bhumika Goyal
+- Andy Gross
+- Juergen Gross
+- Shawn Guo
+- Ulf Hansson
+- Stephen Hemminger (Microsoft)
+- Tejun Heo
+- Rob Herring
+- Masami Hiramatsu
+- Michal Hocko
+- Simon Horman
+- Johan Hovold (Hovold Consulting AB)
+- Christophe JAILLET
+- Olof Johansson
+- Lee Jones (Linaro)
+- Heiner Kallweit
+- Srinivas Kandagatla
+- Jan Kara
+- Shuah Khan (Samsung)
+- David Kershner
+- Jaegeuk Kim
+- Namhyung Kim
+- Colin Ian King
+- Jeff Kirsher
+- Greg Kroah-Hartman (Linux Foundation)
+- Christian König
+- Vinod Koul
+- Krzysztof Kozlowski
+- Viresh Kumar
+- Aneesh Kumar K.V
+- Julia Lawall
+- Doug Ledford
+- Chuck Lever (Oracle)
+- Daniel Lezcano
+- Shaohua Li
+- Xin Long
+- Tony Luck
+- Catalin Marinas (Arm Ltd)
+- Mike Marshall
+- Chris Mason
+- Paul E. McKenney
+- Arnaldo Carvalho de Melo
+- David S. Miller
+- Ingo Molnar
+- Kuninori Morimoto
+- Trond Myklebust
+- Martin K. Petersen (Oracle)
+- Borislav Petkov
+- Jiri Pirko
+- Josh Poimboeuf
+- Sebastian Reichel (Collabora)
+- Guenter Roeck
+- Joerg Roedel
+- Leon Romanovsky
+- Steven Rostedt (VMware)
+- Frank Rowand
+- Ivan Safonov
+- Anna Schumaker
+- Jes Sorensen
+- K.Y. Srinivasan
+- David Sterba (SUSE)
+- Heiko Stuebner
+- Jiri Kosina (SUSE)
+- Willy Tarreau
+- Dmitry Torokhov
+- Linus Torvalds
+- Thierry Reding
+- Rik van Riel
+- Luis R. Rodriguez
+- Geert Uytterhoeven (Glider bvba)
+- Eduardo Valentin (Amazon.com)
+- Daniel Vetter
+- Linus Walleij
+- Richard Weinberger
+- Dan Williams
+- Rafael J. Wysocki
+- Arvind Yadav
+- Masahiro Yamada
+- Wei Yongjun
+- Lv Zheng
+- Marc Zyngier (Arm Ltd)
+
-- 
2.34.1

