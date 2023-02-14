Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF569625D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjBNLXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjBNLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDEDDBE7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676373783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+d2u7qxhmEhGvu08Rt0T5yjU+JQuiplfBwWqI8t4aE=;
        b=ibll4D4XSLAIEvX/nqd/DHHef9KUTFk5EYO6z5c3Qna1I25ivGyPWW2pfB7mcQ0sK/u7aT
        ipmyi9M+g4tlc0Z6eURGrCNixftcXqEYMY0Td9Uiw9O8EaoEXb4MifpSCFHH3t4WhfmRa6
        u2bdqP354aPaqbDe4ITYcpqCH56RTZI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-tA9dCJRrNRqiVwf2XF9c1w-1; Tue, 14 Feb 2023 06:23:01 -0500
X-MC-Unique: tA9dCJRrNRqiVwf2XF9c1w-1
Received: by mail-wm1-f71.google.com with SMTP id m3-20020a05600c3b0300b003dfdc6021bcso7627876wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+d2u7qxhmEhGvu08Rt0T5yjU+JQuiplfBwWqI8t4aE=;
        b=siUzniMFJ6oPC+uwh+1t70mahWxKfp8ixg9KlOLz0y/ZYhTz0B1xbMPd5CQmlVWFZq
         nnH5YUBAQruu4kBlfQCOggeLKlgM/B0GdKROI57do3QJwD4JQo/YQLnvq/FBO9KXIe63
         YznYFmnrPFUMNcsal0UijKWv4pocsU7zVOrqhgZySKNaNu151NGjjyzfV3YrB2zjInQ0
         V6Y/tjjk94xrnGaBTHHJNt49KL8+RuQx72UuWheGIxMkqCFgneyMrp4GCh2MkMIgrpxe
         /D1AI/T2D0PN4c9LxRiQvQI7k+m3Hri+Idn7lc9KwcglpD54UqotBWdnqbTI9DCw7tIS
         WTnQ==
X-Gm-Message-State: AO0yUKU00apzICRj6GMVs9nSxeBJszn1yKAbmc6HqeQrCclZj6CsFmAb
        qnreRU/R/A/OfQgUrLbKf8SdQj5gFbMEH4dfy2ljWaVMbMulaBK+I3NLpGfOLrpcJYXg0vczfY8
        hqt8uEH0Vzwke6fSJoMLp64tf
X-Received: by 2002:adf:f685:0:b0:2c5:607f:5f4f with SMTP id v5-20020adff685000000b002c5607f5f4fmr1663437wrp.8.1676373780693;
        Tue, 14 Feb 2023 03:23:00 -0800 (PST)
X-Google-Smtp-Source: AK7set9YKWzLlY2ftJ89JAEvuLm57wUR5ldr/D2Hdh5dSLx34H1frSXfK1/OpbeT6vGz5CXAXm9unQ==
X-Received: by 2002:adf:f685:0:b0:2c5:607f:5f4f with SMTP id v5-20020adff685000000b002c5607f5f4fmr1663419wrp.8.1676373780354;
        Tue, 14 Feb 2023 03:23:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id z15-20020adfe54f000000b002c5694aef92sm721133wrm.21.2023.02.14.03.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:22:59 -0800 (PST)
