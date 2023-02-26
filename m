Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC06A30D5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjBZOxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjBZOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:53:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650A46BF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:49:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so7526296pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZz7Wrj6RpcNJkd0HlCRkRoarWFliGItBtXoMhl1VyQ=;
        b=OEQgF8XFhS1YnbfOQOJh1IFogO5l8aVUQrCwR9nyy7oN1K9Ji93rp0LItnd8h4XE6q
         oXvlgHNvYZY7Sru38EHw5XpbSsjVDCpErYLQOtN774iKL22Mm3meSyNn/DoDpseqe7VK
         M148czmxLrasp9EktCEGPZBaRaJCIL/h+oxW/Len8VuNVSZLJgVQPTgQZl2H0oXCxaKT
         th31uEB6vb+9QTQp2lgTemj0Wo5Eo3476YMBJNBoEXl1eXjK1lRElSTkvEo/pHe8O8zz
         kKJciJ2YT4YMKnGfyaACr4ey76nUPX2Xt475p0Ss+/Ot3sZ5uU3wsAqqCutxvYDzlxUi
         SM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZz7Wrj6RpcNJkd0HlCRkRoarWFliGItBtXoMhl1VyQ=;
        b=LAVMf7rtYuChFwk9LjoYprScrpXUZ2a8xb9PjRk7p9mL4nWq3TlQv0olhss1Km1CJE
         wSQT3A25hcZGg9YBRvc4PK8g4qZgb6VZph1euCVuQLVslQtuNFgm0sy2fkHniY4TNDpj
         2pDMfIhI4Cjpl/L+AiqKWT1J/n00s7a008R4+5bydOF4TTN8U2ree6Y0OfQnCZErtY5v
         Ey6jqf6kctQMU3F4J+Dss4ueq/ewQAgTAAX8dYae6fYyEjB6++HlrCZMl+tsZUfu7kXZ
         gdJxtgeMMJXAXr6EnD2/eH2J/bDUINcZEgdb+Ulo7qdmWxsnwHTTZY/6zGm4PG6UTjSa
         xVDg==
X-Gm-Message-State: AO0yUKVmocvjQkl7hhdIB6ay0VrLEH0BM6xwpgaJyKE+shBu6sKIGUjn
        KFVJ5JJSEItLqMk1jDwZleeVDA==
X-Google-Smtp-Source: AK7set+gayem3mXhkOe0NYaFyVrW/tJ1qNYdSQjiJZ8SAHMh4YRVx23yElXFyFWK9z6fB2W3nd2NCA==
X-Received: by 2002:a17:902:d4c8:b0:19a:7217:32af with SMTP id o8-20020a170902d4c800b0019a721732afmr23248669plg.5.1677422896084;
        Sun, 26 Feb 2023 06:48:16 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b0019c2cf12d15sm2755589plb.116.2023.02.26.06.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:48:15 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 1/8] mm: vmscan: add a map_nr_max field to shrinker_info
Date:   Sun, 26 Feb 2023 22:46:48 +0800
Message-Id: <20230226144655.79778-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 9c1c5e8b24b8..546c07ccb3bc 100644
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
+			return 0;
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

