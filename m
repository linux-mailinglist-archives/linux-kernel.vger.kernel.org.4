Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB06EC3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjDXCo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXCoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:44:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCA1114
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682304263; x=1713840263;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k27B1ipAQkQd60Tjqvyx1KKy9XwjNqmqc36Yae9K9/s=;
  b=DlVDqsu5JXAOsrt7/Fqw/oNlxpFApLO4/XeJneIAUekHl0w7q6fltSXL
   JyfWObBN49zodEdpy7VXqn54daZUPZfY5mJrZdgOxaISEwdFCQKNhydvP
   nxD2bWCBy/k7BRTFRhlyDeKFFg7X6BkhXi6hqer6v/3cQ94VRfNIy6NlT
   O6HDSo1uNm9+i5T7lduRzzk2OHQ2LAlp63o/O0l+pXDjqLSHAW+we4gsn
   pM5hatfFWi7pJc2mG1Qv7fnvqb7lwZyloSBdOWad96l2FPuHatkvYYCKw
   jtn8bbqSVcNiouiYZv0w2Nv3OCTdtQFPVi+dPvgSSyV0wlneyu3FdFnTh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="325947972"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="325947972"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 19:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="686615186"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="686615186"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2023 19:44:16 -0700
Message-ID: <17342260-0795-9636-8408-0ca0d6c50403@linux.intel.com>
Date:   Mon, 24 Apr 2023 10:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, robin.murphy@arm.com,
        eric.auger@redhat.com, yi.l.liu@intel.com, will@kernel.org,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] iommufd: Add IOMMUFD_CMD_DEVICE_SET_DATA and
 IOMMUFD_CMD_DEVICE_UNSET_DATA
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        kevin.tian@intel.com
References: <cover.1682234302.git.nicolinc@nvidia.com>
 <08604f9f4835d5a6b0d2d75de69722194abf7747.1682234302.git.nicolinc@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <08604f9f4835d5a6b0d2d75de69722194abf7747.1682234302.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/23 3:40 PM, Nicolin Chen wrote:
> Add a new pair of ioctls to allow user space to set and unset its iommu-
> specific device data for a passthrough device that's behind the iommu.
> 
> On platforms with SMMUv3, this new uAPIs will be used to forward a user
> space virtual Stream ID of a passthrough device to link to its physical
> Stream ID and log into a lookup table, in order for the host kernel to
> later run sanity on ATC invalidation requests from the user space, with
> ATC_INV commands that have SID fields (virtual Stream IDs).
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/device.c          | 81 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  3 +
>   drivers/iommu/iommufd/main.c            |  4 ++
>   include/uapi/linux/iommufd.h            | 32 ++++++++++
>   4 files changed, 120 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index c649a3403797..9480cd36a8bd 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -136,6 +136,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   	struct iommufd_device *idev =
>   		container_of(obj, struct iommufd_device, obj);
>   
> +	if (WARN_ON(idev->has_user_data))
> +		dev_iommu_ops(idev->dev)->unset_dev_user_data(idev->dev);

Do you really need this WARN_ON()? The user space application can easily
trigger this kernel WARN() by setting the user data and forgetting to
unset it.

Best regards,
baolu
