Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17A36F47FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjEBQJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjEBQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:09:31 -0400
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [IPv6:2001:41d0:1004:224b::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B32D79
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:09:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683043768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/o5KjzCfkDqLZEgd6My+xebtVjdTGEDkH8rtVpTuiI=;
        b=IOW3TxD7mQFM3cSirOEqkWfTreKFOytB5wnvSIWgdIE5LdcHx6/C8iFldrSkpepWn3pO1X
        GW0Qhg/8UOxiky1J59iFD0QN/l1XYb5fVTpqZ8JVJbinwCWAbcp7ivrh67jqD7pe/l0XPO
        KUjtx9uNRHcRn+hiCbrfChx5FgUlHdo=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v2 2/2] mm: memcg: use READ_ONCE()/WRITE_ONCE() to access stock->cached
Date:   Tue,  2 May 2023 09:08:39 -0700
Message-Id: <20230502160839.361544-2-roman.gushchin@linux.dev>
In-Reply-To: <20230502160839.361544-1-roman.gushchin@linux.dev>
References: <20230502160839.361544-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memcg pointer in the percpu stock can be accessed by drain_all_stock()
from another cpu in a lockless way.
In theory it might lead to an issue, similar to the one which has been
discovered with stock->cached_objcg, where the pointer was zeroed
between the check for being NULL and dereferencing.
In this case the issue is unlikely a real problem, but to make it
bulletproof and similar to stock->cached_objcg, let's annotate all
accesses to stock->cached with READ_ONCE()/WTRITE_ONCE().

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c823c35c2ed4..1e364ad495a3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2275,7 +2275,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
+	if (memcg == READ_ONCE(stock->cached) && stock->nr_pages >= nr_pages) {
 		stock->nr_pages -= nr_pages;
 		ret = true;
 	}
@@ -2290,7 +2290,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 static void drain_stock(struct memcg_stock_pcp *stock)
 {
-	struct mem_cgroup *old = stock->cached;
+	struct mem_cgroup *old = READ_ONCE(stock->cached);
 
 	if (!old)
 		return;
@@ -2303,7 +2303,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 	}
 
 	css_put(&old->css);
-	stock->cached = NULL;
+	WRITE_ONCE(stock->cached, NULL);
 }
 
 static void drain_local_stock(struct work_struct *dummy)
@@ -2338,10 +2338,10 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 
 	stock = this_cpu_ptr(&memcg_stock);
-	if (stock->cached != memcg) { /* reset if necessary */
+	if (READ_ONCE(stock->cached) != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
-		stock->cached = memcg;
+		WRITE_ONCE(stock->cached, memcg);
 	}
 	stock->nr_pages += nr_pages;
 
@@ -2383,7 +2383,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		bool flush = false;
 
 		rcu_read_lock();
-		memcg = stock->cached;
+		memcg = READ_ONCE(stock->cached);
 		if (memcg && stock->nr_pages &&
 		    mem_cgroup_is_descendant(memcg, root_memcg))
 			flush = true;
-- 
2.40.1

