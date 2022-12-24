Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC3655B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiLXVQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiLXVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:16:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83207A457
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:16:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B4FCB802C6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 21:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833C9C433EF;
        Sat, 24 Dec 2022 21:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671916596;
        bh=xNSdUI6pz4D6dE9/Og/zOzJThSiw3fw4+p8TGNZp1R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsDHwiA1Ml1/V9aFtJjyvnguPlFykX7SqWAxLPn1/2OmrJiOtMFJu4fiHxeS/51MK
         Py+b9wD4O1fIaKofMSAk5BsCmejZSGQvCpumBQW8uCG+/+lfjy+Grcirb4Ylj28tg+
         rAvSS0SGB0nYtqB+OWSEVZZIx+kVYF/j2qUfhNI7wZcPCQDrhalzqL3i9rKrMLs4dK
         7EctiQ30THPYXQhdWffKwWrkKqvfSjA+DKBdqguvkJNhmriQNHcGmUjccIU5c+Xfn/
         st4O39arY0XTQSTA4BbwaAtrRsavYjyMyZHmES05IGpln7mgG2bIClTgqfszYSLO81
         yFaOQARpg4mBQ==
Received: by pali.im (Postfix)
        id 3E87D720; Sat, 24 Dec 2022 22:16:36 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] powerpc/85xx: p2020: Unify .setup_arch and .init_IRQ callbacks
Date:   Sat, 24 Dec 2022 22:14:22 +0100
Message-Id: <20221224211425.14983-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221224211425.14983-1-pali@kernel.org>
References: <20221224211425.14983-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make just one .setup_arch and one .init_IRQ callback implementation for all
P2020 board code. This deduplicate repeated and same code.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/p2020.c | 58 +++++------------------------
 1 file changed, 9 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
index b8584bf307b0..adf3750abef9 100644
--- a/arch/powerpc/platforms/85xx/p2020.c
+++ b/arch/powerpc/platforms/85xx/p2020.c
@@ -42,8 +42,6 @@
 #define DBG(fmt, args...)
 #endif
 
-#ifdef CONFIG_MPC85xx_DS
-
 #ifdef CONFIG_PPC_I8259
 
 static void mpc85xx_8259_cascade(struct irq_desc *desc)
@@ -90,7 +88,7 @@ static void __init mpc85xx_8259_init(void)
 
 #endif	/* CONFIG_PPC_I8259 */
 
-static void __init mpc85xx_ds_pic_init(void)
+static void __init p2020_pic_init(void)
 {
 	struct mpic *mpic;
 
@@ -143,58 +141,20 @@ static void __init mpc85xx_ds_uli_init(void)
 #endif
 }
 
-#endif /* CONFIG_MPC85xx_DS */
-
-#ifdef CONFIG_MPC85xx_RDB
-static void __init mpc85xx_rdb_pic_init(void)
-{
-	struct mpic *mpic;
-
-	mpic = mpic_alloc(NULL, 0,
-	  MPIC_BIG_ENDIAN |
-	  MPIC_SINGLE_DEST_CPU,
-	  0, 256, " OpenPIC  ");
-
-	BUG_ON(mpic == NULL);
-	mpic_init(mpic);
-}
-#endif /* CONFIG_MPC85xx_RDB */
-
 /*
  * Setup the architecture
  */
-#ifdef CONFIG_MPC85xx_DS
-static void __init mpc85xx_ds_setup_arch(void)
+static void __init p2020_setup_arch(void)
 {
-	if (ppc_md.progress)
-		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
-
 	swiotlb_detect_4g();
 	fsl_pci_assign_primary();
 	mpc85xx_ds_uli_init();
 	mpc85xx_smp_init();
 
-	printk("MPC85xx DS board from Freescale Semiconductor\n");
-}
-#endif /* CONFIG_MPC85xx_DS */
-
-#ifdef CONFIG_MPC85xx_RDB
-static void __init mpc85xx_rdb_setup_arch(void)
-{
-	if (ppc_md.progress)
-		ppc_md.progress("mpc85xx_rdb_setup_arch()", 0);
-
-	mpc85xx_smp_init();
-
-	fsl_pci_assign_primary();
-
 #ifdef CONFIG_QUICC_ENGINE
 	mpc85xx_qe_par_io_init();
-#endif	/* CONFIG_QUICC_ENGINE */
-
-	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
+#endif
 }
-#endif /* CONFIG_MPC85xx_RDB */
 
 #ifdef CONFIG_MPC85xx_DS
 machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
@@ -235,8 +195,8 @@ static int __init p2020_rdb_pc_probe(void)
 define_machine(p2020_ds) {
 	.name			= "P2020 DS",
 	.probe			= p2020_ds_probe,
-	.setup_arch		= mpc85xx_ds_setup_arch,
-	.init_IRQ		= mpc85xx_ds_pic_init,
+	.setup_arch		= p2020_setup_arch,
+	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
@@ -251,8 +211,8 @@ define_machine(p2020_ds) {
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.probe			= p2020_rdb_probe,
-	.setup_arch		= mpc85xx_rdb_setup_arch,
-	.init_IRQ		= mpc85xx_rdb_pic_init,
+	.setup_arch		= p2020_setup_arch,
+	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
@@ -265,8 +225,8 @@ define_machine(p2020_rdb) {
 define_machine(p2020_rdb_pc) {
 	.name			= "P2020RDB-PC",
 	.probe			= p2020_rdb_pc_probe,
-	.setup_arch		= mpc85xx_rdb_setup_arch,
-	.init_IRQ		= mpc85xx_rdb_pic_init,
+	.setup_arch		= p2020_setup_arch,
+	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-- 
2.20.1

