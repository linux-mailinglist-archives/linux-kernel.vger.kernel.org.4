Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44756A30E0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjBZOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBZOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:53:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A688814213
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:49:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v11so680713plz.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvRso6AuWsz0X9JCAZwWH9GIT0TN5B8gocPlJ++Lup8=;
        b=LzQ+kcdgxQjvYV6/aBTUiIdXty1SduBzej96ViyOvdlzB3Fsg4Lcdgbz3j4hmKO+8+
         TIcLX9NYqDrIQ5/ezPI3RaFfYwQ1ZEDeoEpqbn5P8z2NLz+savfhhRBcSPVq7BwrsDXr
         R1O+OCmiRS291b9X4XNwI5b5W0qVttXgY3Oqixpog+eVUFyly+Rm9YGT9YU8Ro/3F5Pw
         d/nQ47A2O7bUl+GBn4gAU0PulKhyQ7Bu/CfMAW5zYIkO2kY76GczKehRR3kCEzOW262q
         ug1kCR6iRSBx0q+cNBVn+mB+nddqScXB+yCOQ55hN5exNnBS/N7LGAnn4tefuskRqhyI
         gJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvRso6AuWsz0X9JCAZwWH9GIT0TN5B8gocPlJ++Lup8=;
        b=HhtZSwgclEP/XebHoIteUQPhgLBJgRKHRySrYebUH6CQB1wHmMpU7u46yPLU2dcGuf
         KLwv/hd7sYlm+YVzzJS54bQX//MyxAXOakbSmiTJ7rEKiY/tBZOJXkKl2VTGGTpvdNXi
         jjq17L/aboFZnEXqxAJRyLymi5FruidXvdO8+9BvwVeOVdWHVpTZ4Hb3OgJUgZY5syT+
         tnSeT9zR1+7/XSmTW9n04lyN9VPiK4lYs/ty38O9yodaWm2XiVBlzxxGnAvfJgOwKFh6
         ksC3IDkjYKwkyUoQwudnfnXZDZ5/W8htryt5zCHtK/9HMEWs0cLO3FVYMPWnXo5t3QgS
         fryg==
X-Gm-Message-State: AO0yUKUTQHkrXvEwvkAVUeG9zm0gphN9148oDbrsynVxVZ8QolxlU+oH
        cJC5q9xyg6M2o11Z0vGk91ZiiA==
X-Google-Smtp-Source: AK7set8spgroQQIMXk8gdX51DNtELr9O76gOJSC+OLLzgfCw5s0Vzk98NSKahnR1+3e2KLwZ3nhiFQ==
X-Received: by 2002:a17:903:230f:b0:19a:7060:948 with SMTP id d15-20020a170903230f00b0019a70600948mr21481855plh.1.1677422907679;
        Sun, 26 Feb 2023 06:48:27 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b0019c2cf12d15sm2755589plb.116.2023.02.26.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:48:27 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 3/8] mm: vmscan: make memcg slab shrink lockless
Date:   Sun, 26 Feb 2023 22:46:50 +0800
Message-Id: <20230226144655.79778-4-zhengqi.arch@bytedance.com>
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

Like global slab shrink, since commit 1cd0bd06093c
("rcu: Remove CONFIG_SRCU"), it's time to use SRCU
to protect readers who previously held shrinker_rwsem.

We can test with the following script:

```
DIR="/root/shrinker/memcg/mnt"

do_create()
{
        mkdir /sys/fs/cgroup/memory/test
        echo 200M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
        for i in `seq 0 $1`;
        do
                mkdir /sys/fs/cgroup/memory/test/$i;
                echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
                mkdir -p $DIR/$i;
        done
}

do_mount()
{
        for i in `seq $1 $2`;
        do
                mount -t tmpfs $i $DIR/$i;
        done
}

do_touch()
{
        for i in `seq $1 $2`;
        do
                echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
                dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
        done
}

do_create 2000
do_mount 0 2000
do_touch 0 1000
```

