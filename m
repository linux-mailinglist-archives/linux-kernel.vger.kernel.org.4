Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8FC6DBBFB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjDHPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDHPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57613CA32
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA7096159C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B514EC4339C;
        Sat,  8 Apr 2023 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680968961;
        bh=zplOKDm9cHPNlwiN8ZmCM/Qx7EH1y8rnpVlgkclxTVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcqnWGfzoEcEPVi9THO4h8BogVoOIpwQDt5cyoAGZ0hS81JBTOEoZw4CyPv7h+/6P
         RbEcyETN5SjdJ5mGyjhYnTifNGaoimVq1bf//ERoFn7P0HxuwpNnHvGuPj6+CRX0ps
         MivTQQvbDlXwZCt0X+Pfi674tsK/O74mXPUpEpdJTFzBjcFDQekb5XNmC5JWKGUFNs
         JJ0rhB09o5WcqW0ZvGjG0Hm9h974FN7SWLMUs357BkGooAlZknObT5mv+vUntI1cVZ
         VgVaFLzxZZsAAmCCicHaMrXx+VEphOABT1tQkif1/L29J6GOOQVoojwoMd6MVfP8KM
         8wC7eTRZi9Q/Q==
Received: by pali.im (Postfix)
        id EB38B1BE4; Sat,  8 Apr 2023 17:49:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] powerpc/fsl_uli1575: Misc cleanup
Date:   Sat,  8 Apr 2023 17:48:07 +0200
Message-Id: <20230408154814.10400-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408154814.10400-1-pali@kernel.org>
References: <20230408154814.10400-1-pali@kernel.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Use a single line for uli_exclude_device().

Add uli_exclude_device() prototype in ppc-pci.h and guard it.

Remove that prototype from mpc85xx_ds.c and mpc86xx_hpcn.c files.

Make uli_pirq_to_irq[] static as it is used only in that file.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/include/asm/ppc-pci.h         | 9 +++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   | 4 +---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c | 4 +---
 arch/powerpc/platforms/fsl_uli1575.c       | 6 +++---
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index f6cf0159024e..a8db969dd595 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -57,11 +57,20 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev);
 
 #endif /* CONFIG_EEH */
 
+#ifdef CONFIG_FSL_ULI1575
+int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn);
+#endif /* CONFIG_FSL_ULI1575 */
+
 #define PCI_BUSNO(bdfn) ((bdfn >> 8) & 0xff)
 
 #else /* CONFIG_PCI */
 static inline void init_pci_config_tokens(void) { }
 #endif /* !CONFIG_PCI */
 
+#if !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575)
+#include <linux/pci.h>
+static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
+#endif /* !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575) */
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PPC_PCI_H */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 70167b8f00a3..ed7b71d55b10 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -26,6 +26,7 @@
 #include <asm/mpic.h>
 #include <asm/i8259.h>
 #include <asm/swiotlb.h>
+#include <asm/ppc-pci.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -107,9 +108,6 @@ void __init mpc85xx_ds_pic_init(void)
 }
 
 #ifdef CONFIG_PCI
-extern int uli_exclude_device(struct pci_controller *hose,
-				u_char bus, u_char devfn);
-
 static struct device_node *pci_with_uli;
 
 static int mpc85xx_exclude_device(struct pci_controller *hose,
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 7b00ebd2d7f8..3dbd396a0df5 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -22,6 +22,7 @@
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
 #include <asm/swiotlb.h>
+#include <asm/ppc-pci.h>
 
 #include <asm/mpic.h>
 
@@ -39,9 +40,6 @@
 #endif
 
 #ifdef CONFIG_PCI
-extern int uli_exclude_device(struct pci_controller *hose,
-				u_char bus, u_char devfn);
-
 static int mpc86xx_exclude_device(struct pci_controller *hose,
 				   u_char bus, u_char devfn)
 {
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 84afae7a2561..a32f9cef7845 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -13,6 +13,7 @@
 #include <linux/of_irq.h>
 
 #include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 
 #define ULI_PIRQA	0x08
 #define ULI_PIRQB	0x09
@@ -36,7 +37,7 @@
 #define ULI_8259_IRQ14	0x0d
 #define ULI_8259_IRQ15	0x0f
 
-u8 uli_pirq_to_irq[8] = {
+static u8 uli_pirq_to_irq[8] = {
 	ULI_8259_IRQ9,		/* PIRQA */
 	ULI_8259_IRQ10,		/* PIRQB */
 	ULI_8259_IRQ11,		/* PIRQC */
@@ -341,8 +342,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, hpcd_quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, hpcd_quirk_uli5229);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5288, hpcd_final_uli5288);
 
-int uli_exclude_device(struct pci_controller *hose,
-			u_char bus, u_char devfn)
+int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 {
 	if (bus == (hose->first_busno + 2)) {
 		/* exclude Modem controller */
-- 
2.20.1

