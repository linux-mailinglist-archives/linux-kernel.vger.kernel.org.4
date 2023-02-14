Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4269627C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjBNLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjBNLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3417151
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676374186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5kdxsYbT6HT386pMDnxVDxE4u71l/UySB2qYCenzys=;
        b=O29D23GJ5/oolwd6bancuylqSvm8JPKZxiP3LMuk5Bu6+8V7dV/9ynpUzbFSeSXg1LtMiB
        6OV/1T1pUFW2uLrhjRT0dShZEdMua8f8fDboyxpYhPgszQRh8ZyC64Qemg0+WnToWcToJJ
        9pIleWrPzUVGeR/7McS4qXPA+kJuTgs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-82-TMePo_tTPJ-WxRYpi1CnyQ-1; Tue, 14 Feb 2023 06:29:45 -0500
X-MC-Unique: TMePo_tTPJ-WxRYpi1CnyQ-1
Received: by mail-wm1-f72.google.com with SMTP id o31-20020a05600c511f00b003dc53da325dso10776544wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5kdxsYbT6HT386pMDnxVDxE4u71l/UySB2qYCenzys=;
        b=jm2oTgrUMd0CDIQt1QsSJo/AzIHQV8j2E3RsVSOyldupaSMRm3Oewp4nKUNamT5lyU
         KUYYrWwNhUaFV41gSNLV4X6AQOwr03Dn3unLG/kGERctlEzNQ76fIcDKRRkGssa8AqUG
         8och0CHFsvWHfuFpIY1L77MttrQswXIVrDEsrho2YsmSBZXN+ynXAoKZoGEJM89nkbW7
         A0vY65lQbvvCffcp1m5hGliPRcOgJ724bgHZZjTnnRH1GWKhnLrT8PGhJF3+i1eToBxn
         6zwlBTZ7sHqt+ud3Epm+St+97arAJruxjT5xPNrVtDr34UQuJCjeBegG32r7QtN+jXDc
         tWXA==
X-Gm-Message-State: AO0yUKVcp720ZUpTLFVi93/3GSxtD7lCrBQv4ihN0Kiz6ypD16DmQWN4
        ry44A9wb/j/+FCq/g47zvTwQHUsDyItozaU8Chu6AcfqWZBS7eHDJWbsZqVWXmXyPY0iBm8MiPv
        oBq1gcG+cPTdodt0GErde4GNS
X-Received: by 2002:adf:e54e:0:b0:2bf:c09a:c60e with SMTP id z14-20020adfe54e000000b002bfc09ac60emr1853952wrm.2.1676374184210;
        Tue, 14 Feb 2023 03:29:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+WvmvugFF3GicinFyEHzyqoWTVJzxRKV2C+s2TMVInReqBpgLaTuuBgfEY9CTH9qwIcR6+zQ==
X-Received: by 2002:adf:e54e:0:b0:2bf:c09a:c60e with SMTP id z14-20020adfe54e000000b002bfc09ac60emr1853937wrm.2.1676374183947;
        Tue, 14 Feb 2023 03:29:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b002be0b1e556esm12711631wrn.59.2023.02.14.03.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:29:43 -0800 (PST)
