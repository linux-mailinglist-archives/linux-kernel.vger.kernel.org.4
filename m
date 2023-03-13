Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F16B75FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCMLaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCMLaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:30:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2F4C6FC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id n16so1816290pfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678706983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHjpkGxbHVFFSyOk4f8KxselJo2cIaqjL6okRMIx/Nw=;
        b=cMAG05THHEL45EY/ZCrlGRIbq1kt4I6LPUMAH/dQjouL+NMY60brEhRYxofz4Sc3yO
         jVllerX4euE/VSk8gxVy2qydl3B1I0ZvizXWnB/k4AlXoCTSsvfCFO9lUUclwXD/c7zx
         +Lstf6Kcx2x9pLpDuB/8MwyscxtFe5rDeDGAP/r3rkvK8Nru8nZQojqHvbsNe7a2Ab7/
         gUPJ2C1u8cgdUyoJ+NnEXAlZ1izrfSpHumWDpFe9DMlhF0rV7W8iS0Gr8SVDtkxfdNr/
         N3obCyhq6rnOWhxjxKbMgLykNy2bkGDKgby8e4YMGNLWFieQ1ksal3K4NhZ3AUVdAOK+
         UsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHjpkGxbHVFFSyOk4f8KxselJo2cIaqjL6okRMIx/Nw=;
        b=W8QPQQxqVIyFmyp8lbMo8UIKoTm3iLRfsQNS0g/u0doZJmwY60m09905ShojbH1f4r
         5uvj5mxC5bH/iXyJQQKb8wjYX0pGdVU7zLxWickgnbf5P1n+fcgDAI/RsGjAZiRUYOjq
         hdYoFnXcr5J6ijjoQlgQBW4kjzcio+4FBwnUU159O57otp9ko+xpC0u/dY7boCosYvLc
         Z5HVDVSF5f17PDh6AD4VTeQIO2pxf1E7+IfQWIQ/ngEE+Hf7z9tAFtf9+Owb/5zasrbo
         9UGty363kvrvdtDzSHrDQDszVHvyWInhMED8HlyHjiFZnkStHtRPBNE1T0PL8Fph2z00
         6F4A==
X-Gm-Message-State: AO0yUKXhf4rZ4I0WIWLpHFs5Q8XivotVrMfWX900IEbaCfG8dnvUR+GG
        NmE8oHGpB4zCj1Z2isTjim83ew==
X-Google-Smtp-Source: AK7set/7+CC2e3gj8ocPsHr26haOK3QREhbFYzVHIRff/+7vh0RhPeq9x+b/EZ+X+KieTYLWMp1SeQ==
X-Received: by 2002:a05:6a00:2148:b0:606:d3d1:4cc4 with SMTP id o8-20020a056a00214800b00606d3d14cc4mr10842399pfk.3.1678706982825;
        Mon, 13 Mar 2023 04:29:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n2-20020a654882000000b0050300a7c8c2sm4390827pgs.89.2023.03.13.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:29:42 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 1/8] mm: vmscan: add a map_nr_max field to shrinker_info
Date:   Mon, 13 Mar 2023 19:28:12 +0800
Message-Id: <20230313112819.38938-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
References: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
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

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Kirill Tkhai <tkhai@ya.ru>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h |  1 +
 mm/vmscan.c                | 35 ++++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

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
index 9414226218f0..9a2a6301052c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -226,7 +226,8 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 
 static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 				    int map_size, int defer_size,
-				    int old_map_size, int old_defer_size)
+				    int old_map_size, int old_defer_size,
+				    int new_nr_max)
 {
 	struct shrinker_info *new, *old;
 	struct mem_cgroup_per_node *pn;
@@ -240,12 +241,17 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		if (!old)
 			return 0;
 
+		/* Already expanded this shrinker_info */
+		if (new_nr_max <= old->map_nr_max)
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
@@ -295,6 +301,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 		}
 		info->nr_deferred = (atomic_long_t *)(info + 1);
 		info->map = (void *)info->nr_deferred + defer_size;
+		info->map_nr_max = shrinker_nr_max;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	up_write(&shrinker_rwsem);
@@ -302,23 +309,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
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
 
@@ -332,7 +330,8 @@ static int expand_shrinker_info(int new_id)
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
-					       old_map_size, old_defer_size);
+					       old_map_size, old_defer_size,
+					       new_nr_max);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
 			goto out;
@@ -352,9 +351,11 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 
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
@@ -432,7 +433,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
-		for (i = 0; i < shrinker_nr_max; i++) {
+		for (i = 0; i < child_info->map_nr_max; i++) {
 			nr = atomic_long_read(&child_info->nr_deferred[i]);
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
@@ -899,7 +900,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (unlikely(!info))
 		goto unlock;
 
-	for_each_set_bit(i, info->map, shrinker_nr_max) {
+	for_each_set_bit(i, info->map, info->map_nr_max) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
-- 
2.20.1

