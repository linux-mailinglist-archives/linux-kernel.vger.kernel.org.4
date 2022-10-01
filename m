Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF875F1773
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiJAAmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiJAAmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:42:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A31806D6;
        Fri, 30 Sep 2022 17:42:15 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f26so3636462qto.11;
        Fri, 30 Sep 2022 17:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KvgDliJB+w67fuxPgV/YDr4b2ixsUAnMSZw2VwIkDEw=;
        b=X6w3MORv9DjiAUrKeQqu7h3e113Inn2WYGpvBlEqbfSJVaS42SQdjiz0TvpBfKF/AZ
         1p62PFKj89feKqtrmp++MePvViJXP/EPLiTMicgkqKp2YtwuYhUrry8qIMMrvHW96lqP
         3e5JAclNEQ/jxBF+8fdkQrfgs2E7FRolMUcLIcixpuG0IkTRnW+nZqWcNpnbBF2SbPAB
         rtIpPRi7AHKZ3omxzc4LrRRS2MBS9c9nnf2U+R7ZCdDnSM9TxYdSG3GZ3a3vsXUamq/u
         zkA/dON2aLf/2PwNtQX+Xn5HH6hm/ZMEztb4yReX3REypOqemh5iFn72aokiPk9PSFha
         8Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KvgDliJB+w67fuxPgV/YDr4b2ixsUAnMSZw2VwIkDEw=;
        b=bZ2qcCL0Np0xjWZRJnMaRw23tVhrOdCJiy2vKvr2hyDlQ2JJ4Z00/j1WoM4g/z3bex
         cfY4PGTyEFDiqy6xkvXKiSKhfr06uhSRIAibPKNck7vsKbgM7auHYMSfodXejq2LGc0c
         /DupyOU0jlm9OXgVqYm1g3K5floKqoJX8xaw0z4MMNX2oE7rRmSCgz4GtSjCAcYJiPo4
         L/F3fWwa8NyuE70/D92FDFU+u3hkWMTtYaOyHo0Lyo5z+Eiudne/ErTQesQr0HAofj5X
         Rthhyejr1Vjg6+kACgisSvu9258POLvRq38JyZEFKiqVKW4ZaXsnY++A5RgKKKVrCp8q
         vWOA==
X-Gm-Message-State: ACrzQf1j5PPW9XCM32MW9kjIX18OgpKray0mKRnCuywZjI5ebHVwpWx6
        wKn9QLtMcIJYs6nA6DbikKg=
X-Google-Smtp-Source: AMsMyM7BX8sL+32pk5xwVh7ruMl1l1qelS27i0ysUtBW8NT3q+JJf6TFl8Rc3kp+0Da3Ijlm/Qi4vw==
X-Received: by 2002:a05:622a:1007:b0:35d:1ef4:ed10 with SMTP id d7-20020a05622a100700b0035d1ef4ed10mr8891418qte.525.1664584934204;
        Fri, 30 Sep 2022 17:42:14 -0700 (PDT)
Received: from [10.69.53.73] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id fb25-20020a05622a481900b0034035e73be0sm3236323qtb.4.2022.09.30.17.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 17:42:13 -0700 (PDT)
Message-ID: <3af1da5f-6b95-1aab-60f0-d17f141782b4@gmail.com>
Date:   Fri, 30 Sep 2022 17:42:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
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
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <b610a7b3-d740-8d45-c270-4c638deb1cfa@redhat.com>
 <02561695-df44-4df6-c486-1431bf152650@gmail.com>
 <64c3aea2-331b-e482-bbb0-7fac2340163c@redhat.com>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <64c3aea2-331b-e482-bbb0-7fac2340163c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/2022 2:00 AM, David Hildenbrand wrote:
> On 20.09.22 03:03, Doug Berger wrote:
>> On 9/19/2022 2:00 AM, David Hildenbrand wrote:
>>> Hi Dough,
>>>
>>> I have some high-level questions.
>> Thanks for your interest. I will attempt to answer them.
>>
> 
> Hi Doug,
> 
> sorry for the late reply, slowly catching up on mails.
Thanks for finding the time, and for the thoughtful feedback.

