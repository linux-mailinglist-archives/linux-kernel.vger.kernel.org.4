Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94169628C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBNLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBNLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:39:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7672068B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:38:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bx22so14810199pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676374713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cpp5g4YwEWDa4DT8wXU4tZAKlVVkCNcrnZGuAcmfmSM=;
        b=aqLurW5q7zKwI2PgSZNJNw7loOevRmy5lqEEevhz5qzDMUI4Wa8zrDsukrgjLres3b
         cK2jqEjFTs/vPFScCQgYxxHwjg1GJA+vUYBrMnHIfx2qqYmep1tRHvCaM56oASO9eAMh
         y87ZRkuS3bWusX626SmbzfXnC4/cVuCAX0evHMOVld+7EJqSWhDM2g9Ljc/NzxVHwwC/
         1XCg3MBCdDFlHZPIULXCJqejHMMH9HU2vfIUZ0EOPZlocXCl/pHgfGMqSpmiIea1zF5+
         PuYiRcPRJLzeLZkCqIEMVJZlNHaeTFoF5zqCLG9iPP+fnF1AZXPR3Atgy882DSFZZ7rr
         TjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676374713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cpp5g4YwEWDa4DT8wXU4tZAKlVVkCNcrnZGuAcmfmSM=;
        b=vC3WZrjS4FjHDDko0aTvoijdGaMvaTkW68r0VKIiuQg/x+qZVow6DrMm7zKQyvTicc
         +GNx2CF8NyCS/V7QROgZijrQd3EawQ8Ob3VgDLi9jAYwQq1FEls1Y7iMiQhFk93VGcyI
         EoyjACdURqF1LITzL4S6pScGcv1FcRb55QU+Lb6edB7zh5RfwhQddGVS0VZrDcpUsru/
         +nQkcDq4TIjJMERYlJCP4R0bdV7jFwoPGtemSNiAFhHSLo4Yv9QcNds1dqccHtHJyUIf
         7MI2JAsYG4UX5Si3SFr65WbIITLPSzQrknjvW/U+I/KneNm/ghlECZNx9gg/ERgef5Zq
         ClRg==
X-Gm-Message-State: AO0yUKWLu2MIwY2leaazkK10+ul4Jmt3bmTj1EeH8SsOfBxyhKP6ko3x
        kcm0vQ3Xkh5vd9tP40m/MOgtjg==
X-Google-Smtp-Source: AK7set+1oBXElAA+AhCZ2hjNreDhRKcDDRHkW2/4c7NdrWKC4EDdTbvU9Tp93wOkVOo9F4PxyyFdLg==
X-Received: by 2002:a17:902:d2c1:b0:19a:9269:7d1 with SMTP id n1-20020a170902d2c100b0019a926907d1mr2589078plc.4.1676374713213;
        Tue, 14 Feb 2023 03:38:33 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0019607984a5esm10028593ple.95.2023.02.14.03.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:38:32 -0800 (PST)
