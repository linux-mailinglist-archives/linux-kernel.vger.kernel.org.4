Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C9169798F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjBOKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBOKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:12:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF04BBBB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676455915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U488r/PTAImZ4534uaUcG/jSKPhWDD+RbJ2tWH2r7Qw=;
        b=TC7Y8AZ8UuIineHGeX29uGpWuzpjl0yWD5MTOAZXi/1LEbjoUnJGzP8BPBBvGoUaB2Beoh
        sgnCkHr6YFe5nV+JZjkBw0Bdc+4s5kgEobTERiJVEMbhoQOP7JOimUNaatSJBcYVxGopYK
        ZZs0VA6PEHx7DaWEDIwhSWQJfuwBbsI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-353-vJ6us1nqOfeSdwXOExnKXw-1; Wed, 15 Feb 2023 05:11:54 -0500
X-MC-Unique: vJ6us1nqOfeSdwXOExnKXw-1
Received: by mail-wm1-f72.google.com with SMTP id k9-20020a05600c1c8900b003dc5dec2ac6so962852wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U488r/PTAImZ4534uaUcG/jSKPhWDD+RbJ2tWH2r7Qw=;
        b=gxEf/ebjVf1b3bTsNPCtxgapygt9aiYo4rNkx7RXO10OWNBQlfe/3YcOm8rbZ5fraZ
         VeBYI4PIoMK6yqGDoalTQweOAxVTDTSycxfwMxfPh8TpUMe1V2A6CWU/NhWvGjwDjgdO
         +A8HUZMjJJ4/8KWafVzbGdaXYWZ7pvN6NMvhl5ddjaptx9S3+VL9EzaclJbkSbjql8ht
         1CPaHdaXbJ+zfePWyFz0Fv5/GbEEu3Jx+Y2p7qkhul0fssUWcefrH/p/uertUUecveCp
         d4z7FqkPbUMzLjqw4arEmB0mYtT8RjMRBFTe6O8Vcu9P4lNo3+DL1ttPx9JLMNX8RASZ
         pfPA==
X-Gm-Message-State: AO0yUKXrp/tntjSGyZORlONpnTREW/6FvK4fX78XZc4Rgy4rcfLqBIKI
        QMOEssAN5kJPzUtT5LnqWWvq2j9dyYCJ6Zu6D7dfVMw/zQ3Q9xshNcKT1eOVgoqxKO0yc1rsif8
        nrswFY63d9tkGbgyw9qA54n/0
X-Received: by 2002:a5d:65c7:0:b0:2c5:4d8f:ff11 with SMTP id e7-20020a5d65c7000000b002c54d8fff11mr1116440wrw.61.1676455913179;
        Wed, 15 Feb 2023 02:11:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8v2bpELkdOAo6DfMNc6xVkY3ECFdJ96BBohhfjdZNBxVhKDUfI3+NmTRXmAG8gyqe191BR6w==
X-Received: by 2002:a5d:65c7:0:b0:2c5:4d8f:ff11 with SMTP id e7-20020a5d65c7000000b002c54d8fff11mr1116420wrw.61.1676455912921;
        Wed, 15 Feb 2023 02:11:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:1400:b7d:4122:28d:f4c3? (p200300cbc70714000b7d4122028df4c3.dip0.t-ipconnect.de. [2003:cb:c707:1400:b7d:4122:28d:f4c3])
        by smtp.gmail.com with ESMTPSA id b16-20020adfe650000000b002c5534db60bsm8906826wrn.71.2023.02.15.02.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 02:11:52 -0800 (PST)
Message-ID: <b01bb4ef-9bf1-87d7-3ff7-3a8ea7a461ed@redhat.com>
Date:   Wed, 15 Feb 2023 11:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>, x86@kernel.org
References: <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
 <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
 <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
 <Y+uO5IE7boORqsne@dhcp22.suse.cz> <Y+ymKw1eJaRcmDNN@kernel.org>
 <3a85b2b9-95fa-4123-a7a3-2bd6f8b35c13@redhat.com>
 <Y+yuRggjs0otCXFz@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y+yuRggjs0otCXFz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.23 11:04, Mike Rapoport wrote:
