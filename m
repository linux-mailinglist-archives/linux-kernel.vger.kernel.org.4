Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7409C69C781
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjBTJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjBTJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:17:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F814213
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:16:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o16so724582pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676884617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwoNp9Qdt7qy17urXcRkNK9cIx6l5B/5X3wH3FW6ZtQ=;
        b=wmcFkDGFYS4yikPecKl42M1M8hqVdmXSe5i52p3dDfH52hC82kfhxpKZOu6tCa6yiZ
         l5lM+d2spVjbZvRlQtAnLuj2JCzuEftSCsPag8ciu7orqflhAZpQR4gq2OHum1B2WHR5
         y+/O2+KNO9MlDGSk4hIBeeAGEGWU3b7J1D20AwRGES0jdlpGASeSByd5cS1Icy4ar8sN
         OJVE/gn9cZlrHW5xJshERiwu71fwpuR4bye2yeRWZQXlixmrbhfjcorenf+/JepbM3/5
         DsWol6C7YOAkPdXr35/i2iLaQibDvLg41NHcOkvqSKlEvng/9hpmkeGDUtDX2J95qHNx
         p9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676884617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwoNp9Qdt7qy17urXcRkNK9cIx6l5B/5X3wH3FW6ZtQ=;
        b=FuGUrY0V2+e4KD8pULrPimMZDiT70l4dv+fPiKunXgq/L07ihzB8Dqmtak30a/OJSW
         p9LBCWAHOkYjxe+hOE4kjROgYLNlYXewc95Vtgq2mQlIv87ufoKAiIUezKVrMySnlQ5n
         rv7Iqh1InfeES7oded7JCZuotY3QqwppY/o92W2RtOWQuTlnWG06jcWryU9tUYvJlCO9
         aXLcZRowpg9f4hDpqMA04EW8pwS8AYov4xLZjTGsBRUM09PKhPYU86ldRfEmOJe+w0d5
         oa/6KIH+gLf62RxyNxlpZNuO/xL1tumBL4ZdI6+gmaMOtJllfPBKACYTgFvzrcNsy49h
         rMCw==
X-Gm-Message-State: AO0yUKWrfvamH+Xga/alUmPOLImoY//D2cu1uUsGNLl+aT7PS7MeVjdR
        Wy+OAVMdXsQxy6crwbiyusNWpA==
X-Google-Smtp-Source: AK7set/GLdfzqThLrMiTLs9Tzr6PxZnWUhb/DH5CJ36VtGadDPqafJUhcYMkn/oerW22+vMV1SqlAw==
X-Received: by 2002:a17:90a:bf0d:b0:233:a836:15f4 with SMTP id c13-20020a17090abf0d00b00233a83615f4mr528392pjs.1.1676884616905;
        Mon, 20 Feb 2023 01:16:56 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id fs13-20020a17090af28d00b002339195a47bsm432382pjb.53.2023.02.20.01.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:16:56 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     tkhai@ya.ru, sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/5] make slab shrink lockless
Date:   Mon, 20 Feb 2023 17:16:32 +0800
Message-Id: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

  44.16%  [kernel]  [k] down_read_trylock
  14.12%  [kernel]  [k] up_read
  13.43%  [kernel]  [k] shrink_slab
   5.25%  [kernel]  [k] count_shadow_nodes
   3.42%  [kernel]  [k] idr_find

Then we used bpftrace to capture its calltrace as follows:

@[
    down_read_trylock+5
    shrink_slab+292
    shrink_node+640
    do_try_to_free_pages+211
    try_to_free_mem_cgroup_pages+266
    try_charge_memcg+386
    charge_memcg+51
    __mem_cgroup_charge+44
    __handle_mm_fault+1416
    handle_mm_fault+260
    do_user_addr_fault+459
    exc_page_fault+104
    asm_exc_page_fault+38
    clear_user_rep_good+18
    read_zero+100
    vfs_read+176
    ksys_read+93
    do_syscall_64+62
    entry_SYSCALL_64_after_hwframe+114
]: 1868979

It is easy to see that this is caused by the frequent failure to obtain the
read lock of shrinker_rwsem when reclaiming slab memory.

Currently, the shrinker_rwsem is a global lock. And the following cases may
cause the above system cpu hotspots:

a. the write lock of shrinker_rwsem was held for too long. For example, there
   are many memcgs in the system, which causes some paths to hold locks and
   traverse it for too long. (e.g. expand_shrinker_info())
b. the read lock of shrinker_rwsem was held for too long, and a writer came at
   this time. Then this writer will be forced to wait and block all subsequent
   readers.
   For example:
   - be scheduled when the read lock of shrinker_rwsem is held in
     do_shrink_slab()
   - some shrinker are blocked for too long. Like the case mentioned in the
     patchset[1].

[1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/

And all the down_read_trylock() hotspots caused by the above cases can be
solved by replacing the shrinker_rwsem trylocks with SRCU.

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

Save the above script and execute it, we can get the following perf hotspots:

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

After applying this patchset, the hotspot becomes as follows:

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

We can see that the slab reclaim is no longer blocked by shinker_rwsem trylock,
which realizes the lockless slab reclaim.

This series is based on next-20230217.

Comments and suggestions are welcome.

Thanks,
Qi.

Qi Zheng (5):
  mm: vmscan: make global slab shrink lockless
  mm: vmscan: make memcg slab shrink lockless
  mm: shrinkers: make count and scan in shrinker debugfs lockless
  mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
  mm: shrinkers: convert shrinker_rwsem to mutex

 drivers/md/dm-cache-metadata.c |   2 +-
 drivers/md/dm-thin-metadata.c  |   2 +-
 fs/super.c                     |   2 +-
 mm/shrinker_debug.c            |  38 ++++-------
 mm/vmscan.c                    | 119 ++++++++++++++++-----------------
 5 files changed, 76 insertions(+), 87 deletions(-)

-- 
2.20.1

