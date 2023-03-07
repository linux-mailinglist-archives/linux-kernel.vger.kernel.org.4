Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D246AD7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCGG6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCGG5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:57:47 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575D88D9D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:56:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a9so13057180plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 22:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678172203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rhvfVxo/VIqlZiNKGwl0zk05JZT0WS+du3pcLhwX24=;
        b=iOzGoBBFwi7lf9XHmfcZfShTltMjKW7fB7JTbgosxQmnrGMtoxbAgVo1GO+pB9geGD
         ux0EoYY0pV+ERjF8F18TEfHq9gvIyT4dhtCOozSdJ5U3Uc7KDQZjV/RZ0bw9vjZZGL8h
         6AvKxfXxIsouFF4LnTb66UYjTB0h3F16LVfPmemtGR2hTzHJvTn0cjtGnyb6+IXsRvFv
         yWUb+9Dses9zqWd2+QitUQbqI7oCCIQFPmCp3hOV3Kywr901CALSY+b2ZE0aQz5c+ubl
         QFR4X7Ka+3ROzvlIIttem0P+mhUUNQnXkpmli1fLe9fgOOGOH4R00OxZ5OvRzTgdpGxM
         QZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rhvfVxo/VIqlZiNKGwl0zk05JZT0WS+du3pcLhwX24=;
        b=ViHArO+ruGALDjkiGiUi1C/fnSOKjAIxOgRK5E7HFkW6a7LOkGmHWnnSnFJ9wXhFgQ
         9U/ku2w+UbBsuYJNeHjYxeQUiVOyrF5Mlg3JDeuVoL5MQgSCr4gyGHqm14Nj3PTUGgAM
         2e83EJBAApLn5TR4zvLGHZNCpYhWH6ApWEF20qlTI8srnjXBS3aJgvZ24Po5NrnnngsF
         YyUQfm/yPaUZv7wbp09RcImUlEwHturySmgCS2zCvzaMqHbxqE5jxOe/m/eMtUbLqs2a
         eadnkCZwQrbG5HKnY2/zl0jLmJgG+BgfSftWKuvSvmrzJKPwt4Ci8JRY/MfUlAMJd0zL
         8SjQ==
X-Gm-Message-State: AO0yUKVT7RDsQI9oMyvPwt4cRTgKSIm4uct6sQ4R1x24DvE2VG5fnQNq
        6B8dxhNlUuseZ/ynHx/l7Ltx7A==
X-Google-Smtp-Source: AK7set/e/2R01sRD84O4F/1HOwtTPn1OBW88UmvnVs6OndVpcmZVVmumCYjm8VTdPHpr5b8MxHJzjA==
X-Received: by 2002:a05:6a20:1585:b0:cb:c276:58bb with SMTP id h5-20020a056a20158500b000cbc27658bbmr14626109pzj.4.1678172203481;
        Mon, 06 Mar 2023 22:56:43 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b00608dae58695sm7230854pfi.209.2023.03.06.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:56:43 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 3/8] mm: vmscan: make memcg slab shrink lockless
Date:   Tue,  7 Mar 2023 14:56:00 +0800
Message-Id: <20230307065605.58209-4-zhengqi.arch@bytedance.com>
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

Like global slab shrink, this commit also uses SRCU to make
memcg slab shrink lockless.

We can reproduce the down_read_trylock() hotspot through the
following script:

```

DIR="/root/shrinker/memcg/mnt"

do_create()
{
    mkdir -p /sys/fs/cgroup/memory/test
    mkdir -p /sys/fs/cgroup/perf_event/test
    echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
    for i in `seq 0 $1`;
    do
        mkdir -p /sys/fs/cgroup/memory/test/$i;
        echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
        echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
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
        echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
            dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
    done
}

case "$1" in
  touch)
    do_touch $2 $3
    ;;
  test)
      do_create 4000
    do_mount 0 4000
    do_touch 0 3000
    ;;
  *)
    exit 1
    ;;
esac
```

Save the above script, then run test and touch commands.
Then we can use the following perf command to view hotspots:

perf top -U -F 999

1) Before applying this patchset:

  32.31%  [kernel]           [k] down_read_trylock
  19.40%  [kernel]           [k] pv_native_safe_halt
  16.24%  [kernel]           [k] up_read
  15.70%  [kernel]           [k] shrink_slab
   4.69%  [kernel]           [k] _find_next_bit
   2.62%  [kernel]           [k] shrink_node
   1.78%  [kernel]           [k] shrink_lruvec
   0.76%  [kernel]           [k] do_shrink_slab

2) After applying this patchset:

  27.83%  [kernel]           [k] _find_next_bit
  16.97%  [kernel]           [k] shrink_slab
  15.82%  [kernel]           [k] pv_native_safe_halt
   9.58%  [kernel]           [k] shrink_node
   8.31%  [kernel]           [k] shrink_lruvec
   5.64%  [kernel]           [k] do_shrink_slab
   3.88%  [kernel]           [k] mem_cgroup_iter

At the same time, we use the following perf command to capture
IPC information:

perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10

1) Before applying this patchset:

 Performance counter stats for 'system wide' (5 runs):

      454187219766      cycles                    test                    ( +-  1.84% )
       78896433101      instructions              test #    0.17  insn per cycle           ( +-  0.44% )

        10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )

2) After applying this patchset:

 Performance counter stats for 'system wide' (5 runs):

      841954709443      cycles                    test                    ( +- 15.80% )  (98.69%)
      527258677936      instructions              test #    0.63  insn per cycle           ( +- 15.11% )  (98.68%)

          10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )

We can see that IPC drops very seriously when calling
down_read_trylock() at high frequency. After using SRCU,
the IPC is at a normal level.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8515ac40bcaf..1de9bc3e5aa2 100644
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

