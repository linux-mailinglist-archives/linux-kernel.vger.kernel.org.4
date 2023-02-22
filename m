Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF369FCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjBVUF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjBVUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:05:58 -0500
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC63279A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:05:51 -0800 (PST)
Received: from myt5-69594d4a41fa.qloud-c.yandex.net (myt5-69594d4a41fa.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3ca5:0:640:6959:4d4a])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id CCEA95F4C4;
        Wed, 22 Feb 2023 23:05:49 +0300 (MSK)
Received: by myt5-69594d4a41fa.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id j5V0PZwZxqM1-uB90kAko;
        Wed, 22 Feb 2023 23:05:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1677096347;
        bh=71W5XMQdckK/wY/XZVLFIl4KhEfcbFhEzjoIgQolLJo=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=JXjiXlofBhfA8j9ARJKSjobpmgysIq9/0LmRRmeD0MzRaLYU0E+l/ty8AGo6CvGOt
         d6LB2w9alT6Wmt1QmwpkBPCDC95928jffjqWtByCVvVhI7vYCI1J3HXmrY545SUOq6
         3Qx9NMOCP3OxJbswMo6GfJLN3mYuebTQnmoceTq0=
Authentication-Results: myt5-69594d4a41fa.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <23fde2e7-e9e2-2b0d-dfd8-1a654bc5503c@ya.ru>
Date:   Wed, 22 Feb 2023 23:05:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/5] mm: vmscan: make memcg slab shrink lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
References: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
 <20230220091637.64865-3-zhengqi.arch@bytedance.com>
 <dc279728-4cd4-0453-1a28-fe076f254641@ya.ru>
 <39cf7fa7-5dd6-0424-23de-1c33e948a201@bytedance.com>
 <b9d344d0-9d27-034d-d59e-9e880318906b@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <b9d344d0-9d27-034d-d59e-9e880318906b@bytedance.com>
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

