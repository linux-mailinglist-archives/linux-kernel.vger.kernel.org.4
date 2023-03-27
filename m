Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060A6C9A55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjC0DqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0Dp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:45:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D93C31
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:45:56 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PlJby6q14zL66b;
        Mon, 27 Mar 2023 11:45:02 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 11:45:29 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] kmsan: fix a stale comment in kmsan_save_stack_with_flags()
Date:   Mon, 27 Mar 2023 11:41:49 +0800
Message-ID: <20230327034149.942-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 446ec83805dd ("mm/page_alloc: use might_alloc()") and
commit 84172f4bb752 ("mm/page_alloc: combine __alloc_pages and
__alloc_pages_nodemask"), the comment is no longer accurate.
Flag '__GFP_DIRECT_RECLAIM' is clear enough on its own, so remove the
comment rather than update it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/kmsan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index f710257d68670ee..7d1e4aa30bae622 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -73,7 +73,7 @@ depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
 
 	nr_entries = stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
 
-	/* Don't sleep (see might_sleep_if() in __alloc_pages_nodemask()). */
+	/* Don't sleep. */
 	flags &= ~__GFP_DIRECT_RECLAIM;
 
 	handle = __stack_depot_save(entries, nr_entries, flags, true);
-- 
2.25.1

