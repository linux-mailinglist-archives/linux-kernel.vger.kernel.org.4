Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D375679AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjAXN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjAXN6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:58:03 -0500
Received: from MTA-06-3.privateemail.com (mta-06-3.privateemail.com [198.54.127.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11954A5DC;
        Tue, 24 Jan 2023 05:57:35 -0800 (PST)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id 9C2F818000A1;
        Tue, 24 Jan 2023 08:56:47 -0500 (EST)
Received: from bpappas-XPS-13-9310.ucf.edu (050-088-208-136.res.spectrum.com [50.88.208.136])
        by mta-06.privateemail.com (Postfix) with ESMTPA id F257218000A2;
        Tue, 24 Jan 2023 08:56:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1674568607;
        bh=hyywYj3YgpDSUr4+jW3lP2faP9U2ufaGmFKNvculv8g=;
        h=From:To:Cc:Subject:Date:From;
        b=NuVd+GWuVAjzvardhhN0mG2/HD3n/VJ5kZHU0qb8PjGzPqRh3a1e4x55EUa1jWovW
         xlY6jNmisP0TzpAuLHv8vfhm7X+Oz7IB/cikHyPHF7plq3c3ckhmHWSenYbrdSOqk7
         iCl8UofS05icJMqd3jTWvlT8na7l4oAuo8xL9H+0NBlryj6+5UF77faV5zCU3KY/uz
         yhr5L0g+LM6a8QRrD2u9fDEwQuGH3b+rK2m348pXlYYrj3jWap7yoOvkiSSP2UCNPz
         H8IBpxpBA+VYFO0qFPi1ivyZozx76rTG+wIYyITnfN068LMXlYxjixj0XrzDyvopH3
         7JeH8OVtCtJvA==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     sakari.ailus@linux.intel.com
Cc:     bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brent Pappas <bpappas@pappasbrent.com>
Subject: [PATCH] mdeia: ipu3: ipu33-mmu: Replace macro IPU3_ADDR2PTE() with a function
Date:   Tue, 24 Jan 2023 08:55:54 -0500
Message-Id: <20230124135554.13787-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the macro IPU3_ADDR2PTE() with a static function to match
Linux coding style standards.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
 drivers/staging/media/ipu3/ipu3-mmu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-mmu.c b/drivers/staging/media/ipu3/ipu3-mmu.c
index cb9bf5fb29a5..d2d603c32773 100644
--- a/drivers/staging/media/ipu3/ipu3-mmu.c
+++ b/drivers/staging/media/ipu3/ipu3-mmu.c
@@ -25,7 +25,11 @@
 #define IPU3_PT_SIZE		(IPU3_PT_PTES << 2)
 #define IPU3_PT_ORDER		(IPU3_PT_SIZE >> PAGE_SHIFT)
 
-#define IPU3_ADDR2PTE(addr)	((addr) >> IPU3_PAGE_SHIFT)
+static u32 ipu3_addr2pte(phys_addr_t addr)
+{
+	return addr >> IPU3_PAGE_SHIFT;
+}
+
 #define IPU3_PTE2ADDR(pte)	((phys_addr_t)(pte) << IPU3_PAGE_SHIFT)
 
 #define IPU3_L2PT_SHIFT		IPU3_PT_BITS
@@ -200,7 +204,7 @@ static u32 *imgu_mmu_get_l2pt(struct imgu_mmu *mmu, u32 l1pt_idx)
 	l2pt = new_l2pt;
 	mmu->l2pts[l1pt_idx] = new_l2pt;
 
-	pteval = IPU3_ADDR2PTE(virt_to_phys(new_l2pt));
+	pteval = ipu3_addr2pte(virt_to_phys(new_l2pt));
 	mmu->l1pt[l1pt_idx] = pteval;
 
 	spin_unlock_irqrestore(&mmu->lock, flags);
@@ -230,7 +234,7 @@ static int __imgu_mmu_map(struct imgu_mmu *mmu, unsigned long iova,
 		return -EBUSY;
 	}
 
-	l2pt[l2pt_idx] = IPU3_ADDR2PTE(paddr);
+	l2pt[l2pt_idx] = ipu3_addr2pte(paddr);
 
 	spin_unlock_irqrestore(&mmu->lock, flags);
 
@@ -447,7 +451,7 @@ struct imgu_mmu_info *imgu_mmu_init(struct device *parent, void __iomem *base)
 	mmu->dummy_page = (void *)__get_free_page(GFP_KERNEL);
 	if (!mmu->dummy_page)
 		goto fail_group;
-	pteval = IPU3_ADDR2PTE(virt_to_phys(mmu->dummy_page));
+	pteval = ipu3_addr2pte(virt_to_phys(mmu->dummy_page));
 	mmu->dummy_page_pteval = pteval;
 
 	/*
@@ -457,7 +461,7 @@ struct imgu_mmu_info *imgu_mmu_init(struct device *parent, void __iomem *base)
 	mmu->dummy_l2pt = imgu_mmu_alloc_page_table(pteval);
 	if (!mmu->dummy_l2pt)
 		goto fail_dummy_page;
-	pteval = IPU3_ADDR2PTE(virt_to_phys(mmu->dummy_l2pt));
+	pteval = ipu3_addr2pte(virt_to_phys(mmu->dummy_l2pt));
 	mmu->dummy_l2pt_pteval = pteval;
 
 	/*
@@ -473,7 +477,7 @@ struct imgu_mmu_info *imgu_mmu_init(struct device *parent, void __iomem *base)
 	if (!mmu->l1pt)
 		goto fail_l2pts;
 
-	pteval = IPU3_ADDR2PTE(virt_to_phys(mmu->l1pt));
+	pteval = ipu3_addr2pte(virt_to_phys(mmu->l1pt));
 	writel(pteval, mmu->base + REG_L1_PHYS);
 	imgu_mmu_tlb_invalidate(mmu);
 	imgu_mmu_set_halt(mmu, false);
@@ -529,7 +533,7 @@ void imgu_mmu_resume(struct imgu_mmu_info *info)
 
 	imgu_mmu_set_halt(mmu, true);
 
-	pteval = IPU3_ADDR2PTE(virt_to_phys(mmu->l1pt));
+	pteval = ipu3_addr2pte(virt_to_phys(mmu->l1pt));
 	writel(pteval, mmu->base + REG_L1_PHYS);
 
 	imgu_mmu_tlb_invalidate(mmu);
-- 
2.34.1

