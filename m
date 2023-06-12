Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7C72C878
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbjFLO20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237688AbjFLO14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:27:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F63AB4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Do07+ZJ8mt79MyKnagn3FmtuEPVS6qLM8Uvv604VtrU=; b=ft+LfENSbzDpGdR/jPu3Jnufmf
        IHfMnVhVYCDVxL4lsWCBWJNprt6qecPh6iVJH/jyJVtFumN4qbS/yfXinn70dOukq6yXFXA2M+RRH
        FxQpGw2Lk57s0+ygZfS5ucxKr9EfjhLyg81/6pzAN4HAsl67+sCPnuCdCkiJ2UUERt+DcZl7kUxYX
        1xyscFp19lM8RLbNmZhw1hpPskXnts+EK7+TobUzf3g8hRDwewyJipGeaMsQ0LGSpUwlEpT2Hp4jq
        ab/k68N1uDss72tLrlMmwIJaDI+iWY9G36Z1jHRVNlO48LAHDdfPieKLQl3MLtJDhnZggvllYttAA
        3vrSr1ng==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8iUS-004I8p-2v;
        Mon, 12 Jun 2023 14:25:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86: always initialize xen-swiotlb when xen-pcifront is enabling
Date:   Mon, 12 Jun 2023 16:25:41 +0200
Message-Id: <20230612142542.111581-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612142542.111581-1-hch@lst.de>
References: <20230612142542.111581-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dangerous late initialization of xen-swiotlb in
pci_xen_swiotlb_init_late and instead just always initialize
xen-swiotlb in the boot code if CONFIG_XEN_PCIDEV_FRONTEND is
enabled and Xen PV PCI is possible.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/xen/swiotlb-xen.h |  6 ------
 arch/x86/kernel/pci-dma.c              | 29 +++++++-------------------
 drivers/pci/xen-pcifront.c             |  6 ------
 3 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/xen/swiotlb-xen.h b/arch/x86/include/asm/xen/swiotlb-xen.h
index 77a2d19cc9909e..abde0f44df57dc 100644
--- a/arch/x86/include/asm/xen/swiotlb-xen.h
+++ b/arch/x86/include/asm/xen/swiotlb-xen.h
@@ -2,12 +2,6 @@
 #ifndef _ASM_X86_SWIOTLB_XEN_H
 #define _ASM_X86_SWIOTLB_XEN_H
 
-#ifdef CONFIG_SWIOTLB_XEN
-extern int pci_xen_swiotlb_init_late(void);
-#else
-static inline int pci_xen_swiotlb_init_late(void) { return -ENXIO; }
-#endif
-
 int xen_swiotlb_fixup(void *buf, unsigned long nslabs);
 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 				unsigned int address_bits,
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index de6be0a3965ee4..f323d83e40a70b 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -72,9 +72,15 @@ static inline void __init pci_swiotlb_detect(void)
 #endif /* CONFIG_SWIOTLB */
 
 #ifdef CONFIG_SWIOTLB_XEN
+static bool xen_swiotlb_enabled(void)
+{
+	return xen_initial_domain() || x86_swiotlb_enable ||
+		(IS_ENABLED(CONFIG_XEN_PCIDEV_FRONTEND) && xen_pv_pci_possible);
+}
+
 static void __init pci_xen_swiotlb_init(void)
 {
-	if (!xen_initial_domain() && !x86_swiotlb_enable)
+	if (!xen_swiotlb_enabled())
 		return;
 	x86_swiotlb_enable = true;
 	x86_swiotlb_flags |= SWIOTLB_ANY;
@@ -83,27 +89,6 @@ static void __init pci_xen_swiotlb_init(void)
 	if (IS_ENABLED(CONFIG_PCI))
 		pci_request_acs();
 }
-
-int pci_xen_swiotlb_init_late(void)
-{
-	if (dma_ops == &xen_swiotlb_dma_ops)
-		return 0;
-
-	/* we can work with the default swiotlb */
-	if (!io_tlb_default_mem.nslabs) {
-		int rc = swiotlb_init_late(swiotlb_size_or_default(),
-					   GFP_KERNEL, xen_swiotlb_fixup);
-		if (rc < 0)
-			return rc;
-	}
-
-	/* XXX: this switches the dma ops under live devices! */
-	dma_ops = &xen_swiotlb_dma_ops;
-	if (IS_ENABLED(CONFIG_PCI))
-		pci_request_acs();
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pci_xen_swiotlb_init_late);
 #else
 static inline void __init pci_xen_swiotlb_init(void)
 {
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 83c0ab50676dff..11636634ae512f 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -22,7 +22,6 @@
 #include <linux/bitops.h>
 #include <linux/time.h>
 #include <linux/ktime.h>
-#include <linux/swiotlb.h>
 #include <xen/platform_pci.h>
 
 #include <asm/xen/swiotlb-xen.h>
@@ -669,11 +668,6 @@ static int pcifront_connect_and_init_dma(struct pcifront_device *pdev)
 
 	spin_unlock(&pcifront_dev_lock);
 
-	if (!err && !is_swiotlb_active(&pdev->xdev->dev)) {
-		err = pci_xen_swiotlb_init_late();
-		if (err)
-			dev_err(&pdev->xdev->dev, "Could not setup SWIOTLB!\n");
-	}
 	return err;
 }
 
-- 
2.39.2

