Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6615FBF52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJLCr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJLCrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E612A5739
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665542872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZ7K2ewtqQaWv1BFRdt2aFnF+2QCzFo2meKvW1YmXRY=;
        b=Z8da9Iy5xkciPvdycSOe3hq4v7Wcjzs/1mzHc5TqQx277gk89Knj+bPJBINv9LjBMi6wdc
        eYJjKgAnr3blYEriBMLDbAqSqKI4B8XpMMo90b6tn//TX2/WZnikE+Jsqph1fJFwXRuI6l
        uPYy6K5fD/cWABI7GT0Nuu7otLEQcuM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-BK98j3sZPQCDGYspGEcLwA-1; Tue, 11 Oct 2022 22:47:48 -0400
X-MC-Unique: BK98j3sZPQCDGYspGEcLwA-1
Received: by mail-oo1-f72.google.com with SMTP id x1-20020a4a6201000000b004805eb46ceeso5179687ooc.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ7K2ewtqQaWv1BFRdt2aFnF+2QCzFo2meKvW1YmXRY=;
        b=lHyLvui/zoxhmJ9YjRtk8jrTZJ4oAmnLcbhSI8uBP+2fo5/DrwDmEA+QchICwu50id
         HEGAFvWY+7hL7KJziqtNyIADSWmcIOMRKDrmYkJVY8dKaHAoE1imXWm2SSHL18P8Y039
         9DofPm06GhKzt4wLZWYOaX0cmfv7z5kbYOUCba4Uz8z8bkc5LfMdldNQP58siEgPM9ze
         SqmU3MfPjekNOE2VdLa79vEsP1lcQM8r58lAw3bh8dv4n9mzZl4vkmbcImyC0fMYH85X
         eilSfkjWe4M7nhHJuY4Yzu2S/qXCBSXH0TjWE7OdQOgodoDr8NYtfgNTlWLQjRCNwnPd
         Z+XQ==
X-Gm-Message-State: ACrzQf12DHh8zvof/iZiHuYsSyIxNenmviFghdjA+k0Yw+zcdWWfdawT
        e+/g3vWqpEJU3BPw8UxMy9xMT7Jr/J7OR9+eVnffAb6miGpFeYuuplVp6IVoUmspTOgFucXqi09
        DUe3EO2Pep7FtMrLLqepjowKt
X-Received: by 2002:a9d:6e10:0:b0:661:bbbb:4a4c with SMTP id e16-20020a9d6e10000000b00661bbbb4a4cmr41971otr.228.1665542867603;
        Tue, 11 Oct 2022 19:47:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7PjH7xgO7K3tGySu/BZCaC3oiClCrqbe4ANJbEgmTaz5nrUPjzwWuEkFmXB2hRMI/bD0MxTw==
X-Received: by 2002:a9d:6e10:0:b0:661:bbbb:4a4c with SMTP id e16-20020a9d6e10000000b00661bbbb4a4cmr41966otr.228.1665542867332;
        Tue, 11 Oct 2022 19:47:47 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i8-20020a4aab08000000b0047644a9b49asm555240oon.19.2022.10.11.19.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 19:47:46 -0700 (PDT)
Date:   Tue, 11 Oct 2022 19:47:45 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Issue seen since commit f5ff79fddf0e ("dma-mapping: remove
 CONFIG_DMA_REMAP")
Message-ID: <20221012024745.mqlz3i2ayqfygdjv@cantor>
References: <20221010185739.vgw27m7fpmftly3q@cantor>
 <9df969a8-08b1-2b5a-3a86-9a1918f1949b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df969a8-08b1-2b5a-3a86-9a1918f1949b@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:15:57PM +0100, Robin Murphy wrote:
> On 2022-10-10 19:57, Jerry Snitselaar wrote:
> > I've been looking at an odd issue that shows up with commit
> > f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP").  What is being
> > seen is the bnx2fc driver calling dma_free_coherent(), and eventually
> > hits the BUG_ON() in vunmap().  bnx2fc_free_session_resc() does a
> > spin_lock_bh() around the dma_free_coherent() calls, and looking at
> > preempt.h that will trigger in_interrupt() to return positive, so that
> > makes sense. The really odd part is this only happens with the
> > shutdown of the kernel after a system install. Reboots after that do not
> > hit the BUG_ON() in vunmap().
> 
> Most likely a difference in IOMMU config/parameters between the installer
> and the installed kernel - if the latter is defaulting to passthrough then
> it won't be remapping (assuming the device is coherent).
> 

I'm pretty sure that is the difference now. I'm still trying to get access to
a system to verify. I think what is happening is the install occurs
with intel_iommu=on, but they aren't setting up the system to use intel_iommu=on
afterwards. They are saying they aren't installing with intel_iommu=on,
but it looks like the netboot configuration has it, and they aren't
going to get to __iommu_dma_free() if it isn't. :) So, I think during
install the iommu is enabled and uses dma-iommu, and then afterwards
it isn't enabled so they are going through dma-direct, which still
has a possibility of vunmap() in the code. I should have
verification of that tomorrow. Thank you for the responses.

Thanks,
Jerry

> > I still need to grab a system and try to see what it is doing on the
> > subsequent shutdowns, because it seems to me that any time
> > bnx2fc_free_session_resc() is called it will end up there, unless the
> > allocs are not coming from vmalloc() in the later boots. Between the
> > comments in dma_free_attrs(), and preempt.h, dma_free_coherent()
> > shouldn't be called under a spin_lock_bh(), yes? I think the comments
> > in dma_free_attrs() might be out of date with commit f5ff79fddf0e
> > ("dma-mapping: remove CONFIG_DMA_REMAP") in place since now it is more
> > general that you can land in vunmap(). Also, should that WARN_ON() in
> > dma_free_attrs() trigger as well for the BH disabled case?
> > 
> > It was also reproduced with a 6.0-rc5 kernel build[1].
> 
> Looking at the history of that comment I guess I was just trying to capture
> the most common case to explain the original motivation for having the
> WARN_ON(). It was never meant to imply that that's the *only* reason,
> especially since iommu-dma was already well established by that point. That
> warning has been present on x86 in one form or another for 15 years, so I
> guess the real issue at hand is the difference between irqs_disabled() and
> in_interrupt()?
> 
> As far as that particular driver goes it looks rather questionable anyway -
> it seems like a terrible design flaw if a race between consuming things and
> freeing them can exist at all, but then it looks like bnx2fc_arm_cq() might
> actually program the hardware to *reuse* a CQ which may already be waiting
> to be freed as soon as the lock is dropped... that can't be good :/
> 
> Thanks,
> Robin.

