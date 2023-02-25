Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D66A2A95
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBYPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:53:20 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1040D9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:52:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q189so1243563pga.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q04AbPP51Rsl9job/ihkWAhWSRrQZf0kGGWx77Ir7eM=;
        b=cEeozUG9t1phihonMzSqyCXSmUmXf57mMJ/MmuQlQDt6fLvaMO45hc/86KqfpMSFSV
         QBeVd04od3e45FJCSouPDlTqUYzo0L06spyuKRn/STGlgUeTl9oDSmXf/fZ3zPmC+xwu
         Q/rCnDxnJ+VxdiQ8dGzHTHXLwXuI9UFKKP6YUYlRpMivT4Dl/TJIhAisWayq+cN1AW4D
         AurhrGQCUYUctHFJGh4w9FVbz9/ExoSLIEhbqNEewhD79s5YLZdvellOQW/mUHHveNjv
         CZlMwn9AGSn9z8HiOaurkDp4odbqSlqTCVWJvIH1pXTeAAQOXtXtEHmxv1EpLmlvOuKr
         S1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q04AbPP51Rsl9job/ihkWAhWSRrQZf0kGGWx77Ir7eM=;
        b=b8mfMZ4Zm8iaA9UdaGiJeO8B588WUBB25xBpjS8iPbw2jkdXm+QFU/ikiSrTE0LZuk
         kv3YZFiZ+4hD0AVeFIB/MMHhyFcWfodqL7UcpObEo2VpRSFg6ftvt7jfvxttJKAInaza
         sJ+OAokojC49fgqTnN2PwuEQejyU735QtQgNnwMPkGob3zMPBybCUvggCB7A+D9Ck4NR
         A8+wsxOa0nNcA63rYgYh5MWTDOJaPZuvsO6JWYkIZ7biH9f5ZTNp636srkI0jYi1eyJJ
         K3tcAxn0rGNMa1iyUovg6R/g4KqEZ0lwrmW8VQI7vg/UpYT+qqHgjt6Xn55izChU18NB
         9zHw==
X-Gm-Message-State: AO0yUKWpC3A3WO984+GF1JnH1rdtomRrYZ6rIJAjASlnq0KU4sw6DL8r
        9UFXojxWsD5n0wgJ2D7QX7GSAA==
X-Google-Smtp-Source: AK7set8zjgY69RYdDMKhfW4edlqtGfmg3FJEQirkfw6heylGsW5/ZAndoHJ7FaBPGUnXupXsJaaAiw==
X-Received: by 2002:aa7:874d:0:b0:5ef:8b7f:f69b with SMTP id g13-20020aa7874d000000b005ef8b7ff69bmr96607pfo.0.1677340371033;
        Sat, 25 Feb 2023 07:52:51 -0800 (PST)
Received: from [10.200.9.56] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b005b6f63c6cf4sm1375731pfi.30.2023.02.25.07.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 07:52:50 -0800 (PST)
Message-ID: <c91da693-445f-faf4-d69e-d77ab4b5090c@bytedance.com>
Date:   Sat, 25 Feb 2023 23:52:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/7] mm: vmscan: add a map_nr_max field to
 shrinker_info
Content-Language: en-US
To:     Kirill Tkhai <tkhai@ya.ru>
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
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-2-zhengqi.arch@bytedance.com>
 <6f8f01b5-d802-db64-7725-8481c67c13a2@bytedance.com>
 <ea1c5d49-1efa-cce8-8750-e19c56187a7c@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <ea1c5d49-1efa-cce8-8750-e19c56187a7c@ya.ru>
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



On 2023/2/25 23:14, Kirill Tkhai wrote:
> Hi Qi,
> 
> On 25.02.2023 11:18, Qi Zheng wrote:
>>
>>
>> On 2023/2/23 21:27, Qi Zheng wrote:
>>> To prepare for the subsequent lockless memcg slab shrink,
>>> add a map_nr_max field to struct shrinker_info to records
>>> its own real shrinker_nr_max.
>>>
>>> No functional changes.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> I missed Suggested-by here, hi Kirill, can I add it?
>>
>> Suggested-by: Kirill Tkhai <tkhai@ya.ru>
> 
> Yes, feel free to add this tag.

