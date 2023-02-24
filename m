Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36076A15B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBXEJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXEJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:09:18 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB915889
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:09:09 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e9so10427624plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3+5iRQfUSdgPVESq4HCUcwK1kdu8LaKS37Kcc8L19k=;
        b=li78+jy8zofkzsP55VopZKh8pZeh3GSXF46UGPf1OK+uEkn7bKhPHrCJk0Tia35EUC
         7qaXwGH7IT0XzuLWDiYU1AXFfOm8PypKKBzwWe+c0lECbrNsb0Bz3y+Jh0YIOj0wILPn
         CUfP0G/9QgeCYCyAIG2yWOop2eYTL5kxjiwmuUF/gZMsP0p11X3t2NhYbttL6hzdQO0s
         LR7+/UQ0UNRwC/TGSyarediAyR+0lY/i8rZ+I8uyMcwdfAyoX/Fd+r59vGwhc936T3z1
         2dTj67T7wEaj0EO5/3hSO10l3ZGz9bkO5ueubNs+anxYfEL8KgpbBDT3mIMJYwu1B4Q3
         gCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3+5iRQfUSdgPVESq4HCUcwK1kdu8LaKS37Kcc8L19k=;
        b=QTJwWHhSpclKO+mbyjEJSF3VsNE7cnM5byb1zXVpnsQCWdZA751DrcaDl63ZvRKRJc
         GF67Z3aAovI+vbNFURhSULjZan3CdFOwIzMnphuPYC8zvlRwogHo2xVQ8x0KPkSAEdxU
         lIL1p9blC2CVOXshRFhZRvb2m4TPlGxDV0evBNY7teNqRxHT0FIpLQfdBRWtaGFkgWkE
         jVIAcED+KiD5smseLiIviEi7uixTzvGYWGFjKWT6acvONgvX82XxkcLcfpHekOymCGT0
         XeHGcxa+9ChGq1NQ2X5WnMfJ2LO6gX26GO5iFgApt6dTrY3KXiWdjCeaB66zqkT2Ycbx
         Tilw==
X-Gm-Message-State: AO0yUKWfiadc2SJe3VzZpwgJjiyhk1IJyqpWmngKGIuxzQGDOdzeH858
        yKuwBqdmvP0k9Vn+ekDUJs/o6w==
X-Google-Smtp-Source: AK7set/noJ0HLrHmYJU9jLGHXeEbQdObmpKnE6T4ngpSOTPRUa2LWbImv/hc1POd3flA3/RLjQyx2w==
X-Received: by 2002:a17:90b:397:b0:233:f0f3:238b with SMTP id ga23-20020a17090b039700b00233f0f3238bmr13166149pjb.1.1677211749001;
        Thu, 23 Feb 2023 20:09:09 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090a3b0e00b00233ebcb52a6sm477932pjc.36.2023.02.23.20.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 20:09:07 -0800 (PST)
