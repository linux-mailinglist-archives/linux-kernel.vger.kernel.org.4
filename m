Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8EE6B5170
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjCJUH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjCJUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:07:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E50B127137
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678478818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pbWktnKIf2P4TvXCV62Olk42Buree+tecJxAeWz28rI=;
        b=KT1TT1sgTJRV8ZZ8xAKWVG8psHu+paniRzWW3KzhzvvTEy35czl5/079vdit4xyZchkxnm
        oOfLxbXGBcDG/M9CJvlwEDj47aFkNChw1gCx3gjL9AUn4BvkE8q2elSC35KIff3IqN04tu
        3iSO1KskEdJ/HXp6ToKYR5th/0pc+F8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-yGt1OULHMaSmnLcpR3nnNA-1; Fri, 10 Mar 2023 15:06:57 -0500
X-MC-Unique: yGt1OULHMaSmnLcpR3nnNA-1
Received: by mail-ed1-f72.google.com with SMTP id b7-20020a056402350700b004d2a3d5cd3fso9126994edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678478816;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbWktnKIf2P4TvXCV62Olk42Buree+tecJxAeWz28rI=;
        b=cpVfRz97oUnJfXgfuRHYfwe/JNSG1aCa87VDnOp9rQ7iawsw3vftdnvkK+TZsYC5zr
         owh3v1O52ZsnW1cWHZLRSfnaDBKyXbjlSMJCANL6GMdYNTcTdeOxhsDBXQdlN8+nTWeC
         rHeq6EscktGneXNmx+NckdYOlHl7S4sr5BweHLoRa26myaiQYwU9c6GISiIll6m4Hgc0
         s212dA0q1RCZ0a0mY6fDk+jrQgixHXM/QU6yeUh3Utczm71ZRrHx8TlIjdbshFhD1+rg
         8vkoI0mmhtFi+pET+SI4NdQ+N9/nELVle+NZ05hTO/1iNk9vM0j58QeGhIaFBdGzIKzu
         Gu2w==
X-Gm-Message-State: AO0yUKUUA9APhvLQ4aRlLWBFJjc8+O14zHWGLElZjaIpvbMlUn3lAYG7
        ol4oh+6c+WVnaXl7nn50ejH50j/lyqlwpIrVq1ULRfu4AYfC16NysJG3lXspjomLLjGHFnKDlyA
        SLGzlooru0xMHbVhTIdpex3rU
X-Received: by 2002:aa7:d856:0:b0:4bf:5295:ba0e with SMTP id f22-20020aa7d856000000b004bf5295ba0emr21307694eds.41.1678478816174;
        Fri, 10 Mar 2023 12:06:56 -0800 (PST)
X-Google-Smtp-Source: AK7set/04Ww2URZyxcrVnn+BOVIBwqWJSPCfubZMMJCHj+xbnHonAHgF8D8cE2q+F9tPWeyJOJhDMw==
X-Received: by 2002:aa7:d856:0:b0:4bf:5295:ba0e with SMTP id f22-20020aa7d856000000b004bf5295ba0emr21307685eds.41.1678478815848;
        Fri, 10 Mar 2023 12:06:55 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id vv7-20020a170907a68700b008b1b86bf668sm255915ejc.4.2023.03.10.12.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 12:06:55 -0800 (PST)
Message-ID: <c33db2d3-a15e-24bc-87d5-0b31ee468b52@redhat.com>
Date:   Fri, 10 Mar 2023 21:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH drm-next v2 00/16] [RFC] DRM GPUVA Manager & Nouveau
 VM_BIND UAPI
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     matthew.brost@intel.com, willy@infradead.org,
        dri-devel@lists.freedesktop.org, corbet@lwn.net,
        nouveau@lists.freedesktop.org, ogabbay@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bskeggs@redhat.com, tzimmermann@suse.de,
        Liam.Howlett@oracle.com, bagasdotme@gmail.com,
        christian.koenig@amd.com, jason@jlekstrand.net
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230309101243.1150506f@collabora.com>
 <20230309104841.7c03d5b4@collabora.com>
 <d0e59837-703b-964a-877e-38c244f58a85@redhat.com>
 <20230310182536.571315f3@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230310182536.571315f3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 18:25, Boris Brezillon wrote:
