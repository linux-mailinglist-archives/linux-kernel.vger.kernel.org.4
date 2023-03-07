Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5D76AD7D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCGG5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCGG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:57:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D60848DE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:56:22 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z11so7416583pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 22:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678172179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xnc/F2CDRO2PmqdLINKWRn/GpEkzyr0mGNPS5puv6KI=;
        b=D6qL9lxH8H/W2+EDbBE/xJ+qO+md9Tx4IhLuncQXNvVNJQ1m+A2NLUWRCCeopoTyV3
         gjdbDYTvDHDcxOtnRHOWjTyHDivTeBglZK1Jv6z0bEPhzCiOGfioAGjh5Jg7eHRph0Co
         z7JuDiOugNXGXQrICABLwPr6OEcARVaq/m12Uetzcp4vFAtdtIjniJFFuKa1PQowXngE
         fyAFet+4Lq5r+v+ceEcUe9PAqfpS7Ah7dzLMiUeqZZ0WhpGv0ByrBpYKp/izKQAi+4Dy
         uTN+/srvfHv7gCw+7O/jHQtSuRcRgJhyvoqTXeIhk4Pd+x6N9zLSlwye0ycWv3r46rP3
         0pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xnc/F2CDRO2PmqdLINKWRn/GpEkzyr0mGNPS5puv6KI=;
        b=Pz7lscSP+zQrAiugqykZgI0F05AZCROJS9SEoCQleTvo/dTp7Vq5HGhY0ZmK4eciaa
         BCuBQFBuHIr/ekpDTFXQ5q7b+mUdv7cnb+1BObVpUHCIs/l1/K7CxmF+TSwYDfx0mzl0
         rmEhzDxyBJbsz4JfFEaYbxhJ+TcUwRPlb+x79KwE6LFYbyHFmzyGmGcS6TBPHF98CC0b
         zD8Qs4FsiKQsLSW9TsK7P7WkBPAm7hwoq+086hBA/dxEwAstAB9GdvZPPzYn0fy6ZAgw
         onCLuMgrZN7byteRotq7bWlEPEbYU00Bdt6aIRPOFSWJO54f9Q4fDTe/ON+GN65pHZV9
         fCoA==
X-Gm-Message-State: AO0yUKW9jtgHoPJBogwOsKTLVtoKie/aGuYutnZP7HcLDeU+3Dux3PqI
        tekLiRbrWm4/I5mtsUGKo+mmaw==
X-Google-Smtp-Source: AK7set9XrblQF4RUBncUqUzNPJAHzViKIx63eUfVPqUkhjCejP+viBvjqEI4hVH6jlyCyAOqan+3FA==
X-Received: by 2002:a05:6a00:2a08:b0:5ef:8b7f:f69b with SMTP id ce8-20020a056a002a0800b005ef8b7ff69bmr13597328pfb.0.1678172178869;
        Mon, 06 Mar 2023 22:56:18 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b00608dae58695sm7230854pfi.209.2023.03.06.22.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:56:18 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 0/8] make slab shrink lockless
Date:   Tue,  7 Mar 2023 14:55:57 +0800
Message-Id: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Hi all,

This patch series aims to make slab shrink lockless.

1. Background
=============

On our servers, we often find the following system cpu hotspots:

  52.22% [kernel]        [k] down_read_trylock
  19.60% [kernel]        [k] up_read
   8.86% [kernel]        [k] shrink_slab
   2.44% [kernel]        [k] idr_find
   1.25% [kernel]        [k] count_shadow_nodes
   1.18% [kernel]        [k] shrink lruvec
   0.71% [kernel]        [k] mem_cgroup_iter
   0.71% [kernel]        [k] shrink_node
   0.55% [kernel]        [k] find_next_bit

And we used bpftrace to capture its calltrace as follows:

@[
    down_read_trylock+1
    shrink_slab+128
    shrink_node+371
    do_try_to_free_pages+232
    try_to_free_pages+243
    _alloc_pages_slowpath+771
    _alloc_pages_nodemask+702
    pagecache_get_page+255
    filemap_fault+1361
    ext4_filemap_fault+44
    __do_fault+76
    handle_mm_fault+3543
    do_user_addr_fault+442
    do_page_fault+48
    page_fault+62
]: 1161690
@[
    down_read_trylock+1
    shrink_slab+128
    shrink_node+371
    balance_pgdat+690
    kswapd+389
    kthread+246
    ret_from_fork+31
]: 8424884
@[
    down_read_trylock+1
    shrink_slab+128
    shrink_node+371
    do_try_to_free_pages+232
    try_to_free_pages+243
    __alloc_pages_slowpath+771
    __alloc_pages_nodemask+702
    __do_page_cache_readahead+244
    filemap_fault+1674
    ext4_filemap_fault+44
    __do_fault+76
    handle_mm_fault+3543
    do_user_addr_fault+442
    do_page_fault+48
    page_fault+62
]: 20917631

