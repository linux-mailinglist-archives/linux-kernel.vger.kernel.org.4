Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E65F59F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiJESlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiJESlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE62543C3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664995192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LWrr+mzLl+loyhMbjqGtBTsS99v10H6F/JTraBsXlM=;
        b=PFHGElKQsBySo7KoTLkeV5+B2mpXiJVtBHAsLLVPlZwAgmuexOOSyIPEgP566Is6Le1lZ9
        VxyaCER8TzS1hgA8xqkL5JEDv+FOKG7XTawTHEN6G6mJr8OVnaduCNkiyBWiPewoXV140k
        BUp+Bxr+4ch41y4jsqbafaWjzkdtPCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-252-NHJyfAs0PG2SJvRxyuMddA-1; Wed, 05 Oct 2022 14:39:50 -0400
X-MC-Unique: NHJyfAs0PG2SJvRxyuMddA-1
Received: by mail-wm1-f71.google.com with SMTP id p24-20020a05600c1d9800b003b4b226903dso1284044wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=3LWrr+mzLl+loyhMbjqGtBTsS99v10H6F/JTraBsXlM=;
        b=V6KUjgENzhkn6yfer1uUxObP7Mt76rWw2iZQ8X7+s+dIlM7oTwlF8/F5D3EfCb48dK
         4sw8aBj38oc2N4RyUlVJK3we6oVJpRM6wvOQZKlzxMURSwYmlWonjW/POKr23wH67Q+z
         ABa66QfZAyhCeNscvHWXaQ/2Ef+hLorHLSw6cAw1MI0brS8USNdycF4exUQznzcurhlT
         3aN8jYcdos36SyVokl8m0b84jUa+OqEclGjbKSv1+Q9R2yQxGhmfAgxAtYjyOmTFMAdm
         ZwAJOfjrm6j6Agw5gugm1TXW4VEy1aWcGNGcLsVKaxvTzeMHIR/kOJsM2bND7+SlBaFH
         mKBw==
X-Gm-Message-State: ACrzQf1bnn7xJTwhi1b1PIEEZzoFRZR7kPpwq9z0emqLvOz/I3zkJv7u
        KUOrWtbGu1Rhp4MYdLBP2ullqL8kP1Z1gD7q0t9BjQnGGqeiez+updnNlcvestgL4ELc5ldb8pC
        jdPvgIT7PBmpjbza9N+3+hNjQ
X-Received: by 2002:a5d:5552:0:b0:22e:6941:81f8 with SMTP id g18-20020a5d5552000000b0022e694181f8mr430565wrw.521.1664995189465;
        Wed, 05 Oct 2022 11:39:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7KOHX+c5fT4yvas7PB46G0drnxid10BmAo3PVPcJtv5AKCfxdItdjQLE2ZqvXfl1Mdkuxtzw==
X-Received: by 2002:a5d:5552:0:b0:22e:6941:81f8 with SMTP id g18-20020a5d5552000000b0022e694181f8mr430551wrw.521.1664995189012;
        Wed, 05 Oct 2022 11:39:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5a00:b732:1c9:3697:fccf? (p200300cbc7025a00b73201c93697fccf.dip0.t-ipconnect.de. [2003:cb:c702:5a00:b732:1c9:3697:fccf])
        by smtp.gmail.com with ESMTPSA id m13-20020adfe94d000000b0021e43b4edf0sm15571718wrn.20.2022.10.05.11.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 11:39:48 -0700 (PDT)
Message-ID: <106669a6-fe89-f736-19ad-39de44f9a774@redhat.com>
Date:   Wed, 5 Oct 2022 20:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
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
 <3af1da5f-6b95-1aab-60f0-d17f141782b4@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
In-Reply-To: <3af1da5f-6b95-1aab-60f0-d17f141782b4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> So whatever we do, this should in general not be the kernel sole
>> decision to make this memory any special and let ZONE_MOVABLE manage it.
> I believe you are stating that Designated Movable Blocks should only be
> created as a result of special configuration (e.g. kernel parameters,
> devicetree, ...). I would agree with that. Is that what you intended by
> this statement, or am I missing something?

Essentially, that it should mostly be the decision of an educated admin.

...