Message-ID: <f9d0836e-3673-380c-29e2-21b31447207f@bytedance.com>
Date:   Fri, 24 Feb 2023 12:08:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 0/7] make slab shrink lockless
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223181937.GD2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230223181937.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/24 02:19, Paul E. McKenney wrote:
> On Thu, Feb 23, 2023 at 09:27:18PM +0800, Qi Zheng wrote:
>> Hi all,
>>
>> This patch series aims to make slab shrink lockless.
>>
>> 1. Background
>> =============
>>
>> On our servers, we often find the following system cpu hotspots:
>>
>>    44.16%  [kernel]  [k] down_read_trylock
>>    14.12%  [kernel]  [k] up_read
>>    13.43%  [kernel]  [k] shrink_slab
>>     5.25%  [kernel]  [k] count_shadow_nodes
>>     3.42%  [kernel]  [k] idr_find
>>
>> Then we used bpftrace to capture its calltrace as follows:
>>
>> @[
>>      down_read_trylock+5
>>      shrink_slab+292
>>      shrink_node+640
>>      do_try_to_free_pages+211
>>      try_to_free_mem_cgroup_pages+266
>>      try_charge_memcg+386
>>      charge_memcg+51
>>      __mem_cgroup_charge+44
>>      __handle_mm_fault+1416
>>      handle_mm_fault+260
>>      do_user_addr_fault+459
>>      exc_page_fault+104
>>      asm_exc_page_fault+38
>>      clear_user_rep_good+18
>>      read_zero+100
>>      vfs_read+176
>>      ksys_read+93
>>      do_syscall_64+62
>>      entry_SYSCALL_64_after_hwframe+114
>> ]: 1868979
>>
>> It is easy to see that this is caused by the frequent failure to obtain the
>> read lock of shrinker_rwsem when reclaiming slab memory.
>>
>> Currently, the shrinker_rwsem is a global lock. And the following cases may
>> cause the above system cpu hotspots:
>>
>> a. the write lock of shrinker_rwsem was held for too long. For example, there
>>     are many memcgs in the system, which causes some paths to hold locks and
>>     traverse it for too long. (e.g. expand_shrinker_info())
>> b. the read lock of shrinker_rwsem was held for too long, and a writer came at
>>     this time. Then this writer will be forced to wait and block all subsequent
>>     readers.
>>     For example:
>>     - be scheduled when the read lock of shrinker_rwsem is held in
>>       do_shrink_slab()
>>     - some shrinker are blocked for too long. Like the case mentioned in the
>>       patchset[1].
>>
>> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
>>
>> And all the down_read_trylock() hotspots caused by the above cases can be
>> solved by replacing the shrinker_rwsem trylocks with SRCU.

Hi Paul,

> 
> Glad to see that making SRCU unconditional was helpful!  And I do very
> much like the idea of the shrinker running better!

+1 :)

> 
> The main thing that enabled unconditional SRCU was the code added in
> v5.19 to dynamically allocate SRCU's srcu_node combining tree.  This is
> important for a number of Linux distributions that have NR_CPUS up in the
> thousands, for which this combining tree is quite large.  In v5.19 and
> later, srcu_struct structures without frequent call_srcu() invocations
> never allocate that combining tree.  Even srcu_struct structures that
> have enough call_srcu() activity to cause the lock contention that in
> turn forces the combining tree to be allocated, that combining tree
> is sized for the actual number of CPUs present, which is usually way
> smaller than NR_CPUS.

Thank you very much for such a detailed background introduction. :)

> 
> So if you are going to backport this back past v5.19, you might also
> need those SRCU changes.  Or not, depending on how much memory your
> systems are equipped with.  ;-)

Got it.

Thanks,
Qi

