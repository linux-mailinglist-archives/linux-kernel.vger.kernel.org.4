Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC56A0A83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjBWN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjBWN2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:28:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D573608B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:07 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 130so3254099pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677158887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Syv0drMPggMMkttRMMkloSH5R6RYZ1YZAM5MesH77qc=;
        b=hQ0T37qts3rJeuZtmDQARv10wVciADPxTYE7nHXMnr9/N5MAW0787FBKg4eYhKDGIR
         D+o6nrvNrTCJZgauHW1A4MDrBHjxksREY4lTnxwUa84Fsm5l7e+fbi03X46BgEoXdVQ+
         dOAn3WrLOyf4bs99Rq8TgWRjbgf9v7Q1uHlPOpcxV2y0uxirjEy5+OIZMhdR26f/63fU
         P2Pmq2VOLIEelMQtA+O9p5Iee99sRG2fY+Tl1/DItQIUTAgSBqbuxd7az9ZKW/udBx0b
         cWC6J1VhJL/7sSkSUyQ5U+ZKGWW3NEEgGBmU1h341ArROsLUeQb5G50uiU2GeEJsA+K+
         hEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677158887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Syv0drMPggMMkttRMMkloSH5R6RYZ1YZAM5MesH77qc=;
        b=RPTQQkViz2DQEbVzqRJXrhQBuEiON3WGq0wRmIufYw/xT4cjly1dHRjzMjh4dRZtUU
         e3VUaJVgWWstK0riczGgQ0OR4TVrrKa3f4vBNLqX3VmFuWq7SxzgUHTKzmRxcN9nOty7
         1xYyGgiDlkBaI4saW4xwmysY6EOAY5KDvaCzOs9bt6xKamcP/BlLPk+abEl6yk4yn9wD
         SDPs8nckfIvfDYIrfUpmHhLQwPjvvjuOgguLzt8TeFQ/i8kgIvpPu+asVhIiRaRk73Xi
         jeAJppbFiexdZUz1937mf6M92CfOOYazGaFmZCpMVvm1/SnuuHKzaOqdUAZ+BlTahgR9
         i29g==
X-Gm-Message-State: AO0yUKVLaYFi5oZ6+RVJlm60D37NAvtFxRHil88EX6deiw/bQ78XqHyq
        UDFHQOcKbh2e79ILhYxc63/uhw==
X-Google-Smtp-Source: AK7set/3KhLevmt8IbsCAmbb8GxI559C7KBiMEGLPkGOAY2YkyfrjWjj15z30QZAy/t94RwKaPBlcQ==
X-Received: by 2002:aa7:90cf:0:b0:5a9:c2d5:136c with SMTP id k15-20020aa790cf000000b005a9c2d5136cmr12399865pfk.3.1677158887363;
        Thu, 23 Feb 2023 05:28:07 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b005a9bf65b591sm3848591pfo.135.2023.02.23.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:28:07 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 3/7] mm: vmscan: make memcg slab shrink lockless
Date:   Thu, 23 Feb 2023 21:27:21 +0800
Message-Id: <20230223132725.11685-4-zhengqi.arch@bytedance.com>
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
index 02987a6f95d1..25a4a660e45f 100644
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
@@ -268,7 +282,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		       defer_size - old_defer_size);
 
 		rcu_assign_pointer(pn->shrinker_info, new);
-		kvfree_rcu(old, rcu);
+		call_srcu(&shrinker_srcu, &old->rcu, free_shrinker_info_rcu);
 	}
 
 	return 0;
@@ -357,13 +371,14 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 {
 	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
 		struct shrinker_info *info;
+		int srcu_idx;
 
-		rcu_read_lock();
-		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+		srcu_idx = srcu_read_lock(&shrinker_srcu);
+		info = shrinker_info_srcu(memcg, nid);
 		/* Pairs with smp mb in shrink_slab() */
 		smp_mb__before_atomic();
 		set_bit(shrinker_id, info->map);
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

