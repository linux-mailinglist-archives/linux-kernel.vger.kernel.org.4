Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E2B5B33E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiIIJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiIIJ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:26:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57497D5737
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:25:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP9VV3gN1zmVLC;
        Fri,  9 Sep 2022 17:21:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 17:25:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 15/16] mm/page_alloc: remove obsolete gfpflags_normal_context()
Date:   Fri, 9 Sep 2022 17:24:50 +0800
Message-ID: <20220909092451.24883-16-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220909092451.24883-1-linmiaohe@huawei.com>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit dacb5d8875cc ("tcp: fix page frag corruption on page
fault"), there's no caller of gfpflags_normal_context(). Remove it
as this helper is strictly tied to the sk page frag usage and there
won't be other user in the future.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/gfp.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ea6cb9399152..ef4aea3b356e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -36,29 +36,6 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
 }
 
-/**
- * gfpflags_normal_context - is gfp_flags a normal sleepable context?
- * @gfp_flags: gfp_flags to test
- *
- * Test whether @gfp_flags indicates that the allocation is from the
- * %current context and allowed to sleep.
- *
- * An allocation being allowed to block doesn't mean it owns the %current
- * context.  When direct reclaim path tries to allocate memory, the
- * allocation context is nested inside whatever %current was doing at the
- * time of the original allocation.  The nested allocation may be allowed
- * to block but modifying anything %current owns can corrupt the outer
- * context's expectations.
- *
- * %true result from this function indicates that the allocation context
- * can sleep and use anything that's associated with %current.
- */
-static inline bool gfpflags_normal_context(const gfp_t gfp_flags)
-{
-	return (gfp_flags & (__GFP_DIRECT_RECLAIM | __GFP_MEMALLOC)) ==
-		__GFP_DIRECT_RECLAIM;
-}
-
 #ifdef CONFIG_HIGHMEM
 #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
 #else
-- 
2.23.0

