Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A20645A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiLGNSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLGNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:18:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B1EE23;
        Wed,  7 Dec 2022 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670419106; x=1701955106;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Lb5STIL8Ik7pLbD8CfdBIKK+PIMIjQezB8pSNdxlqFg=;
  b=c/qLsLi4yxabq/iixHwoAx/8Sa1DAxD1LMcpKgqHYnlK84Oe69SBADAX
   SnqEsAR9cmO6/o3J+hY6KoVxG6a6EhqVf2s0sPjb+aTXyINiIBH3P12Uj
   z+QKvxsLbsq11J4Mqc1Ypg0WqXAEgrIwQ7iBj4eXh6V38AGeD54pWRPGK
   GvUynQNy9ww5bBkjJrdVUhtHrvze8F0CGhJ25vvq4pke+/F1VmKjsQb6P
   odPnBVk3JjbhU9yYibFXPUEmhl3sdJrIeG+qJuki6exR1hO52/VjFAITZ
   lVTn8mcR+0xqC8uu0pj1UMzgUy5dWnPaokwvJYCNtGzdNMx1LPl+wxtU3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="403158348"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="403158348"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 05:18:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="648731486"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="648731486"
Received: from liming1-mobl1.ccr.corp.intel.com (HELO [10.254.215.192]) ([10.254.215.192])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 05:18:21 -0800
Message-ID: <f9433a12-eacd-9e6b-a517-c3be438193d1@linux.intel.com>
Date:   Wed, 7 Dec 2022 21:18:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
 <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
 <Y4TjWOXYD+DK+d/B@nvidia.com> <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
 <Y4ZCVgLO9AHatwXe@nvidia.com> <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
 <Y4Zm53o1ovdIAqr/@nvidia.com>
 <4b34be4433856d9a3a5bf13dad7a77c1ba93db13.camel@linux.ibm.com>
 <Y4/LsZKmR3iWFphU@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
In-Reply-To: <Y4/LsZKmR3iWFphU@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/7 7:09, Jason Gunthorpe wrote:
>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>   				      const char *buf, size_t count)
>   {
> -	struct group_device *grp_dev;
> -	struct device *dev;
> -	int ret, req_type;
> +	enum dma_api_policy policy;
> +	int ret;
>   
>   	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>   		return -EACCES;
> @@ -2977,77 +2907,30 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>   		return -EINVAL;
>   
>   	if (sysfs_streq(buf, "identity"))
> -		req_type = IOMMU_DOMAIN_IDENTITY;
> +		policy = DMA_API_POLICY_IDENTITY;
>   	else if (sysfs_streq(buf, "DMA"))
> -		req_type = IOMMU_DOMAIN_DMA;
> +		policy = DMA_API_POLICY_STRICT;
>   	else if (sysfs_streq(buf, "DMA-FQ"))
> -		req_type = IOMMU_DOMAIN_DMA_FQ;
> +		policy = DMA_API_POLICY_LAZY;
>   	else if (sysfs_streq(buf, "auto"))
> -		req_type = 0;
> +		policy = DMA_API_POLICY_ANY;
>   	else
>   		return -EINVAL;
>   
>   	/*
> -	 * Lock/Unlock the group mutex here before device lock to
> -	 * 1. Make sure that the iommu group has only one device (this is a
> -	 *    prerequisite for step 2)
> -	 * 2. Get struct *dev which is needed to lock device
> -	 */
> -	mutex_lock(&group->mutex);
> -	if (iommu_group_device_count(group) != 1) {
> -		mutex_unlock(&group->mutex);
> -		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Since group has only one device */
> -	grp_dev = list_first_entry(&group->devices, struct group_device, list);
> -	dev = grp_dev->dev;
> -	get_device(dev);
> -
> -	/*
> -	 * Don't hold the group mutex because taking group mutex first and then
> -	 * the device lock could potentially cause a deadlock as below. Assume
> -	 * two threads T1 and T2. T1 is trying to change default domain of an
> -	 * iommu group and T2 is trying to hot unplug a device or release [1] VF
> -	 * of a PCIe device which is in the same iommu group. T1 takes group
> -	 * mutex and before it could take device lock assume T2 has taken device
> -	 * lock and is yet to take group mutex. Now, both the threads will be
> -	 * waiting for the other thread to release lock. Below, lock order was
> -	 * suggested.
> -	 * device_lock(dev);
> -	 *	mutex_lock(&group->mutex);
> -	 *		iommu_change_dev_def_domain();
> -	 *	mutex_unlock(&group->mutex);
> -	 * device_unlock(dev);
> -	 *
> -	 * [1] Typical device release path
> -	 * device_lock() from device/driver core code
> -	 *  -> bus_notifier()
> -	 *   -> iommu_bus_notifier()
> -	 *    -> iommu_release_device()
> -	 *     -> ops->release_device() vendor driver calls back iommu core code
> -	 *      -> mutex_lock() from iommu core code
> +	 * Taking ownership disables the DMA API domain, prevents drivers from
> +	 * being attached, and switches to a blocking domain. Releasing
> +	 * ownership will put back the new or original DMA API domain.
>   	 */
> -	mutex_unlock(&group->mutex);
> -
> -	/* Check if the device in the group still has a driver bound to it */
> -	device_lock(dev);

With device_lock() removed, this probably races with the
iommu_release_device() path? group->mutex seems insufficient to avoid
the race. Perhaps I missed anything.

> -	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
> -	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
> -		pr_err_ratelimited("Device is still bound to driver\n");
> -		ret = -EBUSY;
> -		goto out;
> -	}
> -
> -	ret = iommu_change_dev_def_domain(group, dev, req_type);
> -	ret = ret ?: count;
> -
> -out:
> -	device_unlock(dev);
> -	put_device(dev);
> +	ret = iommu_group_claim_dma_owner(group, &ret);
> +	if (ret)
> +		return ret;
>   
> -	return ret;
> +	ret = iommu_change_group_dma_api_policy(group, policy);
> +	iommu_group_release_dma_owner(group);
> +	if (ret)
> +		return ret;
> +	return count;
>   }
>   
>   static bool iommu_is_default_domain(struct iommu_group *group)

Best regards,
baolu