On 22.02.2023 11:21, Qi Zheng wrote:
> 
> 
> On 2023/2/22 16:16, Qi Zheng wrote:
>> Hi Kirill,
>>
>> On 2023/2/22 05:43, Kirill Tkhai wrote:
>>> On 20.02.2023 12:16, Qi Zheng wrote:
>>>> Like global slab shrink, since commit 1cd0bd06093c<...>
>>>>   static bool cgroup_reclaim(struct scan_control *sc)
>>>> @@ -891,15 +905,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>   {
>>>>       struct shrinker_info *info;
>>>>       unsigned long ret, freed = 0;
>>>> +    int srcu_idx;
>>>>       int i;
>>>>       if (!mem_cgroup_online(memcg))
>>>>           return 0;
>>>> -    if (!down_read_trylock(&shrinker_rwsem))
>>>> -        return 0;
>>>> -
>>>> -    info = shrinker_info_protected(memcg, nid);
>>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>> +    info = shrinker_info_srcu(memcg, nid);
>>>>       if (unlikely(!info))
>>>>           goto unlock;
>>>
>>> There is shrinker_nr_max dereference under this hunk. It's not in the patch:
>>>
>>>          for_each_set_bit(i, info->map, shrinker_nr_max) {
>>>
>>> Since shrinker_nr_max may grow in parallel, this leads to access beyond allocated memory :(
>>
>> Oh, indeed.
>>
>>>
>>> It looks like we should save size of info->map as a new member of struct shrinker_info.
>>
>> Agree, then we only traverse info->map_size each time. Like below:
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index b6eda2ab205d..f1b5d2803007 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -97,6 +97,7 @@ struct shrinker_info {
>>          struct rcu_head rcu;
>>          atomic_long_t *nr_deferred;
>>          unsigned long *map;
>> +       int map_size;

Sure, like this. The only thing (after rethinking) I want to say is that despite "size" was
may suggestion, now it makes me think that name "size" is about size in bytes.

Possible, something like map_nr_max would be better here.

>>   };
>>
>>   struct lruvec_stats_percpu {
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index f94bfe540675..dd07eb107915 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -239,14 +239,20 @@ static void free_shrinker_info_rcu(struct rcu_head *head)
>>          kvfree(container_of(head, struct shrinker_info, rcu));
>>   }
>>
>> -static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>> -                                   int map_size, int defer_size,
>> -                                   int old_map_size, int old_defer_size)
>> +static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_nr_max,
>> +                                   int old_nr_max)
>>   {
>> +       int map_size, defer_size, old_map_size, old_defer_size;
>>          struct shrinker_info *new, *old;
>>          struct mem_cgroup_per_node *pn;
>>          int nid;
>> -       int size = map_size + defer_size;
>> +       int size;
>> +
>> +       map_size = shrinker_map_size(new_nr_max);
>> +       defer_size = shrinker_defer_size(new_nr_max);
>> +       old_map_size = shrinker_map_size(shrinker_nr_max);
>> +       old_defer_size = shrinker_defer_size(shrinker_nr_max);
> 
> Perhaps these should still be calculated outside the loop as before.

Yeah, for me it's also better.
 
>> +       size = map_size + defer_size;
>>
>>          for_each_node(nid) {
>>                  pn = memcg->nodeinfo[nid];
>> @@ -261,6 +267,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>
>>                  new->nr_deferred = (atomic_long_t *)(new + 1);
>>                  new->map = (void *)new->nr_deferred + defer_size;
>> +               new->map_size = new_nr_max;
>>
>>                  /* map: set all old bits, clear all new bits */
>>                  memset(new->map, (int)0xff, old_map_size);
>> @@ -310,6 +317,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>                  }
>>                  info->nr_deferred = (atomic_long_t *)(info + 1);
>>                  info->map = (void *)info->nr_deferred + defer_size;
>> +               info->map_size = shrinker_nr_max;
>>                  rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>          }
>>          mutex_unlock(&shrinker_mutex);
>> @@ -327,8 +335,6 @@ static int expand_shrinker_info(int new_id)
>>   {
>>          int ret = 0;
>>          int new_nr_max = new_id + 1;
>> -       int map_size, defer_size = 0;
>> -       int old_map_size, old_defer_size = 0;
>>          struct mem_cgroup *memcg;
>>
>>          if (!need_expand(new_nr_max))
>> @@ -339,15 +345,9 @@ static int expand_shrinker_info(int new_id)
>>
>>          lockdep_assert_held(&shrinker_mutex);
>>
>> -       map_size = shrinker_map_size(new_nr_max);
>> -       defer_size = shrinker_defer_size(new_nr_max);
>> -       old_map_size = shrinker_map_size(shrinker_nr_max);
>> -       old_defer_size = shrinker_defer_size(shrinker_nr_max);
>> -
>>          memcg = mem_cgroup_iter(NULL, NULL, NULL);
>>          do {
>> -               ret = expand_one_shrinker_info(memcg, map_size, defer_size,
>> -                                              old_map_size, old_defer_size);
>> +               ret = expand_one_shrinker_info(memcg, new_nr_max, shrinker_nr_max);
>>                  if (ret) {
>>                          mem_cgroup_iter_break(NULL, memcg);
>>                          goto out;
>> @@ -912,7 +912,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>          if (unlikely(!info))
>>                  goto unlock;
>>
>> -       for_each_set_bit(i, info->map, shrinker_nr_max) {
>> +       for_each_set_bit(i, info->map, info->map_size) {
>>                  struct shrink_control sc = {
>>                          .gfp_mask = gfp_mask,
>>                          .nid = nid,
>>
>> I will send the v2.
>>
>> Thanks,
>> Qi
>>
>>>
>>>> @@ -949,14 +962,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>                   set_shrinker_bit(memcg, nid, i);
>>>>           }
>>>>           freed += ret;
>>>> -
>>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>>> -            freed = freed ? : 1;
>>>> -            break;
>>>> -        }
>>>>       }
>>>>   unlock:
>>>> -    up_read(&shrinker_rwsem);
>>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>       return freed;
>>>>   }
>>>>   #else /* CONFIG_MEMCG */
>>>
>>
> 

