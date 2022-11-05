Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6376E61A71B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKEC7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKEC7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:59:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216074298E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667617153; x=1699153153;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nA2ZpvvMkG9bg091jxopQ0FeyEazlYwoknqAfV6Z4bo=;
  b=MW8eJGurMMIcmwrGzmDUg8ELXUEGYf+JIifcelUJJNGjoQ77J2irN7yC
   2h9KIrSArIvYCRcJo4/AJr75574oXbGVc/TZHZldMPTl7MT4JoPzgwhIo
   nH63ZcGKekTHDSVdRflOdenSRY+/nBCjXrLZ8K9XIe1D54UH14vKldJCf
   6MMzkdbNB88jbuLzip/q2YFuMy5ksU2CtSG8BqHqlr8NaW4buOECpOWWR
   pZrw3LmqecgsEsORwHgNlu3D1zgTDvBqn1QLpdcrlhwnQymYFc/l2FC/J
   ZOqDRjyXSclbsSueejKd6NUsyz5ZlaPWouqzv1qEXRN+85nYyOia5KI62
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311868882"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="311868882"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 19:59:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="964554646"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="964554646"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.180]) ([10.254.213.180])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 19:59:10 -0700
Message-ID: <3dac436c-29e1-de3d-85f3-67e8af608124@linux.intel.com>
Date:   Sat, 5 Nov 2022 10:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] iommu/vt-d: Use device_block_translation() in
 dev_attach error path
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52763EB6CDF2E171210D04E48C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f6ee3ad3-0e75-2bc0-d03d-c2456ed6620a@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f6ee3ad3-0e75-2bc0-d03d-c2456ed6620a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/5 10:09, Baolu Lu wrote:
>>
>> btw this change is partial. @attach_dev still calls 
>> iommu_enable_pci_caps()
>> which always tries to enable PCI capabilities w/o checking whether they
>> have been enabled or not. Then user will hit -EBUSY when related PCI
>> helpers are called.
> 
> Good catch!
> 
> How about moving iommu_enable/disable_pci_caps() into
> iommu_probe/release_device() path? I may look into details if there's no
> significant arch gaps.

After reconsideration, it seems that this is not a feasible solution.
This changes the order in which PCI devices enable DMA.In addition, for
the kdump kernel, this is not feasible because there may be on-going DMA
on the device.

Perhaps I can make the iommu_enable_pci_caps() reentrant.

Best regards,
baolu
