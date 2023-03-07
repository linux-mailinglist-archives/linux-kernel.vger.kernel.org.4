Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0A6AD7D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCGG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjCGG5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:57:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8087848DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:56:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso11048881pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678172189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER53Y4QROl37259eb6APCiUTawgi9lN6yGxvXXCwSQY=;
        b=e8fFg/1ZMWrDBYFiJGMfpaUyPuJWpCLpWWZq+9/2MnqY7SWb0mfveVeBZnGqQEScRg
         SRpcjengd7bibS0+sCjtTNAacG5ZTh6UzMHGYHGhLesxbisy2K8z9u5WBafxqENJ3cle
         +aareyjuZRIYh2a2Es/Zb9QV30TYYKVFPL1aymJscHSeoeSE0VJP3FXWjmFFNrBEf2bt
         qFIAa0MZmcpqbFGrop17AAgZicTZfc+oz5iTO0ILfWsXzt07POPSqui0chCoPVnuTfpa
         jEpmE0LmM4BFlo/QSmO5S+SEmZWa4v5rkEHKIznIKzxalv0FQT/NqtWCuLU5TuTPr1k7
         kJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER53Y4QROl37259eb6APCiUTawgi9lN6yGxvXXCwSQY=;
        b=OoWQe99pMt8R+oCbBgCHxTNBphX9YG6m6QhfmrkoqZNMjihvHwLSIYpSeeiMUmYEFV
         OUFYU87oHPipXPz9Hkk2wd9VpG2Aq/HlzVakdBwXLaY1d+2aiERye3AiXhENzZIEjHwj
         +73IGTR6QtXrU/iIo/5rOrFfPLlEt+ZZ/HehrUMwZ/Zk8oHeRx464Gk1fqsF7EEaXHK+
         /+Gov2WBwOsRt69QMdn/UkUL6NRnwIz6zKJOYj82uVWn0cjcJCFM3hNaXsgqcaAgX+XI
         TATPDo24Nx2eChjRjqf5e/6fmaB2tPKrvoQbJDGSzuOEXk2zW5xdZ6YzqiG3XIV9cyTR
         mrRQ==
X-Gm-Message-State: AO0yUKVqJsZ/LpJYHUZoKKqavxpKs3QazA3QOpfOGbKX5fO7C1z7qRrS
        ZyEdBLj6PxohgFQ5g76Ub+LsBg==
X-Google-Smtp-Source: AK7set93IUuefTEJlKAupAfnJncofKj6xEUjv3QuTx2o0at5hbUln/n/Dabc1bi7Ww06YH0cGT/21Q==
X-Received: by 2002:a05:6a20:8404:b0:c0:2875:9e8c with SMTP id c4-20020a056a20840400b000c028759e8cmr16929564pzd.1.1678172189271;
        Mon, 06 Mar 2023 22:56:29 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b00608dae58695sm7230854pfi.209.2023.03.06.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:56:28 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 1/8] mm: vmscan: add a map_nr_max field to shrinker_info
Date:   Tue,  7 Mar 2023 14:55:58 +0800
Message-Id: <20230307065605.58209-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for the subsequent lockless memcg slab shrink,
add a map_nr_max field to struct shrinker_info to records
its own real shrinker_nr_max.

Suggested-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h |  1 +
 mm/vmscan.c                | 41 ++++++++++++++++++++++----------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b6eda2ab205d..aa69ea98e2d8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -97,6 +97,7 @@ struct shrinker_info {
 	struct rcu_head rcu;
 	atomic_long_t *nr_deferred;
 	unsigned long *map;
+	int map_nr_max;
 };
 
 struct lruvec_stats_percpu {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9414226218f0..2dcc01682026 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -224,9 +224,16 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 					 lockdep_is_held(&shrinker_rwsem));
 }
 
+static inline bool need_expand(int new_nr_max, int old_nr_max)
+{
+	return round_up(new_nr_max, BITS_PER_LONG) >
+	       round_up(old_nr_max, BITS_PER_LONG);
+}
+
 static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 				    int map_size, int defer_size,
-				    int old_map_size, int old_defer_size)
+				    int old_map_size, int old_defer_size,
+				    int new_nr_max)
 {
 	struct shrinker_info *new, *old;
 	struct mem_cgroup_per_node *pn;
@@ -240,12 +247,17 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		if (!old)
 			return 0;
 
+		/* Already expanded this shrinker_info */
+		if (!need_expand(new_nr_max, old->map_nr_max))
+			continue;
+
 		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
 		if (!new)
 			return -ENOMEM;
 
 		new->nr_deferred = (atomic_long_t *)(new + 1);
 		new->map = (void *)new->nr_deferred + defer_size;
+		new->map_nr_max = new_nr_max;
 
 		/* map: set all old bits, clear all new bits */
 		memset(new->map, (int)0xff, old_map_size);
@@ -295,6 +307,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 		}
 		info->nr_deferred = (atomic_long_t *)(info + 1);
 		info->map = (void *)info->nr_deferred + defer_size;
+		info->map_nr_max = shrinker_nr_max;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	up_write(&shrinker_rwsem);
@@ -302,23 +315,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	return ret;
 }
 
-static inline bool need_expand(int nr_max)
-{
-	return round_up(nr_max, BITS_PER_LONG) >
-	       round_up(shrinker_nr_max, BITS_PER_LONG);
-}
-
 static int expand_shrinker_info(int new_id)
 {
 	int ret = 0;
-	int new_nr_max = new_id + 1;
+	int new_nr_max = round_up(new_id + 1, BITS_PER_LONG);
 	int map_size, defer_size = 0;
 	int old_map_size, old_defer_size = 0;
 	struct mem_cgroup *memcg;
 
-	if (!need_expand(new_nr_max))
-		goto out;
-
 	if (!root_mem_cgroup)
 		goto out;
 
@@ -332,7 +336,8 @@ static int expand_shrinker_info(int new_id)
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
-					       old_map_size, old_defer_size);
+					       old_map_size, old_defer_size,
+					       new_nr_max);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
 			goto out;
@@ -352,9 +357,11 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 
 		rcu_read_lock();
 		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
-		/* Pairs with smp mb in shrink_slab() */
-		smp_mb__before_atomic();
-		set_bit(shrinker_id, info->map);
+		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
+			/* Pairs with smp mb in shrink_slab() */
+			smp_mb__before_atomic();
+			set_bit(shrinker_id, info->map);
+		}
 		rcu_read_unlock();
 	}
 }
@@ -432,7 +439,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
-		for (i = 0; i < shrinker_nr_max; i++) {
+		for (i = 0; i < child_info->map_nr_max; i++) {
 			nr = atomic_long_read(&child_info->nr_deferred[i]);
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
@@ -899,7 +906,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (unlikely(!info))
 		goto unlock;
 
-	for_each_set_bit(i, info->map, shrinker_nr_max) {
+	for_each_set_bit(i, info->map, info->map_nr_max) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
-- 
2.20.1

