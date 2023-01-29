Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B4D67FCAC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 04:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjA2DrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 22:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2DrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 22:47:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B44126
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 19:47:12 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P4HJS4DG6z16MZW;
        Sun, 29 Jan 2023 11:45:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 11:47:09 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Ma Wupeng <mawupeng1@huawei.com>
Subject: [PATCH resend] mm: memcg: fix NULL pointer in mem_cgroup_track_foreign_dirty_slowpath()
Date:   Sun, 29 Jan 2023 12:09:45 +0800
Message-ID: <20230129040945.180629-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
References: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 18365225f044 ("hwpoison, memcg: forcibly uncharge LRU pages"),
hwpoison will forcibly uncharg a LRU hwpoisoned page, the folio_memcg
could be NULl, then, mem_cgroup_track_foreign_dirty_slowpath() could
occurs a NULL pointer dereference, let's do not record the foreign
writebacks for folio memcg is null in mem_cgroup_track_foreign_dirty()
to fix it.

Reported-by: Ma Wupeng <mawupeng1@huawei.com>
Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
resend: correct function name
 include/linux/memcontrol.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index eb6e5b18e1ad..35478695cabf 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1688,10 +1688,13 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
 						  struct bdi_writeback *wb)
 {
+	struct mem_cgroup *memcg;
+
 	if (mem_cgroup_disabled())
 		return;
 
-	if (unlikely(&folio_memcg(folio)->css != wb->memcg_css))
+	memcg = folio_memcg(folio);
+	if (unlikely(memcg && &memcg->css != wb->memcg_css))
 		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
 }
 
-- 
2.35.3

