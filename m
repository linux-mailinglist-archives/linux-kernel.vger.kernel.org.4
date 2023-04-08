Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4B6DBB69
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjDHODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDHOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A93EFBD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DA94615A8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878B9C433EF;
        Sat,  8 Apr 2023 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962550;
        bh=a38Nb5+8BNBu5WNBdOxVHDnSVobRmoKRlk/8DEiKyc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBBkYvEpUI8SwbbzlPd2D0k2OvEpwpC+5BqBS8Z0u8CDD+F9eZEnh0euO/f+HwRx/
         s3qd2JdMkWkkSs9zm9vAZDXJhfRra6u+5K/0iltAoeQ69TINxpP3a/TIp7/wUvL2XH
         DvtP+wWyJ3siCNd72JqNhIPpptnDIgIhojgRWu338t/F+4tyHUEpxUoSxURjh2WuHz
         5KwGNW8ZCTWlhEdKExquwDBqR50QSCzqiN3ExmObLpRY9M7RJqrUZCmCRbYN/rqyUF
         0n1IwbBM/gnnczWxqw6TEGFDERNPVEMgctBqZMlqmFEcCV9ADx2iSllhgccbUOBo7g
         PMgylgktVCeWA==
Received: by pali.im (Postfix)
        id 3B0E924CB; Sat,  8 Apr 2023 16:02:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/13] powerpc/85xx: p2020: Unify .setup_arch and .init_IRQ callbacks
Date:   Sat,  8 Apr 2023 16:01:19 +0200
Message-Id: <20230408140122.25293-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408140122.25293-1-pali@kernel.org>
References: <20230408140122.25293-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make just one .setup_arch and one .init_IRQ callback implementation for all
P2020 board code. This deduplicate repeated and same code.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

---
Changes in v5:
* Make mpc85xx_ds_pic_init() and mpc85xx_ds_setup_arch() static too.
---
 arch/powerpc/platforms/85xx/mpc85xx.h     |  5 ---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |  4 +--
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  4 +--
 arch/powerpc/platforms/85xx/p2020.c       | 38 +++++++++++++++++++----
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index e792907ee3d5..c764d7551ef1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -21,9 +21,4 @@ void __init mpc85xx_8259_init(void);
 static inline void __init mpc85xx_8259_init(void) {}
 #endif
 
-void __init mpc85xx_ds_pic_init(void);
-void __init mpc85xx_ds_setup_arch(void);
-void __init mpc85xx_rdb_setup_arch(void);
-void __init mpc85xx_rdb_pic_init(void);
-
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index db4cf76c0fd1..4347d629b567 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -34,7 +34,7 @@
 
 #include "mpc85xx.h"
 
-void __init mpc85xx_ds_pic_init(void)
+static void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
 	int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU;
@@ -55,7 +55,7 @@ void __init mpc85xx_ds_pic_init(void)
 /*
  * Setup the architecture
  */
-void __init mpc85xx_ds_setup_arch(void)
+static void __init mpc85xx_ds_setup_arch(void)
 {
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index dbedffc57ce8..c42a68da6dfd 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -29,7 +29,7 @@
 
 #include "mpc85xx.h"
 
-void __init mpc85xx_rdb_pic_init(void)
+static void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
 	int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU;
@@ -48,7 +48,7 @@ void __init mpc85xx_rdb_pic_init(void)
 /*
  * Setup the architecture
  */
-void __init mpc85xx_rdb_setup_arch(void)
+static void __init mpc85xx_rdb_setup_arch(void)
 {
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_rdb_setup_arch()", 0);
diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
index 41bba8c0e335..0e7be454b2de 100644
--- a/arch/powerpc/platforms/85xx/p2020.c
+++ b/arch/powerpc/platforms/85xx/p2020.c
@@ -21,6 +21,32 @@
 #include "smp.h"
 #include "mpc85xx.h"
 
+static void __init p2020_pic_init(void)
+{
+	struct mpic *mpic;
+	int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU;
+
+	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
+
+	if (WARN_ON(!mpic))
+		return;
+
+	mpic_init(mpic);
+	mpc85xx_8259_init();
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init p2020_setup_arch(void)
+{
+	swiotlb_detect_4g();
+	fsl_pci_assign_primary();
+	uli_init();
+	mpc85xx_smp_init();
+	mpc85xx_qe_par_io_init();
+}
+
 #ifdef CONFIG_MPC85xx_DS
 machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
 #endif /* CONFIG_MPC85xx_DS */
@@ -34,8 +60,8 @@ machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
 define_machine(p2020_ds) {
 	.name			= "P2020 DS",
 	.compatible		= "fsl,P2020DS",
-	.setup_arch		= mpc85xx_ds_setup_arch,
-	.init_IRQ		= mpc85xx_ds_pic_init,
+	.setup_arch		= p2020_setup_arch,
+	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
@@ -49,8 +75,8 @@ define_machine(p2020_ds) {
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.compatible		= "fsl,P2020RDB",
-	.setup_arch		= mpc85xx_rdb_setup_arch,
-	.init_IRQ		= mpc85xx_rdb_pic_init,
+	.setup_arch		= p2020_setup_arch,
+	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
@@ -62,8 +88,8 @@ define_machine(p2020_rdb) {
 define_machine(p2020_rdb_pc) {
 	.name			= "P2020RDB-PC",
 	.compatible		= "fsl,P2020RDB-PC",
-	.setup_arch		= mpc85xx_rdb_setup_arch,
-	.init_IRQ		= mpc85xx_rdb_pic_init,
+	.setup_arch		= p2020_setup_arch,
+	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
-- 
2.20.1

