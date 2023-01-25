Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D078C67B927
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjAYSTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjAYSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:19:01 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5403458992;
        Wed, 25 Jan 2023 10:18:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfWeU7EJgUDTbBuRVfTw2yLY1zR0Mb10ENQ4lsP+ttilf65zCdAkpUEtHzINlEZKkV5UF+o5ECM7C7KXol0/Y7N8Qpt9Ha+ZV4uF95i2dokDhloUnJyl0h9+RfhLiqECNYVGCsA9Kzqj402c1rOoWgbi86y1+8Rfp1Iu9MN1hWxEihK91qMFr6i0ngJCtYBSKZPdBR6+zbH+43TMriagPitgIG0ALQXcpJCaQbRq26MO1NrgS2J9VVtdiqiGrHTEWelsU1CP5j2FisMFz3wslX8gwOF2ctY7bjc9jca9V3/oBj5Hqz18tLPcOWi6wKKw/fIZG6x9Nq9QtL68B1JpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQUBPkEPSUkRH2Ug7EtV6YsgBp27BzZR8AC3WpBr+rk=;
 b=oWMdB7snHveHA9QUTo2smfX8WTQzTB270FkTQQYiCrNJak8cGGTYhg2OD1P/RG4W70hopFh+N32zehe6dJvBJ/Q0adyJIlpvy+hWe4uyaK3yFKWyILs3IXBRtsR2qIMVw+X3Rw1A0Ct/CovsiGUq92f/jamz1f+Rj2DGjGQ7rcw0fKA0ZP2Nr93wUxEubN53OBdzXAGf8lheWNNXk0nGuy5gnj6tJe+Dw0Z9EaGLwbVf1xgn/GGpZTTgvFMHIXK0KqnAj87boz0OCe1OJHMlIkU5eaHkrHFNeRZfVmU65f/PTbLlrPqbZ49jhNkMJ0kIBiRKU1FvbHL3LTMFrMvIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQUBPkEPSUkRH2Ug7EtV6YsgBp27BzZR8AC3WpBr+rk=;
 b=uS3IwhmsoKCVrUZJmeYukaRDoAyOoqmKYooBhVDgUei7W7swRap/cTG3e15W24CFgBG0W7aruyBQvipSfCPLXdzGm2NKzE+c4OOBAwdBPZ1wvrJm6fx8e2VXCJtbvRwngcGt1YUbf3hgNFizC636aUxvrVIJ+csnACXxgxCyS7M=
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 18:18:42 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::76) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Wed, 25 Jan 2023 18:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 18:18:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 12:18:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 10:18:40 -0800
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 25 Jan 2023 12:18:40 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] docs/sp_SP: Add process magic-number translation
Date:   Wed, 25 Jan 2023 12:18:40 -0600
Message-ID: <20230125181840.3007341-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f63645-ad35-43fb-ff39-08daff0096c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noP/KRFfu0XKWOt9aKAwxXcfGzhLEN0X7fbiHo5O3VvMpFuypHA5q7X0nnSTf3BSpzUR8F3xN8IN4wl2FdjGHJKGRPLqqfwnw40OJ1Y18q31N/v+JECNaYdCDMAdeFMdhJ91GipXlG4AUOPOC2tto7izP/YowQITRmZzDMhWxbln09Dg6F8+mH3qyV2nsG7ASXzD8tAUy1s2KXm5JOPrJ9jC0Wt0QrR6tvdRzh/qKviOHhcMDVCZpHXSt0YlYd1fjAIzgdJWtgOaNEgQ1KOxZXjvO0cfdPjBqHvykp5Wuk6WIaiE8GM3BZO//uIjN0MgDmhprL9sbaBXuBW1j82X5Ok383Av2kp4RO5/ByoSYTilodvWluclAlPxAxJWS8wblDp2n2TyocrQ4oriJs8x7wY5I0C21cXOJsNP2/d6fgiVNG9LVEShpdpqTzun9eXaMqfVz7RDTTtpa4pwA6MsCy1lNG4/m9uofROEbi+nWP+/0ntJbqXB+RuNGjad0upgWyKwdqudz4+L91+lC3otZyJcTO82rJXxbeV7xRQZPV0aGOJV6yAr0PIZcs7myCia4ANqmnjrsS6Pcyo+Dr5vREzFWuVEuxoe6m+MbKz04ztY043oRmOFviJy+QNHms7sts6QpVz8OmX7IlLcgTUf3zEYYSdKRbdhBKahYrCqqDfmc45GiaBL3J9/snk4XxEgsRK4bqFNceL4tSG/HKgrW2dr0wLFgdsJAemvyLCzgRk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(47076005)(426003)(336012)(316002)(81166007)(356005)(54906003)(41300700001)(82740400003)(40460700003)(36756003)(2906002)(44832011)(8936002)(40480700001)(36860700001)(5660300002)(8676002)(6916009)(4326008)(70586007)(70206006)(83380400001)(478600001)(7696005)(82310400005)(26005)(86362001)(1076003)(2616005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:18:41.9253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f63645-ad35-43fb-ff39-08daff0096c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the following document into Spanish:

