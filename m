Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247B65FDE49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJMQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJMQdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C1A1382EF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665678801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=258B5dvfB770baVruwTSi3C+iVLJewGHOe6aI0MzdOY=;
        b=TOM2DSLAT+AaIrR9/gzPeEVwGE9iVbBEQZpZqSGTKmA7ZY0alR+hwKsBTMkXFy59+n1fBo
        DVZ0SkVwU90cRCoZk0s1Xel0lbqO8oTc2slmcCrxSSyYaG4qyMr4i73vEmQKsZPKLWTDAM
        q6kDU9y2Xuum7t5zY5SIdJzWBEV1adM=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-PjSVLKTpONSNf-7ttflcFQ-1; Thu, 13 Oct 2022 12:33:20 -0400
X-MC-Unique: PjSVLKTpONSNf-7ttflcFQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-131e72856e0so1334648fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=258B5dvfB770baVruwTSi3C+iVLJewGHOe6aI0MzdOY=;
        b=Y3iVDnLWrCQxNC7jYnoBUW3H3Ml/JhzMp8QKbM9YYAsQOc0brccbL9I9ZvXxyKxv04
         eiYTEJ5tEOnI50zE5mUEK0d5x1jC8xUNuC6JvJpe4gMCb+QxQrjarklwP2+W0lVuUg+N
         WDHAio8Ly6vbY9Nt11AcBWbE6KhQCLZX78pStjMtwwiVQYc3m2yeZ0pR+Je5jKYR1kXe
         gLy2tA9OpsFfb7U7PbKcmuU4TS9r/6ABmRwvaoj/sXdT8t0iRGLM9nGPE3xA3nuj4k+Q
         V86vYDOzqG5t+0c7nKJ0p45lpGnoUT8Tn7gsI8aICBKsR9io9QA8EogRqjQIAke9KCdh
         xB2Q==
X-Gm-Message-State: ACrzQf0MxdkK7A3g4Wh5hvrcxzmX8+i4rap4zWBCJKMLpMJq9e+e9Lvs
        3HZ1DgfWs9dN2GnhN42w0VWVplFlyuTg5cbRARH6ROuXIQ5I/T22b4iZl9s3U+HZP+RLotx046L
        qvxOJP+sLprc1mrwV7LZJZz7o
X-Received: by 2002:a05:6808:ab3:b0:354:939b:2cee with SMTP id r19-20020a0568080ab300b00354939b2ceemr5076841oij.184.1665678799581;
        Thu, 13 Oct 2022 09:33:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6JuHSuXN3NCTH9AZ16U7Xkb+Q97H7KlKMUyPGSFXHsGClZ2sPSt5OAXujOmppNyLfSSaSpfg==
X-Received: by 2002:a05:6808:ab3:b0:354:939b:2cee with SMTP id r19-20020a0568080ab300b00354939b2ceemr5076832oij.184.1665678799358;
        Thu, 13 Oct 2022 09:33:19 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s20-20020a056808209400b0035179b87ba5sm16723oiw.20.2022.10.13.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:33:18 -0700 (PDT)
Date:   Thu, 13 Oct 2022 09:33:17 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Message-ID: <20221013163317.pgcsvmktotdtkduf@cantor>
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013153355.2365865-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And I apparently had vt-d on the brain, which should be dropped
from the summary.

On Thu, Oct 13, 2022 at 08:33:55AM -0700, Jerry Snitselaar wrote:
> iommu_sva_bind_device() should only be called if
> iommu_dev_enable_feature() succeeded. There has been one case already
> where that hasn't been the case, which resulted in a null pointer
> deref in dev_iommu_ops(). To avoid that happening in the future if
> another driver makes that mistake, sanity check dev->iommu and
> dev->iommu->iommu_dev prior to calling dev_iommu_ops().
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> drivers/iommu/iommu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4893c2429ca5..20ec75667529 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>  {
>  	struct iommu_group *group;
>  	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	const struct iommu_ops *ops;
> +
> +	if (!dev->iommu || !dev->iommu->iommu_dev) {
> +		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
> +			__func__);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	ops = dev_iommu_ops(dev);
>  
>  	if (!ops->sva_bind)
>  		return ERR_PTR(-ENODEV);
> -- 
> 2.37.2
> 

