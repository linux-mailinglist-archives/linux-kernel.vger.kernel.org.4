Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D946DBB64
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDHOC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDHOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCBEFBF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A13EB615A3
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6314C433EF;
        Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962549;
        bh=EYkoivVbC90IhkNPwKngRi4B+5+jGi4J3fzGRmyKcFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHYPZPhc78lA/uUbvXLHHqeJqDcvHneiTOHaghStzw3BIeGPRys0pIOSXMIXODAzM
         xbrqXHMcOwuO9XdYY6VDf1bgpt8Maet79lgtdwXdf6XxkgePMz3vJr5yiHyU7fD+uX
         V5Y1tLjnbWyozbBSsu5FYS6pfQv6a4hVMozkEZC4t8u1lpcrp+MFyGK4zTiFXYbsYm
         PKx0ZWCFYpjcinHlK19DFhLnyV7Ul8zSS7TAiKZWbw+VeWOp0UMY9MWaaxOGXWcusW
         3o4dBZN5eVVh0nM2uhuXtpM8CsYU0yyEwe3xA/HcYCUq0UO870BgCzj+IjWlDiFqa1
         rvdVCKJWNV/lA==
Received: by pali.im (Postfix)
        id 5665432FC; Sat,  8 Apr 2023 16:02:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/13] powerpc/85xx: p2020: Define just one machine description
Date:   Sat,  8 Apr 2023 16:01:20 +0200
Message-Id: <20230408140122.25293-12-pali@kernel.org>
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

Combine machine descriptions and code of all P2020 boards into just one
generic unified P2020 machine description. This allows kernel to boot on
any P2020-based board with P2020 DTS file without need to patch kernel and
define a new machine description in 85xx powerpc platform directory.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/p2020.c | 57 ++++++++++-------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
index 0e7be454b2de..0e4d715145af 100644
--- a/arch/powerpc/platforms/85xx/p2020.c
+++ b/arch/powerpc/platforms/85xx/p2020.c
@@ -47,47 +47,29 @@ static void __init p2020_setup_arch(void)
 	mpc85xx_qe_par_io_init();
 }
 
-#ifdef CONFIG_MPC85xx_DS
-machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
-#endif /* CONFIG_MPC85xx_DS */
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p2020_probe(void)
+{
+	struct device_node *p2020_cpu;
 
-#ifdef CONFIG_MPC85xx_RDB
-machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
-machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
-#endif /* CONFIG_MPC85xx_RDB */
+	/*
+	 * There is no common compatible string for all P2020 boards.
+	 * The only common thing is "PowerPC,P2020@0" cpu node.
+	 * So check for P2020 board via this cpu node.
+	 */
+	p2020_cpu = of_find_node_by_path("/cpus/PowerPC,P2020@0");
+	of_node_put(p2020_cpu);
 
-#ifdef CONFIG_MPC85xx_DS
-define_machine(p2020_ds) {
-	.name			= "P2020 DS",
-	.compatible		= "fsl,P2020DS",
-	.setup_arch		= p2020_setup_arch,
-	.init_IRQ		= p2020_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
-#endif
-	.get_irq		= mpic_get_irq,
-	.progress		= udbg_progress,
-};
-#endif /* CONFIG_MPC85xx_DS */
+	return !!p2020_cpu;
+}
 
-#ifdef CONFIG_MPC85xx_RDB
-define_machine(p2020_rdb) {
-	.name			= "P2020 RDB",
-	.compatible		= "fsl,P2020RDB",
-	.setup_arch		= p2020_setup_arch,
-	.init_IRQ		= p2020_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
-#endif
-	.get_irq		= mpic_get_irq,
-	.progress		= udbg_progress,
-};
+machine_arch_initcall(p2020, mpc85xx_common_publish_devices);
 
-define_machine(p2020_rdb_pc) {
-	.name			= "P2020RDB-PC",
-	.compatible		= "fsl,P2020RDB-PC",
+define_machine(p2020) {
+	.name			= "Freescale P2020",
+	.probe			= p2020_probe,
 	.setup_arch		= p2020_setup_arch,
 	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
@@ -97,4 +79,3 @@ define_machine(p2020_rdb_pc) {
 	.get_irq		= mpic_get_irq,
 	.progress		= udbg_progress,
 };
-#endif /* CONFIG_MPC85xx_RDB */
-- 
2.20.1

