Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F124067EF86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjA0U0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA0U0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FC92DE7F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674851121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPFaivJKn71UfPFDN84nxVwrXtkpEKt3PCNX8OYRPaI=;
        b=dK+x//Au8PmxTWbdWyZGBptQ90UKZV0Il4wVDsB+lyZ5E8AOoE3CRnYKzgcE4beLaTysyh
        AClNAKvrATIO4iLBAgeJBigYat93LirnEAZdNeeUYky3JGgOANTLX1Xi5xpUlqogml/UpO
        84cCz96L4DlJ+jlf2pMLpC3R/AmZfvY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-384-k8oe9VzEMWiBgN2-9Lhscg-1; Fri, 27 Jan 2023 15:25:19 -0500
X-MC-Unique: k8oe9VzEMWiBgN2-9Lhscg-1
Received: by mail-qk1-f199.google.com with SMTP id s7-20020a05620a0bc700b006e08208eb31so3652220qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPFaivJKn71UfPFDN84nxVwrXtkpEKt3PCNX8OYRPaI=;
        b=S8qrql/U2mdGhv/DXlBsrvVBB0Aq1EP/HwEyFVLUdHbuRx4uxRbXPEp1z3uNXzudKA
         IYWkH9J+dRxu6A4a9ytIkvythXp0qxpX0zQzPgheA0o0wrjIx/uRO51B20AGbr9V3vnj
         Wi4nq5aShh7MqnhPI/v4FqBJmR+6uNrDDN+DwSPSKscH7nS3bY73yNA7pLYiYSMWVMo5
         /s/h2nPSYRQsV7uDgEvYEgp7xtJOWfLAGtau/8WhnPMmZUglX38xHWhCK3D2T8MnnvOt
         DQWoANmOcD4T7fcyn3SXZEOHxnRmmooBDNbedWSlkVvytZpAzO5TbOQfdC2HJpw+vgPN
         2P6A==
X-Gm-Message-State: AO0yUKUOhQQ/gi83BkfIqf08rTDHaCCLjXyzSJlnjaxAaYOQqAHlcdIJ
        TKYcAtUaefKvMNlQqiVyYfi4aLDYN2AcY5yFCZcYXcTruNYciOWXtO/opfiYK9AlhNgYV8g/eZx
        nTeDZKB1BQzHnbjXfhlebcPTDOMpMqLJe8pTJvg0W
X-Received: by 2002:ae9:e314:0:b0:719:484e:f986 with SMTP id v20-20020ae9e314000000b00719484ef986mr166688qkf.209.1674851118758;
        Fri, 27 Jan 2023 12:25:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+reW9epoUgsTvkoCuS4BWyTRI928d66PYTf9uNh1S8zfiJVxGLovoAqoY3RSrdRLwfrJTOHStCXA8a5N+ZuEY=
X-Received: by 2002:ae9:e314:0:b0:719:484e:f986 with SMTP id
 v20-20020ae9e314000000b00719484ef986mr166680qkf.209.1674851118416; Fri, 27
 Jan 2023 12:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20230118061256.2689-1-dakr@redhat.com> <20230118061256.2689-6-dakr@redhat.com>
 <Y9MjSeMcsd18r9vM@DUT025-TGLU.fm.intel.com> <7c046ff9-728d-7634-9d77-8536308c7481@redhat.com>
 <c2256c7d-e768-ae3f-d465-b9f8080d111b@amd.com> <2427a918-5348-d1ef-ccae-a29c1ff33c83@redhat.com>
 <a214b28b-043c-a8bb-69da-b4d8216fce56@amd.com> <3a76bfa9-8ee5-a7d9-b9fb-a98181baec0b@redhat.com>
 <49ac3f95-6eda-9009-4b28-0167213301b2@amd.com>
In-Reply-To: <49ac3f95-6eda-9009-4b28-0167213301b2@amd.com>
From:   David Airlie <airlied@redhat.com>
Date:   Sat, 28 Jan 2023 06:25:06 +1000
Message-ID: <CAMwc25oGap_hEg5AquM_L2eH42PcG=pM3KPS6HNTNj-SzeHu+g@mail.gmail.com>
Subject: Re: [PATCH drm-next 05/14] drm/nouveau: new VM_BIND uapi interfaces
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Matthew Brost <matthew.brost@intel.com>, daniel@ffwll.ch,
        bskeggs@redhat.com, jason@jlekstrand.net, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 1:17 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.01.23 um 15:44 schrieb Danilo Krummrich:
