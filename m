Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC996E57DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDRDeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDRDeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:34:13 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16B81FCA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:34:09 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 33I3XRlX088878;
        Tue, 18 Apr 2023 11:33:27 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 18 Apr 2023 11:33:23 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: fix printk format within cma
Date:   Tue, 18 Apr 2023 11:33:09 +0800
Message-ID: <1681788789-19679-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 33I3XRlX088878
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

cma and page pointer printed via %p are hash value which make debug to be hard.
change them to %px.

[63321.482751] [c7] cma: cma_alloc(): memory range at 000000000b5e462c is busy, retrying
[63321.482786] [c7] cma: cma_alloc(): memory range at 000000000f7d6fae is busy, retrying
[63321.482823] [c7] cma: cma_alloc(): memory range at 00000000e653b59b is busy, retrying
[63322.378890] [c7] cma: cma_release(page 00000000dd53cf48)
[63322.378913] [c7] cma: cma_release(page 00000000315f703d)
[63322.378925] [c7] cma: cma_release(page 00000000791e3a5f)

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/cma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 4a978e0..dfe9813 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -435,7 +435,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (!cma || !cma->count || !cma->bitmap)
 		goto out;
 
-	pr_debug("%s(cma %p, count %lu, align %d)\n", __func__, (void *)cma,
+	pr_debug("%s(cma %px, count %lu, align %d)\n", __func__, (void *)cma,
 		 count, align);
 
 	if (!count)
@@ -534,7 +534,7 @@ bool cma_pages_valid(struct cma *cma, const struct page *pages,
 	pfn = page_to_pfn(pages);
 
 	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count) {
-		pr_debug("%s(page %p, count %lu)\n", __func__,
+		pr_debug("%s(page %px, count %lu)\n", __func__,
 						(void *)pages, count);
 		return false;
 	}
@@ -560,7 +560,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
 	if (!cma_pages_valid(cma, pages, count))
 		return false;
 
-	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
+	pr_debug("%s(page %px, count %lu)\n", __func__, (void *)pages, count);
 
 	pfn = page_to_pfn(pages);
 
-- 
1.9.1

