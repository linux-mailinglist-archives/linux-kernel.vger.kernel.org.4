Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A1269F794
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjBVPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjBVPUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:20:23 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105236FFA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:20:21 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PMJnD1yt9z9sTk;
        Wed, 22 Feb 2023 15:43:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mZ-y7XAscdZc; Wed, 22 Feb 2023 15:43:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PMJmx1KhCz9sTq;
        Wed, 22 Feb 2023 15:43:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DE978B77A;
        Wed, 22 Feb 2023 15:43:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tKlf2-Sq28ET; Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AF038B787;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31MEhMD51187129
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:43:22 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31MEhMBj1187128;
        Wed, 22 Feb 2023 15:43:22 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 11/17] powerpc/85xx: p2020: Move all P2020 RDB machine descriptions to p2020.c
Date:   Wed, 22 Feb 2023 15:42:58 +0100
Message-Id: <c5ca41a6a96ec60d38243cc77d01e77eaaba25cd.1677076552.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677076552.git.christophe.leroy@csgroup.eu>
References: <cover.1677076552.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677076980; l=7192; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=/APkHm0vLupHNPYOOM8QGlGxxbyS0eRfj8Vr8fKV8h8=; b=uZCMERUX4mYu6IcvpJ7tbiD3bAVw58YtS+ihVtjZeumhxehhhQ7i6H/Hzw+md2zf+x9Lg5eQ1FoV cQUPBqD2BUrNUxMK/5gQWW5swCyGL2NBRM5klG+BnctckxLQv0xY
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

This moves machine descriptions and all related code for all P2020 boards
into new p2020.c source file.
This is preparation for code de-duplication and
providing one unified machine description for all P2020 boards. In
follow-up patches would be copied functions refactored and simplified to be
specific just for P2020 boards.

Signed-off-by: Pali Rohár <pali@kernel.org>
[chleroy: Split in two patches: one for DS, one for RDB and keep helpers out]
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/Makefile      |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx.h     |  2 +
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 46 +-----------------
 arch/powerpc/platforms/85xx/p2020.c       | 57 +++++++++++++++++++++++
 4 files changed, 61 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 1f54623db9b7..93451850ed83 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
 obj-$(CONFIG_MPC8536_DS)  += mpc8536_ds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o p2020.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
-obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
+obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o p2020.o
 obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index ca8b39e6b05a..8f7b37c1de87 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -17,5 +17,7 @@ static inline void __init mpc85xx_qe_par_io_init(void) {}
 
 void __init mpc85xx_ds_pic_init(void);
 void __init mpc85xx_ds_setup_arch(void);
+void __init mpc85xx_rdb_setup_arch(void);
+void __init mpc85xx_rdb_pic_init(void);
 
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index b23f826339b5..d1f497e086ed 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -48,7 +48,7 @@ void __init mpc85xx_rdb_pic_init(void)
 /*
  * Setup the architecture
  */
-static void __init mpc85xx_rdb_setup_arch(void)
+void __init mpc85xx_rdb_setup_arch(void)
 {
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_rdb_setup_arch()", 0);
@@ -93,8 +93,6 @@ static void __init mpc85xx_rdb_setup_arch(void)
 	pr_info("MPC85xx RDB board from Freescale Semiconductor\n");
 }
 
-machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
-machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1020_mbg_pc, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1020_rdb, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1020_rdb_pc, mpc85xx_common_publish_devices);
@@ -107,13 +105,6 @@ machine_arch_initcall(p1024_rdb, mpc85xx_common_publish_devices);
 /*
  * Called very early, device-tree isn't unflattened
  */
-static int __init p2020_rdb_probe(void)
-{
-	if (of_machine_is_compatible("fsl,P2020RDB"))
-		return 1;
-	return 0;
-}
-
 static int __init p1020_rdb_probe(void)
 {
 	if (of_machine_is_compatible("fsl,P1020RDB"))
@@ -138,13 +129,6 @@ static int __init p1021_rdb_pc_probe(void)
 	return 0;
 }
 