- process/magic-number.rst

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../translations/sp_SP/process/index.rst      |  1 +
 .../sp_SP/process/magic-number.rst            | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/magic-number.rst

diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index ca95cd296ee1..c978a8132ce1 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -16,3 +16,4 @@
    code-of-conduct
    kernel-enforcement-statement
    email-clients
+   magic-number
diff --git a/Documentation/translations/sp_SP/process/magic-number.rst b/Documentation/translations/sp_SP/process/magic-number.rst
new file mode 100644
index 000000000000..6459f130f1e2
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/magic-number.rst
@@ -0,0 +1,90 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
+:Translator: Carlos Bilbao <carlos.bilbao@amd.com>
+
+.. _sp_magicnumbers:
+
+Números mágicos de Linux
+========================
+
+Este archivo es un registro de los números mágicos que están en uso. Cuando
+usted incluya un número mágico a una estructura, también debe agregarlo a
+este documento, ya que es mejor si los números mágicos utilizados por
+varias estructuras son únicos.
+
+Es una muy buena idea proteger las estructuras de datos del kernel con
+números mágicos. Esto le permite verificar en tiempo de ejecución si (a)
+una estructura ha sido manipulada, o (b) ha pasado la estructura incorrecta
+a una rutina. Esto último es especialmente útil --- particularmente cuando
+pasa punteros a estructuras a través de un puntero void *. El código tty,
+por ejemplo, hace esto con frecuencia para pasar información específica del
+driver y líneas de estructuras específicas de protocolo de un lado al
+otro.
+
+La forma de usar números mágicos es declararlos al principio de la
+estructura, así::
+
+	struct tty_ldisc {
+		int	magic;
+		...
+	};
+
+Por favor, siga este método cuando agregue futuras mejoras al kernel! Me ha
+ahorrado innumerables horas de depuración, especialmente en los casos
+complicados donde una matriz ha sido invadida y las estructuras que siguen
+a la matriz se han sobrescrito. Usando este método, estos casos se detectan
+de forma rápida y segura.
+
+Changelog::
+
+					Theodore Ts'o
+					31 Mar 94
+
+  La tabla mágica ha sido actualizada para Linux 2.1.55.
+
+					Michael Chastain
+					<mailto:mec@shout.net>
+					22 Sep 1997
+
+  Ahora debería estar actualizada con Linux 2.1.112. Porque
+  estamos en fase de "feature freeze", es muy poco probable que
+  algo cambiará antes de 2.2.x. Las entradas son
+  ordenados por campo numérico.
+
+					Krzysztof G. Baranowski
+					<mailto: kgb@knm.org.pl>
+					29 Jul 1998
+
+  Se actualizó la tabla mágica a Linux 2.5.45. Justo sobre el feature
+  freeze, pero es posible que algunos nuevos números mágicos se cuelen en
+  el kernel antes de 2.6.x todavía.
+
+					Petr Baudis
+					<pasky@ucw.cz>
+					03 Nov 2002
+
+  La tabla mágica ha sido actualizada para Linux 2.5.74.
+
+					Fabian Frederick
+					<ffrederick@users.sourceforge.net>
+					09 Jul 2003
+
+===================== ================ ======================== ==========================================
+Magic Name            Number           Structure                File
+===================== ================ ======================== ==========================================
+PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
+APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
+FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
+SLIP_MAGIC            0x5302           slip                     ``drivers/net/slip.h``
+MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/char/pcmcia/synclink_cs.c``
+BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/net/baycom_epp.c``
+HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/linux/hdlcdrv.h``
+KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mips/include/asm/sn/klkernvars.h``
+CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h``
+YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/net/hamradio/yam.c``
+CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/scsi/ncr53c8xx.c``
+QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/scsi/arm/queue.c``
+QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/scsi/arm/queue.c``
+NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mips/include/asm/sn/nmi.h``
+===================== ================ ======================== ==========================================
-- 
2.34.1