Message-ID: <1ac1c7ad-05c3-cd5f-1bde-6d0ee3697163@bytedance.com>
Date:   Tue, 14 Feb 2023 19:38:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/14 19:29, David Hildenbrand wrote:
> On 14.02.23 12:26, Qi Zheng wrote:
>>
>>
>> On 2023/2/14 19:22, David Hildenbrand wrote:
>>> On 14.02.23 11:26, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2023/2/14 17:43, Mike Rapoport wrote:
>>>>> On Tue, Feb 14, 2023 at 10:17:03AM +0100, David Hildenbrand wrote:
>>>>>> On 14.02.23 09:42, Vlastimil Babka wrote:
>>>>>>> On 2/13/23 12:00, Qi Zheng wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2023/2/13 16:47, Vlastimil Babka wrote:
>>>>>>>>> On 2/12/23 12:03, Qi Zheng wrote:
>>>>>>>>>> In x86, numa_register_memblks() is only interested in
>>>>>>>>>> those nodes which have enough memory, so it skips over
>>>>>>>>>> all nodes with memory below NODE_MIN_SIZE (treated as
>>>>>>>>>> a memoryless node). Later on, we will initialize these
>>>>>>>>>> memoryless nodes (allocate pgdat in free_area_init()
>>>>>>>>>> and build zonelist etc), and will online these nodes
>>>>>>>>>> in init_cpu_to_node() and init_gi_nodes().
>>>>>>>>>>
>>>>>>>>>> After boot, these memoryless nodes are in N_ONLINE
>>>>>>>>>> state but not in N_MEMORY state. But we can still allocate
>>>>>>>>>> pages from these memoryless nodes.
>>>>>>>>>>
>>>>>>>>>> In SLUB, we only process nodes in the N_MEMORY state,
>>>>>>>>>> such as allocating their struct kmem_cache_node. So if
>>>>>>>>>> we allocate a page from the memoryless node above to
>>>>>>>>>> SLUB, the struct kmem_cache_node of the node corresponding
>>>>>>>>>> to this page is NULL, which will cause panic.
>>>>>>>>>>
>>>>>>>>>> For example, if we use qemu to start a two numa node kernel,
>>>>>>>>>> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>>>>>>>>> and the other node has 2G, then we will encounter the
>>>>>>>>>> following panic:
>>>>>>>>>>
>>>>>>>>>> [    0.149844] BUG: kernel NULL pointer dereference, address:
>>>>>>>>>> 0000000000000000
>>>>>>>>>> [    0.150783] #PF: supervisor write access in kernel mode
>>>>>>>>>> [    0.151488] #PF: error_code(0x0002) - not-present page
>>>>>>>>>> <...>
>>>>>>>>>> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>>>>>>>>> <...>
>>>>>>>>>> [    0.169781] Call Trace:
>>>>>>>>>> [    0.170159]  <TASK>
>>>>>>>>>> [    0.170448]  deactivate_slab+0x187/0x3c0
>>>>>>>>>> [    0.171031]  ? bootstrap+0x1b/0x10e
>>>>>>>>>> [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>>>>>>>>> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>>>>>>>>> [    0.172735]  ? bootstrap+0x1b/0x10e
>>>>>>>>>> [    0.173236]  bootstrap+0x6b/0x10e
>>>>>>>>>> [    0.173720]  kmem_cache_init+0x10a/0x188
>>>>>>>>>> [    0.174240]  start_kernel+0x415/0x6ac
>>>>>>>>>> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>>>>>>>>> [    0.175417]  </TASK>
>>>>>>>>>> [    0.175713] Modules linked in:
>>>>>>>>>> [    0.176117] CR2: 0000000000000000
>>>>>>>>>>
>>>>>>>>>> In addition, we can also encountered this panic in the actual
>>>>>>>>>> production environment. We set up a 2c2g container with two
>>>>>>>>>> numa nodes, and then reserved 128M for kdump, and then we
>>>>>>>>>> can encountered the above panic in the kdump kernel.
>>>>>>>>>>
>>>>>>>>>> To fix it, we can filter memoryless nodes when allocating
>>>>>>>>>> pages.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>>>>> Reported-by: Teng Hu <huteng.ht@bytedance.com>
>>>>>>>>>
>>>>>>>>> Well AFAIK the key mechanism to only allocate from "good" nodes
>>>>>>>>> is the
>>>>>>>>> zonelist, we shouldn't need to start putting extra checks like
>>>>>>>>> this. So it
>>>>>>>>> seems to me that the code building the zonelists should take the
>>>>>>>>> NODE_MIN_SIZE constraint in mind.
>>>>>>>>
>>>>>>>> Indeed. How about the following patch:
>>>>>>>
>>>>>>> +Cc also David, forgot earlier.
>>>>>>>
>>>>>>> Looks good to me, at least.
>>>>>>>
>>>>>>>> @@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t
>>>>>>>> *used_node_mask)
>>>>>>>>              int min_val = INT_MAX;
>>>>>>>>              int best_node = NUMA_NO_NODE;
>>>>>>>>
>>>>>>>> -       /* Use the local node if we haven't already */
>>>>>>>> -       if (!node_isset(node, *used_node_mask)) {
>>>>>>>> +       /*
>>>>>>>> +        * Use the local node if we haven't already. But for
>>>>>>>> memoryless
>>>>>>>> local
>>>>>>>> +        * node, we should skip it and fallback to other nodes.
>>>>>>>> +        */
>>>>>>>> +       if (!node_isset(node, *used_node_mask) && node_state(node,
>>>>>>>> N_MEMORY)) {
>>>>>>>>                      node_set(node, *used_node_mask);
>>>>>>>>                      return node;
>>>>>>>>              }
>>>>>>>>
>>>>>>>> For memoryless node, we skip it and fallback to other nodes when
>>>>>>>> build its zonelists.
>>>>>>>>
>>>>>>>> Say we have node0 and node1, and node0 is memoryless, then:
>>>>>>>>
>>>>>>>> [    0.102400] Fallback order for Node 0: 1
>>>>>>>> [    0.102931] Fallback order for Node 1: 1
>>>>>>>>
>>>>>>>> In this way, we will not allocate pages from memoryless node0.
>>>>>>>>
>>>>>>
>>>>>> In offline_pages(), we'll first build_all_zonelists() to then
>>>>>> node_states_clear_node()->node_clear_state(node, N_MEMORY);
>>>>>>
>>>>>> So at least on the offlining path, we wouldn't detect it properly 
>>>>>> yet I
>>>>>> assume, and build a zonelist that contains a now-memory-less node?
>>>>>
>>>>> Another question is what happens if a new memory is plugged into a 
>>>>> node
>>>>> that had < NODE_MIN_SIZE of memory and after hotplug it stops being
>>>>> "memoryless".
>>>>
>>>> When going online and offline a memory will re-call
>>>> build_all_zonelists() to re-establish the zonelists (the zonelist of
>>>> itself and other nodes). So it can stop being "memoryless"
>>>> automatically.
>>>>
>>>> But in online_pages(), did not see the check of < NODE_MIN_SIZE.
>>>
>>> TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
>>> pretty x86 specific thing.
>>>
>>> Are we sure we want to get NODE_MIN_SIZE involved?
>>
>> Maybe add an arch_xxx() to handle it?
> 
> I still haven't figured out what we want to achieve with NODE_MIN_SIZE 
> at all. It smells like an arch-specific hack looking at
> 
> "Don't confuse VM with a node that doesn't have the minimum amount of 
> memory"

I'm also confused about this comment.

I found the patch that originally introduced this:

	https://github.com/torvalds/linux/commit/9391a3f9c7f17bdd82adf9a98905450642cc8970

But the commit message didn't explain it very clearly. :(

> 
> Why shouldn't mm-core deal with that?
> 
> I'd appreciate an explanation of the bigger picture, what the issue is 
> and what the approach to solve it is (including memory onlining/offlining).
> 

-- 
Thanks,
Qi
