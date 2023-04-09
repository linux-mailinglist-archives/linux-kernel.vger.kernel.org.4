Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88316DBE23
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 02:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDIAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIAJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 20:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5247783F6
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 17:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0F5E616BD
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 00:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C92C433A0;
        Sun,  9 Apr 2023 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680998961;
        bh=HhZeWrgAig2HaS6hHyjC+NpmU7/VpU/d+SrMRHkoT6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucBBxINODGUVQGq30JIZ7MkNr9qlRoBk/lnedWexPzpOEpfLn7pSS1tokOLthU/98
         wCt52TmsKX9bC9rTcK+kvcgERKZLY12G3VLu2JJoV6JXTcjnwmPKzt27FD5Sv8hbPx
         HBps4N7scRshb3pBNoDpTG0NCwOv67RulXkyUyRd37i9++xQ6iHRvp8U+SRoCtNWyZ
         Gh2mG452bEvykO/+85UepZ+FwDVN4SQaq90JLzcSSXI5BLETMsRVNVGunx8ZIjMgy4
         /8cKueNJ7jHphBEXWwaY6WBvOhAG0bXpdWxFHG7yUtiSvWYfU9Q7JPYCDkrQ3txN5O
         j/fvjEdwrPReQ==
Received: by pali.im (Postfix)
        id 8DCF3209C; Sun,  9 Apr 2023 02:09:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] powerpc/85xx: mpc85xx_ds: Move uli_init() code into its own driver file
Date:   Sun,  9 Apr 2023 02:08:08 +0200
Message-Id: <20230409000812.18904-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230409000812.18904-1-pali@kernel.org>
References: <20230409000812.18904-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move uli_init() function into existing driver fsl_uli1575.c file in order
to share its code between more platforms and board files.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/include/asm/ppc-pci.h       |  2 ++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 23 +----------------------
 arch/powerpc/platforms/fsl_uli1575.c     | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index a8db969dd595..0e393aeed912 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -59,6 +59,7 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev);
 
 #ifdef CONFIG_FSL_ULI1575
 int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn);
+void __init uli_init(void);
 #endif /* CONFIG_FSL_ULI1575 */
 
 #define PCI_BUSNO(bdfn) ((bdfn >> 8) & 0xff)
@@ -70,6 +71,7 @@ static inline void init_pci_config_tokens(void) { }
 #if !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575)
 #include <linux/pci.h>
 static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
+static inline void __init uli_init(void) {}
 #endif /* !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575) */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 581b5f0ef3be..c474da3eeea8 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -107,27 +107,6 @@ void __init mpc85xx_ds_pic_init(void)
 #endif	/* CONFIG_PPC_I8259 */
 }
 
-static void __init mpc85xx_ds_uli_init(void)
-{
-#ifdef CONFIG_PCI
-	struct device_node *node;
-	struct device_node *pci_with_uli;
-
-	/* See if we have a ULI under the primary */
-
-	node = of_find_node_by_name(NULL, "uli1575");
-	while ((pci_with_uli = of_get_parent(node))) {
-		of_node_put(node);
-		node = pci_with_uli;
-
-		if (pci_with_uli == fsl_pci_primary) {
-			ppc_md.pci_exclude_device = uli_exclude_device;
-			break;
-		}
-	}
-#endif
-}
-
 /*
  * Setup the architecture
  */
@@ -138,7 +117,7 @@ static void __init mpc85xx_ds_setup_arch(void)
 
 	swiotlb_detect_4g();
 	fsl_pci_assign_primary();
-	mpc85xx_ds_uli_init();
+	uli_init();
 	mpc85xx_smp_init();
 
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 1350db0b935d..b073db9d7c79 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -358,3 +358,22 @@ int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+
+void __init uli_init(void)
+{
+	struct device_node *node;
+	struct device_node *pci_with_uli;
+
+	/* See if we have a ULI under the primary */
+
+	node = of_find_node_by_name(NULL, "uli1575");
+	while ((pci_with_uli = of_get_parent(node))) {
+		of_node_put(node);
+		node = pci_with_uli;
+
+		if (pci_with_uli == fsl_pci_primary) {
+			ppc_md.pci_exclude_device = uli_exclude_device;
+			break;
+		}
+	}
+}
-- 
2.20.1

