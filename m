Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C296A2A98
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBYP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:58:26 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C07A8E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:57:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so5829006pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9s3KaYzY1O48r0hHlMxEi+lC1lpKpo7fQlTZOZw4lw4=;
        b=eGuumtsC9Sizd4IaJeYPFPjSCDd6McfZ6NAAL5+nP20I2fVgh09fMCzypvXU2YvM8d
         ivG9Xs7JoG+6/9zk+8mf01vS6xg5MZvLtWeJEmrJRCOOJUCirFOIZS6VOZLqpNdL/VQh
         8fxkFL/OUwLR4fT8PBw7r5Vd+s/xk+z4K1GVkm5Jvgk+2yoTlg3F6feTVAv+lZmRhKkT
         EEhClBj/tCa4xuW0D8JD9pkeR2+YjZFEtXCgTgPGMO6vQ1VOjjnDiUm35VkZniIrNJCE
         vTQchpJgKsnfTBOonB8C47KNfOGxp+EEMvz2M1vJFxYMhNR2qRwpqAkLkivRsDJS8sQZ
         QHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9s3KaYzY1O48r0hHlMxEi+lC1lpKpo7fQlTZOZw4lw4=;
        b=wXXkL+jK9jpftTwSPdHcKGLGEDSeSDScYCrs7XqASE9TML/tSw4bdGfX1HhESSp2s/
         73yrMFv5YGUOKQBxHvjXmNZnRn+kUocegUQTlR/N8bj7mVgIq+f8dIDy4fhnWV1KDrT0
         sMJNuYHhKM1ZmiDi37IH+RtFs8DXURQMrF59AXdXyeVLAGGs3W4mfuNIV40hGHGw3xPv
         rz+1oELpNBnrSCdTz6xtwn7nDgh+qZeaTLVRZ/d35hblqa22O7po25Q3ID1vlneitqLF
         Azwt319HFzypu19WlYiwOVIObp7OLDjDk2TH+Qo7j+fOdr7LB2zmIWZLRm/69+IVw/fs
         tDNg==
X-Gm-Message-State: AO0yUKUqJKhWE+iluxIkbOAj+GkmGc8wnAOy6lpCJhrLqTqYZPU5Yu8S
        hZuUk1mFXWp+rlIUzIMD1JK1Mg==
X-Google-Smtp-Source: AK7set8qd/znAYzb4t6CjBcCK97Uos3NFhIltRA4jMBV7HR1MCPvd+wWP3F9Y3/2oQ7Bs0aNGVHY2g==
X-Received: by 2002:a05:6a20:7f9c:b0:cc:4118:65c4 with SMTP id d28-20020a056a207f9c00b000cc411865c4mr11413952pzj.5.1677340677004;
        Sat, 25 Feb 2023 07:57:57 -0800 (PST)
Received: from [10.200.9.56] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id j12-20020a637a4c000000b004fbb4a55b64sm1238718pgn.86.2023.02.25.07.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 07:57:56 -0800 (PST)
Message-ID: <74c4cf95-9506-98b3-9fc0-0814f63d5d7f@bytedance.com>
Date:   Sat, 25 Feb 2023 23:57:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
To:     Kirill Tkhai <tkhai@ya.ru>, Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/evb+PBeaahx9Os@sultan-box.localdomain>
 <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
 <b9593d94-057d-43d3-97e2-07cf83896041@ya.ru>
 <ed9c844b-c431-df69-21ff-1b6dc6557b20@ya.ru>
 <f20c6ae7-0dfe-1d4a-9589-05e378961f08@bytedance.com>
 <1aa70926-af39-0ce1-ae23-d86deb74d1c6@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <1aa70926-af39-0ce1-ae23-d86deb74d1c6@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/25 23:30, Kirill Tkhai wrote:
