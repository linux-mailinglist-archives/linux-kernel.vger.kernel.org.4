Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9D634F55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiKWFEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiKWFD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:03:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C5E9338
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669179838; x=1700715838;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=piSeHphfFBUuFKj955dzRIMO4eKHzZ6VALiFWXwyXUo=;
  b=K6iP0TWGyTcVYXDkDUQH0Z69msbvVOdS8Qt7c+WTtSTVTCmDbArCG6PO
   K4rUqHnNcG9l51goWal78yYa0vaz1+1Khmx2wEqoi+89C/hCr8jb1g1M9
   Fgnk+u1zqraeWa2n8BX3O7OeCP4+jtp73X506zWW/fBDJ9oAX+xM7TY9Q
   ZU31RDS4BD23T898mV/HlS2mBvudtWBJaC+rlKSGkITPQiQRznRy1vizm
   UAEs51vk6AtxxuKDn5KI/DClzcdMHvXDBHX3YMUdwZetBTV9ehdfBbfYw
   k8ddG0RjWx09+NQm4gq6Z9gCz2E0qc2dE4kD+s+gv3+bapxZBp2NxrxFP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="311609414"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="311609414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 21:03:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816348905"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="816348905"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.242]) ([10.254.213.242])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 21:03:54 -0800
Message-ID: <c085f67d-7874-4a83-a12c-703d1638d940@linux.intel.com>
Date:   Wed, 23 Nov 2022 13:03:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>
References: <20221122034529.3311562-1-jacob.jun.pan@linux.intel.com>
 <bc647ceb-b14b-dc5b-ba83-4f8befd188c5@arm.com>
 <BN9PR11MB527620902046A4339EAACD3F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
In-Reply-To: <BN9PR11MB527620902046A4339EAACD3F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/23 9:02, Tian, Kevin wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: Wednesday, November 23, 2022 1:49 AM
>>
>>> +
>>> +/* Impacted QAT device IDs ranging from 0x4940 to 0x4943 */
>>> +#define BUGGY_QAT_DEVID_MASK 0x494c
>>> +static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
>>> +{
>>> +	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
>>> +		return false;
>>> +
>>> +	if ((pdev->device & 0xfffc) != BUGGY_QAT_DEVID_MASK)
>>> +		return false;
>>> +
>>> +	if (risky_device(pdev))
>>> +		return false;
>>
>> Hmm, I'm not sure that that makes much sense to me - what privilege can
>> the device gain from being told to invalidate things twice? Why would we
>> want to implicitly *allow* a device to potentially keep using a stale
>> translation if for some bizarre reason firmware has marked it as
>> external, surely that's worse?

 From the perspective of IOMMU, any quirk is only applicable to trusted
devices. If the IOMMU driver detects that a quirk is being applied to an
untrusted device, it is already buggy or malicious. The IOMMU driver
should let the users know by:

	pci_info(pdev,
		 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
		 pdev->vendor, pdev->device);
	pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");

and stop applying any quirk.

>>
> 
> ATS is disabled for such device hence no dtlb at all.
> 
> bool pci_ats_supported(struct pci_dev *dev)
> {
> 	if (!dev->ats_cap)
> 		return false;
> 
> 	return (dev->untrusted == 0);
> }
> 
> So above check doesn't make things worse. It's kind of meaningless
> but according to Baolu he wants that check in every quirk...

At some time in the future, the hardware may support kind of enhanced
ATS (or Secure ATS). At that time, above condition may be changed.

Best regards,
baolu
