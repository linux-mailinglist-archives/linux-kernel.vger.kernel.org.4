Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4371074E479
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGKCwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjGKCwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:52:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9501AC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689043950; x=1720579950;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=noYdFbvgl9Bp6GQUz/5z8WucJ+NOT94UdQ0ZDvr+XtI=;
  b=WwBFZRrPFVBMuD55EnypEacEFZroXsgjNYLwHQY1t0fxZ49EVwpUrdLc
   f7lXhSEbRtyZoJW4vlQA48AokaCfJWLvbVocwOA+92+jPzCwtKWGzls4L
   GVLQZnVYZtgJTO2cObUPlxJw/ZLdaT5czY7y2OFxHMYbeGDI3POKUi6Zj
   Xz0FSqrq44UiG5I7HjzzTrch9iXWjYLFrDCkEndTMjcg8xBdDzPQ28cg9
   akbCghKw/AHfuWbeCUdCz/uwmGpMAgo+nlNK7X+BAyaKH+SvHIj2ZOqC5
   LQ/R99y8oAAzPMGFcap28jStTmRszUpT6nx0QwfEigs0QZYbe1s61jrRh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="363374627"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="363374627"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="791022671"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="791022671"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.35]) ([10.252.187.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:52:26 -0700
Message-ID: <e3146447-6af8-9049-e951-915e2770988b@linux.intel.com>
Date:   Tue, 11 Jul 2023 10:52:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Content-Language: en-US
To:     "Liu, Jingqi" <jingqi.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
 <BN9PR11MB5276885D6A142BC94D80C2618C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4f18a7ca-3a57-0097-51f0-490f876831dc@intel.com>
 <BN9PR11MB5276ECF766C4F89F5083992F8C2EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f2f23ca1-0881-4601-7ea5-c5e42ab83f62@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f2f23ca1-0881-4601-7ea5-c5e42ab83f62@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/11 9:40, Liu, Jingqi wrote:
> On 7/4/2023 3:54 PM, Tian, Kevin wrote:
>>> From: Liu, Jingqi <jingqi.liu@intel.com>
>>> Sent: Monday, July 3, 2023 10:37 PM
>>>
>>> On 7/3/2023 3:15 PM, Tian, Kevin wrote:
>>>>> From: Liu, Jingqi <jingqi.liu@intel.com>
>>>>> Sent: Sunday, June 25, 2023 11:05 PM
>>>>>
>>>>> The original debugfs only dumps all IOMMU page tables without pasid
>>>>> supported. It traverses all devices on the pci bus, then dumps all 
>>>>> page
>>>>> tables based on device domains. This traversal is from software
>>>>> perspective.
>>>>>
>>>>> This series dumps page tables by traversing root tables, context 
>>>>> tables,
>>>>> pasid directories and pasid tables from hardware perspective. By
>>>>> specifying source identifier and PASID, it supports dumping specified
>>>>> page table or all page tables in legacy mode or scalable mode.
>>>>>
>>>>> For a device that only supports legacy mode, specify the source
>>>>> identifier, and search the root table and context table to dump its
>>>>> page table. It does not support to specify PASID.
>>>>>
>>>>> For a device that supports scalable mode, specify a
>>>>> {source identifier, PASID} pair and search the root table, context 
>>>>> table
>>>>> and pasid table to dump its page table.  If the pasid is not 
>>>>> specified,
>>>>> it is set to RID_PASID.
>>>>>
>>>>> Switch to dump all page tables by specifying "auto".
>>>>>
>>>>> Examples are as follows:
>>>>> 1) Dump the page table of device "00:1f.0" that only supports legacy
>>>>> mode.
>>>>>
>>>>> $ sudo echo 00:1f.0 >
>>>>> /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>>> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>>> Device 0000:00:1f.0 @0x105407000
>>>>> IOVA_PFN                PML5E                   PML4E
>>>>> 0x0000000000000 |       0x0000000000000000      0x0000000105408003
>>>>> 0x0000000000001 |       0x0000000000000000      0x0000000105408003
>>>>> 0x0000000000002 |       0x0000000000000000      0x0000000105408003
>>>>> 0x0000000000003 |       0x0000000000000000      0x0000000105408003
>>>>>
>>>>> PDPE                    PDE                     PTE
>>>>> 0x0000000105409003      0x000000010540a003      0x0000000000000003
>>>>> 0x0000000105409003      0x000000010540a003      0x0000000000001003
>>>>> 0x0000000105409003      0x000000010540a003      0x0000000000002003
>>>>> 0x0000000105409003      0x000000010540a003      0x0000000000003003
>>>>>
>>>>> [...]
>>>>>
>>>>> 2) Dump the page table of device "00:0a.0" with pasid "2".
>>>>>
>>>>> $ sudo echo 00:0a.0,2 >
>>>>> /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>>> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>> What about creating a directory layout per {dev, pasid} so the user can
>>>> easily figure out and dump?
>>>>
>>>> e.g.
>>>>
>>>> /sys/kernel/debug/iommu/intel/00:0a.0/0/domain_translation_struct
>>>> /sys/kernel/debug/iommu/intel/00:0a.0/2/domain_translation_struct
>>> Thanks.
>>>
>>> Do you mean create a directory for each device, whether it supports
>>> PASID or not ?
>> every device has PASID#0 valid, i.e. RID2PASID.
> Sorry for the late response.
> Got it. Thanks.
>>> Seems the PASID can be assigned at runtime.
>>> So it needs to support creating debugfs file at runtime in IOMMU driver.
>>> Looks like this requires modifying IOMMU driver.
>>>
>> Isn't this patch trying to modify the driver?
> I just tried not to modify the driver except debugfs.
> I'll try this implementation.

I'd second Kevin's suggestion.

If you check how usb xhci dumps its contexts for devices, you can see
the similar scheme.

# ls /sys/kernel/debug/usb/xhci/0000:00:14.0/devices
01  02  03  04  05

In our case, pasid 0 is special which denotes the domain attached to the
RID.

Best regards,
baolu