We can see that down_read_trylock() of shrinker_rwsem is being called with
high frequency at that time. Because of the poor multicore scalability of atomic
operations, this can lead to a significant drop in IPC (instructions per cycle).

And more, the shrinker_rwsem is a global read-write lock in shrinkers subsystem,
which protects most operations such as slab shrink, registration and
unregistration of shrinkers, etc. This can easily cause problems in the
following cases.

1) When the memory pressure is high and there are many filesystems mounted or
   unmounted at the same time, slab shrink will be affected (down_read_trylock()
   failed).

   Such as the real workload mentioned by Kirill Tkhai:

   ```
   One of the real workloads from my experience is start of an overcommitted
   node containing many starting containers after node crash (or many resuming
   containers after reboot for kernel update). In these cases memory pressure is
   huge, and the node goes round in long reclaim.
   ```

2) If a shrinker is blocked (such as the case mentioned in [1]) and a writer
   comes in (such as mount a fs), then this writer will be blocked and cause all
   subsequent shrinker-related operations to be blocked.

[1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/

All the above cases can be solved by replacing the shrinker_rwsem trylocks with
SRCU.

2. Survey
=========

Before doing the code implementation, I found that there were many similar
submissions in the community:

a. Davidlohr Bueso submitted a patch in 2015.
   Subject: [PATCH -next v2] mm: srcu-ify shrinkers
   Link: https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
   Result: It was finally merged into the linux-next branch, but failed on arm
           allnoconfig (without CONFIG_SRCU)

b. Tetsuo Handa submitted a patchset in 2017.
   Subject: [PATCH 1/2] mm,vmscan: Kill global shrinker lock.
   Link: https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
   Result: Finally chose to use the current simple way (break when
           rwsem_is_contended()). And Christoph Hellwig suggested to using SRCU,
           but SRCU was not unconditionally enabled at the time.

c. Kirill Tkhai submitted a patchset in 2018.
   Subject: [PATCH RFC 00/10] Introduce lockless shrink_slab()
   Link: https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
   Result: At that time, SRCU was not unconditionally enabled, and there were
           some objections to enabling SRCU. Later, because Kirill's focus was
           moved to other things, this patchset was not continued to be updated.

d. Sultan Alsawaf submitted a patch in 2021.
   Subject: [PATCH] mm: vmscan: Replace shrinker_rwsem trylocks with SRCU protection
   Link: https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
   Result: Rejected because SRCU was not unconditionally enabled.

We can find that almost all these historical commits were abandoned because SRCU
was not unconditionally enabled. But now SRCU has been unconditionally enable
by Paul E. McKenney in 2023 [2], so it's time to replace shrinker_rwsem trylocks
with SRCU.

[2] https://lore.kernel.org/lkml/20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1/

3. Reproduction and testing
===========================

We can reproduce the down_read_trylock() hotspot through the following script:

```
#!/bin/bash

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

Save the above script, then run test and touch commands. Then we can use the
following perf command to view hotspots:

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

At the same time, we use the following perf command to capture IPC information:

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

We can see that IPC drops very seriously when calling down_read_trylock() at
high frequency. After using SRCU, the IPC is at a normal level.

This series is based on next-20230306.

Comments and suggestions are welcome.

Thanks,
Qi.

Changelog in v3 -> v4:
 - fix bug in [PATCH v3 1/7]
 - revise commit messages
 - rebase onto the next-20230306

Changelog in v2 -> v3:
 - fix bug in [PATCH v2 1/7] (per Kirill)
 - add Kirill's pacth which restore a check similar to the rwsem_is_contendent()
   check by adding shrinker_srcu_generation

Changelog in v1 -> v2:
 - add a map_nr_max field to shrinker_info (suggested by Kirill)
 - use shrinker_mutex in reparent_shrinker_deferred() (pointed by Kirill)

Kirill Tkhai (1):
  mm: vmscan: add shrinker_srcu_generation

Qi Zheng (7):
  mm: vmscan: add a map_nr_max field to shrinker_info
  mm: vmscan: make global slab shrink lockless
  mm: vmscan: make memcg slab shrink lockless
  mm: shrinkers: make count and scan in shrinker debugfs lockless
  mm: vmscan: hold write lock to reparent shrinker nr_deferred
  mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
  mm: shrinkers: convert shrinker_rwsem to mutex

 drivers/md/dm-cache-metadata.c |   2 +-
 drivers/md/dm-thin-metadata.c  |   2 +-
 fs/super.c                     |   2 +-
 include/linux/memcontrol.h     |   1 +
 mm/shrinker_debug.c            |  38 +++-----
 mm/vmscan.c                    | 166 +++++++++++++++++++--------------
 6 files changed, 112 insertions(+), 99 deletions(-)

-- 
2.20.1