>>
>>> only be located at the end of addressable memory then it will always be
>>> located on MEMC1 of a 7278 system. This will create a tendency for user
>>> space accesses to consume more bandwidth on the MEMC1 memory controller
>>> and kernel space accesses to consume more bandwidth on MEMC0. A more
>>> even distribution of ZONE_MOVABLE memory between the available memory
>>> controllers in theory makes more memory bandwidth available to user
>>> space intensive loads.
>>>
>>
>> Sorry to be dense, is this also about different memory access latency or
>> just memory bandwidth?
> Broadcom memory controllers do support configurable real-time scheduling
> with bandwidth guarantees for different memory clients so I suppose this
> is a fair question. However, the expectation here is that the CPUs would
> have equivalent access latencies, so it is really just about memory
> bandwidth for the CPUs.

Okay, thanks for clarifying.

...

>>>>
>>>>> Unfortunately, the historical monotonic layout of zones would
>>>>> mean that if the lowest addressed memory controller contains
>>>>> ZONE_MOVABLE memory then all of the memory available from
>>>>> memory controllers at higher addresses must also be in the
>>>>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>>>>> onto the lowest addressed memory controller and significantly
>>>>> reduce the amount of memory available for non-movable
>>>>> allocations.
>>>>
>>>> We do have code that relies on zones during boot to not overlap within a
>>>> single node.
>>> I believe my changes address all such reliance, but if you are aware of
>>> something I missed please let me know.
>>>
>>
>> One example I'm aware of is drivers/base/memory.c:memory_block_add_nid()
>> / early_node_zone_for_memory_block().
>>
>> If we get it wrong, or actually have memory blocks that span multiple
>> zones, we can no longer offline these memory blocks. We really wanted to
>> avoid scanning the memmap for now and it seems to get the job done in
>> environments we care about.
> To the extent that this implementation only supports creating Designated
> Movable Blocks in boot memory and boot memory does not generally support
> offlining, I wouldn't expect this to be an issue. However, if for some

Sad truth is, that boot memory sometimes is supposed to support 
offlining -- or people expect it to work to some degree. For example, 
with special memblock hacks you can get them into ZONE_MOVABLE to be 
able to hotunplug some NUMA nodes even after a reboot (movable_node 
kernel parameter).

There are use cases where you want to offline boot memory to save energy 
by disabling complete memory banks -- best effort when not using 
ZONE_MOVABLE.

Having that said, I agree that it's a corner case use case.

> reason offlining boot memory becomes desirable then we should use
> dmb_intersects() along with zone_intersects() to take the appropriate
> action. Based on the current usage of zone_intersects() I'm not entirely
> sure what the correct action should be.
> 
>>
>>>>
>>>>>
>>>>> The main objective of this patch set is therefore to allow a
>>>>> block of memory to be designated as part of the ZONE_MOVABLE
>>>>> zone where it will always only be used by the kernel page
>>>>> allocator to satisfy requests for movable pages. The term
>>>>> Designated Movable Block is introduced here to represent such a
>>>>> block. The favored implementation allows modification of the
>>>>
>>>> Sorry to say, but that term is rather suboptimal to describe what you
>>>> are doing here. You simply have some system RAM you'd want to have
>>>> managed by ZONE_MOVABLE, no?
>>> That may be true, but I found it superior to the 'sticky' movable
>>> terminology put forth by Mel Gorman ;). I'm happy to entertain
>>> alternatives, but they may not be as easy to find as you think.
>>
>> Especially the "blocks" part is confusing. Movable pageblocks? Movable
>> Linux memory blocks?
>>
>> Note that the sticky movable *pageblocks* were a completely different
>> concept than simply reusing ZONE_MOVABLE for some memory ranges.
> I would say that is open for debate. The implementations would be
> "completely different" but the objectives could be quite similar.
> There appear to be a number of people that are interested in the concept
> of memory that can only contain data that tolerates relocation for
> various potentially non-competing reasons.
> 
> Fundamentally, the concept of MIGRATE_MOVABLE memory is useful to allow
> competing user space processes to share limited physical memory supplied
> by the kernel. The data in that memory can be relocated elsewhere by the
> kernel when the process that owns it is not executing. This movement is
> typically not observable to the owning process which has its own address
> space.
> 
> The kernel uses MIGRATE_UNMOVABLE memory to protect the integrity of its
> address space, but of course what the kernel considers unmovable could
> in fact be moved by a hypervisor in a way that is analogous to what the
> kernel does for user space.
> 
> For maximum flexibility the Linux memory management allows for
> converting the migratetype of free memory to help satisfy requests to
> allocate pages of memory through a mechanism I will call "fallback". The
> concepts of sticky movable pageblocks and ZONE_MOVABLE have the common
> objective of preventing the migratetype of pageblocks from getting
> converted to anything other than MIGRATE_MOVABLE, and this is what makes
> the memory special.

