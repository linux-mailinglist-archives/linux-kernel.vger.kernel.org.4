Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017296C52A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCVRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCVRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:36:41 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3692062B45
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:36:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id bz27so11870666qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679506581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWbfKdnzylqruLkb669PxI2Ds25u6VYLIbbrabovtsY=;
        b=PQJwj1HPzHv1dtC0s3LoMHBNrziJ3IVIJiiSj7ubk1Ssg4NpoJ16lj3aVjbzQKzGGX
         XMvtY+X/emL9T9l07jeS5LSy+n1C6AQ4TI/c3g3fFpB4zyjl5w7QslGs7TvOO9N7YRDW
         kKq1cJ4HDgAdkQ9UrrlfAU/u79UYRgjiOpTkBKtGNW29CXuv/cJFdTBRR+GURcZ5mQ+a
         4Rrof8zPjg6cdzZmbRiIe35cfkSaVKcuRDD7ogzBdeh5H3KGTejCaXvDZuTnkjr6ahbY
         368qtfEBHTUEs8FXhi5Ex9el+l8BdPR+fjWt+m+0uncVwnmkqa93zXp55EXw7foH0W/C
         kvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWbfKdnzylqruLkb669PxI2Ds25u6VYLIbbrabovtsY=;
        b=Ev9Pf9ReYMc2G9nkLYDJZpPUIMZq59lC4Bp67NHUgRIQ0XyIhllRKjdcZLncvrcuQg
         yh9Cbd5FtIWZrQLZWqyQOo98MhVlQvOktJkTs2IVyQ4V2oXiUKNrSUcUyNAOAzK6j0WS
         16uD6+hV2Mcw5pGPIVdgFWcdEmREyHo0wFb3VTH6dXjmA2BKGYxE+7EKTsI1/7Z8AhFv
         tgfujK4VDr990yXIU4TPOfzMp4YyTSWU2qO0gDITCa+y7d8kIh4/8NWIAgXCDEAfifJk
         vn1A3+abO/vUUh3O88fUmNoeKvWARqcbgFShz1St+vrom9znEq37uurVIqxsvnkPbofI
         e1cQ==
X-Gm-Message-State: AO0yUKUNUqPPl1cHB5Ujn6u7lPUnfAlV7rqqp5+g4pma+QWWzmGR1Pgs
        dzXHFtFZVOF+S5AtBKL+WHkMxg==
X-Google-Smtp-Source: AK7set+1jTuQ5BkMw9ArPzCi/uxOuElPpNpMdi9teoMqfXrR/0DmTYHtW2bV7gjcoP3ib42QHmjm2w==
X-Received: by 2002:a05:622a:1806:b0:3e3:791e:72d0 with SMTP id t6-20020a05622a180600b003e3791e72d0mr8033898qtc.19.1679506580800;
        Wed, 22 Mar 2023 10:36:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g1-20020a37b601000000b00743592b4745sm11604976qkf.109.2023.03.22.10.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:36:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pf2Nn-000yQO-Iz;
        Wed, 22 Mar 2023 14:36:19 -0300
Date:   Wed, 22 Mar 2023 14:36:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Message-ID: <ZBs8k8nki/iqUiwE@ziepe.ca>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca>
 <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
 <ZBr5e6tn1i7EE/16@ziepe.ca>
 <a5b946f0-5be8-a656-a8d5-1cd75399f0c4@arm.com>
 <ZBsb01emBJJMZIt0@ziepe.ca>
 <bee3e168-3fc3-89e8-6b10-a830f052cf55@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee3e168-3fc3-89e8-6b10-a830f052cf55@arm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 04:04:25PM +0000, Steven Price wrote:
> On 22/03/2023 15:16, Jason Gunthorpe wrote:
> > On Wed, Mar 22, 2023 at 03:08:41PM +0000, Steven Price wrote:
> >> @@ -1035,8 +1055,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
> >>  	if (iommu->domain == domain)
> >>  		return 0;
> >>  
> >> -	if (iommu->domain)
> >> -		rk_iommu_detach_device(iommu->domain, dev);
> >> +	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
> >> +	if (ret)
> >> +		return ret;
> > 
> >>  
> >>  	iommu->domain = domain;
> >>  
> >> @@ -1049,8 +1070,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
> >>  		return 0;
> >>  
> >>  	ret = rk_iommu_enable(iommu);
> >> -	if (ret)
> >> -		rk_iommu_detach_device(iommu->domain, dev);
> > 
> > I think this still needs error handling, it should put it back to the
> > identity domain and return an error code if it fails to attach to the
> > requested domain.
> 
> What confused me here is that there's already a call to
> rk_iommu_identity_attach() just above. But I can obviously add a...

I don't know this driver at all, but to me it looks like this is
perhaps undoing a partially failed rk_iommu_enable() since it doesn't
seem to enetirely fix itself. Ie it zeros the INT_MASK and DTE_ADDR

Maybe it would be better to put that error cleanup direclty into
enable and just move the iommu->domain assignment to after enable
success.

>        if (ret)
>                rk_iommu_identity_attach(&rk_identity_domain, dev);
> 
> ... in here. But I don't know how to handle an error from
> rk_iommu_identity_attach() at this point. Does it need handling - is a
> WARN_ON sufficient?

WARN_ON should be fine, that is kind of hacky, it would be better to
organize things so there is an identity attach function that cannot
fail, ie pre-assumes all the validation is done alread.y

> 
> > It should also initlaize iommu->domain to the identity domain when the
> > iommu struct is allocated. The iommu->domain should never be
> > NULL. identity domain means the IOMMU is turned off which was
> > previously called "detached".
> 
> I presume you mean in rk_iommu_probe()?

It would be best if it was setup at allocation time so in
rk_iommu_of_xlate() before dev_iommu_priv_set()

Jason
