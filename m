Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC361A6CF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKECJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKECJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:09:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050702C11F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667614189; x=1699150189;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=+LNSy0qKszqJbrPe5Z7NBJATYat40gCGeYFNFMZ4Dp8=;
  b=K+AHs1F7Eq9MUKVlHRw9lr6aGAFeSTwHgpZtpJtClNGALNgoxFAW6h3F
   mfr/g0EZksHqAIBjqqASjAHIE4bM5FK4MBaf5FjpSSN+XWT9AsMqEqTh8
   2NOf5rB++D5KBMNMRWmLc7rPRPz6cK8j45otfw3alUjqJRiOvnVOXhOeY
   I1MgLdBU1U8ADUGlKk/LF/DIpHnieHmx34EhXBexPhT/rFzhwNGM/HUdr
   fRBMYGzK87Jw6oKX64xnfZwSIuRLbAQXR9hiLXgQf9YglpKvd/Hl3btW5
   uy3gn5OrXA/xbo1TyXbUESpS8R4jrJ5e1j4iDrdKCax83i1RD30tNhp/+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="336822499"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="336822499"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 19:09:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668552592"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="668552592"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.180]) ([10.254.213.180])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 19:09:46 -0700
Message-ID: <f6ee3ad3-0e75-2bc0-d03d-c2456ed6620a@linux.intel.com>
Date:   Sat, 5 Nov 2022 10:09:44 +0800
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
 <20221103055329.633052-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52763EB6CDF2E171210D04E48C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/7] iommu/vt-d: Use device_block_translation() in
 dev_attach error path
In-Reply-To: <BN9PR11MB52763EB6CDF2E171210D04E48C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/4 10:18, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 3, 2022 1:53 PM
>>
>> If domain attaching to device fails, the IOMMU driver should bring the
>> device to blocking DMA state. The upper layer is expected to recover it
>> by attaching a new domain. Use device_block_translation() in the error
>> path of dev_attach to make the behavior specific.
>>
>> The difference between device_block_translation() and the previous
>> dmar_remove_one_dev_info() is that the latter disables PCIe ATS and the
>> related PCIe features. This is unnecessary as these features are not per
>> domain capabilities, disabling them during domain switching is
>> unnecessary.
> 
> well, the opposite argument is that when the DMA is blocked what is
> the point of enabling ATS/PRI on the device.

It's not "DMA is blocked", but "DMA without PASID is blocked". :-)

As above term implies, it's conceptually incorrect to disable ATS/PRI
only because DMA without PASID is about to blocked.

> 
> btw this change is partial. @attach_dev still calls iommu_enable_pci_caps()
> which always tries to enable PCI capabilities w/o checking whether they
> have been enabled or not. Then user will hit -EBUSY when related PCI
> helpers are called.

Good catch!

How about moving iommu_enable/disable_pci_caps() into
iommu_probe/release_device() path? I may look into details if there's no
significant arch gaps.

> 
> another difference worthy of pointing out is that in scalable mode it is
> the RID2PASID entry instead of context entry being cleared.

Yes. Will update the commit message.

Best regards,
baolu
