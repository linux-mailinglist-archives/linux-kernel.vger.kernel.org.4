Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB76368D530
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjBGLKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjBGLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:10:13 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5C37B68
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:09:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vb7Jx97_1675768181;
Received: from localhost(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0Vb7Jx97_1675768181)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 19:09:42 +0800
From:   Kaihao Bai <carlo.bai@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     anshuman.khandual@arm.com, baolin.wang@linux.alibaba.com,
        carlo.bai@linux.alibaba.com
Subject: [RFC PATCH 1/1] arm64: mm: remove unnecessary multiple tlb flush of contiguous hugetlb
Date:   Tue,  7 Feb 2023 19:09:41 +0800
Message-Id: <1675768181-41518-1-git-send-email-carlo.bai@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arm64, contiguous flag refers to the same TLB entry that shared by a
contiguous address range. If flush one entry of the address range, it
would cover the whole contiguous address range. Thus there's no need to
flush all contiguous range that CONT_PMD/PTE points to.

Signed-off-by: Kaihao Bai <carlo.bai@linux.alibaba.com>
---
 arch/arm64/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 95364e8bdc19..9213072ce9c7 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -213,7 +213,7 @@ static pte_t get_clear_contig_flush(struct mm_struct *mm,
 	pte_t orig_pte = get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
 
-	flush_tlb_range(&vma, addr, addr + (pgsize * ncontig));
+	flush_tlb_page(&vma, addr);
 	return orig_pte;
 }
 
@@ -238,7 +238,7 @@ static void clear_flush(struct mm_struct *mm,
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 
-	flush_tlb_range(&vma, saddr, addr);
+	flush_tlb_page(&vma, saddr);
 }
 
 static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
-- 
2.27.0

