Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59565FE6B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJNBwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNBwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:52:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639018982A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665712369; x=1697248369;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tvf1KEUmmFWCZG5Vqpb9xVTMOaAK+dTPvxZXl2xkreQ=;
  b=Wm5mtvnMIcHanNnbKfYNsFLrFdrjFzqG77pmOOVC7aLAVLgC0beql2Aw
   gT3c3TLGF+dLQCsfpN1JVdE0NUypKwEE20z5u0cORrgp2XC/hATPlREeD
   j2akybprrn7bDw+FFPD/pBUTnZe7xt5h0sbvxpR0hH73zi///1jblDQ5j
   uEtB+njd9zFLjDexpjXnSsxNlxoYaOq6+iTCaKXASy6k3fCSF4K4TefDb
   lzkq77zocHbU/COcHp75HQmTNwOTagj0A4d0G3QP4Q10WqxXDxzRsGh7m
   bUaMDaz4taZ1kIXtRgUgEBs5Uk2KNGYaY4TUtYJiJHSXzA1Cm2CJzToG4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="305244853"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="305244853"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:52:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="627401441"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="627401441"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.33]) ([10.254.210.33])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:52:46 -0700
Message-ID: <89029bfb-bdf6-43e3-b24c-09c266277f0e@linux.intel.com>
Date:   Fri, 14 Oct 2022 09:52:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221013153355.2365865-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 23:33, Jerry Snitselaar wrote:
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
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4893c2429ca5..20ec75667529 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>   {
>   	struct iommu_group *group;
>   	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	const struct iommu_ops *ops;
> +
> +	if (!dev->iommu || !dev->iommu->iommu_dev) {
> +		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
> +			__func__);
> +		return ERR_PTR(-ENODEV);
> +	}

If that's the case, dev_iommu_ops() will warn a NULL pointer reference.
This kind of error will be discovered at the first place.

Best regards,
baolu

> +
> +	ops = dev_iommu_ops(dev);
>   
>   	if (!ops->sva_bind)
>   		return ERR_PTR(-ENODEV);