> 
>>>
>>>> MOTIVATION:
>>>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>>>> controllers with each mapped in a different address range within
>>>> a Uniform Memory Architecture. Some users of these systems have
>>>
>>> How large are these areas typically?
>>>
>>> How large are they in comparison to other memory in the system?
>>>
>>> How is this memory currently presented to the system?
>> I'm not certain what is typical because these systems are highly
>> configurable and Broadcom's customers have different ideas about
>> application processing.
>>
>> The 7278 device has four ARMv8 CPU cores in an SMP cluster and two
>> memory controllers (MEMCs). Each MEMC is capable of controlling up to
>> 8GB of DRAM. An example 7278 system might have 1GB on each controller,
>> so an arm64 kernel might see 1GB on MEMC0 at 0x40000000-0x7FFFFFFF and
>> 1GB on MEMC1 at 0x300000000-0x33FFFFFFF.
>>
>> The Designated Movable Block concept introduced here has the potential
>> to offer useful services to different constituencies. I tried to
>> highlight this in my V1 patch set with the hope of attracting some
>> interest, but it can complicate the overall discussion, so I would like
>> to maybe narrow the discussion here. It may be good to keep them in mind
>> when assessing the overall value, but perhaps the "other opportunities"
>> can be covered as a follow on discussion.
>>
>> The base capability described in commits 7-15 of this V1 patch set is to
>> allow a 'movablecore' block to be created at a particular base address
>> rather than solely at the end of addressable memory.
>>
> 
> Just so we're on the same page:
> 
> Having too much ZONE_MOVABLE memory (ratio compared to !ZONE_MOVABLE 
> memory) is dangerous. Acceptable ratios highly depend on the target 
> workload. An extreme example is memory-hungry applications that end up 
> long-term pinning a lot of memory (e.g., VMs with SR-IO): we can run 
> easily out of free memory in the !ZONE_MOVABLE zones and might not want 
> ZONE_MOVABLE at all.
Definitely. I've had to explain this to application developers myself 
:). This is fundamentally why the existing 'movablecore' implementation 
is insufficient for multiple memory controllers. Placing any 
ZONE_MOVABLE memory on the lower addressed memory controller forces all 
of the higher addressed memory controller(s) to only contain 
ZONE_MOVABLE memory, which is generally unacceptable for any workload.

> 
> So whatever we do, this should in general not be the kernel sole 
> decision to make this memory any special and let ZONE_MOVABLE manage it.
I believe you are stating that Designated Movable Blocks should only be 
created as a result of special configuration (e.g. kernel parameters, 
devicetree, ...). I would agree with that. Is that what you intended by 
this statement, or am I missing something?

> 
> It's the same with CMA. "Heavy" CMA users require special configuration: 
> hugetlb_cma is one prime example.
> 
>>>
>>>> expressed the desire to locate ZONE_MOVABLE memory on each
>>>> memory controller to allow user space intensive processing to
>>>> make better use of the additional memory bandwidth.
>>>
>>> Can you share some more how exactly ZONE_MOVABLE would help here to make
>>> better use of the memory bandwidth?
>> ZONE_MOVABLE memory is effectively unusable by the kernel. It can be
>> used by user space applications through both the page allocator and the
>> Hugetlbfs. If a large 'movablecore' allocation is defined and it can
> 
> Hugetlbfs not necessarily by all architectures. Some architectures don't 
> support placing hugetlb pages on ZONE_MOVABLE (not migratable) and 
> gigantic pages are special either way.
That's true.

