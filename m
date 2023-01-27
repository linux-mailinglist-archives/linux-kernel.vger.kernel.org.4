Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752DD67F022
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjA0VKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA0VKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:10:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724B83049
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674853776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndB8ukEHepKxXU5mNVOIBCnfXxGd6UUpK39fQXPswC0=;
        b=Rgr3jRRtwTOLifFgFieBNZy+ihdnOUuR2fCx+RaeJI45XtYt+GPeVwsOMnQLlbgFEI8l/Z
        h/v+uy5MQzPZw6PZGP0SGCjdtxMWTifBm3me3iZAVe0Ci/cL6v27IfbFhjWHh/uoqyuo8v
        unc2LkRuu+R1wwJ3ufZCBQqD1ElUwDo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-qj3u1lRwNnKQ8FmextM9vw-1; Fri, 27 Jan 2023 16:09:34 -0500
X-MC-Unique: qj3u1lRwNnKQ8FmextM9vw-1
Received: by mail-ej1-f69.google.com with SMTP id hc30-20020a170907169e00b0086d90ee8b17so4177064ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndB8ukEHepKxXU5mNVOIBCnfXxGd6UUpK39fQXPswC0=;
        b=6SVvHEjw+knzhRuTr3w1XoMTwwVLHZ/bAF6uxrG/u6PXiIz78qDMQXQq1LCT759W5I
         uZT4jW9QcmOK89DLYls6ciTUUi83IHqOmqbRfoSWatGuKSXR3Bv5aOnAvCGGE4I64nFt
         TSFo2jaR8AwoE3YxJtpB5yzpZFU1/DQjk3mw2Mn+WtzZg6ibofRIAzanJKbFTX2H7bo6
         lTEll0Qq1hbDuweX/MnsKHukBKwR3DQkTNMMaJeMAzWFbDqFZ5CKGuzIooLDFtSkpfRh
         n9uNAOHUgVZjzBFzTBxBKT+rspCB/2TLgYKeudc+5Bt8XftWVGlGiylE4rGMYACdRCpE
         MSdw==
X-Gm-Message-State: AFqh2koRytdAMyUa0mb5x75HUFNVUD3wenPww+KGvtETcfj5/lI8jX/e
        HDgdQmS7o9AZAvDT5LLmxQ37L1uaQV+PoIqeSLSgtavZD966yFJvtfXgk0KhmoFg968deXIgFt0
        wAKnlU0KpKNBObdSAgy1ecw8+
X-Received: by 2002:a17:907:6f07:b0:7c0:f90f:163d with SMTP id sy7-20020a1709076f0700b007c0f90f163dmr49336054ejc.11.1674853773608;
        Fri, 27 Jan 2023 13:09:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsi7P8iP1bejpKZSCAEnXNpSzoQMFgQttLInrYR0+DaK+fktxckqwLaVKdgC8gbyCCpYVQfEA==
X-Received: by 2002:a17:907:6f07:b0:7c0:f90f:163d with SMTP id sy7-20020a1709076f0700b007c0f90f163dmr49336038ejc.11.1674853773276;
        Fri, 27 Jan 2023 13:09:33 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id n18-20020a1709067b5200b00878530f5324sm2871370ejo.90.2023.01.27.13.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 13:09:32 -0800 (PST)
Message-ID: <bc523c5c-efe6-1a7f-b49a-e0867dc1413d@redhat.com>
Date:   Fri, 27 Jan 2023 22:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH drm-next 05/14] drm/nouveau: new VM_BIND uapi interfaces
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Brost <matthew.brost@intel.com>
Cc:     daniel@ffwll.ch, airlied@redhat.com, bskeggs@redhat.com,
        jason@jlekstrand.net, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org
References: <20230118061256.2689-1-dakr@redhat.com>
 <20230118061256.2689-6-dakr@redhat.com>
 <Y9MjSeMcsd18r9vM@DUT025-TGLU.fm.intel.com>
 <7c046ff9-728d-7634-9d77-8536308c7481@redhat.com>
 <c2256c7d-e768-ae3f-d465-b9f8080d111b@amd.com>
 <2427a918-5348-d1ef-ccae-a29c1ff33c83@redhat.com>
 <a214b28b-043c-a8bb-69da-b4d8216fce56@amd.com>
 <3a76bfa9-8ee5-a7d9-b9fb-a98181baec0b@redhat.com>
 <49ac3f95-6eda-9009-4b28-0167213301b2@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <49ac3f95-6eda-9009-4b28-0167213301b2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 16:17, Christian König wrote:
