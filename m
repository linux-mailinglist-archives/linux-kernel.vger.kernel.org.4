Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60AA6B75FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCMLaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCMLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:30:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A250705
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i5so12568600pla.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678706976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nutwP8eBjcVbc22noDnh/NYMSLjOUT6aykIF5CijApM=;
        b=MzKjonRwDEyp9YK0wN9uimbirJQKR0BXX2a8DB31h6L2ZA8J7mVZMif6Q5pIL1trWH
         IbA6L9qk1kpjpjRfSm04E96W5314yKbX+/qH06tmxUtP3xjnWuVJR1wUGkfiXo308aon
         Ti50dw8vgpplmlZ9TSRDwjAt0jLgqG2yhaT+doXpqku3dkqZmOukNjNK78fqtkYOLYKe
         r3t8RudrznyjC3Jc1Hve7JvVIC1NvGdlXS3DYD+ElEF0ZD5TmlTHbPa58tgFsZa9W6eL
         /ztXnUm6TM/xE3AHNny6Fl/2PGAL1iVXjZsbbDwIeqatB+aNIEZ8q7xDBU//6oW/ud/V
         TFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nutwP8eBjcVbc22noDnh/NYMSLjOUT6aykIF5CijApM=;
        b=2+M/cW8yauBsvHW85yDzEHX+7SiVh+M46BcJG7RAFzD1W03dqwei4gNvL1HWdavtgY
         7A3u0pA/tfymB1h66ihnbLVeRKHlkKh+/Lew2Aro0KtbxOz9Xd9Hbfy0mY8U5c6HtmUa
         5pqZcujcmsBggIOyS4HGvfRFeEpKCKkiUvZqECx+HXnzP4H0TC2tGV+aq8GfJ6Aza/07
         WEufii/jPk4itAYqr0v9BUPUo2i2Qx9ZB/JDCNA4z/RxZXAHXLkTHbym78T73d4ff7TG
         dowqbFk/J7Q8g++nBi5jk8/FcaN0wnFLit7mGetATdI9G1VM6VzhedO/Wx0b1YSpQEfQ
         NRiw==
X-Gm-Message-State: AO0yUKUkgROi9DssSVk2icQDS9XgWEdaE2AZwgyR6/lSxSjTfBvwG3EF
        Qd17Zyq4AhlJ0e6+HxWbDp8p2625UYTxtULWbO8=
X-Google-Smtp-Source: AK7set+Jz3TakTA+hO8L1yLd1pWq03DSCcigRddSwyrvx0+RyypZ7xKGo6LeVhnJjE1rU9cMtOuMcg==
X-Received: by 2002:a05:6a20:7f8e:b0:cc:c303:8a65 with SMTP id d14-20020a056a207f8e00b000ccc3038a65mr13693918pzj.2.1678706975963;
        Mon, 13 Mar 2023 04:29:35 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n2-20020a654882000000b0050300a7c8c2sm4390827pgs.89.2023.03.13.04.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:29:35 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 0/8] make slab shrink lockless
Date:   Mon, 13 Mar 2023 19:28:11 +0800
Message-Id: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Changelog in v4 -> v5:
 - clean up [PATCH v4 1/8] (per Kirill)
 - include linux/srcu.h in [PATCH v4 2/8] and [PATCH v4 5/8] (per Vlastimil)
 - fix typo in the commit message of [PATCH v4 4/8] (per Vlastimil)
 - add more explanation to the commit message of [PATCH v4 7/8]
 - collect Acked-bys

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
 mm/shrinker_debug.c            |  39 ++++----
 mm/vmscan.c                    | 160 ++++++++++++++++++---------------
 6 files changed, 107 insertions(+), 99 deletions(-)

-- 
2.20.1