> 
>> only be located at the end of addressable memory then it will always be
>> located on MEMC1 of a 7278 system. This will create a tendency for user
>> space accesses to consume more bandwidth on the MEMC1 memory controller
>> and kernel space accesses to consume more bandwidth on MEMC0. A more
>> even distribution of ZONE_MOVABLE memory between the available memory
>> controllers in theory makes more memory bandwidth available to user
>> space intensive loads.
>>
> 
> Sorry to be dense, is this also about different memory access latency or 
> just memory bandwidth?
Broadcom memory controllers do support configurable real-time scheduling 
with bandwidth guarantees for different memory clients so I suppose this 
is a fair question. However, the expectation here is that the CPUs would 
have equivalent access latencies, so it is really just about memory 
bandwidth for the CPUs.

> 
> Do these memory areas have special/different performance 
> characteristics? Using dedicated/fake NUMA nodes might be more in line 
> with what CXL and PMEM are up to.
> 
> Using ZONE_MOVABLE for that purpose feels a little bit like an abuse of 
> the mechanism.
Current usage intends to have equivalent performance from a CPU 
perspective. God forbid any Broadcom customers read your questions and 
start asking for such capabilities :), but if they do I agree that 
ZONE_MOVABLE for that purpose would be harebrained.

> To be clearer what I mean:
> 
> We can place any movable allocations on ZONE_MOVABLE, including kernel 
> allocations. User space allocations are just one example, and int he 
> future we'll turn more and more allocations movable to be able to cope 
> with bigger ZONE_MOVABLE demands due to DAX/CXL. I once looked into 
> migrating user space page tables, just to give an example.
That's good to know.

> 
> 
>>>
>>>> Unfortunately, the historical monotonic layout of zones would
>>>> mean that if the lowest addressed memory controller contains
>>>> ZONE_MOVABLE memory then all of the memory available from
>>>> memory controllers at higher addresses must also be in the
>>>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>>>> onto the lowest addressed memory controller and significantly
>>>> reduce the amount of memory available for non-movable
>>>> allocations.
>>>
>>> We do have code that relies on zones during boot to not overlap within a
>>> single node.
>> I believe my changes address all such reliance, but if you are aware of
>> something I missed please let me know.
>>
> 
> One example I'm aware of is drivers/base/memory.c:memory_block_add_nid() 
> / early_node_zone_for_memory_block().
> 
> If we get it wrong, or actually have memory blocks that span multiple 
> zones, we can no longer offline these memory blocks. We really wanted to 
> avoid scanning the memmap for now and it seems to get the job done in 
> environments we care about.
To the extent that this implementation only supports creating Designated 
Movable Blocks in boot memory and boot memory does not generally support 
offlining, I wouldn't expect this to be an issue. However, if for some 
reason offlining boot memory becomes desirable then we should use 
dmb_intersects() along with zone_intersects() to take the appropriate 
action. Based on the current usage of zone_intersects() I'm not entirely 
sure what the correct action should be.

> 
>>>
>>>>
>>>> The main objective of this patch set is therefore to allow a
>>>> block of memory to be designated as part of the ZONE_MOVABLE
>>>> zone where it will always only be used by the kernel page
>>>> allocator to satisfy requests for movable pages. The term
>>>> Designated Movable Block is introduced here to represent such a
>>>> block. The favored implementation allows modification of the
>>>
>>> Sorry to say, but that term is rather suboptimal to describe what you
>>> are doing here. You simply have some system RAM you'd want to have
>>> managed by ZONE_MOVABLE, no?
>> That may be true, but I found it superior to the 'sticky' movable
>> terminology put forth by Mel Gorman ;). I'm happy to entertain
>> alternatives, but they may not be as easy to find as you think.
> 
> Especially the "blocks" part is confusing. Movable pageblocks? Movable 
> Linux memory blocks?
> 
> Note that the sticky movable *pageblocks* were a completely different 
> concept than simply reusing ZONE_MOVABLE for some memory ranges.
I would say that is open for debate. The implementations would be 
"completely different" but the objectives could be quite similar.
There appear to be a number of people that are interested in the concept 
of memory that can only contain data that tolerates relocation for 
various potentially non-competing reasons.

Fundamentally, the concept of MIGRATE_MOVABLE memory is useful to allow 
competing user space processes to share limited physical memory supplied 
by the kernel. The data in that memory can be relocated elsewhere by the 
kernel when the process that owns it is not executing. This movement is 
typically not observable to the owning process which has its own address 
space.