> Am 27.01.23 um 15:44 schrieb Danilo Krummrich:
>> [SNIP]
>>>>>
>>>>> What you want is one component for tracking the VA allocations 
>>>>> (drm_mm based) and a different component/interface for tracking the 
>>>>> VA mappings (probably rb tree based).
>>>>
>>>> That's what the GPUVA manager is doing. There are gpuva_regions 
>>>> which correspond to VA allocations and gpuvas which represent the 
>>>> mappings. Both are tracked separately (currently both with a 
>>>> separate drm_mm, though). However, the GPUVA manager needs to take 
>>>> regions into account when dealing with mappings to make sure the 
>>>> GPUVA manager doesn't propose drivers to merge over region 
>>>> boundaries. Speaking from userspace PoV, the kernel wouldn't merge 
>>>> mappings from different VKBuffer objects even if they're virtually 
>>>> and physically contiguous.
>>>
>>> That are two completely different things and shouldn't be handled in 
>>> a single component.
>>
>> They are different things, but they're related in a way that for 
>> handling the mappings (in particular merging and sparse) the GPUVA 
>> manager needs to know the VA allocation (or region) boundaries.
>>
>> I have the feeling there might be a misunderstanding. Userspace is in 
>> charge to actually allocate a portion of VA space and manage it. The 
>> GPUVA manager just needs to know about those VA space allocations and 
>> hence keeps track of them.
>>
>> The GPUVA manager is not meant to be an allocator in the sense of 
>> finding and providing a hole for a given request.
>>
>> Maybe the non-ideal choice of using drm_mm was implying something else.
> 
> Uff, well long story short that doesn't even remotely match the 
> requirements. This way the GPUVA manager won't be usable for a whole 
> bunch of use cases.
> 
> What we have are mappings which say X needs to point to Y with this and 
> hw dependent flags.
> 
> The whole idea of having ranges is not going to fly. Neither with AMD 
> GPUs and I strongly think not with Intels XA either.

A range in the sense of the GPUVA manager simply represents a VA space 
allocation (which in case of Nouveau is taken in userspace). Userspace 
allocates the portion of VA space and lets the kernel know about it. The 
current implementation needs that for the named reasons. So, I think 
there is no reason why this would work with one GPU, but not with 
another. It's just part of the design choice of the manager.

And I'm absolutely happy to discuss the details of the manager 
implementation though.

> 
>>> We should probably talk about the design of the GPUVA manager once 
>>> more when this should be applicable to all GPU drivers.
>>
>> That's what I try to figure out with this RFC, how to make it 
>> appicable for all GPU drivers, so I'm happy to discuss this. :-)
> 
> Yeah, that was really good idea :) That proposal here is really far away 
> from the actual requirements.
> 

And those are the ones I'm looking for. Do you mind sharing the 
requirements for amdgpu in particular?