> Hi Danilo,
> 
> On Fri, 10 Mar 2023 17:45:58 +0100
> Danilo Krummrich <dakr@redhat.com> wrote:
>> Hi Boris,
>>
>>> On Thu, 9 Mar 2023 10:12:43 +0100
>>> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>>>
>>> Ok, so I just noticed you only have one bind queue per drm_file
>>> (cli->sched_entity), and jobs are executed in-order on a given queue,
>>> so I guess that allows you to modify the VA space at submit time
>>> without risking any modifications to the VA space coming from other
>>> bind-queues targeting the same VM. And, if I'm correct, synchronous
>>> bind/unbind ops take the same path, so no risk for those to modify the
>>> VA space either (just wonder if it's a good thing to have to sync
>>> bind/unbind operations waiting on async ones, but that's a different
>>> topic).
>>
>> Yes, that's all correct.
>>
>> The page table allocation happens through nouveau_uvmm_vmm_get() which
>> either allocates the corresponding page tables or increases the
>> reference count, in case they already exist, accordingly.
>> The call goes all the way through nvif into the nvkm layer (not the
>> easiest to follow the call chain) and ends up in nvkm_vmm_ptes_get().
>>
>> There are multiple reasons for updating the VA space at submit time in
>> Nouveau.
>>
>> 1) Subsequent EXEC ioctl() calls would need to wait for the bind jobs
>> they depend on within the ioctl() rather than in the scheduler queue,
>> because at the point of time where the ioctl() happens the VA space
>> wouldn't be up-to-date.
> 
> Hm, actually that's what explicit sync is all about, isn't it? If you
> have async binding ops, you should retrieve the bind-op out-fences and
> pass them back as in-fences to the EXEC call, so you're sure all the
> memory mappings you depend on are active when you execute those GPU
> jobs. And if you're using sync binds, the changes are guaranteed to be
> applied before the ioctl() returns. Am I missing something?
> 

No, you're right and this is exactly how I implemented it. The 
difference is where to wait for the bind jobs out-fences.

In the EXEC ioctl() we need to validate the GEM objects backing the 
dependent mappings and add the jobs fence to the GEMs DMA reservation. 
If the VA space isn't up-to-date we might not be able to look up the 
relevant GEMs and miss them.

If the VA space change happens in the bind jobs submit path (ioctl()), 
it is guaranteed that the view of the VA space is up-to-date (actually 
it might even be ahead of the actual current state) when the EXEC 
ioctl() is called. Hence, I can just pass the out-fences of the binds 
jobs the EXEC depends on to the job scheduler and return from the 
ioctl(). The job scheduler will then wait for the actual mappings being 
populated before executing the EXEC job.

If the VA space change is done when the bind job executes on the 
scheduler we would need to wait for the bind jobs out-fences in the EXEC 
ioctl() itself.

>>
>> 2) Let's assume a new mapping is requested and within it's range other
>> mappings already exist. Let's also assume that those existing mappings
>> aren't contiguous, such that there are gaps between them. In such a case
>> I need to allocate page tables only for the gaps between the existing
>> mappings, or alternatively, allocate them for the whole range of the new
>> mapping, but free / decrease the reference count of the page tables for
>> the ranges of the previously existing mappings afterwards.
>> In the first case I need to know the gaps to allocate page tables for
>> when submitting the job, which means the VA space must be up-to-date. In
>> the latter one I must save the ranges of the previously existing
>> mappings somewhere in order to clean them up, hence I need to allocate
>> memory to store this information. Since I can't allocate this memory in
>> the jobs run() callback (fence signalling critical section) I need to do
>> it when submitting the job already and hence the VA space must be
>> up-to-date again.
> 
> Yep that makes perfect sense, and that explains how the whole thing can
> work. When I initially read the patch series, I had more complex use
> cases in mind, with multiple bind queues targeting the same VM, and
> synchronous bind taking a fast path (so they don't have to wait on
> async binds which can in turn wait on external deps). This model makes
> it hard to predict what the VA space will look like when an async bind
> operation gets to be executed, thus making page table allocation more
> complex, or forcing us to over-estimate the amount of pages we need for
> this update (basically one page per MMU level, except maybe the top
> level, plus the number of pages you'll always need for the bind
> operation itself).
> 
>> However, this is due to how page table management currently works in
>> Nouveau and we might change that in the future.
> 
> I'm curious to hear about that if you have a bit of time. I'm starting
> from scratch with pancsf, and I might consider going for something
> similar to what you plan to do next.

There is no concrete plan yet. However, with the current implementation 
there are a few shortcomings (also in handling sparse ranges) that I'd 
like to address in the future.

> 
>>
>> Synchronous binds/unbinds taking the same path through the scheduler is
>> a downside of this approach.
> 
> Indeed. I mean, I can probably live with this limitation, but I'm
> curious to know if the pg table management changes you're considering
> for the future would solve that problem.

As mentioned above, I have a few ideas, but I did not think through them 
entirely yet.

A few thoughts though: If running synchronous binds/unbinds through the 
job scheduler is a concern I think it could be beneficial to 
(pre-)allocate page tables for newly requested mappings without the need 
to know whether there are existing mappings within this range already 
(ideally without tracking page table allocations separate from GPUVAs), 
such that we can update the VA space at job execution time. Same thing 
for freeing page tables for a range that only partially contains 
mappings at all. For that, reference counting page tables per mapping 
wouldn't really work.

On the other hand we need to consider that freeing page tables for a 
given range and allocating new page tables for the same or an 
overlapping range would need to be ordered in order to avoid races.

> 
> Anyway, thanks for taking the time to answer my question, things are
> much clearer now.

I'm happy to discuss this. Feel free to also reach out in IRC, my nick 
is 'dakr'.

> 
> Boris
> 

