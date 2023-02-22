Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A8869FC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjBVT7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjBVT7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:59:15 -0500
X-Greylist: delayed 80938 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Feb 2023 11:58:46 PST
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E07420B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:58:45 -0800 (PST)
Received: from iva3-4792ebb2806b.qloud-c.yandex.net (iva3-4792ebb2806b.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:c0e:0:640:4792:ebb2])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 89EBB5F417;
        Wed, 22 Feb 2023 22:58:43 +0300 (MSK)
Received: by iva3-4792ebb2806b.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id dwUQ802ZjOs1-fqGYg3Vm;
        Wed, 22 Feb 2023 22:58:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1677095922;
        bh=YsD5Es+crBasC+jtKbzgfw9zDouhXr6PGgoj3gfM2CQ=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=YoNZ2eA9C/nJ2O/wtM8O5ZnkFFBi7u1d1U3/nAaKHoC03xRy+OsWNBZATcwkzYPM2
         lKfyQ+GSZ2YdyxiI0UabfNNjlE9cMgH2uX076IM0jt4dFuwIEHB0e8msO/ZFDDuhBX
         lYdDcl4ex9LKZBn5i8KYw+JzZPoI9Yrqvl/EKWUU=
Authentication-Results: iva3-4792ebb2806b.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <715594a8-1eca-7f80-adc0-3655153adffa@ya.ru>
Date:   Wed, 22 Feb 2023 22:58:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/5] mm: vmscan: make memcg slab shrink lockless
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
 <8733cb3c-7a6a-33c4-b84e-4fb981dae765@ya.ru>
 <2eb276f1-0d81-f207-4cf9-e6586c5e18c8@bytedance.com>
Content-Language: en-US
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <2eb276f1-0d81-f207-4cf9-e6586c5e18c8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.2023 10:32, Qi Zheng wrote:
> 
> 
> On 2023/2/22 05:28, Kirill Tkhai wrote:
>> On 20.02.2023 12:16, Qi Zheng wrote:
> <...>
>>>     void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>>   {
>>> -    int i, nid;
>>> +    int i, nid, srcu_idx;
>>>       long nr;
>>>       struct mem_cgroup *parent;
>>>       struct shrinker_info *child_info, *parent_info;
>>> @@ -429,16 +443,16 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>>>           parent = root_mem_cgroup;
>>>         /* Prevent from concurrent shrinker_info expand */
>>> -    down_read(&shrinker_rwsem);
>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>
>> Don't we still have to be protected against parallel expand_one_shrinker_info()?
>>
>> It looks like parent->nodeinfo[nid]->shrinker_info pointer may be changed in expand*
>> right after we've dereferenced it here.
> 
> Hi Kirill,
> 
> Oh, indeed. We may wrongly reparent the child's nr_deferred to the old
> parent's nr_deferred (it is about to be freed by call_srcu).
> 
> The reparent_shrinker_deferred() will only be called on the offline
> path (not a hotspot path), so we may be able to use shrinker_mutex
> introduced later for protection. What do you think?

It looks good for me. One more thing I'd analyzed is whether we want to have
is two reparent_shrinker_deferred() are executing in parallel.

Possible, we should leave rwsem there as it was used before..
 
>>
>>>       for_each_node(nid) {
>>> -        child_info = shrinker_info_protected(memcg, nid);
>>> -        parent_info = shrinker_info_protected(parent, nid);
>>> +        child_info = shrinker_info_srcu(memcg, nid);
>>> +        parent_info = shrinker_info_srcu(parent, nid);
>>>           for (i = 0; i < shrinker_nr_max; i++) {
>>>               nr = atomic_long_read(&child_info->nr_deferred[i]);
>>>               atomic_long_add(nr, &parent_info->nr_deferred[i]);
>>>           }
>>>       }
>>> -    up_read(&shrinker_rwsem);
>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>   }
>>>     static bool cgroup_reclaim(struct scan_control *sc)
>>> @@ -891,15 +905,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>   {
>>>       struct shrinker_info *info;
>>>       unsigned long ret, freed = 0;
>>> +    int srcu_idx;
>>>       int i;
>>>         if (!mem_cgroup_online(memcg))
>>>           return 0;
>>>   -    if (!down_read_trylock(&shrinker_rwsem))
>>> -        return 0;
>>> -
>>> -    info = shrinker_info_protected(memcg, nid);
>>> +    srcu_idx = srcu_read_lock(&shrinker_srcu);
>>> +    info = shrinker_info_srcu(memcg, nid);
>>>       if (unlikely(!info))
>>>           goto unlock;
>>>   @@ -949,14 +962,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>>                   set_shrinker_bit(memcg, nid, i);
>>>           }
>>>           freed += ret;
>>> -
>>> -        if (rwsem_is_contended(&shrinker_rwsem)) {
>>> -            freed = freed ? : 1;
>>> -            break;
>>> -        }
>>>       }
>>>   unlock:
>>> -    up_read(&shrinker_rwsem);
>>> +    srcu_read_unlock(&shrinker_srcu, srcu_idx);
>>>       return freed;
>>>   }
>>>   #else /* CONFIG_MEMCG */
>>
> 

