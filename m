Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46A76DBBF8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjDHPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDHPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138CCA0B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F64961068
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A4DC4339B;
        Sat,  8 Apr 2023 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680968960;
        bh=Ycr7jTbAN7a67s9Ksm6I4CQ7mN9wdogyCtOnF9CVtvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dELuKUhPsFk+exD3P4FjQl6b6PyX3q6paFQZ3H3m8k3GdK/SJx7tRJu3Z8VD89kOT
         +ULxjmnb1RAa8tSNEwGjFCHxIHGcvPSXhYWdF5rHpNqOgJIBxLoMUvmks+723wS1rw
         KAUijtckBQ4PvxXwaHpfsoIeUkbseyiv1KJbTbbInWaoGhCt4nGBm/AYsTIcBDZr91
         nPOzmMMz0+fErbLAh2utXB5Nj6qjEi4mbqF+UIniExfs3uhNTQXffF1l6uisSGX+2Q
         MCfivqavJ7WbYa4DSfnGlXceTX8fdSTlKKEWT+LzutLPZ8mynUV8sHi8GQTkbeXKPs
         /akvyuHMQsa8g==
Received: by pali.im (Postfix)
        id 39EFE2047; Sat,  8 Apr 2023 17:49:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] powerpc/fsl_uli1575: Simplify uli_exclude_device() usage
Date:   Sat,  8 Apr 2023 17:48:09 +0200
Message-Id: <20230408154814.10400-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408154814.10400-1-pali@kernel.org>
References: <20230408154814.10400-1-pali@kernel.org>
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

Function uli_exclude_device() is called only from mpc86xx_exclude_device()
and mpc85xx_exclude_device() functions. Both those functions are same, so
merge its logic directly into the uli_exclude_device() function.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   | 13 +------------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c | 13 +------------
 arch/powerpc/platforms/fsl_uli1575.c       |  4 +++-
 3 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 0c905a838942..581b5f0ef3be 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -107,17 +107,6 @@ void __init mpc85xx_ds_pic_init(void)
 #endif	/* CONFIG_PPC_I8259 */
 }
 
-#ifdef CONFIG_PCI
-static int mpc85xx_exclude_device(struct pci_controller *hose,
-				   u_char bus, u_char devfn)
-{
-	if (hose->dn == fsl_pci_primary)
-		return uli_exclude_device(hose, bus, devfn);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-#endif	/* CONFIG_PCI */
-
 static void __init mpc85xx_ds_uli_init(void)
 {
 #ifdef CONFIG_PCI
@@ -132,7 +121,7 @@ static void __init mpc85xx_ds_uli_init(void)
 		node = pci_with_uli;
 
 		if (pci_with_uli == fsl_pci_primary) {
-			ppc_md.pci_exclude_device = mpc85xx_exclude_device;
+			ppc_md.pci_exclude_device = uli_exclude_device;
 			break;
 		}
 	}
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 3dbd396a0df5..645125cc8420 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -39,17 +39,6 @@
 #define DBG(fmt...) do { } while(0)
 #endif
 
-#ifdef CONFIG_PCI
-static int mpc86xx_exclude_device(struct pci_controller *hose,
-				   u_char bus, u_char devfn)
-{
-	if (hose->dn == fsl_pci_primary)
-		return uli_exclude_device(hose, bus, devfn);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-#endif /* CONFIG_PCI */
-
 
 static void __init
 mpc86xx_hpcn_setup_arch(void)
@@ -58,7 +47,7 @@ mpc86xx_hpcn_setup_arch(void)
 		ppc_md.progress("mpc86xx_hpcn_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
+	ppc_md.pci_exclude_device = uli_exclude_device;
 #endif
 
 	printk("MPC86xx HPCN board from Freescale Semiconductor\n");
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index a32f9cef7845..1350db0b935d 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -15,6 +15,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
 
+#include <sysdev/fsl_pci.h>
+
 #define ULI_PIRQA	0x08
 #define ULI_PIRQB	0x09
 #define ULI_PIRQC	0x0a
@@ -344,7 +346,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5288, hpcd_final_uli5288);
 
 int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 {
-	if (bus == (hose->first_busno + 2)) {
+	if (hose->dn == fsl_pci_primary && bus == (hose->first_busno + 2)) {
 		/* exclude Modem controller */
 		if ((PCI_SLOT(devfn) == 29) && (PCI_FUNC(devfn) == 1))
 			return PCIBIOS_DEVICE_NOT_FOUND;
-- 
2.20.1

