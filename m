Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26A6A020F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjBWEgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjBWEgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:36:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF3298CA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:36:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso11164981pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XK4ibI8/uUfdNyj+CoDahUPgh1hk1k4xSJibemMMbU=;
        b=MwM88iKJj+5FHMLrX6MQ87HI+V5GLGcQS/e1HnbX121YYIRnPeVUQLPz/Ab73429h0
         DHVN0ZHfUEAMOSUUNsdmCF8rZeyDyT8OZiPuXb9gk0Ri7aqjxmylnTURMdkPb8QUxawe
         qH2IX/Hv9L7RlKBBEzs+i7tZ4uezCu85IdggYavrJeYqJiajjJGfdvVAKH/Dccsa3XGB
         gYHxTBmX85MASmstqPNM5HPGw/BjeJUCFGN8qjCZeyoIRuatLzYP4QLEx5oODuEzzby3
         5R1IJbKLorPuS3/Bw037p2WnZ3OpTlRGI/HJJEdqlZnXDTDZ8Cv672iLNo/weVH5u/mj
         SPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XK4ibI8/uUfdNyj+CoDahUPgh1hk1k4xSJibemMMbU=;
        b=FuV4klB28uHG0eZqR7htj4c9EfzjcaqLD4GDgRYe0RLK1BqQWZ9wedAVsO4c9YVpie
         e34iPRBf0HHzQuE4QW2K/lWovoyXgkGF2+wLGPlG7zXgp4KS1EJKsmKXjkO2wYKArAdQ
         pgxxN9g291qv/wKcG5CD7bujrUYKR6MQ4Whoh5pgAmdCweUCZbfEENabvL904AtD18LH
         RmB9XP41sQE0/adOgLQx19Qr2aKQF+OnY+Niy53LfY9n1ZCPBn9kZcKrrF7SA0TGxYKs
         i7r7MFJFQ4WsnIAxQ/MxDLUUj7peclpTouHiCtKLJ8ergw3hH7/Q6RUFkVR78Xeq1VEK
         41Cw==
X-Gm-Message-State: AO0yUKWPoRYQkuXDgiJWcTrbf2lSGxqAkhaqNGj85AOZhq0nL41LjRuI
        IK2mb9TLBhn7jV7ihvL/hO1H7Q==
X-Google-Smtp-Source: AK7set+k6V8krmEU27aMnHaUWN3cNVVoz5AuFIm3KkclaffwIWLcTyYrGBxgQHtMc71TKJn039YlYw==
X-Received: by 2002:a05:6a21:3399:b0:c7:6a98:5bd9 with SMTP id yy25-20020a056a21339900b000c76a985bd9mr14002720pzb.3.1677126968589;
        Wed, 22 Feb 2023 20:36:08 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id b21-20020a6567d5000000b00476dc914262sm5306590pgs.1.2023.02.22.20.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 20:36:08 -0800 (PST)
Message-ID: <46020fa1-d55b-c719-3bde-df66c93cd0d0@bytedance.com>
Date:   Thu, 23 Feb 2023 12:36:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] mm: vmscan: make memcg slab shrink lockless
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
References: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
 <20230220091637.64865-3-zhengqi.arch@bytedance.com>
 <8733cb3c-7a6a-33c4-b84e-4fb981dae765@ya.ru>
 <2eb276f1-0d81-f207-4cf9-e6586c5e18c8@bytedance.com>
 <715594a8-1eca-7f80-adc0-3655153adffa@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <715594a8-1eca-7f80-adc0-3655153adffa@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/23 03:58, Kirill Tkhai wrote:
> On 22.02.2023 10:32, Qi Zheng wrote:
>>
>>
>> On 2023/2/22 05:28, Kirill Tkhai wrote:
>>> On 20.02.2023 12:16, Qi Zheng wrote:
>> <...>
>>>>      void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>>>    {
>>>> -    int i, nid;
>>>> +    int i, nid, srcu_idx;
>>>>        long nr;
>>>>        struct mem_cgroup *parent;
>>>>        struct shrinker_info *child_info, *parent_info;
>>>> @@ -429,16 +443,16 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>>>            parent = root_mem_cgroup;
>>>>          /* Prevent from concurrent shrinker_info expand */
>>>> -    down_read(&shrinker_rwsem);
>>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>
>>> Don't we still have to be protected against parallel expand_one_shrinker_info()?
>>>
>>> It looks like parent->nodeinfo[nid]->shrinker_info pointer may be changed in expand*
>>> right after we've dereferenced it here.
>>
>> Hi Kirill,
>>
>> Oh, indeed. We may wrongly reparent the child's nr_deferred to the old
>> parent's nr_deferred (it is about to be freed by call_srcu).
>>
>> The reparent_shrinker_deferred() will only be called on the offline
>> path (not a hotspot path), so we may be able to use shrinker_mutex
>> introduced later for protection. What do you think?
> 
> It looks good for me. One more thing I'd analyzed is whether we want to have
> is two reparent_shrinker_deferred() are executing in parallel.

I see that mem_cgroup_css_offline() is already protected by
cgroup_mutex, so maybe shrinker_mutex is enough here. :)

> 
> Possible, we should leave rwsem there as it was used before..
>   
>>>
>>>>        for_each_node(nid) {
>>>> -        child_info = shrinker_info_protected(memcg, nid);
>>>> -        parent_info = shrinker_info_protected(parent, nid);
>>>> +        child_info = shrinker_info_srcu(memcg, nid);
>>>> +        parent_info = shrinker_info_srcu(parent, nid);
>>>>            for (i = 0; i < shrinker_nr_max; i++) {
>>>>                nr = atomic_long_read(&child_info->nr_deferred[i]);
>>>>                atomic_long_add(nr, &parent_info->nr_deferred[i]);
>>>>            }
>>>>        }
>>>> -    up_read(&shrinker_rwsem);
>>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>    }
>>>>      static bool cgroup_reclaim(struct scan_control *sc)
>>>> @@ -891,15 +905,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>    {
>>>>        struct shrinker_info *info;
>>>>        unsigned long ret, freed = 0;
>>>> +    int srcu_idx;
>>>>        int i;
>>>>          if (!mem_cgroup_online(memcg))
>>>>            return 0;
>>>>    -    if (!down_read_trylock(&shrinker_rwsem))
>>>> -        return 0;
>>>> -
>>>> -    info = shrinker_info_protected(memcg, nid);
>>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>>> +    info = shrinker_info_srcu(memcg, nid);
>>>>        if (unlikely(!info))
>>>>            goto unlock;
>>>>    @@ -949,14 +962,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>>                    set_shrinker_bit(memcg, nid, i);
>>>>            }
>>>>            freed += ret;
>>>> -
>>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>>> -            freed = freed ? : 1;
>>>> -            break;
>>>> -        }
>>>>        }
>>>>    unlock:
>>>> -    up_read(&shrinker_rwsem);
>>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>>        return freed;
>>>>    }
>>>>    #else /* CONFIG_MEMCG */
>>>
>>
> 

-- 
Thanks,
Qi