Before applying:

  46.60%  [kernel]  [k] down_read_trylock
  18.70%  [kernel]  [k] up_read
  15.44%  [kernel]  [k] shrink_slab
   4.37%  [kernel]  [k] _find_next_bit
   2.75%  [kernel]  [k] xa_load
   2.07%  [kernel]  [k] idr_find
   1.73%  [kernel]  [k] do_shrink_slab
   1.42%  [kernel]  [k] shrink_lruvec
   0.74%  [kernel]  [k] shrink_node
   0.60%  [kernel]  [k] list_lru_count_one

After applying:

  19.53%  [kernel]  [k] _find_next_bit
  14.63%  [kernel]  [k] do_shrink_slab
  14.58%  [kernel]  [k] shrink_slab
  11.83%  [kernel]  [k] shrink_lruvec
   9.33%  [kernel]  [k] __blk_flush_plug
   6.67%  [kernel]  [k] mem_cgroup_iter
   3.73%  [kernel]  [k] list_lru_count_one
   2.43%  [kernel]  [k] shrink_node
   1.96%  [kernel]  [k] super_cache_count
   1.78%  [kernel]  [k] __rcu_read_unlock
   1.38%  [kernel]  [k] __srcu_read_lock
   1.30%  [kernel]  [k] xas_descend

We can see that the readers is no longer blocked.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2a21a84d3db1..490764f8e085 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -57,6 +57,7 @@
 #include <linux/khugepaged.h>
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
+#include <linux/srcu.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -221,8 +222,21 @@ static inline int shrinker_defer_size(int nr_items)
 static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 						     int nid)
 {
-	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
-					 lockdep_is_held(&shrinker_rwsem));
+	return srcu_dereference_check(memcg->nodeinfo[nid]->shrinker_info,
+				      &shrinker_srcu,
+				      lockdep_is_held(&shrinker_rwsem));
+}
+
+static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
+						     int nid)
+{
+	return srcu_dereference(memcg->nodeinfo[nid]->shrinker_info,
+				&shrinker_srcu);
+}
+
+static void free_shrinker_info_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct shrinker_info, rcu));
 }
 
 static inline bool need_expand(int new_nr_max, int old_nr_max)
@@ -269,7 +283,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		       defer_size - old_defer_size);
 
 		rcu_assign_pointer(pn->shrinker_info, new);
-		kvfree_rcu(old, rcu);
+		call_srcu(&shrinker_srcu, &old->rcu, free_shrinker_info_rcu);
 	}
 
 	return 0;
@@ -355,15 +369,16 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 {
 	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
 		struct shrinker_info *info;
+		int srcu_idx;
 
-		rcu_read_lock();
-		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+		srcu_idx = srcu_read_lock(&shrinker_srcu);
+		info = shrinker_info_srcu(memcg, nid);
 		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
 			/* Pairs with smp mb in shrink_slab() */
 			smp_mb__before_atomic();
 			set_bit(shrinker_id, info->map);
 		}
-		rcu_read_unlock();
+		srcu_read_unlock(&shrinker_srcu, srcu_idx);
 	}
 }
 
@@ -377,7 +392,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		return -ENOSYS;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -411,7 +425,7 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 
-	info = shrinker_info_protected(memcg, nid);
+	info = shrinker_info_srcu(memcg, nid);
 	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
 }
 
@@ -420,7 +434,7 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 
-	info = shrinker_info_protected(memcg, nid);
+	info = shrinker_info_srcu(memcg, nid);
 	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
 }
 
@@ -898,15 +912,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
+	int srcu_idx;
 	int i;
 
 	if (!mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
-
-	info = shrinker_info_protected(memcg, nid);
+	srcu_idx = srcu_read_lock(&shrinker_srcu);
+	info = shrinker_info_srcu(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
@@ -956,14 +969,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 				set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
-
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	srcu_read_unlock(&shrinker_srcu, srcu_idx);
 	return freed;
 }
 #else /* CONFIG_MEMCG */
-- 
2.20.1

