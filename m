Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1108369B9C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBRL1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBRL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:26:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F281632C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:26:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 666F0B822AE
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D4EC433A7;
        Sat, 18 Feb 2023 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676719612;
        bh=FAbayckINTcRtQEApIU4KxM0IuLRQEFTI2dIvymgGt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bm8dQF+Fektu6qZvLgRICtgM0fuRiUYW50iz2fPx+MO0GMQxxFIPOOubK3guWhQIG
         /6CRarXi1GWgOIZM6G3fA253xCdDbabAwQZpgvgvZ9aV2gJDUyBaf0XhJ5qX9JUFln
         jnGSH7gSEPAMZCNmPn3cWNoi8DyAmF0xTKN2WOyMB2l8cifUGGGgVNKARsuQXvjLzK
         5+3EXz6JRk0cEDWlX0+J8JyO2mnXXjA82iVJJRv3xNRP2gu2LTmVKErVzxcmQO83tu
         mDsorRQCR5C7sZ7WJD+P/mcwu/2ZjGAUQlfevKaA+/wOFVXPNjIz/XmE7Wk9j/fa8w
         zk5eQkS5Zj5Qg==
Received: by pali.im (Postfix)
        id 82DCA2619; Sat, 18 Feb 2023 12:26:49 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] powerpc/85xx: p2020: Define just one machine description
Date:   Sat, 18 Feb 2023 12:14:03 +0100
Message-Id: <20230218111405.27688-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230218111405.27688-1-pali@kernel.org>
References: <20230218111405.27688-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 arch/powerpc/platforms/85xx/p2020.c | 77 ++++++-----------------------
 1 file changed, 15 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
index 1033b7bb05cc..feb5507bfc89 100644
--- a/arch/powerpc/platforms/85xx/p2020.c
+++ b/arch/powerpc/platforms/85xx/p2020.c
@@ -151,83 +151,36 @@ static void __init p2020_setup_arch(void)
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
+static int __init p2020_probe(void)
 {
-	return !!of_machine_is_compatible("fsl,P2020DS");
-}
-#endif /* CONFIG_MPC85xx_DS */
+	struct device_node *p2020_cpu;
 
-#ifdef CONFIG_MPC85xx_RDB
-static int __init p2020_rdb_probe(void)
-{
-	if (of_machine_is_compatible("fsl,P2020RDB"))
-		return 1;
-	return 0;
-}
+	/*
+	 * There is no common compatible string for all P2020 boards.
+	 * The only common thing is "PowerPC,P2020@0" cpu node.
+	 * So check for P2020 board via this cpu node.
+	 */
+	p2020_cpu = of_find_node_by_path("/cpus/PowerPC,P2020@0");
+	of_node_put(p2020_cpu);
 
-static int __init p2020_rdb_pc_probe(void)
-{
-	if (of_machine_is_compatible("fsl,P2020RDB-PC"))
-		return 1;
-	return 0;
+	return !!p2020_cpu;
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