> On Wed, Feb 15, 2023 at 10:43:58AM +0100, David Hildenbrand wrote:
>> On 15.02.23 10:30, Mike Rapoport wrote:
>>> On Tue, Feb 14, 2023 at 02:38:44PM +0100, Michal Hocko wrote:
>>>> On Tue 14-02-23 12:58:39, David Hildenbrand wrote:
>>>>> On 14.02.23 12:48, David Hildenbrand wrote:
>>>>>> On 14.02.23 12:44, Mike Rapoport wrote:
>>>>>>> (added x86 folks)
>>>>>>>
>>>>>>> On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
>>>>>>>> On 14.02.23 12:26, Qi Zheng wrote:
>>>>>>>>> On 2023/2/14 19:22, David Hildenbrand wrote:
>>>>>>>>>>
>>>>>>>>>> TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
>>>>>>>>>> pretty x86 specific thing.
>>>>>>>>>>
>>>>>>>>>> Are we sure we want to get NODE_MIN_SIZE involved?
>>>>>>>>>
>>>>>>>>> Maybe add an arch_xxx() to handle it?
>>>>>>>>
>>>>>>>> I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
>>>>>>>> all. It smells like an arch-specific hack looking at
>>>>>>>>
>>>>>>>> "Don't confuse VM with a node that doesn't have the minimum amount of
>>>>>>>> memory"
>>>>>>>>
>>>>>>>> Why shouldn't mm-core deal with that?
>>>>>>>
>>>>>>> Well, a node with <4M RAM is not very useful and bears all the overhead of
>>>>>>> an extra live node.
>>>>>>
>>>>>> And totally not with 4.1M, haha.
>>>>>>
>>>>>> I really like the "Might fix boot" in the commit description.
>>>>>>
>>>>>>>
>>>>>>> But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
>>>>>>> weird HW configurations just live with this?
>>>>>>
>>>>>>
>>>>>> ;)
>>>>>>
>>>>>
>>>>> Actually, remembering 09f49dca570a ("mm: handle uninitialized numa nodes
>>>>> gracefully"), this might be the right thing to do. That commit assumes that
>>>>> all offline nodes would get the pgdat allocated in free_area_init(). So that
>>>>> we end up with an allocated pgdat for all possible nodes. The reasoning IIRC
>>>>> was that we don't care about wasting memory in weird VM setups.
>>>>
>>>> Yes, that is the case indeed. I suspect the NODE_MIN_SIZE is a relict of
>>>> the past when some PXM entries were incorrect or fishy. I would just
>>>> drop the check and see whether something breaks. Or make those involved
>>>> back then remember whether this is addressing something that is relevant
>>>> these days. Even 5MB node makes (as the memmap is allocated for the
>>>> whole memory section anyway and that is 128MB) a very little sense if you ask me.
>>>
>>> How about we try this:
>>>
>>>   From b670120bcacd3fe34a40d7179c70ca2ab69279e0 Mon Sep 17 00:00:00 2001
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>> Date: Wed, 15 Feb 2023 11:12:18 +0200
>>> Subject: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
>>>
>>> Qi Zheng reports crashes in a production environment and provides a
>>> simplified example as a reproducer:
>>>
>>>     For example, if we use qemu to start a two NUMA node kernel,
>>>     one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>>     and the other node has 2G, then we will encounter the
>>>     following panic:
>>>
>>>     [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>     [    0.150783] #PF: supervisor write access in kernel mode
>>>     [    0.151488] #PF: error_code(0x0002) - not-present page
>>>     <...>
>>>     [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>>     <...>
>>>     [    0.169781] Call Trace:
>>>     [    0.170159]  <TASK>
>>>     [    0.170448]  deactivate_slab+0x187/0x3c0
>>>     [    0.171031]  ? bootstrap+0x1b/0x10e
>>>     [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>>     [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>>     [    0.172735]  ? bootstrap+0x1b/0x10e
>>>     [    0.173236]  bootstrap+0x6b/0x10e
>>>     [    0.173720]  kmem_cache_init+0x10a/0x188
>>>     [    0.174240]  start_kernel+0x415/0x6ac
>>>     [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>>     [    0.175417]  </TASK>
>>>     [    0.175713] Modules linked in:
>>>     [    0.176117] CR2: 0000000000000000
>>>
>>> The crashes happen because of inconsistency between nodemask that has
>>> nodes with less than 4MB as memoryless and the actual memory fed into
>>> core mm.
>>>
>>> The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
>>> empty node in SRAT parsing") that introduced minimal size of a NUMA node
>>> does not explain why a node size cannot be less than 4MB and what boot
>>> failures this restriction might fix.
>>>
>>> Since then a lot has changed and core mm won't confuse badly about small
>>> node sizes.
>>>
>>> Drop the limitation for the minimal node size.
>>>
>>> Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
>>> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
>>> ---
>>>    arch/x86/include/asm/numa.h | 7 -------
>>>    arch/x86/mm/numa.c          | 7 -------
>>>    2 files changed, 14 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
>>> index e3bae2b60a0d..ef2844d69173 100644
>>> --- a/arch/x86/include/asm/numa.h
>>> +++ b/arch/x86/include/asm/numa.h
>>> @@ -12,13 +12,6 @@
>>>    #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
>>> -/*
>>> - * Too small node sizes may confuse the VM badly. Usually they
>>> - * result from BIOS bugs. So dont recognize nodes as standalone
>>> - * NUMA entities that have less than this amount of RAM listed:
>>> - */
>>> -#define NODE_MIN_SIZE (4*1024*1024)
>>> -
>>>    extern int numa_off;
>>>    /*
>>> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
>>> index 2aadb2019b4f..55e3d895f15c 100644
>>> --- a/arch/x86/mm/numa.c
>>> +++ b/arch/x86/mm/numa.c
>>> @@ -601,13 +601,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>>>    		if (start >= end)
>>>    			continue;
>>> -		/*
>>> -		 * Don't confuse VM with a node that doesn't have the
>>> -		 * minimum amount of memory:
>>> -		 */
>>> -		if (end && (end - start) < NODE_MIN_SIZE)
>>> -			continue;
>>> -
>>>    		alloc_node_data(nid);
>>>    	}
>>
>> Hopefully it fixes the issue.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>>
>> The 4 MiB looks like the magical MAX_ORDER (and/or pageblock) thingy to me.
>> I recall that there were issues in the past when memory exposed to the buddy
>> would only be partially covering a pageblock. IIRC, memblock should already
>> take care to not expose memory to the buddy that is not aligned to MAX_ORDER
>> boundaries -- correct?
> 
> I don't remember those issues, but memblock does not align memory freed to
> the buddy.
> 
> Still, this 4MB looks like a really old magic that was way before memblock
> and even SPARSEMEM was experimental back then.
> 
> It's possible that the issues were with DISCONTIGMEM or with bootmem.

I recall where I stumbled over that:

commit 3c5f2eb9695cd241c9898a01388b19a149d0b7d2
Author: Heiko Carstens <hca@linux.ibm.com>
Date:   Tue Jul 14 07:46:40 2020 +0200

     s390/mm: avoid trimming to MAX_ORDER

     Trimming to MAX_ORDER was originally done in order to avoid to set
     HOLES_IN_ZONE, which in turn would enable a quite expensive
     pfn_valid() check. pfn_valid() however only checks if a struct page
     exists for a given pfn.

     With sparsemen vmemmap there are always struct pages, since memmaps
     are allocated for whole sections. Therefore remove the HOLES_IN_ZONE
     comment and the trimming.

     Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

So indeed, it might just be a legacy leftover and with SPARSEMEM it 
should all be fine.

-- 
Thanks,

David / dhildenb