> 
> 							Thanx, Paul
> 
>> 2. Survey
>> =========
>>
>> Before doing the code implementation, I found that there were many similar
>> submissions in the community:
>>
>> a. Davidlohr Bueso submitted a patch in 2015.
>>     Subject: [PATCH -next v2] mm: srcu-ify shrinkers
>>     Link: https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
>>     Result: It was finally merged into the linux-next branch, but failed on arm
>>             allnoconfig (without CONFIG_SRCU)
>>
>> b. Tetsuo Handa submitted a patchset in 2017.
>>     Subject: [PATCH 1/2] mm,vmscan: Kill global shrinker lock.
>>     Link: https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
>>     Result: Finally chose to use the current simple way (break when
>>             rwsem_is_contended()). And Christoph Hellwig suggested to using SRCU,
>>             but SRCU was not unconditionally enabled at the time.
>>
>> c. Kirill Tkhai submitted a patchset in 2018.
>>     Subject: [PATCH RFC 00/10] Introduce lockless shrink_slab()
>>     Link: https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
>>     Result: At that time, SRCU was not unconditionally enabled, and there were
>>             some objections to enabling SRCU. Later, because Kirill's focus was
>>             moved to other things, this patchset was not continued to be updated.
>>
>> d. Sultan Alsawaf submitted a patch in 2021.
>>     Subject: [PATCH] mm: vmscan: Replace shrinker_rwsem trylocks with SRCU protection
>>     Link: https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
>>     Result: Rejected because SRCU was not unconditionally enabled.
>>
>> We can find that almost all these historical commits were abandoned because SRCU
>> was not unconditionally enabled. But now SRCU has been unconditionally enable
>> by Paul E. McKenney in 2023 [2], so it's time to replace shrinker_rwsem trylocks
>> with SRCU.
>>
>> [2] https://lore.kernel.org/lkml/20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1/
>>
>> 3. Reproduction and testing
>> ===========================
>>
>> We can reproduce the down_read_trylock() hotspot through the following script:
>>
>> ```
>> #!/bin/bash
>> DIR="/root/shrinker/memcg/mnt"
>>
>> do_create()
>> {
>>          mkdir /sys/fs/cgroup/memory/test
>>          echo 200M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>>          for i in `seq 0 $1`;
>>          do
>>                  mkdir /sys/fs/cgroup/memory/test/$i;
>>                  echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>>                  mkdir -p $DIR/$i;
>>          done
>> }
>>
>> do_mount()
>> {
>>          for i in `seq $1 $2`;
>>          do
>>                  mount -t tmpfs $i $DIR/$i;
>>          done
>> }
>>
>> do_touch()
>> {
>>          for i in `seq $1 $2`;
>>          do
>>                  echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>>                  dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
>>          done
>> }
>>
>> do_create 2000
>> do_mount 0 2000
>> do_touch 0 1000
>> ```
>>
>> Save the above script and execute it, we can get the following perf hotspots:
>>
>>    46.60%  [kernel]  [k] down_read_trylock
>>    18.70%  [kernel]  [k] up_read
>>    15.44%  [kernel]  [k] shrink_slab
>>     4.37%  [kernel]  [k] _find_next_bit
>>     2.75%  [kernel]  [k] xa_load
>>     2.07%  [kernel]  [k] idr_find
>>     1.73%  [kernel]  [k] do_shrink_slab
>>     1.42%  [kernel]  [k] shrink_lruvec
>>     0.74%  [kernel]  [k] shrink_node
>>     0.60%  [kernel]  [k] list_lru_count_one
>>
>> After applying this patchset, the hotspot becomes as follows:
>>
>>    19.53%  [kernel]  [k] _find_next_bit
>>    14.63%  [kernel]  [k] do_shrink_slab
>>    14.58%  [kernel]  [k] shrink_slab
>>    11.83%  [kernel]  [k] shrink_lruvec
>>     9.33%  [kernel]  [k] __blk_flush_plug
>>     6.67%  [kernel]  [k] mem_cgroup_iter
>>     3.73%  [kernel]  [k] list_lru_count_one
>>     2.43%  [kernel]  [k] shrink_node
>>     1.96%  [kernel]  [k] super_cache_count
>>     1.78%  [kernel]  [k] __rcu_read_unlock
>>     1.38%  [kernel]  [k] __srcu_read_lock
>>     1.30%  [kernel]  [k] xas_descend
>>
>> We can see that the slab reclaim is no longer blocked by shinker_rwsem trylock,
>> which realizes the lockless slab reclaim.
>>
>> This series is based on next-20230217.
>>
>> Comments and suggestions are welcome.
>>
>> Thanks,
>> Qi.
>>
>> Changelog in v1 -> v2:
>>   - add a map_nr_max field to shrinker_info (suggested by Kirill)
>>   - use shrinker_mutex in reparent_shrinker_deferred() (pointed by Kirill)
>>
>> Qi Zheng (7):
>>    mm: vmscan: add a map_nr_max field to shrinker_info
>>    mm: vmscan: make global slab shrink lockless
>>    mm: vmscan: make memcg slab shrink lockless
>>    mm: shrinkers: make count and scan in shrinker debugfs lockless
>>    mm: vmscan: hold write lock to reparent shrinker nr_deferred
>>    mm: vmscan: remove shrinker_rwsem from synchronize_shrinkers()
>>    mm: shrinkers: convert shrinker_rwsem to mutex
>>
>>   drivers/md/dm-cache-metadata.c |   2 +-
>>   drivers/md/dm-thin-metadata.c  |   2 +-
>>   fs/super.c                     |   2 +-
>>   include/linux/memcontrol.h     |   1 +
>>   mm/shrinker_debug.c            |  38 ++++-----
>>   mm/vmscan.c                    | 142 +++++++++++++++++----------------
>>   6 files changed, 92 insertions(+), 95 deletions(-)
>>
>> -- 
>> 2.20.1
>>

-- 
Thanks,
Qi
