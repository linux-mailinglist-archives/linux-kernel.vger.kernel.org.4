Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9866CA8DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC0P1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0P07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:26:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC82D4E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:26:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ja10so8779228plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679930817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Odb92SQ0FVvs57ZcM9A8PJotl9bKl4RHOoMbk3dA3D4=;
        b=e0Y1bQb3FmaTSC2GM9EK+o91pCalJmsio+SSS2HeFxcRwBTaSGbGYRRwhVaIUzHSpk
         PaZabU6yLU1iUGDfpEABRxiqFXC0dPyQ+1uBK5T+siCRQBa4cYRnL3c+WQnSmQOhbX5A
         oPskDLRfQL7IYrcgPLYNq2DHHUlV/t7wHVf7XoCjQT/g9oL6JyfxZaSo5Yr2qzawi42N
         sKPhpVgjdKtrlY/vVyFCrlmZpRO1puDQ3ACYlxKJqzWRCDk20lhxcZNwZbylD0ZCFudN
         j+Cvjcy77Vwu3NtPwunPnZYVlNyFKwIpuuDmz6SfsSSYTKp949kVkPrDevY16dOhvIb4
         OC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odb92SQ0FVvs57ZcM9A8PJotl9bKl4RHOoMbk3dA3D4=;
        b=Drot0dnn4wlC0sT1QGuY4EUa51aWVuMVuV7D2olm9YWMA2tTSELjqLtPmIkcGDCx3v
         ARFjeTBj+nkY1rsUNi2K2ECTLQwytOVeAkvZ0tNHqgwR2pGBUTt6OKFM9Em2UP7cT7lV
         PbbqQgMPrjhObJG3JGyAd0y747a0ll9beQXGWDCs6Tnvu/H5ukgXSIkveNRrK764j3dp
         hlj2kwoU6a3Vat69PuuHKFyYl8/0Vm09SiD9E3HmCW9YTP/tojgr+qtBHwCdJ69rp6tT
         ygSLe3fV7OvYIeEmpOr3Ay5vQcym2uwaHb1T/rniYUh5le9LApR8fMAYMqXDNSRaR5tP
         chsA==
X-Gm-Message-State: AAQBX9f7Bg19aOWZpIRJTYQ2loELid8xSyErA+HOanK7cbEYgTuli9PZ
        X/XkqaXrdK7c90jZihgbGZ/NXw==
X-Google-Smtp-Source: AKy350Z+cfTmght/h3mZN4yZCxLnNcQHz+khJqLqwwNJtRrzbffWTQd88JWx2oKkmUIhTFGvZmmgNg==
X-Received: by 2002:a17:903:120a:b0:19e:7d67:84e6 with SMTP id l10-20020a170903120a00b0019e7d6784e6mr13850465plh.0.1679930817447;
        Mon, 27 Mar 2023 08:26:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b0019a97a4324dsm19509745plb.5.2023.03.27.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:26:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pgokJ-003AkL-Bc;
        Mon, 27 Mar 2023 12:26:55 -0300
Date:   Mon, 27 Mar 2023 12:26:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Keeping <john@metanate.com>
Cc:     Steven Price <steven.price@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Message-ID: <ZCG1v9hRybc/951e@ziepe.ca>
References: <20230324111127.221640-1-steven.price@arm.com>
 <ZCGpmHUWyZVaeIIx@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGpmHUWyZVaeIIx@donbot>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:35:04PM +0100, John Keeping wrote:
> On Fri, Mar 24, 2023 at 11:11:27AM +0000, Steven Price wrote:
> > Similar to exynos, we need a set_platform_dma_ops() callback for proper
> > operation on ARM 32 bit after recent changes in the IOMMU framework
> > (detach ops removal). But also the use of a NULL domain is confusing.
> > 
> > Rework the code to have a singleton rk_identity_domain which is assigned
> > to domain when using an identity mapping rather than "detaching". This
> > makes the code easier to reason about.
> > 
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> > Changes since v1[1]:
> > 
> >  * Reworked the code to avoid a NULL domain, instead a singleton
> >    rk_identity_domain is used instead. The 'detach' language is no
> >    longer used.
> > 
> > [1] https://lore.kernel.org/r/20230315164152.333251-1-steven.price%40arm.com
> > 
> >  drivers/iommu/rockchip-iommu.c | 50 ++++++++++++++++++++++++++--------
> >  1 file changed, 39 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> > index f30db22ea5d7..437541004994 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> [snip]
> > +static struct iommu_domain rk_identity_domain = {
> > +	.type = IOMMU_DOMAIN_IDENTITY,
> > +	.ops = &rk_identity_ops,
> > +};
> > +
> > +#ifdef CONFIG_ARM
> 
> Is this #ifdef needed?  I can't see anything ARM-specific about this
> function or .set_platform_dma_ops.

set_platform_dma_ops is never called on ARM64.

> Not shown in the patch are the pm_runtime hooks.  Do they need to
> change like this?

Most likely yes

Jason