> > [SNIP]
> >>>>
> >>>> What you want is one component for tracking the VA allocations
> >>>> (drm_mm based) and a different component/interface for tracking the
> >>>> VA mappings (probably rb tree based).
> >>>
> >>> That's what the GPUVA manager is doing. There are gpuva_regions
> >>> which correspond to VA allocations and gpuvas which represent the
> >>> mappings. Both are tracked separately (currently both with a
> >>> separate drm_mm, though). However, the GPUVA manager needs to take
> >>> regions into account when dealing with mappings to make sure the
> >>> GPUVA manager doesn't propose drivers to merge over region
> >>> boundaries. Speaking from userspace PoV, the kernel wouldn't merge
> >>> mappings from different VKBuffer objects even if they're virtually
> >>> and physically contiguous.
> >>
> >> That are two completely different things and shouldn't be handled in
> >> a single component.
> >
> > They are different things, but they're related in a way that for
> > handling the mappings (in particular merging and sparse) the GPUVA
> > manager needs to know the VA allocation (or region) boundaries.
> >
> > I have the feeling there might be a misunderstanding. Userspace is in
> > charge to actually allocate a portion of VA space and manage it. The
> > GPUVA manager just needs to know about those VA space allocations and
> > hence keeps track of them.
> >
> > The GPUVA manager is not meant to be an allocator in the sense of
> > finding and providing a hole for a given request.
> >
> > Maybe the non-ideal choice of using drm_mm was implying something else.
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
>
> >> We should probably talk about the design of the GPUVA manager once
> >> more when this should be applicable to all GPU drivers.
> >
> > That's what I try to figure out with this RFC, how to make it
> > appicable for all GPU drivers, so I'm happy to discuss this. :-)
>
> Yeah, that was really good idea :) That proposal here is really far away
> from the actual requirements.
>
> >>> For sparse residency the kernel also needs to know the region
> >>> boundaries to make sure that it keeps sparse mappings around.
> >>
> >> What?
> >
> > When userspace creates a new VKBuffer with the
> > VK_BUFFER_CREATE_SPARSE_BINDING_BIT the kernel may need to create
> > sparse mappings in order to ensure that using this buffer without any
> > memory backed mappings doesn't fault the GPU.
> >
> > Currently, the implementation does this the following way:
> >
> > 1. Userspace creates a new VKBuffer and hence allocates a portion of
> > the VA space for it. It calls into the kernel indicating the new VA
> > space region and the fact that the region is sparse.
> >
> > 2. The kernel picks up the region and stores it in the GPUVA manager,
> > the driver creates the corresponding sparse mappings / page table
> > entries.
> >
> > 3. Userspace might ask the driver to create a couple of memory backed
> > mappings for this particular VA region. The GPUVA manager stores the
> > mapping parameters, the driver creates the corresponding page table
> > entries.
> >
> > 4. Userspace might ask to unmap all the memory backed mappings from
> > this particular VA region. The GPUVA manager removes the mapping
> > parameters, the driver cleans up the corresponding page table entries.
> > However, the driver also needs to re-create the sparse mappings, since
> > it's a sparse buffer, hence it needs to know the boundaries of the
> > region it needs to create the sparse mappings in.
>
> Again, this is not how things are working. First of all the kernel
> absolutely should *NOT* know about those regions.
>
> What we have inside the kernel is the information what happens if an
> address X is accessed. On AMD HW this can be:
>
> 1. Route to the PCIe bus because the mapped BO is stored in system memory=
.
> 2. Route to the internal MC because the mapped BO is stored in local memo=
ry.
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
> When Vulkan allocates a sparse VKBuffer what should happen is the followi=
ng:
>
> 1. The Vulkan driver somehow figures out a VA region A..B for the
> buffer. This can be in userspace (libdrm_amdgpu) or kernel (drm_mm), but
> essentially is currently driver specific.

There are NO plans to have drm_mm do VA region management, VA region
management will be in userspace in Mesa. Can we just not bring that up agai=
n?
This is for GPU VA tracking not management if that makes it easier we
could rename it.

>
> 2. The kernel gets a request to map the VA range A..B as sparse, meaning
> that it updates the page tables from A..B with the sparse setting.
>
> 3. User space asks kernel to map a couple of memory backings at location
> A+1, A+10, A+15 etc....

3.5?

Userspace asks the kernel to unmap A+1 so it can later map something
else in there?

What happens in that case, with a set of queued binds, do you just do
a new sparse mapping for A+1, does userspace decide that?

Dave.

>
> 4. The VKBuffer is de-allocated, userspace asks kernel to update region
> A..B to not map anything (usually triggers a non-recoverable fault).
>
> When you want to unify this between hw drivers I strongly suggest to
> completely start from scratch once more.
>
> First of all don't think about those mappings as VMAs, that won't work
> because VMAs are usually something large. Think of this as individual
> PTEs controlled by the application. similar how COW mappings and struct
> pages are handled inside the kernel.
>
> Then I would start with the VA allocation manager. You could probably
> base that on drm_mm. We handle it differently in amdgpu currently, but I
> think this is something we could change.
>
> Then come up with something close to the amdgpu VM system. I'm pretty
> sure that should work for Nouveau and Intel XA as well. In other words
> you just have a bunch of very very small structures which represents
> mappings and a larger structure which combine all mappings of a specific
> type, e.g. all mappings of a BO or all sparse mappings etc...
>
> Merging of regions is actually not mandatory. We don't do it in amdgpu
> and can live with the additional mappings pretty well. But I think this
> can differ between drivers.
>
> Regards,
> Christian.
>

