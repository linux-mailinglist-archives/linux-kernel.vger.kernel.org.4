Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6D6C4B16
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCVMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCVMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:50:06 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B29765
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:50:05 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o44so9136074qvo.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679489404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w7gE8texmE3DXA6Si9qcI9IbQl6PzfIzMyuDdUR1aGM=;
        b=Zmsb6zCFzu/kmtgX9pgfKoiphZnKawAnRXfkkAM6tgS4xNN/QcVxADZ/FRRGWXnrab
         J2f5Eoq2GgYVO/M0SALVmy0xbQZb+iixEPkCyuWoBOPZe5PVSC2wjTV8ZTKnWzTXa2lz
         gaRUjJsv1G8VfJ8UJbkgyRpko0RTono1j5VeDpU0+C7AMiRrGBNYFMm/M9QoVEfH3BXp
         oHNqoN4L6EjXEXlE20euDUiPvzvLQAmAMIY4mxt7ztSVV7e7vJchdolzra66iFm4RTOb
         poH15Jsrv6+Q/QNzzeWqctmZFEF18GsTKFsjRJm7XpHEnZk/x8DO9KzfiaynQJg2oKW3
         k/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7gE8texmE3DXA6Si9qcI9IbQl6PzfIzMyuDdUR1aGM=;
        b=3T8iBAN3dM+1lUPxBMYcNaI7ZKega8iyqr8TtdqsyILxhgMXEubCjrelS+fCmeg7hf
         NmO801PG9yD0YhJNjrIhhLORr4jL1/4v6C+BSDxjRgnajgpUXGyt5VhXOSQF+qqJr7aF
         q0RRNYuI5sa6D5/YrWt4i/HZll/is5jobXVzVAKIqI2UcSrko7S0DgJYVRvHR8L6rMgj
         5+SZLtBQau7nUd5/465tVJUgvAyahnTpTQB1O8a8iY5eTXZ+C21B1IoqzvnI24m35MUS
         FLC3AdvbeMAz7IOXw/e39OS1VRXPxikpOLNmWPb08gvBFdz27A+CfBbZdmWyGsvEI6PB
         1E2Q==
X-Gm-Message-State: AO0yUKVlSLNFCt4JFUl82N3y8WTR9iILBy2RN5Whg3fSQB3KUZ3/zWjQ
        ZKdmKaCLhBM0F0aMM2gtiuDvpg==
X-Google-Smtp-Source: AK7set+VnGTjKIIgaUl7XLaK5Bz0mAnMGv9q8V5I9Mle27qkRgJWN3VPYUoIH6BqWcnLhci14N1fww==
X-Received: by 2002:a05:6214:acd:b0:5ac:77ef:f76 with SMTP id g13-20020a0562140acd00b005ac77ef0f76mr5491411qvi.44.1679489404535;
        Wed, 22 Mar 2023 05:50:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id c68-20020a379a47000000b00746aa080eefsm1655211qke.6.2023.03.22.05.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:50:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pexul-000mfl-Ct;
        Wed, 22 Mar 2023 09:50:03 -0300
Date:   Wed, 22 Mar 2023 09:50:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Message-ID: <ZBr5e6tn1i7EE/16@ziepe.ca>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca>
 <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:02:41AM +0000, Steven Price wrote:
> On 21/03/2023 14:38, Jason Gunthorpe wrote:
> > On Wed, Mar 15, 2023 at 04:41:52PM +0000, Steven Price wrote:
> >> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> >> operation on ARM 32 bit after recent changes in the IOMMU framework
> >> (detach ops removal).
> >>
> >> Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> ---
> >> This fixes a splat I was seeing on a Firefly-RK3288, more details here:
> >> https://lore.kernel.org/all/26a5d1b8-40b3-b1e4-bc85-740409c26838@arm.com/
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Thanks for the review.
> 
> > Do you know what state the iommu is left in after
> > rk_iommu_detach_device()? Ie is it blocking DMA or doing identity or
> > something else?
> 
> To be honest I really don't know for sure. But from my small
> understanding of the code: rk_iommu_detach_device() ends up in
> rk_iommu_disable_paging() which appears to switch to identity mode
> ("Disable memory translation").

Can you consider writing this patch like this instead:

https://lore.kernel.org/linux-iommu/ZBnef7g7GCxogPNz@ziepe.ca/

?

I'd much rather we move toward clearly documenting what is going on
with the HW and remove this undefined "detach" language.

Jason
