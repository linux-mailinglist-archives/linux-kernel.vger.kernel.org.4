Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB2722A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjFEPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFEPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:07:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D29F3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:07:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53202149ae2so2746091a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685977623; x=1688569623;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/AnUH4NyOFOfeFW4z2Hv5MjXbIVAxrl6I8rD8h2nXI=;
        b=fQAxlNFJUVLFDjb3BS/xR3a8Ixr4j3CcY1EMpFY3zB/TaHEOFllG2OOpVbbV1YrQj6
         6waCRflBguFhv4ZVsG0WMJu4SR0GOka7p3gx89x9VRMSGNqbnU/0OeIYC6zbYxmi2ixG
         FQK/bC5N1hZIHTNb1iB8+s3Xbhwh6coy0Ao9bMi1wpTaMasUnIXX+XutOauYUUrm1arm
         K/zjtE0t5v4FADWzHh3dUvAst13YVzvpWzPh9dscasPRl6GODGtGMrQwwCWOplkIIepZ
         MF7M5IA5g2Ep9bWF6ASDaYtUFf5bcoOXN3uoNWj/smzJEqPjP1XE/GqUaygXT8pmVR7J
         /XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685977623; x=1688569623;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N/AnUH4NyOFOfeFW4z2Hv5MjXbIVAxrl6I8rD8h2nXI=;
        b=aTMIiKF/ZRu7UI7hhVntgBfLGsNKh96DLRiUTx1/ei4UJ6ryhvZEyP2grJxCQbIyfx
         /rxY9HMAJNAaEYl33abuyN8240aClfW8PhwIaEerXER2fuHfxQr+MBR185F45zOs+mM5
         EYVPoLH9nzPzP+8hCVMuhpMiQxfHDxPH30rjXgoYJ4TEEVNxIAhy3zWaMB1HScUpMJ9W
         XyvZYYmoKNbLXO0Jonkv9CZ40l5zStoiFUm68JcZAwQp13tB0wdWHZt+tGMDTTDJB8T/
         tcGsOe0v9vooDBXcS0kEGNTz2Bo1oi6Jq0Ia+rZSOBW7Sanhjoo8m2KpRMEwhfvI8kLl
         aFcg==
X-Gm-Message-State: AC+VfDzYxS/OX4oJIprPJNSzdkJGBGn9SI3ORoyIUXlhZMrS/5Km7aNE
        0JAwAPnn4JU/qQNhIKmsBQBHJw==
X-Google-Smtp-Source: ACHHUZ5UOaVddgvJAK440PyhovQ+p5icPCsPxtFzbybbo+7OdlpOG7hQUcVDuqYhtzVvLq/CAZDFPg==
X-Received: by 2002:a17:90b:3e8e:b0:259:c73:65e6 with SMTP id rj14-20020a17090b3e8e00b002590c7365e6mr3184123pjb.23.1685977622633;
        Mon, 05 Jun 2023 08:07:02 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i14-20020a63d44e000000b00543ad78e3bdsm2210044pgj.16.2023.06.05.08.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:07:02 -0700 (PDT)
