Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059AC5F72A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiJGBxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJGBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:53:13 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC5AA3CC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:53:11 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 2971r3ga065216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 7 Oct 2022 09:53:03 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 7 Oct 2022 09:53:02 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <steve.kang@unisoc.com>
Subject: [Resend PATCH] mm: add stackdepot information on page->private for tracking
Date:   Fri, 7 Oct 2022 09:52:41 +0800
Message-ID: <1665107561-23030-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 2971r3ga065216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Private is vacant for most of Non-LRU pages while the user has explicitly
operation on page->private via set_page_private, I would like introduce
stackdepot information on page->private for a simplified tracking mechanism
which could be help for kernel driver's memory leak.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/page_alloc.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d4..b79a503 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -75,6 +75,7 @@
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
 #include <linux/delayacct.h>
+#include <linux/stackdepot.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -2464,6 +2465,25 @@ static inline bool should_skip_init(gfp_t flags)
 	return (flags & __GFP_SKIP_ZERO);
 }
 
+#ifdef CONFIG_STACKDEPOT
+static noinline depot_stack_handle_t set_track_prepare(void)
+{
+       depot_stack_handle_t trace_handle;
+       unsigned long entries[16];
+       unsigned int nr_entries;
+
+       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
+       trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+
+       return trace_handle;
+}
+#else
+static inline depot_stack_handle_t set_track_prepare(void)
+{
+       return 0;
+}
+#endif
+
 inline void post_alloc_hook(struct page *page, unsigned int order,
 				gfp_t gfp_flags)
 {
@@ -2471,8 +2491,14 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 			!should_skip_init(gfp_flags);
 	bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
 	int i;
+	depot_stack_handle_t stack_handle = set_track_prepare();
 
-	set_page_private(page, 0);
+	/*
+	 * Don't worry, user will cover private directly without checking
+	 * this field and has ability to trace the page. This also will not
+	 * affect expected state when freeing
+	 */
+	set_page_private(page, stack_handle);
 	set_page_refcounted(page);
 
 	arch_alloc_page(page, order);
-- 
1.9.1

