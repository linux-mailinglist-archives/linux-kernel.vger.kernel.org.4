Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381705FDD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJMPhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJMPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE22C6958
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665675454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZC8ZhODybW3HN+Dzjja+AX4is7YURzcPSRS/gTWg/mU=;
        b=Xy+nmoRWYQjINjAENClEbpyAnaeXmP/ywdJWAw2sSU9diMnoyQAtRQYGBSAypwB/eXuTo/
        goJiyo8MB1D0BtnFoi3Wv0cLj8mTInxJHjthkWC4+CgmfpfGcle2+JPICmGC+ms43adPKR
        TUJeeroLct29OeTkFK7yjSY/lcsSRYg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-c8gP-XhMOXyB0WAmpdOjkQ-1; Thu, 13 Oct 2022 11:37:32 -0400
X-MC-Unique: c8gP-XhMOXyB0WAmpdOjkQ-1
Received: by mail-oo1-f69.google.com with SMTP id m13-20020a4a390d000000b004809df50243so995061ooa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC8ZhODybW3HN+Dzjja+AX4is7YURzcPSRS/gTWg/mU=;
        b=cTXhkE4WIiVkA0jJPJqqHwdkfRHYkaeMS5kw2yz0mwgDpgtO6SawEnsK7sZ+NuUwCc
         ZptMQM1t3xl9GZ7U83e+RcnhzuMOvZVCnCyudC2MothZYbFAImn+d2q7tR1j9w/j6zIh
         KYJ0YUKfaS2BVbWRdpr9ZkvIshj6wQx5cc2Lxux/6dcJbwsqq+Ri2wwKKktOP6fxVRJ2
         ITRGXaz2eCCAHpZH73zzNTUqAYpWJmsfuT5oKnGYaBx7wSpotQ1NgwPgE9qrMhBoPZD9
         PlTVMAHUGn5cdwN6F7Vm6dpN1BuNq3dXSxbm/4IeSxy9eB6HzPj+ocMg0qi7r5mSnXHz
         V+HA==
X-Gm-Message-State: ACrzQf2/bKJmGbQ1+WCjGJYI0jFZZrtKqLHwRkMcyBEIOodMgPdKwpy2
        W45QPkyPB+3Zi0BLWjrahkCvt2EKoDdxOXUIru47SPb+R5YcXT/5EgaHgFcOYtDA8gAG5Mi+XKw
        aZ9Wa5GCJXX0zvocIzFDJy2RA
X-Received: by 2002:a05:6808:1b12:b0:354:a089:1998 with SMTP id bx18-20020a0568081b1200b00354a0891998mr150713oib.9.1665675452095;
        Thu, 13 Oct 2022 08:37:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6yjHx5WKkTxDmnf9BkOTj1JV+8H3boJ42+MTYhu1d27xRvNYYoqWqfZtJP/7wopOxXoTlmHw==
X-Received: by 2002:a05:6808:1b12:b0:354:a089:1998 with SMTP id bx18-20020a0568081b1200b00354a0891998mr150697oib.9.1665675451855;
        Thu, 13 Oct 2022 08:37:31 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id r2-20020a4a83c2000000b004809c78083asm872774oog.25.2022.10.13.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:37:31 -0700 (PDT)
Date:   Thu, 13 Oct 2022 08:37:30 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Message-ID: <20221013153730.rwtukjgpdgwgfodv@cantor>
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

I don't know how many other drivers there will be in the future,
so quite possibly a non-issue. It did happen with the idxd driver
though, and I was thinking about that this morning so thought I
would send a patch to avoid it in the future.

Regards,
Jerry

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

