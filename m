Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E301B6A0F58
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjBWSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBWSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:19:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7DB2C665
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:19:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C77D6B81AB8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E82FC4339B;
        Thu, 23 Feb 2023 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677176378;
        bh=RRQBZ5NUMCLwb1dO1MGKaL8c28QR+BiMByA9YQlNGIc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kto4UoicxZeUXWvtvVZhowPVTDydwo6pGMI7kT/w7/aHX/tNKv/He/GCY8VqiUz4x
         2MXfYWjjfWceEBlSyMO6Y04NcPIRP5BGdFzKgrCUC7DGdb/WWer11QJ5JWjUOcYE6N
         EDAbQwTau8XlWdhEa2iX1PDq9SyI5zCTzqqUQhK8C313YfH+aeByfBeT8eBYAE/ucP
         KI9Tsx5WUgdG5wqIiUyNKaBXvhE4a1PwDyJSM7Q3Ab/vyPRpSlGFn0wGSE6po/ZYh7
         qIM3pJmYYLWGPiOCXXWpsRVzAwGimPxiBrorFg1LkaZHLCxSy9f7HjuWNajs5VSmno
         J3xdRKWxSYzBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E05ED5C0DBB; Thu, 23 Feb 2023 10:19:37 -0800 (PST)
Date:   Thu, 23 Feb 2023 10:19:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] make slab shrink lockless
Message-ID: <20230223181937.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 09:27:18PM +0800, Qi Zheng wrote:
> Hi all,
> 
> This patch series aims to make slab shrink lockless.
> 
> 1. Background
> =============
> 
> On our servers, we often find the following system cpu hotspots:
> 
>   44.16%  [kernel]  [k] down_read_trylock
>   14.12%  [kernel]  [k] up_read
>   13.43%  [kernel]  [k] shrink_slab
>    5.25%  [kernel]  [k] count_shadow_nodes
>    3.42%  [kernel]  [k] idr_find
> 
> Then we used bpftrace to capture its calltrace as follows:
> 
> @[
>     down_read_trylock+5
>     shrink_slab+292
>     shrink_node+640
>     do_try_to_free_pages+211
>     try_to_free_mem_cgroup_pages+266
>     try_charge_memcg+386
>     charge_memcg+51
>     __mem_cgroup_charge+44
>     __handle_mm_fault+1416
>     handle_mm_fault+260
>     do_user_addr_fault+459
>     exc_page_fault+104
>     asm_exc_page_fault+38
>     clear_user_rep_good+18
>     read_zero+100
>     vfs_read+176
>     ksys_read+93
>     do_syscall_64+62
>     entry_SYSCALL_64_after_hwframe+114
> ]: 1868979
> 
> It is easy to see that this is caused by the frequent failure to obtain the
> read lock of shrinker_rwsem when reclaiming slab memory.
> 
> Currently, the shrinker_rwsem is a global lock. And the following cases may
> cause the above system cpu hotspots:
> 
> a. the write lock of shrinker_rwsem was held for too long. For example, there
>    are many memcgs in the system, which causes some paths to hold locks and
>    traverse it for too long. (e.g. expand_shrinker_info())
> b. the read lock of shrinker_rwsem was held for too long, and a writer came at
>    this time. Then this writer will be forced to wait and block all subsequent
>    readers.
>    For example:
>    - be scheduled when the read lock of shrinker_rwsem is held in
>      do_shrink_slab()
>    - some shrinker are blocked for too long. Like the case mentioned in the
>      patchset[1].
> 
> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
> 
> And all the down_read_trylock() hotspots caused by the above cases can be
> solved by replacing the shrinker_rwsem trylocks with SRCU.

Glad to see that making SRCU unconditional was helpful!  And I do very
much like the idea of the shrinker running better!

The main thing that enabled unconditional SRCU was the code added in
v5.19 to dynamically allocate SRCU's srcu_node combining tree.  This is
important for a number of Linux distributions that have NR_CPUS up in the
thousands, for which this combining tree is quite large.  In v5.19 and
later, srcu_struct structures without frequent call_srcu() invocations
never allocate that combining tree.  Even srcu_struct structures that
have enough call_srcu() activity to cause the lock contention that in
turn forces the combining tree to be allocated, that combining tree
is sized for the actual number of CPUs present, which is usually way
smaller than NR_CPUS.

So if you are going to backport this back past v5.19, you might also
need those SRCU changes.  Or not, depending on how much memory your
systems are equipped with.  ;-)

							Thanx, Paul