Message-ID: <82fa1976-d60b-e1fc-f87d-0f35d2f1eeab@bytedance.com>
Date:   Mon, 5 Jun 2023 23:06:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
 <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com>
 <20230605140344.66pwpdg5zgb6rfa7@revolver>
 <8f9ed046-529f-073f-5c1a-4c69328b2519@bytedance.com>
 <20230605144438.rloukl3mccgkfxam@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liu, Yujie" <yujie.liu@intel.com>, linux-kernel@vger.kernel.org
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230605144438.rloukl3mccgkfxam@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/5 22:44, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230605 10:27]:
>>
>>
>> 在 2023/6/5 22:03, Liam R. Howlett 写道:
>>> * Peng Zhang <zhangpeng.00@bytedance.com> [230605 03:59]:
>>>>
>>>>
>>>> 在 2023/6/5 14:18, Yin, Fengwei 写道:
>>>>>
>>>>>
>>>>> On 6/5/2023 12:41 PM, Yin Fengwei wrote:
>>>>>> Hi Peng,
>>>>>>
>>>>>> On 6/5/23 11:28, Peng Zhang wrote:
>>>>>>>
>>>>>>>
>>>>>>> 在 2023/6/2 16:10, Yin, Fengwei 写道:
>>>>>>>> Hi Liam,
>>>>>>>>
>>>>>>>> On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
>>>>>>>>> Initial work on preallocations showed no regression in performance
>>>>>>>>> during testing, but recently some users (both on [1] and off [android]
>>>>>>>>> list) have reported that preallocating the worst-case number of nodes
>>>>>>>>> has caused some slow down.  This patch set addresses the number of
>>>>>>>>> allocations in a few ways.
>>>>>>>>>
>>>>>>>>> During munmap() most munmap() operations will remove a single VMA, so
>>>>>>>>> leverage the fact that the maple tree can place a single pointer at
>>>>>>>>> range 0 - 0 without allocating.  This is done by changing the index in
>>>>>>>>> the 'sidetree'.
>>>>>>>>>
>>>>>>>>> Re-introduce the entry argument to mas_preallocate() so that a more
>>>>>>>>> intelligent guess of the node count can be made.
>>>>>>>>>
>>>>>>>>> Patches are in the following order:
>>>>>>>>> 0001-0002: Testing framework for benchmarking some operations
>>>>>>>>> 0003-0004: Reduction of maple node allocation in sidetree
>>>>>>>>> 0005:      Small cleanup of do_vmi_align_munmap()
>>>>>>>>> 0006-0013: mas_preallocate() calculation change
>>>>>>>>> 0014:      Change the vma iterator order
>>>>>>>> I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
>>>>>>>> this patchset.
>>>>>>>>
>>>>>>>> The result has a little bit improvement:
>>>>>>>> Base (next-20230602):
>>>>>>>>       503880
>>>>>>>> Base with this patchset:
>>>>>>>>       519501
>>>>>>>>
>>>>>>>> But they are far from the none-regression result (commit 7be1c1a3c7b1):
>>>>>>>>       718080
>>>>>>>>
>>>>>>>>
>>>>>>>> Some other information I collected:
>>>>>>>> With Base, the mas_alloc_nodes are always hit with request: 7.
>>>>>>>> With this patchset, the request are 1 or 5.
>>>>>>>>
>>>>>>>> I suppose this is the reason for improvement from 503880 to 519501.
>>>>>>>>
>>>>>>>> With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
>>>>>>>> mas_alloc_nodes() call. Thanks.
>>>>>>> Hi Fengwei,
>>>>>>>
>>>>>>> I think it may be related to the inaccurate number of nodes allocated
>>>>>>> in the pre-allocation. I slightly modified the pre-allocation in this
>>>>>>> patchset, but I don't know if it works. It would be great if you could
>>>>>>> help test it, and help pinpoint the cause. Below is the diff, which can
>>>>>>> be applied based on this pachset.
>>>>>> I tried the patch, it could eliminate the call of mas_alloc_nodes() during
>>>>>> the test. But the result of benchmark got a little bit improvement:
>>>>>>      529040
>>>>>>
>>>>>> But it's still much less than none-regression result. I will also double
>>>>>> confirm the none-regression result.
>>>>> Just noticed that the commit f5715584af95 make validate_mm() two implementation
>>>>> based on CONFIG_DEBUG_VM instead of CONFIG_DEBUG_VM_MAPPLE_TREE). I have
>>>>> CONFIG_DEBUG_VM but not CONFIG_DEBUG_VM_MAPPLE_TREE defined. So it's not an
>>>>> apple to apple.
>>>
>>> You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
>>> have it as a different commit id in my branch.
>>>
>>> I 'restored' some of the checking because I was able to work around not
>>> having the mt_dump() definition with the vma iterator.  I'm now
>>> wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
>>> have added these extra checks.
>>>
>>>>>
>>>>>
>>>>> I disable CONFIG_DEBUG_VM and re-run the test and got:
>>>>> Before preallocation change (7be1c1a3c7b1):
>>>>>        770100
>>>>> After preallocation change (28c5609fb236):
>>>>>        680000
>>>>> With liam's fix:
>>>>>        702100
>>>>> plus Peng's fix:
>>>>>        725900
>>>> Thank you for your test, now it seems that the performance
>>>> regression is not so much.
>>>
>>> We are also too strict on the reset during mas_store_prealloc() checking
>>> for a spanning write.  I have a fix for this for v2 of the patch set,
>>> although I suspect it will not make a huge difference.
>>>
>>>>>
>>>>>
>>>>> Regards
>>>>> Yin, Fengwei
>>>>>
>>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Yin, Fengwei
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Peng
>>>>>>>
>>>>>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>>>>>> index 5ea211c3f186..e67bf2744384 100644
>>>>>>> --- a/lib/maple_tree.c
>>>>>>> +++ b/lib/maple_tree.c
>>>>>>> @@ -5575,9 +5575,11 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>>>>>             goto ask_now;
>>>>>>>         }
>>>>>>>
>>>>>>> -    /* New root needs a singe node */
>>>>>>> -    if (unlikely(mte_is_root(mas->node)))
>>>>>>> -        goto ask_now;
>>>
>>> Why did you drop this?  If we are creating a new root we will only need
>>> one node.
>> The code below handles the root case perfectly,
>> we don't need additional checks.
>> 	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
>> 		request = mas_mt_height(mas) * 2 - 1;
> 
> Unless we have the minimum for a node, in which case we will fall
> through and ask for one node.  This works and is rare enough so I'll
> drop it.  Thanks.
> 
>>>
>>>>>>> +    if ((node_size == wr_mas.node_end + 1 &&
>>>>>>> +         mas->offset == wr_mas.node_end) ||
>>>>>>> +        (node_size == wr_mas.node_end &&
>>>>>>> +         wr_mas.offset_end - mas->offset == 1))
>>>>>>> +        return 0;
>>>
>>> I will add this to v2 as well, or something similar.
>>>
>>>>>>>
>>>>>>>         /* Potential spanning rebalance collapsing a node, use worst-case */
>>>>>>>         if (node_size  - 1 <= mt_min_slots[wr_mas.type])
>>>>>>> @@ -5590,7 +5592,6 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>>>>>         if (likely(!mas_is_err(mas)))
>>>>>>>             return 0;
>>>>>>>
>>>>>>> -    mas_set_alloc_req(mas, 0);
>>>
>>> Why did you drop this?  It seems like a worth while cleanup on failure.
>> Because we will clear it in mas_node_count_gfp()->mas_alloc_nodes().
> 
> On failure we set the alloc request to the remainder of what was not
> allocated.
Yes, you are right.
> 
>>>
>>>>>>>         ret = xa_err(mas->node);
>>>>>>>         mas_reset(mas);
>>>>>>>         mas_destroy(mas);
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Regards
>>>>>>>> Yin, Fengwei
>>>>>>>>
>>>>>>>>>
>>>>>>>>> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
>>>>>>>>>
>>>>>>>>> Liam R. Howlett (14):
>>>>>>>>>       maple_tree: Add benchmarking for mas_for_each
>>>>>>>>>       maple_tree: Add benchmarking for mas_prev()
>>>>>>>>>       mm: Move unmap_vmas() declaration to internal header
>>>>>>>>>       mm: Change do_vmi_align_munmap() side tree index
>>>>>>>>>       mm: Remove prev check from do_vmi_align_munmap()
>>>>>>>>>       maple_tree: Introduce __mas_set_range()
>>>>>>>>>       mm: Remove re-walk from mmap_region()
>>>>>>>>>       maple_tree: Re-introduce entry to mas_preallocate() arguments
>>>>>>>>>       mm: Use vma_iter_clear_gfp() in nommu
>>>>>>>>>       mm: Set up vma iterator for vma_iter_prealloc() calls
>>>>>>>>>       maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>>>>>>>>>       maple_tree: Update mas_preallocate() testing
>>>>>>>>>       maple_tree: Refine mas_preallocate() node calculations
>>>>>>>>>       mm/mmap: Change vma iteration order in do_vmi_align_munmap()
>>>>>>>>>
>>>>>>>>>      fs/exec.c                        |   1 +
>>>>>>>>>      include/linux/maple_tree.h       |  23 ++++-
>>>>>>>>>      include/linux/mm.h               |   4 -
>>>>>>>>>      lib/maple_tree.c                 |  78 ++++++++++----
>>>>>>>>>      lib/test_maple_tree.c            |  74 +++++++++++++
>>>>>>>>>      mm/internal.h                    |  40 ++++++--
>>>>>>>>>      mm/memory.c                      |  16 ++-
>>>>>>>>>      mm/mmap.c                        | 171 ++++++++++++++++---------------
>>>>>>>>>      mm/nommu.c                       |  45 ++++----
>>>>>>>>>      tools/testing/radix-tree/maple.c |  59 ++++++-----
>>>>>>>>>      10 files changed, 331 insertions(+), 180 deletions(-)
>>>>>>>>>
