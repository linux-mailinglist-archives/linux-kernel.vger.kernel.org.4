Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27056960D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjBNKds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjBNKdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:33:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58922DF3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:33:18 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gd1so3895102pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676370797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Wj9/hXlrWGWDF+Thm8m1kU7n9xJTrILBDDgYL6C5Gk=;
        b=1iLeX6Z5JlY1Z2cv15w0DRaIv/H28PpgSE04jrxfWnCOXPXIWgyNfB9NpmpY749eWh
         QO7wHnI+RDcoqW/+DNfKxsSuNB26POEijSbrR3t/SQJq+CF8J2cdHX6kYorrFNC6r7S5
         tH/k4tyx2xbJ4iw49IO2N5lyOUBnd5JfxbYWmSkKR4kbPOu/3QH+pQLCc6IkXT9w4JN9
         2kIdGskjbKSLJ6lu9eoa00qgwHUSCHtqpmzmnjEx+1EZnk9HYgSFShAlPGgY1FjV5L+y
         MbZgI58nKIbS3tv9k1vNRATp9T5PdXqnWxOaPdJiIpFhQVfU/yqYlsK6xiQoIIcs7Hsx
         UkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676370797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wj9/hXlrWGWDF+Thm8m1kU7n9xJTrILBDDgYL6C5Gk=;
        b=biRr1f1g9ZOoj2+X1hVyXJk1zyT4aBka9B4Q0FVhsDu7PeRrZ/oC1gdWqD9B6NDxLi
         siL2l/m+7qXO2bpDK1paGKInKn4jHyjdL3DtJc0fgKv+62o53IpsP3qH0fPxaq7SfRsR
         jKmvkOBwZSHMCxOJezlw+EmzuzncOfdik7+CtWmnplH20aeG1r5pATbzwsdP1YfUbvC4
         337egQJGXyvzJ/hraSQ9DagGdRk/51RO0apqBnNuHKqiquM3FToMNr6vOCeMdHGjS3pp
         NqCR7NZnLDodEK5Qryz+X9OCest6hzxm/m4dd6Ja1u25lYepQYetNy7BupqwpYurmRS4
         R9jQ==
X-Gm-Message-State: AO0yUKU/U5GpjU2IkaPePztneP1bofwhHohFLElBFnKheZA7KD5bP8c3
        HAmpuwn9j9XxscyAsNXPU6oj6w==
X-Google-Smtp-Source: AK7set+V+Y3xne1KgmezUg3Mf/Wh/rtyAH1xliVaYolYlfqKFN1pEqhpyKXovnTXS6IePQzxRbhHdw==
X-Received: by 2002:a05:6a21:6d97:b0:bc:6c4f:308a with SMTP id wl23-20020a056a216d9700b000bc6c4f308amr2507380pzb.0.1676370797654;
        Tue, 14 Feb 2023 02:33:17 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id i196-20020a636dcd000000b004fb171df68fsm2166259pgc.7.2023.02.14.02.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 02:33:17 -0800 (PST)
Message-ID: <4a9fba3c-3924-9d5f-7b42-522a183d1f2e@bytedance.com>
Date:   Tue, 14 Feb 2023 18:33:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz> <Y+tQDN/TmdTPFFR6@kernel.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y+tQDN/TmdTPFFR6@kernel.org>
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



On 2023/2/14 17:10, Mike Rapoport wrote:
> On Mon, Feb 13, 2023 at 09:47:43AM +0100, Vlastimil Babka wrote:
>> On 2/12/23 12:03, Qi Zheng wrote:
>>> In x86, numa_register_memblks() is only interested in
>>> those nodes which have enough memory, so it skips over
>>> all nodes with memory below NODE_MIN_SIZE (treated as
>>> a memoryless node). Later on, we will initialize these
>>> memoryless nodes (allocate pgdat in free_area_init()
>>> and build zonelist etc), and will online these nodes
>>> in init_cpu_to_node() and init_gi_nodes().
>>>
>>> After boot, these memoryless nodes are in N_ONLINE
>>> state but not in N_MEMORY state. But we can still allocate
>>> pages from these memoryless nodes.
>>>
>>> In SLUB, we only process nodes in the N_MEMORY state,
>>> such as allocating their struct kmem_cache_node. So if
>>> we allocate a page from the memoryless node above to
>>> SLUB, the struct kmem_cache_node of the node corresponding
>>> to this page is NULL, which will cause panic.
>>>
>>> For example, if we use qemu to start a two numa node kernel,
>>> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>> and the other node has 2G, then we will encounter the
>>> following panic:
>>>
>>> [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>> [    0.150783] #PF: supervisor write access in kernel mode
>>> [    0.151488] #PF: error_code(0x0002) - not-present page
>>> <...>
>>> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>> <...>
>>> [    0.169781] Call Trace:
>>> [    0.170159]  <TASK>
>>> [    0.170448]  deactivate_slab+0x187/0x3c0
>>> [    0.171031]  ? bootstrap+0x1b/0x10e
>>> [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>> [    0.172735]  ? bootstrap+0x1b/0x10e
>>> [    0.173236]  bootstrap+0x6b/0x10e
>>> [    0.173720]  kmem_cache_init+0x10a/0x188
>>> [    0.174240]  start_kernel+0x415/0x6ac
>>> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>> [    0.175417]  </TASK>
>>> [    0.175713] Modules linked in:
>>> [    0.176117] CR2: 0000000000000000
>>>
>>> In addition, we can also encountered this panic in the actual
>>> production environment. We set up a 2c2g container with two
>>> numa nodes, and then reserved 128M for kdump, and then we
>>> can encountered the above panic in the kdump kernel.
>>>
>>> To fix it, we can filter memoryless nodes when allocating
>>> pages.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Reported-by: Teng Hu <huteng.ht@bytedance.com>
>>
>> Well AFAIK the key mechanism to only allocate from "good" nodes is the
>> zonelist, we shouldn't need to start putting extra checks like this. So it
>> seems to me that the code building the zonelists should take the
>> NODE_MIN_SIZE constraint in mind.
> 
> Why just not drop the memory for nodes with size < NODE_MIN_SIZE from
> memblock at the first place?

In this way, it seems that no pages of size < NODE_MIN_SIZE nodes will
be released to buddy, so the pages of these nodes will not be allocated,
and the above-mentioned panic will be avoided.

But these nodes will still build zonelists for itself, which seems
unnecessary?

> Then we won't need runtime checks at all.
>   
>>> ---
>>>   mm/page_alloc.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 588555754601..b9cce56f4e21 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -4188,6 +4188,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>>>   			(alloc_flags & ALLOC_CPUSET) &&
>>>   			!__cpuset_zone_allowed(zone, gfp_mask))
>>>   				continue;
>>> +
>>> +		/* Don't allocate page from memoryless nodes. */
>>> +		if (!node_state((zone_to_nid(zone)), N_MEMORY))
>>> +			continue;
>>> +
>>>   		/*
>>>   		 * When allocating a page cache page for writing, we
>>>   		 * want to get it from a node that is within its dirty
>>
> 

-- 
Thanks,
Qi
