Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0451869793A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBOJo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjBOJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9523431A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676454242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3U1FEZ4RqMM5/a4DwiutQ56IQqaMtzE5cgyWiSkU74=;
        b=UZEGLBsXDejjApXhBDNPqqMuo88TGglVpp5TdFNMSs0TufMwzcaPmOYRwT9rkLn6hmTSBs
        rlUWk59piG1R9YQN4u9FYsdpuapbcZPJCe7HaC+92Jc4sModaMpViIRwZbkAvcCWq6cNmR
        Tlar94Yc7Fk6XSDbzvh+vlkfC5eQTjo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-I7ex9v-rMFiX_mARaPtpiw-1; Wed, 15 Feb 2023 04:44:01 -0500
X-MC-Unique: I7ex9v-rMFiX_mARaPtpiw-1
Received: by mail-wm1-f69.google.com with SMTP id s11-20020a05600c384b00b003dffc7343c3so9024355wmr.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3U1FEZ4RqMM5/a4DwiutQ56IQqaMtzE5cgyWiSkU74=;
        b=4mKc5MiyLsObfcry6SlZR0VH4OUy5uLA38ekGOjOYU+KD17Ul8P7J604iWR2ADNBm7
         kVnAIkwVMaPNr1Cpi06jcbN5u00msV/pzeEEg0TQ2OlzXwTZpqlmiCyY81bv1//hgkpj
         ZXIfm/lp+knH4nVm3FB9sF58+ecTl1s7lASyK0+4zfAT918QGK2QzM2FUCe3AALCVmhc
         1ewqxEK9XLNH/ryzlG0B58yKUfnuU7W4Qk8lk91dAGFBkMkz8/aKmxXG/KNUxkziSQj8
         zgPmkoZUOuVGgGFAzwAPS+0+ZBHaeQ0wOtRGyWlkGYy+Zu8W4Nr06hRaJXQiyhg724Mw
         pWSQ==
X-Gm-Message-State: AO0yUKUEDfdGfnb/jx+rbl8I2NCgIN0p/GYRWhdwkOQK6k8fMmnkH6cN
        ECHA0XsUCo37Js4b/dqYCjyJpI3XRd8KskLW78wBi6nwEDGgjyARq2Hpi+HAXD48Fqj06eBjRcz
        7pn/WrSpgy58GtkIhz+aniFSOusXlYQ==
X-Received: by 2002:a05:600c:91d:b0:3e2:668:3ed7 with SMTP id m29-20020a05600c091d00b003e206683ed7mr224507wmp.1.1676454240167;
        Wed, 15 Feb 2023 01:44:00 -0800 (PST)
X-Google-Smtp-Source: AK7set9rhiWAFNKJ4UTGGW2zvYD0ibyuRrJXlIe6DimzrLjLdqt60/8pIH/IQ//lvvP1+x1WW1WmOQ==
X-Received: by 2002:a05:600c:91d:b0:3e2:668:3ed7 with SMTP id m29-20020a05600c091d00b003e206683ed7mr224495wmp.1.1676454239853;
        Wed, 15 Feb 2023 01:43:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:1400:b7d:4122:28d:f4c3? (p200300cbc70714000b7d4122028df4c3.dip0.t-ipconnect.de. [2003:cb:c707:1400:b7d:4122:28d:f4c3])
        by smtp.gmail.com with ESMTPSA id y5-20020a05600c364500b003dffe312925sm1467030wmq.15.2023.02.15.01.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 01:43:59 -0800 (PST)
Message-ID: <3a85b2b9-95fa-4123-a7a3-2bd6f8b35c13@redhat.com>
Date:   Wed, 15 Feb 2023 10:43:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
To:     Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>, x86@kernel.org
References: <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
 <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
 <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
 <Y+uO5IE7boORqsne@dhcp22.suse.cz> <Y+ymKw1eJaRcmDNN@kernel.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y+ymKw1eJaRcmDNN@kernel.org>
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

