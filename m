Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B882C5BD904
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiITBEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITBEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:04:10 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344D4AD79;
        Mon, 19 Sep 2022 18:04:07 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id v15so995284qvi.11;
        Mon, 19 Sep 2022 18:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SCxIzRVwRu2G1qyALIGV2kP/vMjMV5jdoi16PEYIOgE=;
        b=JoKocIbQ9FpAgbTONCLFLTIJaW8RRKGOp3HkoVbpxgbjuiIG0KmoCvdr/PISnLUBIL
         D5HplYeToAG7UGMlLxSjFBOr0nnbixjInlbsJXHhWabAEK5q/zzjS1ltr8DrAggMnjxt
         Wkq765VWfEekiOlmSMMVNaeR62rllD8B0KiTGPpLzbDVwiDL/ESTDQ6tFndD49p4UYSi
         ul7gjqGTFrXxDplF75+HNupiAl+oHE4b3yxKNgucKpnAGpqYqM2X8RPgpABpxHy2h8p1
         d4wr77qc4KT7z9tXrL/FbZVvl8h/oD2SOuy3125A9bPk8yNolZR6EYSqJUe+EjP6nEvj
         n+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SCxIzRVwRu2G1qyALIGV2kP/vMjMV5jdoi16PEYIOgE=;
        b=k0cEFhCOOLfMZeUCRVlCrxlH+iGygAecqqPI0q2BYfop9tzL912yIb0X5bGhNXy+V2
         SY0OUnhUS3c7Oyl7erH2uhNopmPMonrKxELfsASUJB/xof0C7Q+5pp9zRuJ2f0n/5Ani
         YelXBl7IhfpGUF/rRALjX9Vii8dfoDdeiW2c/bd4kUS0M9yth4UQgMfarGlPf9vnLTKA
         8NGLMRHzi9N0uRFJunBNp5DKmMqiduAKODFA+lbMP4yD9p0aNfr2Y6e9czBd8P6lvcnV
         I7639+wFVzaf3nTRBwTftpC+IdKTBt2X3hmRtnNDOfCHnsNsVEnaTN00xiy7xQyK6Lu0
         Wf/A==
X-Gm-Message-State: ACrzQf16OrP4K+VrcYBZQeNGlZ16VR0pbmvZo1jW+JB98hHjLUTLU1jQ
        B0Vxo+o0SHiBav4EkHyc40k=
X-Google-Smtp-Source: AMsMyM50pJeVVx5dO6o5XUepLsYJmU5Mask8xX7Jd1rp09hZn/Y6xrrnn0X1QhT/iaGEEk09kJllIg==
X-Received: by 2002:a0c:a88a:0:b0:474:7f16:f272 with SMTP id x10-20020a0ca88a000000b004747f16f272mr17062550qva.4.1663635840016;
        Mon, 19 Sep 2022 18:04:00 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bs14-20020a05620a470e00b006b58d8f6181sm13648480qkb.72.2022.09.19.18.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 18:03:59 -0700 (PDT)
Message-ID: <02561695-df44-4df6-c486-1431bf152650@gmail.com>
Date:   Mon, 19 Sep 2022 18:03:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <b610a7b3-d740-8d45-c270-4c638deb1cfa@redhat.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <b610a7b3-d740-8d45-c270-4c638deb1cfa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2022 2:00 AM, David Hildenbrand wrote:
> Hi Dough,
> 
> I have some high-level questions.
Thanks for your interest. I will attempt to answer them.

> 
>> MOTIVATION:
>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>> controllers with each mapped in a different address range within
>> a Uniform Memory Architecture. Some users of these systems have
> 
> How large are these areas typically?
> 
> How large are they in comparison to other memory in the system?
> 
> How is this memory currently presented to the system?
I'm not certain what is typical because these systems are highly 
configurable and Broadcom's customers have different ideas about 
application processing.

The 7278 device has four ARMv8 CPU cores in an SMP cluster and two 
memory controllers (MEMCs). Each MEMC is capable of controlling up to 
8GB of DRAM. An example 7278 system might have 1GB on each controller, 
so an arm64 kernel might see 1GB on MEMC0 at 0x40000000-0x7FFFFFFF and 
1GB on MEMC1 at 0x300000000-0x33FFFFFFF.

The Designated Movable Block concept introduced here has the potential 
to offer useful services to different constituencies. I tried to 
highlight this in my V1 patch set with the hope of attracting some 
interest, but it can complicate the overall discussion, so I would like 
to maybe narrow the discussion here. It may be good to keep them in mind 
when assessing the overall value, but perhaps the "other opportunities" 
can be covered as a follow on discussion.

The base capability described in commits 7-15 of this V1 patch set is to 
allow a 'movablecore' block to be created at a particular base address 
rather than solely at the end of addressable memory.

> 
>> expressed the desire to locate ZONE_MOVABLE memory on each
>> memory controller to allow user space intensive processing to
>> make better use of the additional memory bandwidth.
> 
> Can you share some more how exactly ZONE_MOVABLE would help here to make 
> better use of the memory bandwidth?
ZONE_MOVABLE memory is effectively unusable by the kernel. It can be 
used by user space applications through both the page allocator and the 
Hugetlbfs. If a large 'movablecore' allocation is defined and it can 
only be located at the end of addressable memory then it will always be 
located on MEMC1 of a 7278 system. This will create a tendency for user 
space accesses to consume more bandwidth on the MEMC1 memory controller 
and kernel space accesses to consume more bandwidth on MEMC0. A more 
even distribution of ZONE_MOVABLE memory between the available memory 
controllers in theory makes more memory bandwidth available to user 
space intensive loads.

