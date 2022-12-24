Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36A2655B45
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiLXVR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiLXVRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:17:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD841A445
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:17:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37248B802C6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 21:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF47C433D2;
        Sat, 24 Dec 2022 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671916666;
        bh=GmtMxhGoXO8mzjcBa/1xqcbgZxWhZejdfxvLHGTF0Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drl8Y8PLpCkemip4M3K5tuRiOA8LlyJDgh1VykS/oxwNX42iAY+ljwHIunIvcrvlL
         gvFf+OKBa6GagtAf+21dsQUMgIiUYne73KTouQe4XrDwiK25zCzvXIFVK5+Xf12uFr
         Vyf6YgTBugtUWKgG2RVT1ZocrT4h3xztj4sgeouE+Pf3fWZM/gLpvqy0dQUA1iXRa4
         Fv32OA9mKRU+HD1kG4zg52JJrVoaLA5R3/bQVdSYmPCkZg/dcoGXhx/gMztmRioXD8
         q4phiHHP7pg0h43b9qBz1kj5z0C7tAzgAxgMkJDmD+XdrsLoBh6lKm3ubJvnyZ29tL
         l9CAECGu7XhcA==
Received: by pali.im (Postfix)
        id F31E4720; Sat, 24 Dec 2022 22:17:43 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] powerpc/85xx: p2020: Define just one machine description
Date:   Sat, 24 Dec 2022 22:14:23 +0100
Message-Id: <20221224211425.14983-7-pali@kernel.org>
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

Combine machine descriptions and code of all P2020 boards into just one
generic unified P2020 machine description. This allows kernel to boot on
any P2020-based board with P2020 DTS file without need to patch kernel and
define a new machine description in 85xx powerpc platform directory.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/p2020.c | 83 +++++++----------------------
 1 file changed, 19 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
index adf3750abef9..b3fb600e1d83 100644
--- a/arch/powerpc/platforms/85xx/p2020.c
+++ b/arch/powerpc/platforms/85xx/p2020.c
@@ -156,83 +156,38 @@ static void __init p2020_setup_arch(void)
 #endif
 }
 
-#ifdef CONFIG_MPC85xx_DS
-machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
-#endif /* CONFIG_MPC85xx_DS */
-
-#ifdef CONFIG_MPC85xx_RDB
-machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
-machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
-#endif /* CONFIG_MPC85xx_RDB */
+machine_arch_initcall(p2020, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
  */
-#ifdef CONFIG_MPC85xx_DS
-static int __init p2020_ds_probe(void)
-{
-	return !!of_machine_is_compatible("fsl,P2020DS");
-}
-#endif /* CONFIG_MPC85xx_DS */
-
-#ifdef CONFIG_MPC85xx_RDB
-static int __init p2020_rdb_probe(void)
-{
-	if (of_machine_is_compatible("fsl,P2020RDB"))
-		return 1;
-	return 0;
-}
-
-static int __init p2020_rdb_pc_probe(void)
+static int __init p2020_probe(void)
 {
-	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
-		return 1;
-	return 0;
+	struct device_node *p2020_cpu;
+
+	/*
+	 * There is no common compatible string for all P2020 boards.
+	 * The only common thing is "PowerPC,P2020@0" cpu node.
+	 * So check for P2020 board via this cpu node.
+	 */
+	p2020_cpu = of_find_node_by_path("/cpus/PowerPC,P2020@0");
+	if (!p2020_cpu)
+		return 0;
+
+	of_node_put(p2020_cpu);
+	return 1;
 }
-#endif /* CONFIG_MPC85xx_RDB */
-
-#ifdef CONFIG_MPC85xx_DS
-define_machine(p2020_ds) {
-	.name			= "P2020 DS",
-	.probe			= p2020_ds_probe,
-	.setup_arch		= p2020_setup_arch,
-	.init_IRQ		= p2020_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#endif
-	.get_irq		= mpic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
-#endif /* CONFIG_MPC85xx_DS */
-
-#ifdef CONFIG_MPC85xx_RDB
-define_machine(p2020_rdb) {
-	.name			= "P2020 RDB",
-	.probe			= p2020_rdb_probe,
-	.setup_arch		= p2020_setup_arch,
-	.init_IRQ		= p2020_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#endif
-	.get_irq		= mpic_get_irq,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
 
-define_machine(p2020_rdb_pc) {
-	.name			= "P2020RDB-PC",
-	.probe			= p2020_rdb_pc_probe,
+define_machine(p2020) {
+	.name			= "Freescale P2020",
+	.probe			= p2020_probe,
 	.setup_arch		= p2020_setup_arch,
 	.init_IRQ		= p2020_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
+	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
-#endif /* CONFIG_MPC85xx_RDB */
-- 
2.20.1

