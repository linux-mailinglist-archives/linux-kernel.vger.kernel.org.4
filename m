Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD2E697930
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjBOJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbjBOJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:43:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FA36446
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:42:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id oa11-20020a17090b1bcb00b002341a2656e5so1380113pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqBlTSVugTjnyCrRiAgqEdfXQROVguekXI86WbF+IXs=;
        b=yNsyUfoCLWT9tBEhOmVEAUvo6VRTOIzHHniVqoX/eXQLQXCjYE6yUlw0YESaYJ3g+U
         eI4yw1Zia4vm5W7d/k2NHMWN5RFvqIyzpR4dHfg2gbYX9HHjc24GPOtuLDoNdMMMPiog
         sXVY9tP7IE/igBC0fCPa0QZOLxqJtRKKfFD/DqkK/zAMZeliB+Ez5iC2uH7z5vZw4vsA
         ziwMBEhUfPRfWp5SsQoCgVnKZ2wSyHxZJJaL23cGXS+r+SqzUMmoysK2XI73wIfcylBV
         1xPCjuqOfHyxo+yO8+cpwHySuR53+I0BPO+f48sEAaZX5L/ToCrnA/HmkwQ1znjvfjBP
         x4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqBlTSVugTjnyCrRiAgqEdfXQROVguekXI86WbF+IXs=;
        b=WKlmA/SBIKq7LxG9NtdFIODpOsAAxIBQCB6VMXCBPgp+GWaqEyBcpHJbETLtppeRUa
         IFs2YfDaT9egnRp7yK7/WWgDlL/vWuPbGn1cv2OROaVLm2Hgwrz/4V/xR0WrJDwySgeU
         0zxCRh3dMOQ5dBQe45uXmzhy4QVWEm+1Q0K9/k40K4gX9fuQ0Pc++UAUYkOkB1fGjmBb
         lw0bqSgcXseTRl7M+6SjhwzM5lrRZFgnBh11t0wCikYqJKJ5BKnCtT8ekBLhxhv9R/nt
         XjcxOa2FhLOFJv1gCUZR1yfUyiJs/ejCCkrF1cttw6kB+7YBJyOSQq6ZJ5uhQ+C7cYb2
         TKFw==
X-Gm-Message-State: AO0yUKUWoWNLLeQ68kJFA+qsiDEnGeAgH6VhqzlAMV906GMYCkTeyVDc
        ccTgm7aBnX11uhut8dQ+mtwLRA==
X-Google-Smtp-Source: AK7set81vQtZKuJ/VbVIcptx+2dxX/SQ85hdp3fzFRGeG9ds7AjBU/zKwR4t1eB350MeJFtKE/Pglg==
X-Received: by 2002:a17:902:ab02:b0:196:8d96:dc6b with SMTP id ik2-20020a170902ab0200b001968d96dc6bmr1930869plb.2.1676454123202;
        Wed, 15 Feb 2023 01:42:03 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id jh9-20020a170903328900b0018b025d9a40sm7944042plb.256.2023.02.15.01.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 01:42:02 -0800 (PST)
Message-ID: <b030ec03-c214-276f-4a9d-c1bf7439e8f5@bytedance.com>
Date:   Wed, 15 Feb 2023 17:41:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y+ymKw1eJaRcmDNN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/15 17:30, Mike Rapoport wrote:
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

I'm curious how we can test this? I guess no one remembers the
historical background of NODE_MIN_SIZE. :(

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

-- 
Thanks,
Qi