> On 25.02.2023 11:08, Qi Zheng wrote:
>>
>>
>> On 2023/2/25 05:14, Kirill Tkhai wrote:
>>> On 25.02.2023 00:02, Kirill Tkhai wrote:
>>>> On 24.02.2023 07:00, Qi Zheng wrote:
>>>>>
>>>>>
>>>>> On 2023/2/24 02:24, Sultan Alsawaf wrote:
>>>>>> On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
>>>>>>> The shrinker_rwsem is a global lock in shrinkers subsystem,
>>>>>>> it is easy to cause blocking in the following cases:
>>>>>>>
>>>>>>> a. the write lock of shrinker_rwsem was held for too long.
>>>>>>>       For example, there are many memcgs in the system, which
>>>>>>>       causes some paths to hold locks and traverse it for too
>>>>>>>       long. (e.g. expand_shrinker_info())
>>>>>>> b. the read lock of shrinker_rwsem was held for too long,
>>>>>>>       and a writer came at this time. Then this writer will be
>>>>>>>       forced to wait and block all subsequent readers.
>>>>>>>       For example:
>>>>>>>       - be scheduled when the read lock of shrinker_rwsem is
>>>>>>>         held in do_shrink_slab()
>>>>>>>       - some shrinker are blocked for too long. Like the case
>>>>>>>         mentioned in the patchset[1].
>>>>>>>
>>>>>>> Therefore, many times in history ([2],[3],[4],[5]), some
>>>>>>> people wanted to replace shrinker_rwsem reader with SRCU,
>>>>>>> but they all gave up because SRCU was not unconditionally
>>>>>>> enabled.
>>>>>>>
>>>>>>> But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
>>>>>>> the SRCU is unconditionally enabled. So it's time to use
>>>>>>> SRCU to protect readers who previously held shrinker_rwsem.
>>>>>>>
>>>>>>> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
>>>>>>> [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
>>>>>>> [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
>>>>>>> [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
>>>>>>> [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
>>>>>>>
>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>> ---
>>>>>>>     mm/vmscan.c | 27 +++++++++++----------------
>>>>>>>     1 file changed, 11 insertions(+), 16 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>> index 9f895ca6216c..02987a6f95d1 100644
>>>>>>> --- a/mm/vmscan.c
>>>>>>> +++ b/mm/vmscan.c
>>>>>>> @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>>>>>>>       LIST_HEAD(shrinker_list);
>>>>>>>     DECLARE_RWSEM(shrinker_rwsem);
>>>>>>> +DEFINE_SRCU(shrinker_srcu);
>>>>>>>       #ifdef CONFIG_MEMCG
>>>>>>>     static int shrinker_nr_max;
>>>>>>> @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>>>>>>>     void register_shrinker_prepared(struct shrinker *shrinker)
>>>>>>>     {
>>>>>>>         down_write(&shrinker_rwsem);
>>>>>>> -    list_add_tail(&shrinker->list, &shrinker_list);
>>>>>>> +    list_add_tail_rcu(&shrinker->list, &shrinker_list);
>>>>>>>         shrinker->flags |= SHRINKER_REGISTERED;
>>>>>>>         shrinker_debugfs_add(shrinker);
>>>>>>>         up_write(&shrinker_rwsem);
>>>>>>> @@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker *shrinker)
>>>>>>>             return;
>>>>>>>           down_write(&shrinker_rwsem);
>>>>>>> -    list_del(&shrinker->list);
>>>>>>> +    list_del_rcu(&shrinker->list);
>>>>>>>         shrinker->flags &= ~SHRINKER_REGISTERED;
>>>>>>>         if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>>>>>>             unregister_memcg_shrinker(shrinker);
>>>>>>>         debugfs_entry = shrinker_debugfs_remove(shrinker);
>>>>>>>         up_write(&shrinker_rwsem);
>>>>>>>     +    synchronize_srcu(&shrinker_srcu);
>>>>>>> +
>>>>>>>         debugfs_remove_recursive(debugfs_entry);
>>>>>>>           kfree(shrinker->nr_deferred);
>>>>>>> @@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
>>>>>>>     {
>>>>>>>         down_write(&shrinker_rwsem);
>>>>>>>         up_write(&shrinker_rwsem);
>>>>>>> +    synchronize_srcu(&shrinker_srcu);
>>>>>>>     }
>>>>>>>     EXPORT_SYMBOL(synchronize_shrinkers);
>>>>>>>     @@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>>     {
>>>>>>>         unsigned long ret, freed = 0;
>>>>>>>         struct shrinker *shrinker;
>>>>>>> +    int srcu_idx;
>>>>>>>           /*
>>>>>>>          * The root memcg might be allocated even though memcg is disabled
>>>>>>> @@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>>         if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>>>>>>             return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>>>>>     -    if (!down_read_trylock(&shrinker_rwsem))
>>>>>>> -        goto out;
>>>>>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>>>>>     -    list_for_each_entry(shrinker, &shrinker_list, list) {
>>>>>>> +    list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>>>>>> +                 srcu_read_lock_held(&shrinker_srcu)) {
>>>>>>>             struct shrink_control sc = {
>>>>>>>                 .gfp_mask = gfp_mask,
>>>>>>>                 .nid = nid,
>>>>>>> @@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>>>>             if (ret == SHRINK_EMPTY)
>>>>>>>                 ret = 0;
>>>>>>>             freed += ret;
>>>>>>> -        /*
>>>>>>> -         * Bail out if someone want to register a new shrinker to
>>>>>>> -         * prevent the registration from being stalled for long periods
>>>>>>> -         * by parallel ongoing shrinking.
>>>>>>> -         */
>>>>>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>>>>>> -            freed = freed ? : 1;
>>>>>>> -            break;
>>>>>>> -        }
>>>>>>>         }
>>>>>>>     -    up_read(&shrinker_rwsem);
>>>>>>> -out:
>>>>>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>>>>         cond_resched();
>>>>>>>         return freed;
>>>>>>>     }
>>>>>>> -- 
>>>>>>> 2.20.1
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Hi Qi,
>>>>>>
>>>>>> A different problem I realized after my old attempt to use SRCU was that the
>>>>>> unregister_shrinker() path became quite slow due to the heavy synchronize_srcu()
>>>>>> call. Both register_shrinker() *and* unregister_shrinker() are called frequently
>>>>>> these days, and SRCU is too unfair to the unregister path IMO.
>>>>>
>>>>> Hi Sultan,
>>>>>
>>>>> IIUC, for unregister_shrinker(), the wait time is hardly longer with
>>>>> SRCU than with shrinker_rwsem before.
>>>>>
>>>>> And I just did a simple test. After using the script in cover letter to
>>>>> increase the shrink_slab hotspot, I did umount 1k times at the same
>>>>> time, and then I used bpftrace to measure the time consumption of
>>>>> unregister_shrinker() as follows:
>>>>>
>>>>> bpftrace -e 'kprobe:unregister_shrinker { @start[tid] = nsecs; } kretprobe:unregister_shrinker /@start[tid]/ { @ns[comm] = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>>>>>
>>>>> @ns[umount]:
>>>>> [16K, 32K)             3 |      |
>>>>> [32K, 64K)            66 |@@@@@@@@@@      |
>>>>> [64K, 128K)           32 |@@@@@      |
>>>>> [128K, 256K)          22 |@@@      |
>>>>> [256K, 512K)          48 |@@@@@@@      |
>>>>> [512K, 1M)            19 |@@@      |
>>>>> [1M, 2M)             131 |@@@@@@@@@@@@@@@@@@@@@      |
>>>>> [2M, 4M)             313 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>>>> [4M, 8M)             302 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  |
>>>>> [8M, 16M)             55 |@@@@@@@@@
>>>>>
>>>>> I see that the highest time-consuming of unregister_shrinker() is between 8ms and 16ms, which feels tolerable?
>>
>> Hi Kirill,
>>
>>>>
>>>> The fundamental difference is that before the patchset this for_each_set_bit() iteration could be broken in the middle
>>>> of two do_shrink_slab() calls, while after the patchset we can leave for_each_set_bit() only after visiting all set bits.
>>
>> After looking at the git log[1], I saw that we originally introduced
>> rwsem_is_contendent() here to aviod blocking register_shrinker(),
>> not unregister_shrinker().
>>
>> So I am curious, do we really care about the speed of
>> unregister_shrinker()?
> 
> My opinion is that for general reasons we should avoid long unbreakable actions in kernel. Especially when they may be called
> synchronous from userspace.

Got it.

And maybe you missed the previous comments below.

> 
> We even have this as generic rule. See check_hung_task().
> 
> Before, the longest sleep in unregister_shrinker() was a sleep waiting for single longest do_shrink_slab().
> 
> After the patch the longest sleep will be a sleep waiting for all do_shrink_slab() calls (all set bits in shrinker_info).
> 
>> And after using SRCU, register_shrinker() will not be blocked by slab
>> shrink at all.
>>
>> [1]. https://github.com/torvalds/linux/commit/e496612
>>
>>>>
>>>> Using only synchronize_srcu_expedited() won't help here.
>>>>
>>>> My opinion is we should restore a check similar to the rwsem_is_contendent() check that we had before. Something like
>>
>> If we really care about the speed of unregister_shrinker() like
>> register_shrinker(), I think this is a good idea. This guarantees
>> at least the speed of the unregister_shrinker() is not deteriorated. :)
>>
>>>> the below on top of your patchset merged into appropriate patch:
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 27ef9946ae8a..50e7812468ec 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -204,6 +204,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>>>>    LIST_HEAD(shrinker_list);
>>>>    DEFINE_MUTEX(shrinker_mutex);
>>>>    DEFINE_SRCU(shrinker_srcu);
>>>> +static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
>>>>      #ifdef CONFIG_MEMCG
>>>>    static int shrinker_nr_max;
>>>> @@ -782,6 +783,7 @@ void unregister_shrinker(struct shrinker *shrinker)
>>>>        debugfs_entry = shrinker_debugfs_remove(shrinker);
>>>>        mutex_unlock(&shrinker_mutex);
>>>>    +    atomic_inc(&shrinker_srcu_generation);
>>>>        synchronize_srcu(&shrinker_srcu);
>>>>          debugfs_remove_recursive(debugfs_entry);
>>>> @@ -799,6 +801,7 @@ EXPORT_SYMBOL(unregister_shrinker);
>>>>     */
>>>>    void synchronize_shrinkers(void)
>>>>    {
>>>> +    atomic_inc(&shrinker_srcu_generation);
>>>>        synchronize_srcu(&shrinker_srcu);
>>>>    }
>>>>    EXPORT_SYMBOL(synchronize_shrinkers);
>>>> @@ -908,7 +911,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>    {
>>>>        struct shrinker_info *info;
>>>>        unsigned long ret, freed = 0;
>>>> -    int srcu_idx;
>>>> +    int srcu_idx, generation;
>>>>        int i;
>>>>          if (!mem_cgroup_online(memcg))
>>>> @@ -919,6 +922,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>        if (unlikely(!info))
>>>>            goto unlock;
>>>>    +    generation = atomic_read(&shrinker_srcu_generation);
>>>>        for_each_set_bit(i, info->map, info->map_nr_max) {
>>>>            struct shrink_control sc = {
>>>>                .gfp_mask = gfp_mask,
>>>> @@ -965,6 +969,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>                    set_shrinker_bit(memcg, nid, i);
>>>>            }
>>>>            freed += ret;
>>>> +
>>>> +        if (atomic_read(&shrinker_srcu_generation) != generation) {
>>>> +            freed = freed ? : 1;
>>>> +            break;
>>>> +        }
>>>>        }
>>>>    unlock:
>>>>        srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>> @@ -1004,7 +1013,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>    {
>>>>        unsigned long ret, freed = 0;
>>>>        struct shrinker *shrinker;
>>>> -    int srcu_idx;
>>>> +    int srcu_idx, generation;
>>>>          /*
>>>>         * The root memcg might be allocated even though memcg is disabled
>>>> @@ -1017,6 +1026,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>            return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>>          srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>> +    generation = atomic_read(&shrinker_srcu_generation);
>>>>          list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>>>                     srcu_read_lock_held(&shrinker_srcu)) {
>>>> @@ -1030,6 +1040,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>>            if (ret == SHRINK_EMPTY)
>>>>                ret = 0;
>>>>            freed += ret;
>>>> +
>>>> +        if (atomic_read(&shrinker_srcu_generation) != generation) {
>>>> +            freed = freed ? : 1;
>>>> +            break;
>>>> +        }
>>>>        }
>>>>          srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>
>>> Even more, for memcg shrinkers we may unlock SRCU and continue iterations from the same shrinker id:
>>
>> Maybe we can also do this for global slab shrink? Like below:

How about this?

>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index ffddbd204259..9d8c53075298 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1012,7 +1012,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>                                   int priority)
>>   {
>>          unsigned long ret, freed = 0;
>> -       struct shrinker *shrinker;
>> +       struct shrinker *shrinker = NULL;
>>          int srcu_idx, generation;
>>
>>          /*
>> @@ -1025,11 +1025,15 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>          if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>>                  return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>
>> +again:
>>          srcu_idx = srcu_read_lock(&shrinker_srcu);
>>
>>          generation = atomic_read(&shrinker_srcu_generation);
>> -       list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>> -                                srcu_read_lock_held(&shrinker_srcu)) {
>> +       if (!shrinker)
>> +               shrinker = list_entry_rcu(shrinker_list.next, struct shrinker, list);
>> +       else
>> +               shrinker = list_entry_rcu(shrinker->list.next, struct shrinker, list);
>> +       list_for_each_entry_from_rcu(shrinker, &shrinker_list, list) {
>>                  struct shrink_control sc = {
>>                          .gfp_mask = gfp_mask,
>>                          .nid = nid,
>> @@ -1042,8 +1046,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>                  freed += ret;
>>
>>                  if (atomic_read(&shrinker_srcu_generation) != generation) {
>> -                       freed = freed ? : 1;
>> -                       break;
>> +                       srcu_read_unlock(&shrinker_srcu, srcu_idx);
>> +                       cond_resched();
>> +                       goto again;
>>                  }
>>          }
>>
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 27ef9946ae8a..0b197bba1257 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -204,6 +204,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>>>    LIST_HEAD(shrinker_list);
>>>    DEFINE_MUTEX(shrinker_mutex);
>>>    DEFINE_SRCU(shrinker_srcu);
>>> +static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
>>>      #ifdef CONFIG_MEMCG
>>>    static int shrinker_nr_max;
>>> @@ -782,6 +783,7 @@ void unregister_shrinker(struct shrinker *shrinker)
>>>        debugfs_entry = shrinker_debugfs_remove(shrinker);
>>>        mutex_unlock(&shrinker_mutex);
>>>    +    atomic_inc(&shrinker_srcu_generation);
>>>        synchronize_srcu(&shrinker_srcu);
>>>          debugfs_remove_recursive(debugfs_entry);
>>> @@ -799,6 +801,7 @@ EXPORT_SYMBOL(unregister_shrinker);
>>>     */
>>>    void synchronize_shrinkers(void)
>>>    {
>>> +    atomic_inc(&shrinker_srcu_generation);
>>>        synchronize_srcu(&shrinker_srcu);
>>>    }
>>>    EXPORT_SYMBOL(synchronize_shrinkers);
>>> @@ -908,18 +911,19 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>    {
>>>        struct shrinker_info *info;
>>>        unsigned long ret, freed = 0;
>>> -    int srcu_idx;
>>> -    int i;
>>> +    int srcu_idx, generation;
>>> +    int i = 0;
>>>          if (!mem_cgroup_online(memcg))
>>>            return 0;
>>> -
>>> +again:
>>>        srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>        info = shrinker_info_srcu(memcg, nid);
>>>        if (unlikely(!info))
>>>            goto unlock;
>>>    -    for_each_set_bit(i, info->map, info->map_nr_max) {
>>> +    generation = atomic_read(&shrinker_srcu_generation);
>>> +    for_each_set_bit_from(i, info->map, info->map_nr_max) {
>>>            struct shrink_control sc = {
>>>                .gfp_mask = gfp_mask,
>>>                .nid = nid,
>>> @@ -965,6 +969,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>                    set_shrinker_bit(memcg, nid, i);
>>>            }
>>>            freed += ret;
>>> +
>>> +        if (atomic_read(&shrinker_srcu_generation) != generation) {
>>> +            srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>
>> Maybe we can add the following code here, so as to avoid repeating the
>> current id and avoid triggering softlockup:
>>
>>              i++;
>>              cond_resched();

And this. :)

Thanks,
Qi

>>
>> Thanks,
>> Qi
>>
>>> +            goto again;
>>> +        }
>>>        }
>>>    unlock:
>>>        srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>> @@ -1004,7 +1013,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>    {
>>>        unsigned long ret, freed = 0;
>>>        struct shrinker *shrinker;
>>> -    int srcu_idx;
>>> +    int srcu_idx, generation;
>>>          /*
>>>         * The root memcg might be allocated even though memcg is disabled
>>> @@ -1017,6 +1026,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>            return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>>          srcu_idx = srcu_read_lock(&shrinker_srcu);
>>> +    generation = atomic_read(&shrinker_srcu_generation);
>>>          list_for_each_entry_srcu(shrinker, &shrinker_list, list,
>>>                     srcu_read_lock_held(&shrinker_srcu)) {
>>> @@ -1030,6 +1040,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>>            if (ret == SHRINK_EMPTY)
>>>                ret = 0;
>>>            freed += ret;
>>> +
>>> +        if (atomic_read(&shrinker_srcu_generation) != generation) {
>>> +            freed = freed ? : 1;
>>> +            break;
>>> +        }
>>>        }
>>>          srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>
>>>
>>
> 

-- 
Thanks,
Qi