Yes, good summary.

> 
> I agree with Mel Gorman that zones are meant to be about address induced
> limitations, so using a zone for the purpose of breaking the fallback
> mechanism of the page allocator is a misuse of the concept. A new
> migratetype would be more appropriate for representing this change in
> how fallback should apply to the pageblock because the desired behavior
> has nothing to do with the address at which the memory is located. It is
> entirely reasonable to desire "sticky" movable behavior for memory in
> any zone. Such a solution would be directly applicable to our multiple
> memory controller use case, and is really how Designated Movable Blocks
> should be imagined.

I usually agree with Mel, but not necessarily on that point that it's a 
misuse of a concept. It's an extension of an existing concept, that 
doesn't imply it's a misuse. Traditionally, it was about address 
limitations, yes. Now it's also about allocation types. Sure, there 
might be other ways to get it done as well.

I'd compare it to the current use of NUMA nodes: traditionally, it 
really used to be actual NUMA nodes. Nowadays, it's a mechanism, for 
example, to expose performance-differented memory, let applications use 
it via mbind() or have the page allocator dynamically migrate hot/cold 
pages back and forth according to memory tiering strategies.

> 
> However, I also recognize the efficiency benefits of using a
> ZONE_MOVABLE zone to manage the pages that have this "sticky" movable
> behavior. Introducing a new sticky MIGRATE_MOVABLE migratetype adds a
> new free_list to every free_area which increases the search space and
> associated work when trying to allocate a page for all callers.
> Introducing ZONE_MOVABLE reduces the search space by providing an early
> separation between searches for movable and non-movable allocations. The
> classic zone restrictions weren't a good fit for multiple memory
> controllers, but those restrictions were lifted to overcome similar
> issues with memory_hotplug. It is not that Designated Movable Blocks
> want to be in ZONE_MOVABLE, but rather that ZONE_MOVABLE provides a
> convenience for managing the page allocators use of "sticky" movable
> memory just like it does for memory hotplug. Dumping the memory in
> Designated Movable Blocks into the ZONE_MOVABLE zone allows an existing
> mechanism to be reused, reducing the risk of negatively impacting the
> page allocator behavior.
> 
> There are some subtle distinctions between Designated Movable Blocks and
> the existing ZONE_MOVABLE zone. Because Designated Movable Blocks are
> reserved when created they are protected against any early boot time
> kernel reservations that might place unmovable allocations in them. The
> implementation continues to track the zone_movable_pfn as the start of
> the "classic" ZONE_MOVABLE zone on each node. A Designated Movable Block
> can overlap any other zone including the "classic" ZONE_MOVABLE zone.

What exactly to you mean with "overlay" -- I assume you mean that zone 
span will overlay but it really "belongs" to ZONE_MOVABLE, as indicated 
by it's struct page metadata.

>>
>> Doing it the DAX/CXL way would be to expose these memory ranges as
>> daxdev instead, and letting the admin decide how to online these memory
>> ranges when adding them to the buddy via the dax/kmem kernel module.
>>
>> That could mean that your booting with memory on MC0 only, and expose
>> memory of MC1 via a daxdev, giving the admin the possibility do decide
>> to which zone the memory should be onlined too.
>>
>> That would avoid most kernel code changes.
> I wasn't familiar with these kernel mechanisms and did enjoy reading
> about the somewhat oxymoronic "volatile-use of persistent memory" that
> is dax/kmem, but this isn't performance differentiated RAM. It really is
> just System RAM so this degree of complexity seems unwarranted.

It's an existing mechanism that will get heavily used by CXL -- for all 
kinds of memory. I feel like it could solve your use case eventually.

Excluded memory cannot be allocated by the early allocator and you can 
online it to ZONE_MOVABLE. It at least seems to roughly do something you 
want to achieve. I'd be curious what you can't achieve or what we might 
need to make