>>>> For sparse residency the kernel also needs to know the region 
>>>> boundaries to make sure that it keeps sparse mappings around.
>>>
>>> What?
>>
>> When userspace creates a new VKBuffer with the 
>> VK_BUFFER_CREATE_SPARSE_BINDING_BIT the kernel may need to create 
>> sparse mappings in order to ensure that using this buffer without any 
>> memory backed mappings doesn't fault the GPU.
>>
>> Currently, the implementation does this the following way:
>>
>> 1. Userspace creates a new VKBuffer and hence allocates a portion of 
>> the VA space for it. It calls into the kernel indicating the new VA 
>> space region and the fact that the region is sparse.
>>
>> 2. The kernel picks up the region and stores it in the GPUVA manager, 
>> the driver creates the corresponding sparse mappings / page table 
>> entries.
>>
>> 3. Userspace might ask the driver to create a couple of memory backed 
>> mappings for this particular VA region. The GPUVA manager stores the 
>> mapping parameters, the driver creates the corresponding page table 
>> entries.
>>
>> 4. Userspace might ask to unmap all the memory backed mappings from 
>> this particular VA region. The GPUVA manager removes the mapping 
>> parameters, the driver cleans up the corresponding page table entries. 
>> However, the driver also needs to re-create the sparse mappings, since 
>> it's a sparse buffer, hence it needs to know the boundaries of the 
>> region it needs to create the sparse mappings in.
> 
> Again, this is not how things are working. First of all the kernel 
> absolutely should *NOT* know about those regions.
> 
> What we have inside the kernel is the information what happens if an 
> address X is accessed. On AMD HW this can be:
> 
> 1. Route to the PCIe bus because the mapped BO is stored in system memory.
> 2. Route to the internal MC because the mapped BO is stored in local 
> memory.
> 3. Route to other GPUs in the same hive.
> 4. Route to some doorbell to kick of other work.
> ...
> x. Ignore write, return 0 on reads (this is what is used for sparse 
> mappings).
> x+1. Trigger a recoverable page fault. This is used for things like SVA.
> x+2. Trigger a non-recoverable page fault. This is used for things like 
> unmapped regions where access is illegal.
> 
> All this is plus some hw specific caching flags.
> 
> When Vulkan allocates a sparse VKBuffer what should happen is the 
> following:
> 
> 1. The Vulkan driver somehow figures out a VA region A..B for the 
> buffer. This can be in userspace (libdrm_amdgpu) or kernel (drm_mm), but 
> essentially is currently driver specific.

Right, for Nouveau we have this in userspace as well.

> 
> 2. The kernel gets a request to map the VA range A..B as sparse, meaning 
> that it updates the page tables from A..B with the sparse setting.
> 
> 3. User space asks kernel to map a couple of memory backings at location 
> A+1, A+10, A+15 etc....
> 
> 4. The VKBuffer is de-allocated, userspace asks kernel to update region 
> A..B to not map anything (usually triggers a non-recoverable fault).

Until here this seems to be identical to what I'm doing.

It'd be interesting to know how amdgpu handles everything that 
potentially happens between your 3) and 4). More specifically, how are 
the page tables changed when memory backed mappings are mapped on a 
sparse range? What happens when the memory backed mappings are unmapped, 
but the VKBuffer isn't de-allocated, and hence sparse mappings need to 
be re-deployed?

Let's assume the sparse VKBuffer (and hence the VA space allocation) is 
pretty large. In Nouveau the corresponding PTEs would have a rather huge 
page size to cover this. Now, if small memory backed mappings are mapped 
to this huge sparse buffer, in Nouveau we'd allocate a new PT with a 
corresponding smaller page size overlaying the sparse mappings PTEs.

How would this look like in amdgpu?

> 
> When you want to unify this between hw drivers I strongly suggest to 
> completely start from scratch once more.
> 
> First of all don't think about those mappings as VMAs, that won't work 
> because VMAs are usually something large. Think of this as individual 
> PTEs controlled by the application. similar how COW mappings and struct 
> pages are handled inside the kernel.

Why do you consider tracking single PTEs superior to tracking VMAs? All 
the properties for a page you mentioned above should be equal for the 
entirety of pages of a whole (memory backed) mapping, aren't they?

> 
> Then I would start with the VA allocation manager. You could probably 
> base that on drm_mm. We handle it differently in amdgpu currently, but I 
> think this is something we could change.

It was not my intention to come up with an actual allocator for the VA 
space in the sense of actually finding a free and fitting hole in the VA 
space.

For Nouveau (and XE, I think) we have this in userspace and from what 
you've written previously I thought the same applies for amdgpu?

> 
> Then come up with something close to the amdgpu VM system. I'm pretty 
> sure that should work for Nouveau and Intel XA as well. In other words 
> you just have a bunch of very very small structures which represents 
> mappings and a larger structure which combine all mappings of a specific 
> type, e.g. all mappings of a BO or all sparse mappings etc...

Considering what you wrote above I assume that small structures / 
mappings in this paragraph refer to PTEs.

Immediately, I don't really see how this fine grained resolution of 
single PTEs would help implementing this in Nouveau. Actually, I think 
it would even complicate the handling of PTs, but I would need to think 
about this a bit more.

> 
> Merging of regions is actually not mandatory. We don't do it in amdgpu 
> and can live with the additional mappings pretty well. But I think this 
> can differ between drivers.
> 
> Regards,
> Christian.
> 

