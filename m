Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44DF695EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjBNJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjBNJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:18:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BF811EB3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676366227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stZkDlYkb1TUePaSeudFaELIWH0qbeUMQe5FKThxbNY=;
        b=Y2r2z6gHpgsiC/ZZ348lRk+3Fz9Pe9Kiwym/sUF/y8TlW8qiWsdOTLzUiPLFIDd2kWAgx9
        OV/4mU+YKsQG3WDjTyfG05T8CR21uKc3kzSLLnXNlO7jCLzqm4Tb54rlZkTEy1IacIDdel
        tuN16SdAj/hrKLLHkyrE0z3cxdnNkaE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-iTN-M5i7MVaiwccGC8Gpqw-1; Tue, 14 Feb 2023 04:17:06 -0500
X-MC-Unique: iTN-M5i7MVaiwccGC8Gpqw-1
Received: by mail-wm1-f69.google.com with SMTP id l31-20020a05600c1d1f00b003deab30bb8bso7498676wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stZkDlYkb1TUePaSeudFaELIWH0qbeUMQe5FKThxbNY=;
        b=8HIqKscfOiJQYJSr10e2Xhqm3k752pWv9zHVdHfdVKehlQERUOSSWPSCdPqm9YjdYq
         Dd6kQm47AJtPPNChDDE/D7ZoH6C9cWeCGoy0dr23ciWKmcasBAARYa2fBIJzJhq5Gjm6
         7xpoxjvKkWy/bO4kmzUimQNHXoofpmzHHV2tnXAMcMj1aJCh9e/AjKkLAW4Hii2us0y7
         0LcazpcFS1kGZibAqv8p9krfztHk/Sc4U4NS5AX8LpWazp2mFGYTkwVK+5jIst/FmTqv
         dEWCTx5rtqxCyzZozzapN6hCIWIE2se480KnU1C5JkYF0o8uYenQ6MgqpH9IsUxo9Tsr
         M2cQ==
X-Gm-Message-State: AO0yUKU+HZakUEF0YGHZXUeCFhS/gO+tGrETw89REOt8TqHL+yo6Uuiu
        h5dJmTaA/gPtKd37plRN8cLTGesh6nqJ3XRBQT7TjSco744eR1qettBdwt3mqtXlhFeaQYPR7aL
        RabiFDBKtIIsRGfOwK5dPnVhP
X-Received: by 2002:a05:600c:91d:b0:3df:eda1:43b9 with SMTP id m29-20020a05600c091d00b003dfeda143b9mr1458562wmp.4.1676366225243;
        Tue, 14 Feb 2023 01:17:05 -0800 (PST)
X-Google-Smtp-Source: AK7set+ycz0IC1I6k2bpLGRNvKfsXo87T6s/E3RwQk+9PHOkoLPxL7ChlRJwHipS/3WqDbPqyW6kGA==
X-Received: by 2002:a05:600c:91d:b0:3df:eda1:43b9 with SMTP id m29-20020a05600c091d00b003dfeda143b9mr1458539wmp.4.1676366224946;
        Tue, 14 Feb 2023 01:17:04 -0800 (PST)
Received: from [192.168.3.108] (p5b0c60e7.dip0.t-ipconnect.de. [91.12.96.231])
        by smtp.gmail.com with ESMTPSA id f21-20020a05600c43d500b003dc522dd25esm15958603wmn.30.2023.02.14.01.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:17:04 -0800 (PST)
Message-ID: <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
Date:   Tue, 14 Feb 2023 10:17:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
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

