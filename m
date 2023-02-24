Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF246A2356
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBXVCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBXVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:02:28 -0500
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407436BF64
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:02:24 -0800 (PST)
Received: from sas1-7233446457c4.qloud-c.yandex.net (sas1-7233446457c4.qloud-c.yandex.net [IPv6:2a02:6b8:c14:260f:0:640:7233:4464])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 346F05E951;
        Sat, 25 Feb 2023 00:02:22 +0300 (MSK)
Received: by sas1-7233446457c4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id I2YpKrHZjuQ1-O3O8VFck;
        Sat, 25 Feb 2023 00:02:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1677272541;
        bh=nnmA4Hm6QkBGFWe4Z7Beeol0RRN4itQMO596wAeVtNM=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=HP7cjaiQhSU69QQIW5q5YkR8vY8E60peCbcUsJOVwbbaGVGDkgCj+fISDTGjATtcV
         xbxuSwIbNkKraOZqIi4gXZgvPoI+tf4K6+/8eYTEOKCHvHcVuc8pZCJvQHLLVdWX66
         ZVT601To4wGavzN7tHonkeqtUxfwnf7tchDDpreI=
Authentication-Results: sas1-7233446457c4.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <b9593d94-057d-43d3-97e2-07cf83896041@ya.ru>
Date:   Sat, 25 Feb 2023 00:02:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/evb+PBeaahx9Os@sultan-box.localdomain>
 <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