On 15.02.23 10:30, Mike Rapoport wrote:
> On Tue, Feb 14, 2023 at 02:38:44PM +0100, Michal Hocko wrote:
>> On Tue 14-02-23 12:58:39, David Hildenbrand wrote:
>>> On 14.02.23 12:48, David Hildenbrand wrote:
>>>> On 14.02.23 12:44, Mike Rapoport wrote:
>>>>> (added x86 folks)
>>>>>
>>>>> On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
>>>>>> On 14.02.23 12:26, Qi Zheng wrote:
>>>>>>> On 2023/2/14 19:22, David Hildenbrand wrote:
>>>>>>>>
>>>>>>>> TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
>>>>>>>> pretty x86 specific thing.
>>>>>>>>
>>>>>>>> Are we sure we want to get NODE_MIN_SIZE involved?
>>>>>>>
>>>>>>> Maybe add an arch_xxx() to handle it?
>>>>>>
>>>>>> I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
>>>>>> all. It smells like an arch-specific hack looking at
>>>>>>
>>>>>> "Don't confuse VM with a node that doesn't have the minimum amount of
>>>>>> memory"
>>>>>>
>>>>>> Why shouldn't mm-core deal with that?
>>>>>
>>>>> Well, a node with <4M RAM is not very useful and bears all the overhead of
>>>>> an extra live node.
>>>>
>>>> And totally not with 4.1M, haha.
>>>>
>>>> I really like the "Might fix boot" in the commit description.
>>>>
>>>>>
>>>>> But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
>>>>> weird HW configurations just live with this?
>>>>
>>>>
>>>> ;)
>>>>
>>>
>>> Actually, remembering 09f49dca570a ("mm: handle uninitialized numa nodes
>>> gracefully"), this might be the right thing to do. That commit assumes that
>>> all offline nodes would get the pgdat allocated in free_area_init(). So that
>>> we end up with an allocated pgdat for all possible nodes. The reasoning IIRC
>>> was that we don't care about wasting memory in weird VM setups.
>>
>> Yes, that is the case indeed. I suspect the NODE_MIN_SIZE is a relict of
>> the past when some PXM entries were incorrect or fishy. I would just
>> drop the check and see whether something breaks. Or make those involved
>> back then remember whether this is addressing something that is relevant
>> these days. Even 5MB node makes (as the memmap is allocated for the
>> whole memory section anyway and that is 128MB) a very little sense if you ask me.
> 
> How about we try this:
> 
>  From b670120bcacd3fe34a40d7179c70ca2ab69279e0 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Date: Wed, 15 Feb 2023 11:12:18 +0200
> Subject: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
> 
> Qi Zheng reports crashes in a production environment and provides a
> simplified example as a reproducer:
> 
>    For example, if we use qemu to start a two NUMA node kernel,
>    one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>    and the other node has 2G, then we will encounter the
>    following panic:
> 
>    [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>    [    0.150783] #PF: supervisor write access in kernel mode
>    [    0.151488] #PF: error_code(0x0002) - not-present page
>    <...>
>    [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>    <...>
>    [    0.169781] Call Trace:
>    [    0.170159]  <TASK>
>    [    0.170448]  deactivate_slab+0x187/0x3c0
>    [    0.171031]  ? bootstrap+0x1b/0x10e
>    [    0.171559]  ? preempt_count_sub+0x9/0xa0
>    [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>    [    0.172735]  ? bootstrap+0x1b/0x10e
>    [    0.173236]  bootstrap+0x6b/0x10e
>    [    0.173720]  kmem_cache_init+0x10a/0x188
>    [    0.174240]  start_kernel+0x415/0x6ac
>    [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>    [    0.175417]  </TASK>
>    [    0.175713] Modules linked in:
>    [    0.176117] CR2: 0000000000000000
> 
> The crashes happen because of inconsistency between nodemask that has
> nodes with less than 4MB as memoryless and the actual memory fed into
> core mm.
> 
> The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> empty node in SRAT parsing") that introduced minimal size of a NUMA node
> does not explain why a node size cannot be less than 4MB and what boot
> failures this restriction might fix.
> 
> Since then a lot has changed and core mm won't confuse badly about small
> node sizes.
> 
> Drop the limitation for the minimal node size.
> 
> Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/x86/include/asm/numa.h | 7 -------
>   arch/x86/mm/numa.c          | 7 -------
>   2 files changed, 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index e3bae2b60a0d..ef2844d69173 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -12,13 +12,6 @@
>   
>   #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
>   
> -/*
> - * Too small node sizes may confuse the VM badly. Usually they
> - * result from BIOS bugs. So dont recognize nodes as standalone
> - * NUMA entities that have less than this amount of RAM listed:
> - */
> -#define NODE_MIN_SIZE (4*1024*1024)
> -
>   extern int numa_off;
>   
>   /*
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..55e3d895f15c 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -601,13 +601,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>   		if (start >= end)
>   			continue;
>   
> -		/*
> -		 * Don't confuse VM with a node that doesn't have the
> -		 * minimum amount of memory:
> -		 */
> -		if (end && (end - start) < NODE_MIN_SIZE)
> -			continue;
> -
>   		alloc_node_data(nid);
>   	}
>   

Hopefully it fixes the issue.

Acked-by: David Hildenbrand <david@redhat.com>


The 4 MiB looks like the magical MAX_ORDER (and/or pageblock) thingy to 
me. I recall that there were issues in the past when memory exposed to 
the buddy would only be partially covering a pageblock. IIRC, memblock 
should already take care to not expose memory to the buddy that is not 
aligned to MAX_ORDER boundaries -- correct?

-- 
Thanks,

David / dhildenb