The kernel uses MIGRATE_UNMOVABLE memory to protect the integrity of its 
address space, but of course what the kernel considers unmovable could 
in fact be moved by a hypervisor in a way that is analogous to what the 
kernel does for user space.

For maximum flexibility the Linux memory management allows for 
converting the migratetype of free memory to help satisfy requests to 
allocate pages of memory through a mechanism I will call "fallback". The 
concepts of sticky movable pageblocks and ZONE_MOVABLE have the common 
objective of preventing the migratetype of pageblocks from getting 
converted to anything other than MIGRATE_MOVABLE, and this is what makes 
the memory special.

I agree with Mel Gorman that zones are meant to be about address induced 
limitations, so using a zone for the purpose of breaking the fallback 
mechanism of the page allocator is a misuse of the concept. A new 
migratetype would be more appropriate for representing this change in 
how fallback should apply to the pageblock because the desired behavior 
has nothing to do with the address at which the memory is located. It is 
entirely reasonable to desire "sticky" movable behavior for memory in 
any zone. Such a solution would be directly applicable to our multiple 
memory controller use case, and is really how Designated Movable Blocks 
should be imagined.

However, I also recognize the efficiency benefits of using a 
ZONE_MOVABLE zone to manage the pages that have this "sticky" movable 
behavior. Introducing a new sticky MIGRATE_MOVABLE migratetype adds a 
new free_list to every free_area which increases the search space and 
associated work when trying to allocate a page for all callers. 
Introducing ZONE_MOVABLE reduces the search space by providing an early 
separation between searches for movable and non-movable allocations. The 
classic zone restrictions weren't a good fit for multiple memory 
controllers, but those restrictions were lifted to overcome similar 
issues with memory_hotplug. It is not that Designated Movable Blocks 
want to be in ZONE_MOVABLE, but rather that ZONE_MOVABLE provides a 
convenience for managing the page allocators use of "sticky" movable 
memory just like it does for memory hotplug. Dumping the memory in 
Designated Movable Blocks into the ZONE_MOVABLE zone allows an existing 
mechanism to be reused, reducing the risk of negatively impacting the 
page allocator behavior.

There are some subtle distinctions between Designated Movable Blocks and 
the existing ZONE_MOVABLE zone. Because Designated Movable Blocks are 
reserved when created they are protected against any early boot time 
kernel reservations that might place unmovable allocations in them. The 
implementation continues to track the zone_movable_pfn as the start of 
the "classic" ZONE_MOVABLE zone on each node. A Designated Movable Block 
can overlap any other zone including the "classic" ZONE_MOVABLE zone.

> 
>>
>>>
>>>> 'movablecore' kernel parameter to allow specification of a base
>>>> address and support for multiple blocks. The existing
>>>> 'movablecore' mechanisms are retained. Other mechanisms based on
>>>> device tree are also included in this set.
>>>>
>>>> BACKGROUND:
>>>> NUMA architectures support distributing movablecore memory
>>>> across each node, but it is undesirable to introduce the
>>>> overhead and complexities of NUMA on systems that don't have a
>>>> Non-Uniform Memory Architecture.
>>>
>>> How exactly would that look like? I think I am missing something :)
>> The notion would be to consider each memory controller as a separate
>> node, but as stated it is not desirable.
>>
> 
> Doing it the DAX/CXL way would be to expose these memory ranges as 
> daxdev instead, and letting the admin decide how to online these memory 
> ranges when adding them to the buddy via the dax/kmem kernel module.
> 
> That could mean that your booting with memory on MC0 only, and expose 
> memory of MC1 via a daxdev, giving the admin the possibility do decide 
> to which zone the memory should be onlined too.
> 
> That would avoid most kernel code changes.
I wasn't familiar with these kernel mechanisms and did enjoy reading 
about the somewhat oxymoronic "volatile-use of persistent memory" that 
is dax/kmem, but this isn't performance differentiated RAM. It really is 
just System RAM so this degree of complexity seems unwarranted.