>>>
>>>>
>>>> Why do we have to start using ZONE_MOVABLE for them?
>>> One of the "other opportunities" for Designated Movable Blocks is to
>>> allow CMA to allocate from a DMB as an alternative. This would allow
>>> current users to continue using CMA as they want, but would allow users
>>> (e.g. hugetlb_cma) that are not sensitive to the allocation latency to
>>> let the kernel page allocator make more complete use (i.e. waste less)
>>> of the shared memory. ZONE_MOVABLE pageblocks are always MIGRATE_MOVABLE
>>> so the restrictions placed on MIGRATE_CMA pageblocks are lifted within a
>>> DMB.
>>
>> The whole purpose of ZONE_MOVABLE is that *no* unmovable allocations end
>> up on it. The biggest difference to CMA is that the CMA *owner* is able
>> to place unmovable allocations on it.
> I'm not sure that is a wholly fair characterization (or maybe I just
> hope that's the case :). I would agree that the Linux page allocator
> can't place any unmovable allocations on it. I expect that people locate
> memory in ZONE_MOVABLE for different purposes. For example, the memory
> hotplug users ostensibly place memory their so that any data on the hot
> plugged memory can be moved off of the memory prior to it being hot
> unplugged. Unplugging the memory removes the memory from the
> ZONE_MOVABLE zone, but it is not materially different from allocating
> the memory for a different purpose (perhaps in a different machine).

Well, memory offlining is the one operation that evacuates memory) and 
makes sure it cannot be allocated anymore (possibly with the intention 
of removing that memory from the system). Sure, you can call it a fake 
allocation, but there is a more fundamental difference compared to 
random subsystems placing unmovable allocations there.

> 
> Conceptually, allowing a CMA allocator to operate on a Designated
> Movable Block of memory that it *owns* is also removing that memory from
> the ZONE_MOVABLE zone. Issues of ownership should be addressed which is
> why these "other opportunities" are being deferred for now, but I do not
> believe such use is unreasonable. Again, Designated Movable Blocks are
> only allowed in boot memory so there shouldn't be a conflict with memory
> hotplug. I believe the same would apply for hugetlb_cma.
>>
>> Using ZONE_MOVABLE for unmovable allocations (hugetlb_cma) is not
>> acceptable as is.
>>
>> Using ZONE_MOVABLE in different context and calling it DMB is very
>> confusing TBH.
> Perhaps it is more helpful to think of a Designated Movable Block as a
> block of memory whose migratetype is not allowed to be changed from
> MIGRATE_MOVABLE (i.e. "sticky" migrate movable). The fact that

I think that such a description might make the feature easier to grasp. 
Although I am not sure yet if DMB as proposed is rather a hack to avoid 
introducing real sticky movable blocks (sorry, I'm just trying to 
connect the dots and there is a lot of complexity involved) or actually 
a clean design. Messing with zones and memblock always implies complexity :)

> ZONE_MOVABLE is being used to achieve that is an implementation detail
> for this commit set. In the same way that memory hotplug is the concept
> of adding System RAM during run time, but placing it in ZONE_MOVABLE is
> an implementation detail to make it easier to unplug.

Right, but there we don't play any tricks: it's just ZONE_MOVABLE 
without any other metadata pointing out ownership. Maybe that's what you 
are trying to describe here: A DMB inside ZONE_MOVABLE implies that 
there is another owner and that even memory offlining should fail.

> 
>>
>> Just a note that I described the idea of a "PREFER_MOVABLE" zone in the
>> past. In contrast to ZONE_MOVABLE, we cannot run into weird OOM
>> situations in a ZONE misconfiguration, and we'd end up placing only
>> movable allocations on it as long as we can. However, especially
>> gigantic pages could be allocated from it. It sounds kind-of more like
>> what you want -- and maybe in combination of daxctl to let the user
>> decide how to online memory ranges.
> Best not let Mel hear you suggesting another zone;).

He most probably read it already. ;) I can understand all theoretical 
complains about ZONE_MOVABLE, but in the end it has been getting the job 
done for years.

> 
>>
>>
>> And just to make it clear again: depending on ZONE_MOVABLE == only user
>> space allocations is not future proof.
> Understood.

May I ask what the main purpose/use case of DMB is?

Would it be sufficient, to specify that hugetlb are allocated from a 
specific memory area, possible managed by CMA? And then simply providing 
the application that cares these hugetlb pages? Would you need something 
that is *not* hugetlb?

But even then, how would an application be able to specify that exactly 
it's allocation will get served from that part of ZONE_MOVABLE? Sure, if 
you don't reserve any other hugetlb pages, it's easy.


I'd like to note that if you'd go with (fake) NUMA nodes like PMEM or 
CXL you could easily let your application mbind() to that memory and 
have it configured.

-- 
Thanks,

David / dhildenb