-static int __init p2020_rdb_pc_probe(void)
-{
-	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
-		return 1;
-	return 0;
-}
-
 static int __init p1025_rdb_probe(void)
 {
 	return of_machine_is_compatible("fsl,P1025RDB");
@@ -165,20 +149,6 @@ static int __init p1024_rdb_probe(void)
 	return of_machine_is_compatible("fsl,P1024RDB");
 }
 
-define_machine(p2020_rdb) {
-	.name			= "P2020 RDB",
-	.probe			= p2020_rdb_probe,
-	.setup_arch		= mpc85xx_rdb_setup_arch,
-	.init_IRQ		= mpc85xx_rdb_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#endif
-	.get_irq		= mpic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
-
 define_machine(p1020_rdb) {
 	.name			= "P1020 RDB",
 	.probe			= p1020_rdb_probe,
@@ -207,20 +177,6 @@ define_machine(p1021_rdb_pc) {
 	.progress		= udbg_progress,
 };
 
-define_machine(p2020_rdb_pc) {
-	.name			= "P2020RDB-PC",
-	.probe			= p2020_rdb_pc_probe,
-	.setup_arch		= mpc85xx_rdb_setup_arch,
-	.init_IRQ		= mpc85xx_rdb_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#endif
-	.get_irq		= mpic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
-
 define_machine(p1025_rdb) {
 	.name			= "P1025 RDB",
 	.probe			= p1025_rdb_probe,
diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
index 2dfd150c6375..1b0def607749 100644
--- a/arch/powerpc/platforms/85xx/p2020.c
+++ b/arch/powerpc/platforms/85xx/p2020.c
@@ -34,16 +34,42 @@
 
 #include "mpc85xx.h"
 
+#ifdef CONFIG_MPC85xx_DS
 machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
+#endif /* CONFIG_MPC85xx_DS */
+
+#ifdef CONFIG_MPC85xx_RDB
+machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
+#endif /* CONFIG_MPC85xx_RDB */
 
 /*
  * Called very early, device-tree isn't unflattened
  */
+#ifdef CONFIG_MPC85xx_DS
 static int __init p2020_ds_probe(void)
 {
 	return !!of_machine_is_compatible("fsl,P2020DS");
 }
+#endif /* CONFIG_MPC85xx_DS */
+
+#ifdef CONFIG_MPC85xx_RDB
+static int __init p2020_rdb_probe(void)
+{
+	if (of_machine_is_compatible("fsl,P2020RDB"))
+		return 1;
+	return 0;
+}
+
+static int __init p2020_rdb_pc_probe(void)
+{
+	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
+		return 1;
+	return 0;
+}
+#endif /* CONFIG_MPC85xx_RDB */
 
+#ifdef CONFIG_MPC85xx_DS
 define_machine(p2020_ds) {
 	.name			= "P2020 DS",
 	.probe			= p2020_ds_probe,
@@ -57,3 +83,34 @@ define_machine(p2020_ds) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+#endif /* CONFIG_MPC85xx_DS */
+
+#ifdef CONFIG_MPC85xx_RDB
+define_machine(p2020_rdb) {
+	.name			= "P2020 RDB",
+	.probe			= p2020_rdb_probe,
+	.setup_arch		= mpc85xx_rdb_setup_arch,
+	.init_IRQ		= mpc85xx_rdb_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
+#endif
+	.get_irq		= mpic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+
+define_machine(p2020_rdb_pc) {
+	.name			= "P2020RDB-PC",
+	.probe			= p2020_rdb_pc_probe,
+	.setup_arch		= mpc85xx_rdb_setup_arch,
+	.init_IRQ		= mpc85xx_rdb_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
+#endif
+	.get_irq		= mpic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+#endif /* CONFIG_MPC85xx_RDB */
-- 
2.39.1