Content-Language: en-US
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.2023 07:00, Qi Zheng wrote:
> 
> 
> On 2023/2/24 02:24, Sultan Alsawaf wrote:
>> On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
>>> The shrinker_rwsem is a global lock in shrinkers subsystem,
>>> it is easy to cause blocking in the following cases:
>>>
>>> a. the write lock of shrinker_rwsem was held for too long.
>>>     For example, there are many memcgs in the system, which
>>>     causes some paths to hold locks and traverse it for too
>>>     long. (e.g. expand_shrinker_info())
>>> b. the read lock of shrinker_rwsem was held for too long,
>>>     and a writer came at this time. Then this writer will be
>>>     forced to wait and block all subsequent readers.
>>>     For example:
>>>     - be scheduled when the read lock of shrinker_rwsem is
>>>       held in do_shrink_slab()
>>>     - some shrinker are blocked for too long. Like the case
>>>       mentioned in the patchset[1].
>>>
>>> Therefore, many times in history ([2],[3],[4],[5]), some
>>> people wanted to replace shrinker_rwsem reader with SRCU,
>>> but they all gave up because SRCU was not unconditionally
>>> enabled.
>>>
>>> But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
>>> the SRCU is unconditionally enabled. So it's time to use
>>> SRCU to protect readers who previously held shrinker_rwsem.
>>>
>>> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
>>> [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
>>> [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
>>> [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
>>> [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>   mm/vmscan.c | 27 +++++++++++----------------
>>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 9f895ca6216c..02987a6f95d1 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>>>     LIST_HEAD(shrinker_list);
>>>   DECLARE_RWSEM(shrinker_rwsem);
>>> +DEFINE_SRCU(shrinker_srcu);
>>>     #ifdef CONFIG_MEMCG
>>>   static int shrinker_nr_max;
>>> @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>>>   void register_shrinker_prepared(struct shrinker *shrinker)
>>>   {
>>>       down_write(&shrinker_rwsem);
>>> -    list_add_tail(&shrinker->list, &shrinker_list);
>>> +    list_add_tail_rcu(&shrinker->list, &shrinker_list);
>>>       shrinker->flags |= SHRINKER_REGISTERED;
>>>       shrinker_debugfs_add(shrinker);
>>>       up_write(&shrinker_rwsem);
>>> @@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker *shrinker)
>>>           return;
>>>         down_write(&shrinker_rwsem);
>>> -    list_del(&shrinker->list);
>>> +    list_del_rcu(&shrinker->list);
>>>       shrinker->flags &= ~SHRINKER_REGISTERED;
>>>       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>>           unregister_memcg_shrinker(shrinker);
>>>       debugfs_entry = shrinker_debugfs_remove(shrinker);
>>>       up_write(&shrinker_rwsem);
>>>   +    synchronize_srcu(&shrinker_srcu);
>>> +
>>>       debugfs_remove_recursive(debugfs_entry);
>>>         kfree(shrinker->nr_deferred);
>>> @@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
>>>   {
>>>       down_write(&shrinker_rwsem);
>>>       up_write(&shrinker_rwsem);
>>> +    synchronize_srcu(&shrinker_srcu);
>>>   }
>>>   EXPORT_SYMBOL(synchronize_shrinkers);
>>>   @@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>   {
>>>       unsigned long ret, freed = 0;
>>>       struct shrinker *shrinker;
>>> +    int srcu_idx;
>>>         /*
>>>        * The root memcg might be allocated even though memcg is disabled
>>> @@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>       if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>>           return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>   -    if (!down_read_trylock(&shrinker_rwsem))
>>> -        goto out;
>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>   -    list_for_each_entry(shrinker, &shrinker_list, list) {
>>> +    list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>> +                 srcu_read_lock_held(&shrinker_srcu)) {
>>>           struct shrink_control sc = {
>>>               .gfp_mask = gfp_mask,
>>>               .nid = nid,
>>> @@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>           if (ret == SHRINK_EMPTY)
>>>               ret = 0;
>>>           freed += ret;
>>> -        /*
>>> -         * Bail out if someone want to register a new shrinker to
>>> -         * prevent the registration from being stalled for long periods
>>> -         * by parallel ongoing shrinking.
>>> -         */
>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>> -            freed = freed ? : 1;
>>> -            break;
>>> -        }
>>>       }
>>>   -    up_read(&shrinker_rwsem);
>>> -out:
>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>       cond_resched();
>>>       return freed;
>>>   }
>>> -- 
>>> 2.20.1
>>>
>>>
>>
>> Hi Qi,
>>
>> A different problem I realized after my old attempt to use SRCU was that the
>> unregister_shrinker() path became quite slow due to the heavy synchronize_srcu()
>> call. Both register_shrinker() *and* unregister_shrinker() are called frequently
>> these days, and SRCU is too unfair to the unregister path IMO.
> 
> Hi Sultan,
> 
> IIUC, for unregister_shrinker(), the wait time is hardly longer with
> SRCU than with shrinker_rwsem before.
> 
> And I just did a simple test. After using the script in cover letter to
> increase the shrink_slab hotspot, I did umount 1k times at the same
> time, and then I used bpftrace to measure the time consumption of
> unregister_shrinker() as follows:
> 
> bpftrace -e 'kprobe:unregister_shrinker { @start[tid] = nsecs; } kretprobe:unregister_shrinker /@start[tid]/ { @ns[comm] = hist(nsecs - @start[tid]); delete(@start[tid]); }'
> 
> @ns[umount]:
> [16K, 32K)             3 |      |
> [32K, 64K)            66 |@@@@@@@@@@      |
> [64K, 128K)           32 |@@@@@      |
> [128K, 256K)          22 |@@@      |
> [256K, 512K)          48 |@@@@@@@      |
> [512K, 1M)            19 |@@@      |
> [1M, 2M)             131 |@@@@@@@@@@@@@@@@@@@@@      |
> [2M, 4M)             313 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4M, 8M)             302 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  |
> [8M, 16M)             55 |@@@@@@@@@
> 
> I see that the highest time-consuming of unregister_shrinker() is between 8ms and 16ms, which feels tolerable?

The fundamental difference is that before the patchset this for_each_set_bit() iteration could be broken in the middle
of two do_shrink_slab() calls, while after the patchset we can leave for_each_set_bit() only after visiting all set bits.

Using only synchronize_srcu_expedited() won't help here.

My opinion is we should restore a check similar to the rwsem_is_contendent() check that we had before. Something like
the below on top of your patchset merged into appropriate patch:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 27ef9946ae8a..50e7812468ec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -204,6 +204,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 LIST_HEAD(shrinker_list);
 DEFINE_MUTEX(shrinker_mutex);
 DEFINE_SRCU(shrinker_srcu);
+static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -782,6 +783,7 @@ void unregister_shrinker(struct shrinker *shrinker)
 	debugfs_entry = shrinker_debugfs_remove(shrinker);
 	mutex_unlock(&shrinker_mutex);
 
+	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 
 	debugfs_remove_recursive(debugfs_entry);
@@ -799,6 +801,7 @@ EXPORT_SYMBOL(unregister_shrinker);
  */
 void synchronize_shrinkers(void)
 {
+	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 }
 EXPORT_SYMBOL(synchronize_shrinkers);
@@ -908,7 +911,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 {
 	struct shrinker_info *info;
 	unsigned long ret, freed = 0;
-	int srcu_idx;
+	int srcu_idx, generation;
 	int i;
 
 	if (!mem_cgroup_online(memcg))
@@ -919,6 +922,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (unlikely(!info))
 		goto unlock;
 
+	generation = atomic_read(&shrinker_srcu_generation);
 	for_each_set_bit(i, info->map, info->map_nr_max) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
@@ -965,6 +969,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 				set_shrinker_bit(memcg, nid, i);
 		}
 		freed += ret;
+
+		if (atomic_read(&shrinker_srcu_generation) != generation) {
+			freed = freed ? : 1;
+			break;
+		}
 	}
 unlock:
 	srcu_read_unlock(&shrinker_srcu, srcu_idx);
@@ -1004,7 +1013,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
-	int srcu_idx;
+	int srcu_idx, generation;
 
 	/*
 	 * The root memcg might be allocated even though memcg is disabled
@@ -1017,6 +1026,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	srcu_idx = srcu_read_lock(&shrinker_srcu);
+	generation = atomic_read(&shrinker_srcu_generation);
 
 	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
 				 srcu_read_lock_held(&shrinker_srcu)) {
@@ -1030,6 +1040,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
+
+		if (atomic_read(&shrinker_srcu_generation) != generation) {
+			freed = freed ? : 1;
+			break;
+		}
 	}
 
 	srcu_read_unlock(&shrinker_srcu, srcu_idx);

Kirill
