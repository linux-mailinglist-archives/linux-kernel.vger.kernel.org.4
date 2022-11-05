Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2282D61A6C8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKEByz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEBys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:54:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953052CDE3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667613287; x=1699149287;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=BWyOVHcYjGNHgPgYJFQZxzrNVguTi2BzFshMjf3Fowo=;
  b=Ut9CajyzCxQiMzCh6CWby8463V0F7WaNLOBSljF32rNmLsakvLb/gBSp
   9GzXKpXu5zq+h3THFib6ooUFNdC6UiI7DgOMAOKsSyVLPbjdjg70s2hjO
   FIPXzg5vl0D7/Dn/YTOaPjOgWmX3P1VsFODmBI9BN5rYARNcd1fKBYbx7
   GXWdLeO1OMYH64LdPy32Qtnat2k0I81P8y6/p7+BaSD1MTuxnR/sHX4L2
   TeSiAgETlpygAUFY2kK9EoYEbEaWIUtm7hgd6h+tMmPvVLBvuBqE3JByJ
   uFmVz/71Eo0dNELpBax5ZoPBOXOJ9TX8COf+Fmpd3vmhHsaCwXEy8Fz2F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="289837722"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="289837722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:54:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="666568585"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="666568585"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.180]) ([10.254.213.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:54:44 -0700
Message-ID: <5e9bf515-0d3a-9c4e-69b7-820b14979f6b@linux.intel.com>
Date:   Sat, 5 Nov 2022 09:54:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C5A49961FA71CC7881428C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/7] iommu/vt-d: Add blocking domain support
In-Reply-To: <BN9PR11MB5276C5A49961FA71CC7881428C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/4 10:11, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 3, 2022 1:53 PM
>>
>> +/*
>> + * Clear the page table pointer in context or pasid table entries so that
>> + * all DMA requests without PASID from the device are blocked. If the page
>> + * table has been set, clean up the data structures.
>> + */
>> +static void device_block_translation(struct device *dev)
> 
> given this helper will be used both by existing paths and the new block
> domain, it makes more sense to have it work with existing paths first
> i.e. merging with patch3 and then add block domain after.

Yes. Sounds good.

> 
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	unsigned long flags;
>> +
>> +	if (!dev_is_real_dma_subdevice(dev)) {
>> +		if (sm_supported(iommu))
>> +			intel_pasid_tear_down_entry(iommu, dev,
>> +						    PASID_RID2PASID, false);
> 
> Since commit 4140d77a aliases devices don't share pasid table,
> which implies that pci_for_each_dma_alias() is required as did
> in domain_context_clear().

The PCI alias devices have already been covered by the iommu group
concept in the iommu core. On the contrary, I've been thinking about
retiring pci_for_each_dma_alias() in domain_context_clear().



> 
>> +		else
>> +			domain_context_clear(info);
>> +	}
>> +
>> +	if (!info->domain)
>> +		return;
>> +
>> +	spin_lock_irqsave(&info->domain->lock, flags);
>> +	list_del(&info->link);
>> +	spin_unlock_irqrestore(&info->domain->lock, flags);
>> +
>> +	domain_detach_iommu(info->domain, iommu);
>> +	info->domain = NULL;
>> +}
>> +

Best regards,
baolu
