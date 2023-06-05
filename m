Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0053F721C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 05:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjFED3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 23:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFED3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:29:07 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6916A4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 20:28:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so5742666276.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 20:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685935721; x=1688527721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdQWgFavoifUrBnSW8NL4OHJ2vSkips5yRfmkjMQKiM=;
        b=KUb/xolApCMnW7PXovPSm3T5NyfoaHq1HJbPT0MR6oOC+PXvViVlfVfS/7LesZc3+6
         mxUcWCTM8WPSH5SF5Pq4YPYmytD/+GTVhR/6qQIKSjkuB/ocZ053pJ/9hI6h7UkxqPSw
         dxPnrdEzKHZV5MwtPJxMjn+s8rqSHxkJb3w276jllVGk41lapBf9U1+3W7Fep9xCdPqw
         qvEdmZA6x2wmpz7m/VVm4gL7DlvPGqNKED6QlJPU/ke6eo49ePwtejUiFIqu2ZwMa1ZI
         vgiC0wHQSRljYx3iFGP8D00Mn3B59LktDlbL932SnkDih9J/xU4dR6pwpXudn/1hIg0m
         g5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685935721; x=1688527721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qdQWgFavoifUrBnSW8NL4OHJ2vSkips5yRfmkjMQKiM=;
        b=aWrDYiQG0OBXz1kmIfw8+D9faHd39rEnyO3PrDAOSGZ4whGCrfYXqvMGmU10KcoD+4
         AXI8XAf1nuNPzcODlsFP7JFC/g0ufMbzs0dxJpG9N9VPg1K46cXA/NVIUU1fl0JNnSPb
         G79td8CiTk54hQxKUoNUDaot1hE28yFuQo5PPZrkByee5uVRTyRh3GegmeOleExjPGOw
         fshaLVfaqfKUMAFUNoLg/yNPnYX+kmlkjK8CTa2K+G6DwphZkLOhnrmFjvY4J054lKWK
         QgSdQYW8jhPq1e4ZjW+NzVjnsEY77K+c3WYriGaEF9GIUzBIHtdDqT0bemsu0YfM0yug
         f/5g==
X-Gm-Message-State: AC+VfDz21i32bxgvJxyPsybxtYMLuwjeh3Dsz+7BRCmCUA2M1SK5Vvms
        7M9aU8wdPD7Gq/tGVT5JrniT7gOsq0duw8uuJJw=
X-Google-Smtp-Source: ACHHUZ7ddiPRBbXfWpcq6EWaGWLcV9Nh9uouQc/QOnK5aJs8w3/emqTMDQzZa6QyB76tFgRx6sl8WA==
X-Received: by 2002:a25:7242:0:b0:ba6:be9b:3085 with SMTP id n63-20020a257242000000b00ba6be9b3085mr13376424ybc.26.1685935720936;
        Sun, 04 Jun 2023 20:28:40 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id jf12-20020a170903268c00b001b176d96da0sm5386217plb.78.2023.06.04.20.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 20:28:40 -0700 (PDT)
Message-ID: <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
Date:   Mon, 5 Jun 2023 11:28:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
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



在 2023/6/2 16:10, Yin, Fengwei 写道:
> Hi Liam,
> 
> On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
>> Initial work on preallocations showed no regression in performance
>> during testing, but recently some users (both on [1] and off [android]
>> list) have reported that preallocating the worst-case number of nodes
>> has caused some slow down.  This patch set addresses the number of
>> allocations in a few ways.
>>
>> During munmap() most munmap() operations will remove a single VMA, so
>> leverage the fact that the maple tree can place a single pointer at
>> range 0 - 0 without allocating.  This is done by changing the index in
>> the 'sidetree'.
>>
>> Re-introduce the entry argument to mas_preallocate() so that a more
>> intelligent guess of the node count can be made.
>>
>> Patches are in the following order:
>> 0001-0002: Testing framework for benchmarking some operations
>> 0003-0004: Reduction of maple node allocation in sidetree
>> 0005:      Small cleanup of do_vmi_align_munmap()
>> 0006-0013: mas_preallocate() calculation change
>> 0014:      Change the vma iterator order
> I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
> this patchset.
> 
> The result has a little bit improvement:
> Base (next-20230602):
>    503880
> Base with this patchset:
>    519501
> 
> But they are far from the none-regression result (commit 7be1c1a3c7b1):
>    718080
> 
> 
> Some other information I collected:
> With Base, the mas_alloc_nodes are always hit with request: 7.
> With this patchset, the request are 1 or 5.
> 
> I suppose this is the reason for improvement from 503880 to 519501.
> 
> With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
> mas_alloc_nodes() call. Thanks.
Hi Fengwei,

I think it may be related to the inaccurate number of nodes allocated
in the pre-allocation. I slightly modified the pre-allocation in this
patchset, but I don't know if it works. It would be great if you could
help test it, and help pinpoint the cause. Below is the diff, which can
be applied based on this pachset.

Thanks,
Peng

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5ea211c3f186..e67bf2744384 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5575,9 +5575,11 @@ int mas_preallocate(struct ma_state *mas, void 
*entry, gfp_t gfp)
  		goto ask_now;
  	}

-	/* New root needs a singe node */
-	if (unlikely(mte_is_root(mas->node)))
-		goto ask_now;
+	if ((node_size == wr_mas.node_end + 1 &&
+	     mas->offset == wr_mas.node_end) ||
+	    (node_size == wr_mas.node_end &&
+	     wr_mas.offset_end - mas->offset == 1))
+		return 0;

  	/* Potential spanning rebalance collapsing a node, use worst-case */
  	if (node_size  - 1 <= mt_min_slots[wr_mas.type])
@@ -5590,7 +5592,6 @@ int mas_preallocate(struct ma_state *mas, void 
*entry, gfp_t gfp)
  	if (likely(!mas_is_err(mas)))
  		return 0;

-	mas_set_alloc_req(mas, 0);
  	ret = xa_err(mas->node);
  	mas_reset(mas);
  	mas_destroy(mas);


> 
> 
> Regards
> Yin, Fengwei
> 
>>
>> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
>>
>> Liam R. Howlett (14):
>>    maple_tree: Add benchmarking for mas_for_each
>>    maple_tree: Add benchmarking for mas_prev()
>>    mm: Move unmap_vmas() declaration to internal header
>>    mm: Change do_vmi_align_munmap() side tree index
>>    mm: Remove prev check from do_vmi_align_munmap()
>>    maple_tree: Introduce __mas_set_range()
>>    mm: Remove re-walk from mmap_region()
>>    maple_tree: Re-introduce entry to mas_preallocate() arguments
>>    mm: Use vma_iter_clear_gfp() in nommu
>>    mm: Set up vma iterator for vma_iter_prealloc() calls
>>    maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>>    maple_tree: Update mas_preallocate() testing
>>    maple_tree: Refine mas_preallocate() node calculations
>>    mm/mmap: Change vma iteration order in do_vmi_align_munmap()
>>
>>   fs/exec.c                        |   1 +
>>   include/linux/maple_tree.h       |  23 ++++-
>>   include/linux/mm.h               |   4 -
>>   lib/maple_tree.c                 |  78 ++++++++++----
>>   lib/test_maple_tree.c            |  74 +++++++++++++
>>   mm/internal.h                    |  40 ++++++--
>>   mm/memory.c                      |  16 ++-
>>   mm/mmap.c                        | 171 ++++++++++++++++---------------
>>   mm/nommu.c                       |  45 ++++----
>>   tools/testing/radix-tree/maple.c |  59 ++++++-----
>>   10 files changed, 331 insertions(+), 180 deletions(-)
>>
