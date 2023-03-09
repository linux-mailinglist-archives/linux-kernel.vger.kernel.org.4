Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC26B2CDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCIS1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCIS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:27:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2BF5D03
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:27:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so4279174wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678386419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSo3SrRrwG+Alf2X+q3mr8n740CsX06ZYBUOpvJ7CdE=;
        b=IPIedD0SQGSBZITeBMup2NQnh39sEGFGa1cZddW8kIbf6ppxVYKHf3s2QOKb7ZmKji
         ugdaUI9z05k+r+Ddg7ZGjyAOcmNExiHSByAMHAH9lwbvRj/x4yHKFHFXU9jswiNI7qUr
         2DqUrM0lQ9bJQZHP+x6HBQic2DPQMRpYuIijk5YmG+yVbd82sOARPBNEQ50KSgyki1gq
         yFKHtA8+o0XzffHCbQm2mUq9tn0VGuU3xpsaLU1TE2OP1lVwg8eYhh2BN2mOCNAqmI5e
         e5HBvgqrH1Q5+fQ25eubeCez4+V6K9hE4XzMXLR4U7wWF8FQlVmIXDOfCK6ZL8prMb7M
         7ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678386419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSo3SrRrwG+Alf2X+q3mr8n740CsX06ZYBUOpvJ7CdE=;
        b=a67xeQfk1qUEI2ywvCIFaUOU6dDeGEdEW8fVCiqdqwoslkPAfC9j6PWm+A5deOEpH7
         cCPIOg8LTpPVXdkzErUDsYXOHaklJHKgVAtfoxh8BEqgSgb7rfNfJXQ6pKd6HHZfjpiO
         zOX1qd1SL/ZsFtrKvBv3Z/vl2KxX4yCbBkBd8kL61BGITknKvvNCamYrC5F/HPvp2H01
         uv5YaSf961XNvT8IxPbHas5MXLC+PaMXP/rlGZ1TWoWTx/2ZEHHLxfwm9qmnM8How/D/
         lIaLY4EsHkCMxfAv2JGPnbK7r9RFzK6OE3ztW1d6ZEkGub0TePeDodvTlBQsdwBju+Yf
         WPEg==
X-Gm-Message-State: AO0yUKWFxMIDHaogXHOZffRXf6WdyvGVyVAF1+rQxxhK8pgcpiqEQiDy
        /4CTfdqAkJ66z9PajmMaZNCl+A==
X-Google-Smtp-Source: AK7set+z154uyP1Uipi6NNjIApt35+YbI32vUip5j8Zt23KIYEFqnQGAt+J8pFg8TzQ8QBBQG0qcwA==
X-Received: by 2002:a05:600c:524b:b0:3ea:dc1b:90c with SMTP id fc11-20020a05600c524b00b003eadc1b090cmr184067wmb.20.1678386418874;
        Thu, 09 Mar 2023 10:26:58 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id r7-20020a0560001b8700b002c7163660a9sm40251wru.105.2023.03.09.10.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:26:58 -0800 (PST)
Date:   Thu, 9 Mar 2023 18:26:59 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
        will@kernel.org, eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <20230309182659.GA1710571@myrica>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnx0lUkw02cVTi+@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 01:42:17PM +0000, Jean-Philippe Brucker wrote:
> 
> > Although we can keep the alloc and hardware info separate for each IOMMU
> > architecture, we should try to come up with common invalidation methods.
> 
> The invalidation language is tightly linked to the actual cache block
> and cache tag in the IOMMU HW design.

Concretely though, what are the incompatibilities between the HW designs?
They all need to remove a range of TLB entries, using some address space
tag. But if there is an actual difference I do need to know.

> Generality will loose or
> obfuscate the necessary specificity that is required for creating real
> vIOMMUs.
> 
> Further, invalidation is a fast path, it is crazy to take a vIOMMU of
> a real HW receving a native invalidation request, mangle it to some
> obfuscated kernel version and then de-mangle it again in the kernel
> driver. IMHO ideally qemu will simply point the invalidation at the
> WQE in the SW vIOMMU command queue and invoke the ioctl. (Nicolin, we
> should check more into this)

Avoiding copying a few bytes won't make up for the extra context switches
to userspace. An emulated IOMMU can easily decode commands and translate
them to generic kernel structures, in a handful of CPU cycles, just like
they decode STEs. It's what they do, and it's the opposite of obfuscation.