Thanks.

> 
> There is a comment below.
> 
>>> ---
>>>    include/linux/memcontrol.h |  1 +
>>>    mm/vmscan.c                | 29 ++++++++++++++++++-----------
>>>    2 files changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index b6eda2ab205d..aa69ea98e2d8 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -97,6 +97,7 @@ struct shrinker_info {
>>>        struct rcu_head rcu;
>>>        atomic_long_t *nr_deferred;
>>>        unsigned long *map;
>>> +    int map_nr_max;
>>>    };
>>>      struct lruvec_stats_percpu {
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 9c1c5e8b24b8..9f895ca6216c 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -224,9 +224,16 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>>>                         lockdep_is_held(&shrinker_rwsem));
>>>    }
>>>    +static inline bool need_expand(int new_nr_max, int old_nr_max)
>>> +{
>>> +    return round_up(new_nr_max, BITS_PER_LONG) >
>>> +           round_up(old_nr_max, BITS_PER_LONG);
>>> +}
>>> +
>>>    static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>>                        int map_size, int defer_size,
>>> -                    int old_map_size, int old_defer_size)
>>> +                    int old_map_size, int old_defer_size,
>>> +                    int new_nr_max)
>>>    {
>>>        struct shrinker_info *new, *old;
>>>        struct mem_cgroup_per_node *pn;
>>> @@ -240,12 +247,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>>>            if (!old)
>>>                return 0;
>>>    +        if (!need_expand(new_nr_max, old->map_nr_max))
>>> +            return 0;
>>> +
>>>            new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>>>            if (!new)
>>>                return -ENOMEM;
>>>              new->nr_deferred = (atomic_long_t *)(new + 1);
>>>            new->map = (void *)new->nr_deferred + defer_size;
>>> +        new->map_nr_max = new_nr_max;
>>>              /* map: set all old bits, clear all new bits */
>>>            memset(new->map, (int)0xff, old_map_size);
>>> @@ -295,6 +306,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>            }
>>>            info->nr_deferred = (atomic_long_t *)(info + 1);
>>>            info->map = (void *)info->nr_deferred + defer_size;
>>> +        info->map_nr_max = shrinker_nr_max;
>>>            rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>>>        }
>>>        up_write(&shrinker_rwsem);
>>> @@ -302,12 +314,6 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>>>        return ret;
>>>    }
>>>    -static inline bool need_expand(int nr_max)
>>> -{
>>> -    return round_up(nr_max, BITS_PER_LONG) >
>>> -           round_up(shrinker_nr_max, BITS_PER_LONG);
>>> -}
>>> -
>>>    static int expand_shrinker_info(int new_id)
>>>    {
>>>        int ret = 0;
>>> @@ -316,7 +322,7 @@ static int expand_shrinker_info(int new_id)
>>>        int old_map_size, old_defer_size = 0;
>>>        struct mem_cgroup *memcg;
>>>    -    if (!need_expand(new_nr_max))
>>> +    if (!need_expand(new_nr_max, shrinker_nr_max))
>>>            goto out;
>>>          if (!root_mem_cgroup)
>>> @@ -332,7 +338,8 @@ static int expand_shrinker_info(int new_id)
>>>        memcg = mem_cgroup_iter(NULL, NULL, NULL);
>>>        do {
>>>            ret = expand_one_shrinker_info(memcg, map_size, defer_size,
>>> -                           old_map_size, old_defer_size);
>>> +                           old_map_size, old_defer_size,
>>> +                           new_nr_max);
>>>            if (ret) {
>>>                mem_cgroup_iter_break(NULL, memcg);
>>>                goto out;
>>> @@ -432,7 +439,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>>        for_each_node(nid) {
>>>            child_info = shrinker_info_protected(memcg, nid);
>>>            parent_info = shrinker_info_protected(parent, nid);
>>> -        for (i = 0; i < shrinker_nr_max; i++) {
>>> +        for (i = 0; i < child_info->map_nr_max; i++) {
>>>                nr = atomic_long_read(&child_info->nr_deferred[i]);
>>>                atomic_long_add(nr, &parent_info->nr_deferred[i]);
>>>            }
>>> @@ -899,7 +906,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>        if (unlikely(!info))
>>>            goto unlock;
>>>    -    for_each_set_bit(i, info->map, shrinker_nr_max) {
>>> +    for_each_set_bit(i, info->map, info->map_nr_max) {
>>>            struct shrink_control sc = {
>>>                .gfp_mask = gfp_mask,
>>>                .nid = nid,
> 
> The patch as whole thing won't work as expected. It won't ever call shrinker with ids from [round_down(shrinker_nr_max, sizeof(unsigned long)) + 1, shrinker_nr_max - 1]
> 
> Just replay the sequence we add new shrinkers:
> 
> 1)We add shrinker #0:
>     shrinker_nr_max = 0;
> 
>     prealloc_memcg_shrinker()
>        id = 0;
>        expand_shrinker_info(0)
>          new_nr_max = 1;
>          expand_one_shrinker_info(new_nr_max = 1)
>            new->map_nr_max = 1;
>          shrinker_nr_max = 1;
> 
> 2)We add shrinker #1:
>     prealloc_memcg_shrinker()
>       id = 1;
>       expand_shrinker_info(1)
>         new_nr_max = 2;
>         need_expand(2, 1) => false => ignore expand
>         shrinker_nr_max = 2;
> 
> 3)Then we call shrinker:
>    shrink_slab_memcg()
>      for_each_set_bit(i, info->map, 1/* info->map_nr_max */ ) {
>      } => ignore shrinker #1

Oh, I got it.

> 
> I'd fixed this patch by something like the below:

The fix below looks good to me, will add them to the next version. :)

Thanks,
Qi

> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9f895ca6216c..bb617a3871f1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -224,12 +224,6 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>   					 lockdep_is_held(&shrinker_rwsem));
>   }
>   
> -static inline bool need_expand(int new_nr_max, int old_nr_max)
> -{
> -	return round_up(new_nr_max, BITS_PER_LONG) >
> -	       round_up(old_nr_max, BITS_PER_LONG);
> -}
> -
>   static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>   				    int map_size, int defer_size,
>   				    int old_map_size, int old_defer_size,
> @@ -247,9 +241,6 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>   		if (!old)
>   			return 0;
>   
> -		if (!need_expand(new_nr_max, old->map_nr_max))
> -			return 0;
> -
>   		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>   		if (!new)
>   			return -ENOMEM;
> @@ -317,14 +308,11 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   static int expand_shrinker_info(int new_id)
>   {
>   	int ret = 0;
> -	int new_nr_max = new_id + 1;
> +	int new_nr_max = round_up(new_id + 1, BITS_PER_LONG);
>   	int map_size, defer_size = 0;
>   	int old_map_size, old_defer_size = 0;
>   	struct mem_cgroup *memcg;
>   
> -	if (!need_expand(new_nr_max, shrinker_nr_max))
> -		goto out;
> -
>   	if (!root_mem_cgroup)
>   		goto out;
>   
> @@ -359,9 +347,11 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>   
>   		rcu_read_lock();
>   		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> -		/* Pairs with smp mb in shrink_slab() */
> -		smp_mb__before_atomic();
> -		set_bit(shrinker_id, info->map);
> +		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
> +			/* Pairs with smp mb in shrink_slab() */
> +			smp_mb__before_atomic();
> +			set_bit(shrinker_id, info->map);
> +		}
>   		rcu_read_unlock();
>   	}
>   }
> 
> (I also added a new check into set_shrinker_bit() for safety).
> 
> Kirill

-- 
Thanks,
Qi
