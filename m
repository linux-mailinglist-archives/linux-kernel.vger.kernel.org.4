Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB967AB00
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjAYHgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjAYHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:36:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D843457
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674632156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1+Ul5sQzoaw3CKL+Rr3WW09PeQYvbUe0nkd8DHiRlc0=;
        b=dekaFMgEkNAX/BhHGbGph44K2HgSP8qDPl9IQHon3PZ4NJ0NNk9XlhxpUcfftryKp2Ej7Q
        DqZ/j7/wVZG7yOIuOIKWuryuA7cQvNR9GtQxtwMptvBE3KXLN4z/Vvbi8tXouihaYgcMLN
        +knAf4QuTh5iE7oq7bsUPxxEC1u0eck=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-gfHaajAoPI-POjm3Cq7Y9A-1; Wed, 25 Jan 2023 02:35:55 -0500
X-MC-Unique: gfHaajAoPI-POjm3Cq7Y9A-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-15fe7396eb4so4588179fac.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+Ul5sQzoaw3CKL+Rr3WW09PeQYvbUe0nkd8DHiRlc0=;
        b=K2GyaO8RZiypo436qeWpLq6OAD809Nfgpa3OShPhz0OCAacG9DM/Uz2gqNJ9YH57rs
         nlVq9qirBZjl7uOvGGIyR2vIENjGpshevD6ge2h0xNyQ0PDamx2f9AMH5sAg6nXgUAp4
         PX+maNW9wNaFK8HxGY30VzK/7fQfDIUSlroEyz2L83xcSfmri3U8B2K7KI0Oqqjnblxb
         70cJD4I9VQoDkwB2WpxbUBwOF9yZnJjKr8GfZxc0i78RiKZ19bZrTZIEDiY4UCHBF1v5
         2gXL6FB3FUJvQdgjIu8PFwzuIwVkP5MQGrq/A8ahrn8fmmTsvnuTHGRU7rvfYLMiwLVg
         pgQg==
X-Gm-Message-State: AFqh2kri+IUsweoncuCeK8R+PPIU1dIIzVJI+carphH6Dq/PB9ZrViPz
        njpD7aEn4qnza1efyMRQm7VTC08FSS9NuW7Mf42GDVyMSGpUabTpt9n6JZCTB+NQqmlG6+oDg4/
        3r/UaMVb20BoKiiMr1Lwd8Jmu
X-Received: by 2002:a05:6870:9124:b0:15f:c278:ef49 with SMTP id o36-20020a056870912400b0015fc278ef49mr9943008oae.6.1674632154323;
        Tue, 24 Jan 2023 23:35:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsrBVKLDiSLeQadT62Qslz+uBK/ThJ9hDHTsthiDQWfDXU1byL6/MWOVePm8CfYx4MAxndfSg==
X-Received: by 2002:a05:6870:9124:b0:15f:c278:ef49 with SMTP id o36-20020a056870912400b0015fc278ef49mr9943000oae.6.1674632154115;
        Tue, 24 Jan 2023 23:35:54 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id x189-20020a4a41c6000000b0050dc79bb80esm1538802ooa.27.2023.01.24.23.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:35:53 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] mm/memcontrol: Change stock_lock type from local_lock_t to spinlock_t
Date:   Wed, 25 Jan 2023 04:34:59 -0300
Message-Id: <20230125073502.743446-3-leobras@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125073502.743446-1-leobras@redhat.com>
References: <20230125073502.743446-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this context, since it's using per-cpu variables, changing from
local_lock to spinlock should not deal much impact in performance and can
allow operations such as stock draining to happen in remote cpus.

Why performance would probably not get impacted:
1 - Since the lock is in the same cache line as the information that is
    written next, there is no much extra memory access cost for using the
    lock.
2 - Since it's a percpu struct, there should be rare for other cpu to share
    this cacheline, so there should be rare to need cacheline invalidation,
    and writing  to the lock should be cheap since there is always a
    write to next struct members.
3 - Even the write in (2) could be pipelined and batched with following
    writes to the cacheline (such as nr_pages member), further decreasing
    the impact of this change.

Suggested-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f8e86b88b3c7a..1d5c108413c83 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2172,7 +2172,7 @@ void unlock_page_memcg(struct page *page)
 }
 
 struct memcg_stock_pcp {
-	local_lock_t stock_lock;
+	spinlock_t stock_lock; /* Protects the percpu struct */
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
@@ -2190,7 +2190,7 @@ struct memcg_stock_pcp {
 };
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+	.stock_lock = __SPIN_LOCK_UNLOCKED(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
@@ -2235,15 +2235,15 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
+
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
 		stock->nr_pages -= nr_pages;
 		ret = true;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 
 	return ret;
 }
@@ -2280,14 +2280,14 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
+
 	old = drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 }
@@ -2315,10 +2315,12 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
+	struct memcg_stock_pcp *stock;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
 	__refill_stock(memcg, nr_pages);
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 }
 
 /*
@@ -3165,8 +3167,8 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	unsigned long flags;
 	int *bytes;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
 
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
@@ -3218,7 +3220,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 }
@@ -3229,15 +3231,15 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
+
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 
 	return ret;
 }
@@ -3327,9 +3329,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
+
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
 		old = drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
@@ -3345,7 +3347,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 
-- 
2.39.1

