Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFF6B75FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCMLa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCMLaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:30:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CBF4DE14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u5so12549026plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678706997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwHKJa6QSzn+fFUbr3GdLYPgv95cnerwTX8zoVbLwNQ=;
        b=VL291BsmdjOKqQ02b55ZkiNe1Gxiw0B9HIG72ICowrQQIz60/2k76pkbV6ohUH0jkm
         Jox9Y09fVi77XloTu403ELBMBr76X8dzxeQ3haW2GgqK0Esu9ZkoXpWzHaSH6tAaMoDV
         tmDAGCPgOSqsKKkamJFDdXSO6nIaXZBF40p+RTjEGc53dohjfIGG8/C+G7GvyIESgath
         WeikExSTqhrXJdcJWm/xMTEGyKADTPQDEs+Ees4T5pfkypk5jFJZpd/7M1ecIk1aLgTn
         YzvxNO/avEaPXMEeDvs/G5Ff4veN37dFXuRX65vfKGciMuehn4VVeyzAB73LmFAqM9LG
         sxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwHKJa6QSzn+fFUbr3GdLYPgv95cnerwTX8zoVbLwNQ=;
        b=xxYdK0ETSpv07mu7DxsKn8vdTgXep7G0mZN2EZhS+4vcoj6xXRJWV/ZnW8UZBTqKlU
         W7pkoKKRse/pGvOxwZ6mD8K4rcEGYx2E9kJ3lj7bx72uSeHWSEcvERUXQ6AjlD39SU/9
         rioD8KXEcAcOG+REy1ggA3oUF0Arx0VpxD+TChNRGb9j7ZOcI8CtbGo91u7aISy55nOy
         L1IpqEuGBtq0s5iZUaiy/Q5TrC9pdUdQO7CuHJQ0sIFYx4W9vj2Q584St7JuTvA9j4LI
         tEuY5EcU4lkg8shtHtGfFei+Ks0/FGWy65DEx0UAvZxeTeGtILhYC9E1AclajQFN551p
         0TXA==
X-Gm-Message-State: AO0yUKU9GdbvodDFvVK+hBLRiR+8b5/1Fb+ZVnwn33ysX2f79e0441H8
        K0HIWOOQR90wQ9oNt//TLxbLkQ==
X-Google-Smtp-Source: AK7set9JyLNsrTQk+ldmpaXssouDn0mkoIHdAxrcwhQZfqJh+G9zdIKa6tn/z3NoTm4Hps375eI0IQ==
X-Received: by 2002:a17:90a:990e:b0:233:a836:15f4 with SMTP id b14-20020a17090a990e00b00233a83615f4mr12917519pjp.1.1678706996712;
        Mon, 13 Mar 2023 04:29:56 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n2-20020a654882000000b0050300a7c8c2sm4390827pgs.89.2023.03.13.04.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:29:56 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Vlastimil Babka <Vbabka@suse.cz>
Subject: [PATCH v5 3/8] mm: vmscan: make memcg slab shrink lockless
Date:   Mon, 13 Mar 2023 19:28:14 +0800
Message-Id: <20230313112819.38938-4-zhengqi.arch@bytedance.com>
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
Acked-by: Kirill Tkhai <tkhai@ya.ru>
Acked-by: Vlastimil Babka <Vbabka@suse.cz>
---
 mm/vmscan.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index db2ed6e08f67..ce7834030f75 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -222,8 +222,21 @@ static inline int shrinker_defer_size(int nr_items)
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
 
 static int expand_one_shrinker_info(struct mem_cgroup *memcg,
@@ -264,7 +277,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 		       defer_size - old_defer_size);
 
 		rcu_assign_pointer(pn->shrinker_info, new);
-		kvfree_rcu(old, rcu);
+		call_srcu(&shrinker_srcu, &old->rcu, free_shrinker_info_rcu);
 	}
 
 	return 0;
@@ -350,15 +363,16 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
 
@@ -372,7 +386,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		return -ENOSYS;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -406,7 +419,7 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 
-	info = shrinker_info_protected(memcg, nid);
+	info = shrinker_info_srcu(memcg, nid);
 	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
 }
 
@@ -415,7 +428,7 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 {
 	struct shrinker_info *info;
 
-	info = shrinker_info_protected(memcg, nid);
+	info = shrinker_info_srcu(memcg, nid);
 	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
 }
 
@@ -893,15 +906,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
 
@@ -951,14 +963,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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

