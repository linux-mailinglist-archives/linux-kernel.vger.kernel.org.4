Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE88C5E5864
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiIVCIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiIVCIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:08:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06BFA1A77;
        Wed, 21 Sep 2022 19:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663812527; x=1695348527;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1fDpa6Vp9wv2YOhKIYkfzYhHIef9thojyzjgWC31CW0=;
  b=aLL3TzERhUsCeCycGJ6DUqxPx2pnpQ+ivEAKsTefw9H1r+Z1M03a3n5N
   TGBB61YgOodl7L6EKv3ZBtYWuiFAxKZm6urq5wCbz1aGrVeXXlvrw4Lj2
   qB652AQT53OpIdH8aENJZ81l4S/jBV8ZzkSa53fiOdCdgBFBzr3UGshg3
   7Xi4RXk4QlQcFLtOMwajFmjRwBlplz2e7E2egzND2zVTMIHu25ixBSi0z
   WXAxSepHz0m8SwBsD1ri/K0k58Asy2BgZLEm9QRHh7YjDxs5EKqV2Mmt/
   Cwxu3LuV+KXHfjpXH9sq+ggKM5GFfCMbXVw9yY70s6XSYY5z7oU5N0ywb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="280544783"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="280544783"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 19:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="794907643"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2022 19:08:37 -0700
Message-ID: <73008702-87e1-688f-b194-c259c9c03caa@linux.intel.com>
Date:   Thu, 22 Sep 2022 10:02:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
        konrad.dybcio@somainline.org, yong.wu@mediatek.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        tglx@linutronix.de, shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
        quic_saipraka@quicinc.com, jon@solid-run.com,
        yangyingliang@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 3/6] iommu: Add return value rules to attach_dev op and
 APIs
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, robdclark@gmail.com, dwmw2@infradead.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        matthias.bgg@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jean-philippe@linaro.org, sricharan@codeaurora.org
References: <cover.1663744983.git.nicolinc@nvidia.com>
 <8c3dbf153b63a3002a46bab6e707c63fd8635bb8.1663744983.git.nicolinc@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8c3dbf153b63a3002a46bab6e707c63fd8635bb8.1663744983.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 4:23 PM, Nicolin Chen wrote:
> Cases like VFIO wish to attach a device to an existing domain that was
> not allocated specifically from the device. This raises a condition
> where the IOMMU driver can fail the domain attach because the domain and
> device are incompatible with each other.
> 
> This is a soft failure that can be resolved by using a different domain.
> 
> Provide a dedicated errno EINVAL from the IOMMU driver during attach that
> the reason why the attach failed is because of domain incompatibility.
> 
> VFIO can use this to know that the attach is a soft failure and it should
> continue searching. Otherwise, the attach will be a hard failure and VFIO
> will return the code to userspace.
> 
> Update kdocs to add rules of return value to the attach_dev op and APIs.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
>   include/linux/iommu.h | 12 ++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3a808146b50f..1d1e32aeaae6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1975,6 +1975,17 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> +/**
> + * iommu_attach_device - Attach a device to an IOMMU domain

Normally we say "attach an iommu domain to a device/group ...".

Best regards,
baolu