Message-ID: <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
Date:   Tue, 14 Feb 2023 12:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.23 12:26, Qi Zheng wrote:
> 
> 
> On 2023/2/14 19:22, David Hildenbrand wrote:
>> On 14.02.23 11:26, Qi Zheng wrote:
>>>
>>>
>>> On 2023/2/14 17:43, Mike Rapoport wrote:
>>>> On Tue, Feb 14, 2023 at 10:17:03AM +0100, David Hildenbrand wrote:
>>>>> On 14.02.23 09:42, Vlastimil Babka wrote:
>>>>>> On 2/13/23 12:00, Qi Zheng wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2023/2/13 16:47, Vlastimil Babka wrote:
>>>>>>>> On 2/12/23 12:03, Qi Zheng wrote:
>>>>>>>>> In x86, numa_register_memblks() is only interested in
>>>>>>>>> those nodes which have enough memory, so it skips over
>>>>>>>>> all nodes with memory below NODE_MIN_SIZE (treated as
>>>>>>>>> a memoryless node). Later on, we will initialize these
>>>>>>>>> memoryless nodes (allocate pgdat in free_area_init()
>>>>>>>>> and build zonelist etc), and will online these nodes
>>>>>>>>> in init_cpu_to_node() and init_gi_nodes().
>>>>>>>>>
>>>>>>>>> After boot, these memoryless nodes are in N_ONLINE
>>>>>>>>> state but not in N_MEMORY state. But we can still allocate
>>>>>>>>> pages from these memoryless nodes.
>>>>>>>>>
>>>>>>>>> In SLUB, we only process nodes in the N_MEMORY state,
>>>>>>>>> such as allocating their struct kmem_cache_node. So if
>>>>>>>>> we allocate a page from the memoryless node above to
>>>>>>>>> SLUB, the struct kmem_cache_node of the node corresponding
>>>>>>>>> to this page is NULL, which will cause panic.
>>>>>>>>>
>>>>>>>>> For example, if we use qemu to start a two numa node kernel,
>>>>>>>>> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>>>>>>>> and the other node has 2G, then we will encounter the
>>>>>>>>> following panic:
>>>>>>>>>
>>>>>>>>> [    0.149844] BUG: kernel NULL pointer dereference, address:
>>>>>>>>> 0000000000000000
>>>>>>>>> [    0.150783] #PF: supervisor write access in kernel mode
>>>>>>>>> [    0.151488] #PF: error_code(0x0002) - not-present page
>>>>>>>>> <...>
>>>>>>>>> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>>>>>>>> <...>
>>>>>>>>> [    0.169781] Call Trace:
>>>>>>>>> [    0.170159]  <TASK>
>>>>>>>>> [    0.170448]  deactivate_slab+0x187/0x3c0
>>>>>>>>> [    0.171031]  ? bootstrap+0x1b/0x10e
>>>>>>>>> [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>>>>>>>> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>>>>>>>> [    0.172735]  ? bootstrap+0x1b/0x10e
>>>>>>>>> [    0.173236]  bootstrap+0x6b/0x10e
>>>>>>>>> [    0.173720]  kmem_cache_init+0x10a/0x188
>>>>>>>>> [    0.174240]  start_kernel+0x415/0x6ac
>>>>>>>>> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>>>>>>>> [    0.175417]  </TASK>
>>>>>>>>> [    0.175713] Modules linked in:
>>>>>>>>> [    0.176117] CR2: 0000000000000000
>>>>>>>>>
>>>>>>>>> In addition, we can also encountered this panic in the actual
>>>>>>>>> production environment. We set up a 2c2g container with two
>>>>>>>>> numa nodes, and then reserved 128M for kdump, and then we
>>>>>>>>> can encountered the above panic in the kdump kernel.
>>>>>>>>>
>>>>>>>>> To fix it, we can filter memoryless nodes when allocating
>>>>>>>>> pages.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>>>> Reported-by: Teng Hu <huteng.ht@bytedance.com>
>>>>>>>>
>>>>>>>> Well AFAIK the key mechanism to only allocate from "good" nodes
>>>>>>>> is the
>>>>>>>> zonelist, we shouldn't need to start putting extra checks like
>>>>>>>> this. So it
>>>>>>>> seems to me that the code building the zonelists should take the
>>>>>>>> NODE_MIN_SIZE constraint in mind.
>>>>>>>
>>>>>>> Indeed. How about the following patch:
>>>>>>
>>>>>> +Cc also David, forgot earlier.
>>>>>>
>>>>>> Looks good to me, at least.
>>>>>>
>>>>>>> @@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t
>>>>>>> *used_node_mask)
>>>>>>>              int min_val = INT_MAX;
>>>>>>>              int best_node = NUMA_NO_NODE;
>>>>>>>
>>>>>>> -       /* Use the local node if we haven't already */
>>>>>>> -       if (!node_isset(node, *used_node_mask)) {
>>>>>>> +       /*
>>>>>>> +        * Use the local node if we haven't already. But for
>>>>>>> memoryless
>>>>>>> local
>>>>>>> +        * node, we should skip it and fallback to other nodes.
>>>>>>> +        */
>>>>>>> +       if (!node_isset(node, *used_node_mask) && node_state(node,
>>>>>>> N_MEMORY)) {
>>>>>>>                      node_set(node, *used_node_mask);
>>>>>>>                      return node;
>>>>>>>              }
>>>>>>>
>>>>>>> For memoryless node, we skip it and fallback to other nodes when
>>>>>>> build its zonelists.
>>>>>>>
>>>>>>> Say we have node0 and node1, and node0 is memoryless, then:
>>>>>>>
>>>>>>> [    0.102400] Fallback order for Node 0: 1
>>>>>>> [    0.102931] Fallback order for Node 1: 1
>>>>>>>
>>>>>>> In this way, we will not allocate pages from memoryless node0.
>>>>>>>
>>>>>
>>>>> In offline_pages(), we'll first build_all_zonelists() to then
>>>>> node_states_clear_node()->node_clear_state(node, N_MEMORY);
>>>>>
>>>>> So at least on the offlining path, we wouldn't detect it properly yet I
>>>>> assume, and build a zonelist that contains a now-memory-less node?
>>>>
>>>> Another question is what happens if a new memory is plugged into a node
>>>> that had < NODE_MIN_SIZE of memory and after hotplug it stops being
>>>> "memoryless".
>>>
>>> When going online and offline a memory will re-call
>>> build_all_zonelists() to re-establish the zonelists (the zonelist of
>>> itself and other nodes). So it can stop being "memoryless"
>>> automatically.
>>>
>>> But in online_pages(), did not see the check of < NODE_MIN_SIZE.
>>
>> TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
>> pretty x86 specific thing.
>>
>> Are we sure we want to get NODE_MIN_SIZE involved?
> 
> Maybe add an arch_xxx() to handle it?

I still haven't figured out what we want to achieve with NODE_MIN_SIZE 
at all. It smells like an arch-specific hack looking at

"Don't confuse VM with a node that doesn't have the minimum amount of 
memory"

Why shouldn't mm-core deal with that?

I'd appreciate an explanation of the bigger picture, what the issue is 
and what the approach to solve it is (including memory onlining/offlining).

-- 
Thanks,

David / dhildenb

