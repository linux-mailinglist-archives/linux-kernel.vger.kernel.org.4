Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD46FF1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbjEKM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbjEKM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:59:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F4DD6E89
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:59:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6908C165C;
        Thu, 11 May 2023 05:59:53 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C26083F5A1;
        Thu, 11 May 2023 05:59:07 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: [PATCH v1 1/5] mm: vmalloc must set pte via arch code
Date:   Thu, 11 May 2023 13:58:44 +0100
Message-Id: <20230511125848.78621-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511125848.78621-1-ryan.roberts@arm.com>
References: <20230511125848.78621-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is bad practice to directly set pte entries within a pte table.
Instead all modifications must go through arch-provided helpers such as
set_pte_at() to give the arch code visibility and allow it to validate
(and potentially modify) the operation.

Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/vmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9683573f1225..d8d2fe797c55 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2899,10 +2899,13 @@ struct vmap_pfn_data {
 static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
 {
 	struct vmap_pfn_data *data = private;
+	pte_t ptent;
 
 	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
 		return -EINVAL;
-	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
+
+	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
+	set_pte_at(&init_mm, addr, pte, ptent);
 	return 0;
 }
 
-- 
2.25.1

