Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D939739C07
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjFVJG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjFVJEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:04:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B25C49D6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668842bc50dso866526b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424243; x=1690016243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8Fm0YGxp8yCkyBdSSDbuW3Cqk4JmtEEZRGj6EeWqug=;
        b=VXm59oxeB5FguY23iZ6wxsHZUa/n0ixVM5+RJovFhBsSqk7jUN18WD75GpJCgArR0W
         JBsEkA9d39jtf7NG1SF+QvFe/XJdGOqobYaTEX0aq6YpeCNoIMMKV4Gdkmm7QKEFMCrH
         QNswdcRq+FKKLLJSUCefQDEwUuyAf6EXdUAA8SWzr8d5PlDWqAvD+NLb3ziu4Q1ZbddG
         3AHOgUEiuKr4IMyzSNLNbfYcakjlWAem1FVIRkWrvCWnM54TEnQwCZtRjpDkJUyTk1gU
         FK042RTEuCbaP60yQQ0pKyvy7feFAoM0ianmMZaWx78B21cSO7WyFn4vwESs5Li+xEdq
         ozzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424243; x=1690016243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8Fm0YGxp8yCkyBdSSDbuW3Cqk4JmtEEZRGj6EeWqug=;
        b=epDw6N5j3lEf0sDbf3Mq6Zw2Udld/C9Z47BW+fQLPyb6fDT9Lwq6JyFZ0VmUu7K092
         o8sWf36rx4T5N+jltoKKZL3sYr2vSf9aHNJ6TL8nrXRybAb+wD+6WtTj0LAlTUPPh+Vz
         Hjv64/qwnNfDtearxlwArIVNxokaQ56Wn5EdzosndvBeW/Gb4b83SnnqtX8YNckeBx7g
         xCMSYmoEtzSbu1eQTlYG19QE92CP+Lc8J46yXr//sFC2iThQJDUCjiSbjN1VP3MXikAR
         J1kcoAqKbxd8iomlbv5rUw15GOU5jcN6djgQEqENLOgPHEE7OMxvSdhD6/V0kXhBjKa2
         2tMg==
X-Gm-Message-State: AC+VfDxb6dyifZZ8pwLv1sQqA7T2ji3JcAUqMqP0SWG5HhRni7LF9/Wx
        4mkmupybbRQWu11Nd3rMu5f16Q==
X-Google-Smtp-Source: ACHHUZ6zp07NG2bkXXxglRYaIEoFlfKXA7hhsSA7stt9xCgrqpdelrec/tU9od+DRY9y6jYGAzcstA==
X-Received: by 2002:a17:902:da91:b0:1b0:3d54:358f with SMTP id j17-20020a170902da9100b001b03d54358fmr20812342plx.0.1687424243512;
        Thu, 22 Jun 2023 01:57:23 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:57:23 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 25/29] mm: vmscan: make memcg slab shrink lockless
Date:   Thu, 22 Jun 2023 16:53:31 +0800
Message-Id: <20230622085335.77010-26-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like global slab shrink, this commit also uses refcount+RCU
method to make memcg slab shrink lockless.

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

perf top -U -F 999 [-g]

1) Before applying this patchset:

  35.34%  [kernel]             [k] down_read_trylock
  18.44%  [kernel]             [k] shrink_slab
  15.98%  [kernel]             [k] pv_native_safe_halt
  15.08%  [kernel]             [k] up_read
   5.33%  [kernel]             [k] idr_find
   2.71%  [kernel]             [k] _find_next_bit
   2.21%  [kernel]             [k] shrink_node
   1.29%  [kernel]             [k] shrink_lruvec
   0.66%  [kernel]             [k] do_shrink_slab
   0.33%  [kernel]             [k] list_lru_count_one
   0.33%  [kernel]             [k] __radix_tree_lookup
   0.25%  [kernel]             [k] mem_cgroup_iter

-   82.19%    19.49%  [kernel]                  [k] shrink_slab
   - 62.00% shrink_slab
        36.37% down_read_trylock
        15.52% up_read
        5.48% idr_find
        3.38% _find_next_bit
      + 0.98% do_shrink_slab

