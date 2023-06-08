Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81D9727511
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjFHCkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjFHCkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:40:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67D13D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686192035; x=1717728035;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Irsk2p/RD2Z8gMtL+6Cvp6rDMB9fErH7tDvNO2pvfes=;
  b=a5gZI/xmR9fzPz8IfVv2IUoA3hGZQu+gLloSXZZOccOVk4o9TiswIR05
   kCBs3+MPLEncRYeti2kBiFwrP4Zsw16dfFjNAcVxyOUNaW6ppVpC+RBx7
   wqPaNC6HKmEbtDeZSaOcIO71fiQDOtlAY3uPknfuAOjAkMLdGF9NUvM3n
   YPIqc5YMKGMK6ZloHIFW9IaofUh+oJNmgi6+544gM3LDwUszjPU5iiZxc
   zW5lwRHjwBjbnYhVjURR3X8NWAyD7X7tyU4LitfSIc24uAvYB2aIp282H
   0+i7or1KRnkDxXhCeFOHEo27IFItpm5v/F8lrv/C9Kea5Ml/KSqliwJ0E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360509287"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="360509287"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 19:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709782120"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="709782120"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2023 19:40:30 -0700
Message-ID: <f0a691fa-d050-f457-9c8d-0ae340eab58f@linux.intel.com>
Date:   Thu, 8 Jun 2023 10:39:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Michael Shavit <mshavit@google.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com> <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZIBxPd1/JCAle6yP@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 7:59 PM, Jason Gunthorpe wrote:
> On Wed, Jun 07, 2023 at 12:06:07AM +0530, Michael Shavit wrote:
>>> What we definately shouldn't do is try to have different SVA
>>> iommu_domain's pointing at the same ASID. That is again making SVA
>>> special, which we are trying to get away from 😄
>> Fwiw, this change is preserving the status-quo in that regard;
>> arm-smmu-v3-sva.c is already doing this. But yes, I agree that
>> resolving the limitation is a better long term solution... and
>> something I can try to look at further.
> I suppose we also don't really have a entirely clear picture what
> allocating multiple SVA domains should even do in the iommu driver.
> 
> The driver would like to share the ASID, but things are much cleaner
> for everything if the driver model has ASID 1:1 with the iommu_domain.

This means that each ASID should be mapped to a single IOMMU domain.
This is conceptually right as iommu_domain represents a hardware page
table. For SVA, it's an mm_struct.

So in my mind, each sva_domain should have a 1:1 relationship with an
mm_struct. Each sva_domain could have a 1:N relationship with ASID (or
PCI PASID), but in current implementation, it's a 1:1 relationship due
to the current global pasid policy for SVA.

> 
> It suggests we are missing some core code in iommu_sva_bind_device()
> to try to re-use existing SVA iommu_domains. This would certainly be
> better than trying to teach every driver how to share and refcount
> its ASID concept...
> 
> Today we have this super hacky iommu_get_domain_for_dev_pasid()
> thing that allows SVA domain reuse for a single device.
> 
> Possibly what we should do is conver the u32 pasid in the mm_struct to
> a struct iommu_mm_data * and put alot more stuff in there. eg a linked
> list of all SVA domains.

I don't quite follow "a linked list of all SVA domains". If my above
understanding is correct, then there should be a single sva_domain for
each mm_struct. The iommu_sva_domain_alloc() takes the responsibility to
allocate/free and refcount the sva domain. The sva bind code could
simply:

	domain = iommu_get_sva_domain(dev, mm);
	iommu_attach_device_pasid(domain, dev, pasid);

and the sva unbind code:

	iommu_detach_device_pasid(domain, dev, pasid);
	iommu_put_sva_domain(domain);

Perhaps, we can further drop struct iommu_sva and make the sva
bind/unbind interfaces to return the sva domain instead?

Best regards,
baolu