> 
>>>
>>> Why can't we simply designate these regions as CMA regions?
>> We and others have encountered significant performance issues when large
>> CMA regions are used. There are significant restrictions on the page
>> allocator's use of MIGRATE_CMA pages and the memory subsystem works very
>> hard to keep about half of the memory in the CMA region free. There have
>> been attempts to patch the CMA implementation to alter this behavior
>> (for example the set I referenced Mel's response to in [1]), but there
>> are users that desire the current behavior.
> 
> Optimizing that would be great, eventually making it configurable or 
> selecting the behavior based on the actual CMA area sizes.
> 
>>
>>>
>>> Why do we have to start using ZONE_MOVABLE for them?
>> One of the "other opportunities" for Designated Movable Blocks is to
>> allow CMA to allocate from a DMB as an alternative. This would allow
>> current users to continue using CMA as they want, but would allow users
>> (e.g. hugetlb_cma) that are not sensitive to the allocation latency to
>> let the kernel page allocator make more complete use (i.e. waste less)
>> of the shared memory. ZONE_MOVABLE pageblocks are always MIGRATE_MOVABLE
>> so the restrictions placed on MIGRATE_CMA pageblocks are lifted within a
>> DMB.
> 
> The whole purpose of ZONE_MOVABLE is that *no* unmovable allocations end 
> up on it. The biggest difference to CMA is that the CMA *owner* is able 
> to place unmovable allocations on it.
I'm not sure that is a wholly fair characterization (or maybe I just 
hope that's the case :). I would agree that the Linux page allocator 
can't place any unmovable allocations on it. I expect that people locate 
memory in ZONE_MOVABLE for different purposes. For example, the memory 
hotplug users ostensibly place memory their so that any data on the hot 
plugged memory can be moved off of the memory prior to it being hot 
unplugged. Unplugging the memory removes the memory from the 
ZONE_MOVABLE zone, but it is not materially different from allocating 
the memory for a different purpose (perhaps in a different machine).

Conceptually, allowing a CMA allocator to operate on a Designated 
Movable Block of memory that it *owns* is also removing that memory from 
the ZONE_MOVABLE zone. Issues of ownership should be addressed which is 
why these "other opportunities" are being deferred for now, but I do not 
believe such use is unreasonable. Again, Designated Movable Blocks are 
only allowed in boot memory so there shouldn't be a conflict with memory 
hotplug. I believe the same would apply for hugetlb_cma.
> 
> Using ZONE_MOVABLE for unmovable allocations (hugetlb_cma) is not 
> acceptable as is.
> 
> Using ZONE_MOVABLE in different context and calling it DMB is very 
> confusing TBH.
Perhaps it is more helpful to think of a Designated Movable Block as a 
block of memory whose migratetype is not allowed to be changed from 
MIGRATE_MOVABLE (i.e. "sticky" migrate movable). The fact that 
ZONE_MOVABLE is being used to achieve that is an implementation detail 
for this commit set. In the same way that memory hotplug is the concept 
of adding System RAM during run time, but placing it in ZONE_MOVABLE is 
an implementation detail to make it easier to unplug.

> 
> Just a note that I described the idea of a "PREFER_MOVABLE" zone in the 
> past. In contrast to ZONE_MOVABLE, we cannot run into weird OOM 
> situations in a ZONE misconfiguration, and we'd end up placing only 
> movable allocations on it as long as we can. However, especially 
> gigantic pages could be allocated from it. It sounds kind-of more like 
> what you want -- and maybe in combination of daxctl to let the user 
> decide how to online memory ranges.
Best not let Mel hear you suggesting another zone;).

> 
> 
> And just to make it clear again: depending on ZONE_MOVABLE == only user 
> space allocations is not future proof.
Understood.

> 
>>
>>>
>> Thanks for your consideration,
>> Dough Baker ... I mean Doug Berger :).
> 
> 
> :) Thanks Doug!
> 
Thank you!
-Doug