On 14.02.23 09:42, Vlastimil Babka wrote:
> On 2/13/23 12:00, Qi Zheng wrote:
>>
>>
>> On 2023/2/13 16:47, Vlastimil Babka wrote:
>>> On 2/12/23 12:03, Qi Zheng wrote:
>>>> In x86, numa_register_memblks() is only interested in
>>>> those nodes which have enough memory, so it skips over
>>>> all nodes with memory below NODE_MIN_SIZE (treated as
>>>> a memoryless node). Later on, we will initialize these
>>>> memoryless nodes (allocate pgdat in free_area_init()
>>>> and build zonelist etc), and will online these nodes
>>>> in init_cpu_to_node() and init_gi_nodes().
>>>>
>>>> After boot, these memoryless nodes are in N_ONLINE
>>>> state but not in N_MEMORY state. But we can still allocate
>>>> pages from these memoryless nodes.
>>>>
>>>> In SLUB, we only process nodes in the N_MEMORY state,
>>>> such as allocating their struct kmem_cache_node. So if
>>>> we allocate a page from the memoryless node above to
>>>> SLUB, the struct kmem_cache_node of the node corresponding
>>>> to this page is NULL, which will cause panic.
>>>>
>>>> For example, if we use qemu to start a two numa node kernel,
>>>> one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>>>> and the other node has 2G, then we will encounter the
>>>> following panic:
>>>>
>>>> [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>> [    0.150783] #PF: supervisor write access in kernel mode
>>>> [    0.151488] #PF: error_code(0x0002) - not-present page
>>>> <...>
>>>> [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>>>> <...>
>>>> [    0.169781] Call Trace:
>>>> [    0.170159]  <TASK>
>>>> [    0.170448]  deactivate_slab+0x187/0x3c0
>>>> [    0.171031]  ? bootstrap+0x1b/0x10e
>>>> [    0.171559]  ? preempt_count_sub+0x9/0xa0
>>>> [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>>>> [    0.172735]  ? bootstrap+0x1b/0x10e
>>>> [    0.173236]  bootstrap+0x6b/0x10e
>>>> [    0.173720]  kmem_cache_init+0x10a/0x188
>>>> [    0.174240]  start_kernel+0x415/0x6ac
>>>> [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>>>> [    0.175417]  </TASK>
>>>> [    0.175713] Modules linked in:
>>>> [    0.176117] CR2: 0000000000000000
>>>>
>>>> In addition, we can also encountered this panic in the actual
>>>> production environment. We set up a 2c2g container with two
>>>> numa nodes, and then reserved 128M for kdump, and then we
>>>> can encountered the above panic in the kdump kernel.
>>>>
>>>> To fix it, we can filter memoryless nodes when allocating
>>>> pages.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> Reported-by: Teng Hu <huteng.ht@bytedance.com>
>>>
>>> Well AFAIK the key mechanism to only allocate from "good" nodes is the
>>> zonelist, we shouldn't need to start putting extra checks like this. So it
>>> seems to me that the code building the zonelists should take the
>>> NODE_MIN_SIZE constraint in mind.
>>
>> Indeed. How about the following patch:
> 
> +Cc also David, forgot earlier.
> 
> Looks good to me, at least.
> 
>> @@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t
>> *used_node_mask)
>>           int min_val = INT_MAX;
>>           int best_node = NUMA_NO_NODE;
>>
>> -       /* Use the local node if we haven't already */
>> -       if (!node_isset(node, *used_node_mask)) {
>> +       /*
>> +        * Use the local node if we haven't already. But for memoryless
>> local
>> +        * node, we should skip it and fallback to other nodes.
>> +        */
>> +       if (!node_isset(node, *used_node_mask) && node_state(node,
>> N_MEMORY)) {
>>                   node_set(node, *used_node_mask);
>>                   return node;
>>           }
>>
>> For memoryless node, we skip it and fallback to other nodes when
>> build its zonelists.
>>
>> Say we have node0 and node1, and node0 is memoryless, then:
>>
>> [    0.102400] Fallback order for Node 0: 1
>> [    0.102931] Fallback order for Node 1: 1
>>
>> In this way, we will not allocate pages from memoryless node0.
>>

In offline_pages(), we'll first build_all_zonelists() to then 
node_states_clear_node()->node_clear_state(node, N_MEMORY);

So at least on the offlining path, we wouldn't detect it properly yet I 
assume, and build a zonelist that contains a now-memory-less node?

-- 
Thanks,

David / dhildenb