> 
>> Unfortunately, the historical monotonic layout of zones would
>> mean that if the lowest addressed memory controller contains
>> ZONE_MOVABLE memory then all of the memory available from
>> memory controllers at higher addresses must also be in the
>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>> onto the lowest addressed memory controller and significantly
>> reduce the amount of memory available for non-movable
>> allocations.
> 
> We do have code that relies on zones during boot to not overlap within a 
> single node.
I believe my changes address all such reliance, but if you are aware of 
something I missed please let me know.

> 
>>
>> The main objective of this patch set is therefore to allow a
>> block of memory to be designated as part of the ZONE_MOVABLE
>> zone where it will always only be used by the kernel page
>> allocator to satisfy requests for movable pages. The term
>> Designated Movable Block is introduced here to represent such a
>> block. The favored implementation allows modification of the
> 
> Sorry to say, but that term is rather suboptimal to describe what you 
> are doing here. You simply have some system RAM you'd want to have 
> managed by ZONE_MOVABLE, no?
That may be true, but I found it superior to the 'sticky' movable 
terminology put forth by Mel Gorman ;). I'm happy to entertain 
alternatives, but they may not be as easy to find as you think.

> 
>> 'movablecore' kernel parameter to allow specification of a base
>> address and support for multiple blocks. The existing
>> 'movablecore' mechanisms are retained. Other mechanisms based on
>> device tree are also included in this set.
>>
>> BACKGROUND:
>> NUMA architectures support distributing movablecore memory
>> across each node, but it is undesirable to introduce the
>> overhead and complexities of NUMA on systems that don't have a
>> Non-Uniform Memory Architecture.
> 
> How exactly would that look like? I think I am missing something :)
The notion would be to consider each memory controller as a separate 
node, but as stated it is not desirable.

> 
>>
>> Commit 342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror 
>> option")
>> also depends on zone overlap to support sytems with multiple
>> mirrored ranges.
> 
> IIRC, zones will not overlap within a single node.
I believe the implementation for kernelcore=mirror allows for the 
possibility of multiple non-adjacent mirrored ranges in a single node 
and accommodates the zone overlap.

> 
>>
>> Commit c6f03e2903c9 ("mm, memory_hotplug: remove zone restrictions")
>> embraced overlapped zones for memory hotplug.
> 
> Yes, after boot.
> 
>>
>> This commit set follows their lead to allow the ZONE_MOVABLE
>> zone to overlap other zones while spanning the pages from the
>> lowest Designated Movable Block to the end of the node.
>> Designated Movable Blocks are made absent from overlapping zones
>> and present within the ZONE_MOVABLE zone.
>>
>> I initially investigated an implementation using a Designated
>> Movable migrate type in line with comments[1] made by Mel Gorman
>> regarding a "sticky" MIGRATE_MOVABLE type to avoid using
>> ZONE_MOVABLE. However, this approach was riskier since it was
>> much more instrusive on the allocation paths. Ultimately, the
>> progress made by the memory hotplug folks to expand the
>> ZONE_MOVABLE functionality convinced me to follow this approach.
>>
>> OPPORTUNITIES:
>> There have been many attempts to modify the behavior of the
>> kernel page allocators use of CMA regions. This implementation
>> of Designated Movable Blocks creates an opportunity to repurpose
>> the CMA allocator to operate on ZONE_MOVABLE memory that the
>> kernel page allocator can use more agressively, without
>> affecting the existing CMA implementation. It is hoped that the
>> "shared-dmb-pool" approach included here will be useful in cases
>> where memory sharing is more important than allocation latency.
>>
>> CMA introduced a paradigm where multiple allocators could
>> operate on the same region of memory, and that paradigm can be
>> extended to Designated Movable Blocks as well. I was interested
>> in using kernel resource management as a mechanism for exposing
>> Designated Movable Block resources (e.g. /proc/iomem) that would
>> be used by the kernel page allocator like any other ZONE_MOVABLE
>> memory, but could be claimed by an alternative allocator (e.g.
>> CMA). Unfortunately, this becomes complicated because the kernel
>> resource implementation varies materially across different
>> architectures and I do not require this capability so I have
>> deferred that.
> 
> Why can't we simply designate these regions as CMA regions?
We and others have encountered significant performance issues when large 
CMA regions are used. There are significant restrictions on the page 
allocator's use of MIGRATE_CMA pages and the memory subsystem works very 
hard to keep about half of the memory in the CMA region free. There have 
been attempts to patch the CMA implementation to alter this behavior 
(for example the set I referenced Mel's response to in [1]), but there 
are users that desire the current behavior.

> 
> Why do we have to start using ZONE_MOVABLE for them?
One of the "other opportunities" for Designated Movable Blocks is to 
allow CMA to allocate from a DMB as an alternative. This would allow 
current users to continue using CMA as they want, but would allow users 
(e.g. hugetlb_cma) that are not sensitive to the allocation latency to 
let the kernel page allocator make more complete use (i.e. waste less) 
of the shared memory. ZONE_MOVABLE pageblocks are always MIGRATE_MOVABLE 
so the restrictions placed on MIGRATE_CMA pageblocks are lifted within a 
DMB.

> 
Thanks for your consideration,
Dough Baker ... I mean Doug Berger :).