2) After applying this patchset:

  46.83%  [kernel]           [k] shrink_slab
  20.52%  [kernel]           [k] pv_native_safe_halt
   8.85%  [kernel]           [k] do_shrink_slab
   7.71%  [kernel]           [k] _find_next_bit
   1.72%  [kernel]           [k] xas_descend
   1.70%  [kernel]           [k] shrink_node
   1.44%  [kernel]           [k] shrink_lruvec
   1.43%  [kernel]           [k] mem_cgroup_iter
   1.28%  [kernel]           [k] xas_load
   0.89%  [kernel]           [k] super_cache_count
   0.84%  [kernel]           [k] xas_start
   0.66%  [kernel]           [k] list_lru_count_one

-   65.50%    40.44%  [kernel]                  [k] shrink_slab
   - 22.96% shrink_slab
        13.11% _find_next_bit
      - 9.91% do_shrink_slab
         - 1.59% super_cache_count
              0.92% list_lru_count_one

We can see that the first perf hotspot becomes shrink_slab,
which is what we expect.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 58 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 767569698946..357a1f2ad690 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -213,6 +213,12 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 					 lockdep_is_held(&shrinker_rwsem));
 }
 
+static struct shrinker_info *shrinker_info_rcu(struct mem_cgroup *memcg,
+					       int nid)
+{
+	return rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+}
+
 static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 				    int map_size, int defer_size,
 				    int old_map_size, int old_defer_size,
@@ -339,7 +345,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 		struct shrinker_info *info;
 
 		rcu_read_lock();
-		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
+		info = shrinker_info_rcu(memcg, nid);
 		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
 			/* Pairs with smp mb in shrink_slab() */
 			smp_mb__before_atomic();
@@ -359,7 +365,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 		return -ENOSYS;
 
 	down_write(&shrinker_rwsem);
-	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -392,18 +397,28 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
 				   struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
+	long nr_deferred;
 
-	info = shrinker_info_protected(memcg, nid);
-	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+	rcu_read_lock();
+	info = shrinker_info_rcu(memcg, nid);
+	nr_deferred = atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
+	rcu_read_unlock();
+
+	return nr_deferred;
 }
 
 static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 				  struct mem_cgroup *memcg)
 {
 	struct shrinker_info *info;
+	long nr_deferred;
+
+	rcu_read_lock();
+	info = shrinker_info_rcu(memcg, nid);
+	nr_deferred = atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
+	rcu_read_unlock();
 
-	info = shrinker_info_protected(memcg, nid);
-	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
+	return nr_deferred;
 }
 
 void reparent_shrinker_deferred(struct mem_cgroup *memcg)
@@ -955,19 +970,18 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
-	int i;
+	int i = 0;
 
 	if (!mem_cgroup_online(memcg))
 		return 0;
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		return 0;
-
-	info = shrinker_info_protected(memcg, nid);
+again:
+	rcu_read_lock();
+	info = shrinker_info_rcu(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
-	for_each_set_bit(i, info->map, info->map_nr_max) {
+	for_each_set_bit_from(i, info->map, info->map_nr_max) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
@@ -982,6 +996,10 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 		}
 
+		if (!shrinker_try_get(shrinker))
+			continue;
+		rcu_read_unlock();
+
 		/* Call non-slab shrinkers even though kmem is disabled */
 		if (!memcg_kmem_online() &&
 		    !(shrinker->flags & SHRINKER_NONSLAB))
@@ -1014,13 +1032,19 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		}
 		freed += ret;
 
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
+		shrinker_put(shrinker);
+
+		/*
+		 * We have already exited the read-side of rcu critical section
+		 * before calling do_shrink_slab(), the shrinker_info may be
+		 * released in expand_one_shrinker_info(), so restart the
+		 * iteration.
+		 */
+		i++;
+		goto again;
 	}
 unlock:
-	up_read(&shrinker_rwsem);
+	rcu_read_unlock();
 	return freed;
 }
 #else /* CONFIG_MEMCG */
-- 
2.30.2

