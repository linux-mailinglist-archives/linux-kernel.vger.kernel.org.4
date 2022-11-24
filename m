Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484AE6370B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiKXC7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKXC7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:59:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2706360EB4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669258785; x=1700794785;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IufW+4kjNCCmY+c/Fvrz1m8hLDQrCXBRYM8ney2fuHY=;
  b=AS194wPdk5WKTfes2IhPyAw9YkxUtAvrVdZTn4iIXdc2zaVtAEC6cag6
   d7GJ51zBN7mMuZjjqOl2L6NdaVW4k4h97gf9aUANPfeZuKpKrP3MlxKh+
   LbE3XY1VIqLEdBIzWmPcXniKvLumUOp1bhqI3rszyXtJK4B/tiAd2MHwS
   VS8mvcZ/nfRdhHJ9RVSl2njhPfoGEdkM9K1gybns+o2JjvQrjdICbL1t1
   vD7jTdnjI3YL4k10rRyZ4E/cDFnqQaqrRbVfcZ+gw9CZzEF9yumX2JjMG
   w7QCRALAAf6VbVrCSPlb+NX5P2STMwoysZ83WZ9Qjqn5esziJzPwi5WMg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="297562764"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="297562764"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 18:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="644327084"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="644327084"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2022 18:59:38 -0800
Message-ID: <992ba86c-73e6-8db0-0216-c2a8b7d1f58f@linux.intel.com>
Date:   Thu, 24 Nov 2022 10:52:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Add a fix for devices need extra dtlb flush
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>
References: <20221122034529.3311562-1-jacob.jun.pan@linux.intel.com>
 <bc647ceb-b14b-dc5b-ba83-4f8befd188c5@arm.com>
 <BN9PR11MB527620902046A4339EAACD3F8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c085f67d-7874-4a83-a12c-703d1638d940@linux.intel.com>
 <BN9PR11MB527642B1DA920C78742036FD8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <53678e27-1bbc-a7e8-a1b0-0427fc0e5b62@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <53678e27-1bbc-a7e8-a1b0-0427fc0e5b62@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 7:32 PM, Robin Murphy wrote:
> On 2022-11-23 05:18, Tian, Kevin wrote:
>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>> Sent: Wednesday, November 23, 2022 1:04 PM
>>>
>>> On 2022/11/23 9:02, Tian, Kevin wrote:
>>>>> From: Robin Murphy <robin.murphy@arm.com>
>>>>> Sent: Wednesday, November 23, 2022 1:49 AM
>>>>>
>>>>>> +
>>>>>> +/* Impacted QAT device IDs ranging from 0x4940 to 0x4943 */
>>>>>> +#define BUGGY_QAT_DEVID_MASK 0x494c
>>>>>> +static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
>>>>>> +{
>>>>>> +    if (pdev->vendor != PCI_VENDOR_ID_INTEL)
>>>>>> +        return false;
>>>>>> +
>>>>>> +    if ((pdev->device & 0xfffc) != BUGGY_QAT_DEVID_MASK)
>>>>>> +        return false;
>>>>>> +
>>>>>> +    if (risky_device(pdev))
>>>>>> +        return false;
>>>>>
>>>>> Hmm, I'm not sure that that makes much sense to me - what privilege 
>>>>> can
>>>>> the device gain from being told to invalidate things twice? Why 
>>>>> would we
>>>>> want to implicitly *allow* a device to potentially keep using a stale
>>>>> translation if for some bizarre reason firmware has marked it as
>>>>> external, surely that's worse?
>>>
>>>   From the perspective of IOMMU, any quirk is only applicable to trusted
>>> devices. If the IOMMU driver detects that a quirk is being applied to an
>>> untrusted device, it is already buggy or malicious. The IOMMU driver
>>> should let the users know by:
>>>
>>>     pci_info(pdev,
>>>          "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted
>>> PCI link\n",
>>>          pdev->vendor, pdev->device);
>>>     pci_info(pdev, "Please check with your BIOS/Platform vendor about
>>> this\n");
>>>
>>> and stop applying any quirk.
>>>
>>
>> A quirk usually relaxes something then you want it only on trusted 
>> devices.
>>
>> but the quirk in this patch is trying to fix a vulnerability. In 
>> concept it's
>> weird to skip it on untrusted devices. This iiuc was the part causing 
>> confusion
>> to Robin.
> 
> Right, it's that reasoning in general that seems bogus to me. Clearly 
> any quirk that effectively grants additional privileges, like an 
> identity mapping quirk, should not be applied to untrusted external 
> devices which may be spoofing an affected VID/DID to gain that 
> privilege, but not all quirks imply privilege. If, say, a WiFI 
> controller needs something innocuous like a DMA alias or address width 
> quirk to function correctly, it will still need that regardless of 
> whether it's soldered to a motherboard or to a removable expansion card, 
> and it would do nobody any good to deny correct functionality based on 
> that unnecessary distinction. Yes, I appreciate that in practice many of 
> those kind of quirks will be applied in other layers anyway, but I still 
> think it's wrong to make a sweeping assumption that all IOMMU-level 
> quirks are precious treasure not to be shared with outsiders, rather 
> than assess their impact individually. The detriment in this case is 
> small (just needless code churn), but even that's still not nothing.

Fair enough. I agreed here.

Can we put some comments here so that people can still easily read the
discussion here after a long time?

Best regards,
baolu
