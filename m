Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5896A0A81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjBWN21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjBWN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:28:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C516AFD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:27:54 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id bh1so12833262plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrlDcamq7Bi2YsIBW+HX78wqxYPHwSepVRJN6rWNlHI=;
        b=ZOzVR5Mq59QyAziI48QmC8waUhSJJ+JNAgYhrkofGCSeV4WavcSYIdZxOhkoYD32Uy
         lN22vIocIhlb1bTeM1MN3wOb2DPCrzoU9gEV0RzEOao1nVLaad65GzZ9eoRcdfu0yRIw
         1AkgXLFFTpYJ6QCOy8HEgbyCf1dvNFXPCDLEPMYBpU2SBjVJ7fChrOZSBnJtmdulnM/u
         HHQn+mpyQ5p/8kzqT6hdqMUVjI0tcFTrz6VAVhYe2PsK4L3DmoGMWmnMb9trM8hOJWbn
         4brJwLGR5uq6FPraW/MLHJfslc46DMOsDOrC999BVws6VMn/wx8kKhcEVvTP+hlgyV13
         Yc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrlDcamq7Bi2YsIBW+HX78wqxYPHwSepVRJN6rWNlHI=;
        b=QOM0+y1mNSYhpyVxPKNm7oIchsuYiv+OEGzeFHJr6frBsUelAziqpBuG32c6aD9AKz
         nF1aV6b0zM/3VoQshrOYhyj+O5gfdpQc9v5LeczeSxO5Kk79nPPaya4CKxEclzIt+kya
         mACxL6PUeElo1uFMZ71kB2GYBxTXpbHnJHDpTQ2Gy5dCwe87Aqm2crqx6RcnC2NghEIK
         f0AevcxwGmp01lhcyGEsCvmCDBOTddQNVpZCDb5GAL548XN5iQ2awvHr2pI45CapD0bR
         saQalVEyIHJh+6AJ1NSPGhjznhlX79mgC+h96Tt71CUvW4s/9VOn9MRt/VZvWqit2SKp
         bavw==
X-Gm-Message-State: AO0yUKV2QX8p40BX+ARlpmsguJd0RM/v+PUbuJMeT5pEKKEPh/JazWa8
        9cmf6cneE9xgLJ1S92ZvUtZHGw==
X-Google-Smtp-Source: AK7set/Q5vUZSF1XZejx+2VH547lt1MLTL0Wio2yOw08/SNhuOs+jhsXUnSmQScf+sU82FAyj/kmPA==
X-Received: by 2002:a05:6a20:6914:b0:c7:5700:30bb with SMTP id q20-20020a056a20691400b000c7570030bbmr6050862pzj.4.1677158874314;
        Thu, 23 Feb 2023 05:27:54 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b005a9bf65b591sm3848591pfo.135.2023.02.23.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:27:54 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 1/7] mm: vmscan: add a map_nr_max field to shrinker_info
Date:   Thu, 23 Feb 2023 21:27:19 +0800
Message-Id: <20230223132725.11685-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
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

No functional changes.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h |  1 +
 mm/vmscan.c                | 29 ++++++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

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
index 9c1c5e8b24b8..9f895ca6216c 100644
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
@@ -240,12 +247,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		if (!old)
 			return 0;
 
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
@@ -295,6 +306,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 		}
 		info->nr_deferred = (atomic_long_t *)(info + 1);
 		info->map = (void *)info->nr_deferred + defer_size;
+		info->map_nr_max = shrinker_nr_max;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	up_write(&shrinker_rwsem);
@@ -302,12 +314,6 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
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
@@ -316,7 +322,7 @@ static int expand_shrinker_info(int new_id)
 	int old_map_size, old_defer_size = 0;
 	struct mem_cgroup *memcg;
 
-	if (!need_expand(new_nr_max))
+	if (!need_expand(new_nr_max, shrinker_nr_max))
 		goto out;
 
 	if (!root_mem_cgroup)
@@ -332,7 +338,8 @@ static int expand_shrinker_info(int new_id)
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
 		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
-					       old_map_size, old_defer_size);
+					       old_map_size, old_defer_size,
+					       new_nr_max);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
 			goto out;
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