> 2. Survey
> =========
> 
> Before doing the code implementation, I found that there were many similar
> submissions in the community:
> 
> a. Davidlohr Bueso submitted a patch in 2015.
>    Subject: [PATCH -next v2] mm: srcu-ify shrinkers
>    Link: https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
>    Result: It was finally merged into the linux-next branch, but failed on arm
>            allnoconfig (without CONFIG_SRCU)
> 
> b. Tetsuo Handa submitted a patchset in 2017.
>    Subject: [PATCH 1/2] mm,vmscan: Kill global shrinker lock.
>    Link: https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
>    Result: Finally chose to use the current simple way (break when
>            rwsem_is_contended()). And Christoph Hellwig suggested to using SRCU,
>            but SRCU was not unconditionally enabled at the time.
> 
> c. Kirill Tkhai submitted a patchset in 2018.
>    Subject: [PATCH RFC 00/10] Introduce lockless shrink_slab()
>    Link: https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
>    Result: At that time, SRCU was not unconditionally enabled, and there were
>            some objections to enabling SRCU. Later, because Kirill's focus was
>            moved to other things, this patchset was not continued to be updated.
> 
> d. Sultan Alsawaf submitted a patch in 2021.
>    Subject: [PATCH] mm: vmscan: Replace shrinker_rwsem trylocks with SRCU protection
>    Link: https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
>    Result: Rejected because SRCU was not unconditionally enabled.
> 
> We can find that almost all these historical commits were abandoned because SRCU
> was not unconditionally enabled. But now SRCU has been unconditionally enable
> by Paul E. McKenney in 2023 [2], so it's time to replace shrinker_rwsem trylocks
> with SRCU.
> 
> [2] https://lore.kernel.org/lkml/20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1/
> 
> 3. Reproduction and testing
> ===========================
> 
> We can reproduce the down_read_trylock() hotspot through the following script:
> 
> ```
> #!/bin/bash
> DIR="/root/shrinker/memcg/mnt"
> 
> do_create()
> {
>         mkdir /sys/fs/cgroup/memory/test
>         echo 200M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>         for i in `seq 0 $1`;
>         do
>                 mkdir /sys/fs/cgroup/memory/test/$i;
>                 echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>                 mkdir -p $DIR/$i;
>         done
> }
> 
> do_mount()
> {
>         for i in `seq $1 $2`;
>         do
>                 mount -t tmpfs $i $DIR/$i;
>         done
> }
> 
> do_touch()
> {
>         for i in `seq $1 $2`;
>         do
>                 echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>                 dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
>         done
> }
> 
> do_create 2000
> do_mount 0 2000
> do_touch 0 1000
> ```
> 
> Save the above script and execute it, we can get the following perf hotspots:
> 
>   46.60%  [kernel]  [k] down_read_trylock
>   18.70%  [kernel]  [k] up_read
>   15.44%  [kernel]  [k] shrink_slab
>    4.37%  [kernel]  [k] _find_next_bit
>    2.75%  [kernel]  [k] xa_load
>    2.07%  [kernel]  [k] idr_find
>    1.73%  [kernel]  [k] do_shrink_slab
>    1.42%  [kernel]  [k] shrink_lruvec
>    0.74%  [kernel]  [k] shrink_node
>    0.60%  [kernel]  [k] list_lru_count_one
> 
> After applying this patchset, the hotspot becomes as follows:
> 
>   19.53%  [kernel]  [k] _find_next_bit
>   14.63%  [kernel]  [k] do_shrink_slab
>   14.58%  [kernel]  [k] shrink_slab
>   11.83%  [kernel]  [k] shrink_lruvec
>    9.33%  [kernel]  [k] __blk_flush_plug
>    6.67%  [kernel]  [k] mem_cgroup_iter
>    3.73%  [kernel]  [k] list_lru_count_one
>    2.43%  [kernel]  [k] shrink_node
>    1.96%  [kernel]  [k] super_cache_count
>    1.78%  [kernel]  [k] __rcu_read_unlock
>    1.38%  [kernel]  [k] __srcu_read_lock
>    1.30%  [kernel]  [k] xas_descend
> 
> We can see that the slab reclaim is no longer blocked by shinker_rwsem trylock,
> which realizes the lockless slab reclaim.
> 
> This series is based on next-20230217.
> 
> Comments and suggestions are welcome.
> 
> Thanks,
> Qi.
> 
> Changelog in v1 -> v2:
>  - add a map_nr_max field to shrinker_info (suggested by Kirill)
>  - use shrinker_mutex in reparent_shrinker_deferred() (pointed by Kirill)
> 
> Qi Zheng (7):
>   mm: vmscan: add a map_nr_max field to shrinker_info
>   mm: vmscan: make global slab shrink lockless
>   mm: vmscan: make memcg slab shrink lockless
>   mm: shrinkers: make count and scan in shrinker debugfs lockless
>   mm: vmscan: hold write lock to reparent shrinker nr_deferred
>   mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
>   mm: shrinkers: convert shrinker_rwsem to mutex
> 
>  drivers/md/dm-cache-metadata.c |   2 +-
>  drivers/md/dm-thin-metadata.c  |   2 +-
>  fs/super.c                     |   2 +-
>  include/linux/memcontrol.h     |   1 +
>  mm/shrinker_debug.c            |  38 ++++-----
>  mm/vmscan.c                    | 142 +++++++++++++++++----------------
>  6 files changed, 92 insertions(+), 95 deletions(-)
> 
> -- 
> 2.20.1
> 