Message-ID: <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
Date:   Tue, 14 Feb 2023 12:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Qi Zheng <arch0.zheng@gmail.com>, Mike Rapoport <rppt@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Teng Hu <huteng.ht@bytedance.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 11:26, Qi Zheng wrote:
> 
> 
> On 2023/2/14 17:43, Mike Rapoport wrote:
>> On Tue, Feb 14, 2023 at 10:17:03AM +0100, David Hildenbrand wrote:
>>> On 14.02.23 09:42, Vlastimil Babka wrote:
>>>> On 2/13/23 12:00, Qi Zheng wrote:
>>>>>
>>>>>
>>>>> On 2023/2/13 16:47, Vlastimil Babka wrote:
>>>>>> On 2/12/23 12:03, Qi Zheng wrote:
>>>>>>> In x86, numa_register_memblks() is only interested in
>>>>>>> those nodes which have enough memory, so it skips over
>>>>>>> all nodes with memory below NODE_MIN_SIZE (treated as
>>>>>>> a memoryless node). Later on, we will initialize these
>>>>>>> memoryless nodes (allocate pgdat in free_area_init()
>>>>>>> and build zonelist etc), and will online these nodes
>>>>>>> in init_cpu_to_node() and init_gi_nodes().
>>>>>>>
>>>>>>> After boot, these memoryless nodes are in N_ONLINE
>>>>>>> state but not in N_MEMORY state. But we can still allocate
>>>>>>> pages from these memoryless nodes.
>>>>>>>
>>>>>>> In SLUB, we only process nodes in the N_MEMORY state,
>>>>>>> such as allocating their struct kmem_cache_node. So if
>>>>>>> we allocate a page from the memoryless node above to
>>>>>>> SLUB, the struct kmem_cache_node of the node corresponding
>>>>>>> to this page is NULL, which will cause panic.
>>>>>>>
>>>>>>> For example, if we use qemu to start a two numa node kernel,
>>>>>>> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>>>>>> and the other node has 2G, then we will encounter the
>>>>>>> following panic:
>>>>>>>
>>>>>>> [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>>>>> [    0.150783] #PF: supervisor write access in kernel mode
>>>>>>> [    0.151488] #PF: error_code(0x0002) - not-present page
>>>>>>> <...>
>>>>>>> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>>>>>> <...>
>>>>>>> [    0.169781] Call Trace:
>>>>>>> [    0.170159]  <TASK>
>>>>>>> [    0.170448]  deactivate_slab+0x187/0x3c0
>>>>>>> [    0.171031]  ? bootstrap+0x1b/0x10e
>>>>>>> [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>>>>>> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>>>>>> [    0.172735]  ? bootstrap+0x1b/0x10e
>>>>>>> [    0.173236]  bootstrap+0x6b/0x10e
>>>>>>> [    0.173720]  kmem_cache_init+0x10a/0x188
>>>>>>> [    0.174240]  start_kernel+0x415/0x6ac
>>>>>>> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>>>>>> [    0.175417]  </TASK>
>>>>>>> [    0.175713] Modules linked in:
>>>>>>> [    0.176117] CR2: 0000000000000000
>>>>>>>
>>>>>>> In addition, we can also encountered this panic in the actual
>>>>>>> production environment. We set up a 2c2g container with two
>>>>>>> numa nodes, and then reserved 128M for kdump, and then we
>>>>>>> can encountered the above panic in the kdump kernel.
>>>>>>>
>>>>>>> To fix it, we can filter memoryless nodes when allocating
>>>>>>> pages.
>>>>>>>
>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>> Reported-by: Teng Hu <huteng.ht@bytedance.com>
>>>>>>
>>>>>> Well AFAIK the key mechanism to only allocate from "good" nodes is the
>>>>>> zonelist, we shouldn't need to start putting extra checks like this. So it
>>>>>> seems to me that the code building the zonelists should take the
>>>>>> NODE_MIN_SIZE constraint in mind.
>>>>>
>>>>> Indeed. How about the following patch:
>>>>
>>>> +Cc also David, forgot earlier.
>>>>
>>>> Looks good to me, at least.
>>>>
>>>>> @@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t
>>>>> *used_node_mask)
>>>>>             int min_val = INT_MAX;
>>>>>             int best_node = NUMA_NO_NODE;
>>>>>
>>>>> -       /* Use the local node if we haven't already */
>>>>> -       if (!node_isset(node, *used_node_mask)) {
>>>>> +       /*
>>>>> +        * Use the local node if we haven't already. But for memoryless
>>>>> local
>>>>> +        * node, we should skip it and fallback to other nodes.
>>>>> +        */
>>>>> +       if (!node_isset(node, *used_node_mask) && node_state(node,
>>>>> N_MEMORY)) {
>>>>>                     node_set(node, *used_node_mask);
>>>>>                     return node;
>>>>>             }
>>>>>
>>>>> For memoryless node, we skip it and fallback to other nodes when
>>>>> build its zonelists.
>>>>>
>>>>> Say we have node0 and node1, and node0 is memoryless, then:
>>>>>
>>>>> [    0.102400] Fallback order for Node 0: 1
>>>>> [    0.102931] Fallback order for Node 1: 1
>>>>>
>>>>> In this way, we will not allocate pages from memoryless node0.
>>>>>
>>>
>>> In offline_pages(), we'll first build_all_zonelists() to then
>>> node_states_clear_node()->node_clear_state(node, N_MEMORY);
>>>
>>> So at least on the offlining path, we wouldn't detect it properly yet I
>>> assume, and build a zonelist that contains a now-memory-less node?
>>
>> Another question is what happens if a new memory is plugged into a node
>> that had < NODE_MIN_SIZE of memory and after hotplug it stops being
>> "memoryless".
> 
> When going online and offline a memory will re-call
> build_all_zonelists() to re-establish the zonelists (the zonelist of
> itself and other nodes). So it can stop being "memoryless"
> automatically.
> 
> But in online_pages(), did not see the check of < NODE_MIN_SIZE.

TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a 
pretty x86 specific thing.

Are we sure we want to get NODE_MIN_SIZE involved?

-- 
Thanks,

David / dhildenb