> 
> The purpose of these interfaces is to support high performance full
> functionality vIOMMUs of the real HW, we should not loose sight of
> that goal.
> 
> We are actually planning to go futher and expose direct invalidation
> work queues complete with HW doorbells to userspace. This obviously
> must be in native HW format.

Doesn't seem relevant since direct access to command queue wouldn't use
this struct.

> 
> Nicolin, I think we should tweak the uAPI here so that the
> invalidation opaque data has a format tagged on its own, instead of
> re-using the HWPT tag. Ie you can have a ARM SMMUv3 invalidate type
> tag and also a virtio-viommu invalidate type tag.
> 
> This will allow Jean to put the invalidation decoding in the iommu
> drivers if we think that is the right direction. virtio can
> standardize it as a "HW format".
> 
> > Ideally I'd like something like this for vhost-iommu:
> > 
> > * slow path through userspace for complex requests like attach-table and
> >   probe, where the VMM can decode arch-specific information and translate
> >   them to iommufd and vhost-iommu ioctls to update the configuration.
> > 
> > * fast path within the kernel for performance-critical requests like
> >   invalidate, page request and response. It would be absurd for the
> >   vhost-iommu driver to translate generic invalidation requests from the
> >   guest into arch-specific commands with special opcodes, when the next
> >   step is calling the IOMMU driver which does that for free.
> 
> Someone has to do the conversion. If you don't think virito should do
> it then I'd be OK to add a type tag for virtio format invalidation and
> put it in the IOMMU driver.

Implementing two invalidation formats in each IOMMU driver does not seem
practical.

> 
> But given virtio overall already has to know *alot* about how the HW
> it is wrapping works I don't think it is necessarily absurd for virtio
> to do the conversion. I'd like to evaluate this in patches in context
> with how much other unique HW code ends up in kernel-side vhost-iommu.

Ideally none. I'd rather leave those, attach and probe, in userspace and
if possible compatible with iommufd to avoid register decoding. 

> 
> However, I don't know the rational for virtio-viommu, it seems like a
> strange direction to me.

A couple of reasons are relevant here: non-QEMU VMMs don't want to emulate
all vendor IOMMUs, new architectures get vIOMMU mostly for free, and vhost
provides a faster path. Also the ability to optimize paravirtual
interfaces for things like combined invalidation (IOTLB+ATC) or, later,
nested page requests.

For a while the main vIOMMU use-case was assignment to guest userspace,
mainly DPDK, which works great with a generic and slow map/unmap
interface. Since vSVA is still a niche use-case, and nesting without page
faults requires pinning the whole guest memory, map/unmap still seems more
desirable to me. But there is some renewed interest in supporting page
tables with virtio-iommu for the reasons above.

> All the iommu drivers have native command
> queues. ARM and AMD are both supporting native command queues directly
> in the guest, complete with a direct guest MMIO doorbell ring.

Arm SMMUv3 mandates a single global command queue (SMMUv2 uses registers).
An SMMUv3 can optionally implement multiple command queues, though I don't
know if they can be safely assigned to guests. For a lot of SMMUv3
implementations that have a single queue and for other architectures, we
can do better than hardware emulation.

> 
> If someone wants to optimize this I'd think the way to do it is to use
> virtio like techniques to put SW command queue processing in the
> kernel iommu driver and continue to use the HW native interface in the
> VM.

I didn't get which kernel this is.

> 
> What benifit comes from replacing the HW native interface with virtio?
> Especially on ARM where the native interface is pretty clean?
> 
> > During previous discussions we came up with generic invalidations that
> > could fit both Arm and x86 [1][2]. The only difference was the ASID
> > (called archid/id in those proposals) which VT-d didn't need. Could we try
> > to build on that?
> 
> IMHO this was just unioning all the different invalidation types
> together. It makes sense for something like virtio but it is
> illogical/obfuscated as a user/kernel interface since it still
> requires a userspace HW driver to understand what subset of the
> invalidations are used on the actual HW.

As above, decoding arch-specific structures into generic ones is what an
emulated IOMMU does, and it doesn't make a performance difference in which
format it forwards that to the kernel. The host IOMMU driver checks the
guest request and copies them into the command queue. Whether that request
comes in the form of a structure binary-compatible with Arm SMMUvX.Y, or
some generic structure, does not make a difference.

Thanks,
Jean

