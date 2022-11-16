Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26E62B470
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiKPICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiKPICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:02:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5569626D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668585770; x=1700121770;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=P7XmQDqtWN3uGybclt/6TjW9vIWa6aTdjZL3gss/tJE=;
  b=OrMeHq7jqRhNsZtexyxCetV3tWDbQ7jOhU0bUEdVmslYrgwT6HzXY17a
   /P1P9C05mxeetlDYwReWzCEXY7LvQ2wtradkWm/8UF8+f0BUo8riUCcUp
   khMQFC429sSlzqv3fpEkjYdud0YouWLseC2ZZriyUK8MwtBzFTcoPEO71
   Zi+hXMA2FzhNFvOisO+l9HFUca8MyEPA7k6s14nWzpFvUp6CfCtnuqs83
   KuD1+9IgTQZ50Wdw9NDj5nS4kdEBXhJTv27OAq1r9AVB+f0+7L/OyPRHH
   D/f0MUyy3xQvamj0bUhTSRrvg/RnaFNK8zeiP/a1s7769yomPSws0QcSi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="295846195"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295846195"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:02:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672303490"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="672303490"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.114]) ([10.254.212.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 00:02:48 -0800
Message-ID: <ebace32b-be36-5c9f-579b-211cad75df02@linux.intel.com>
Date:   Wed, 16 Nov 2022 16:02:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-5-baolu.lu@linux.intel.com>
 <BN9PR11MB527668E6C7666CAA5F0804428C079@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e7c686d7-bad9-b58b-3be4-50898e142230@linux.intel.com>
 <BL1PR11MB5271F0D4E91A3F6179216ADA8C079@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
In-Reply-To: <BL1PR11MB5271F0D4E91A3F6179216ADA8C079@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/16 13:35, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, November 16, 2022 12:36 PM
>>
>> On 11/16/22 11:53 AM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Monday, November 14, 2022 9:41 AM
>>>> @@ -4562,7 +4538,10 @@ static void intel_iommu_release_device(struct
>>>> device *dev)
>>>>    {
>>>>    	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>>
>>>> -	dmar_remove_one_dev_info(dev);
>>>> +	iommu_disable_pci_caps(info);
>>>> +	domain_context_clear(info);
>>>> +	device_block_translation(dev);
>>> clear context after blocking translation.
>> Unfortunately domain_context_clear() needs reference to info->domain
>> (for domain id when flushing cache), which is cleared in
>> device_block_translation().
>>
> this sounds an ordering problem. clearing context should be after
> blocking translation in concept.

At present, when the default domain is attached to the device, we first
populate the pasid table entry, and then populate the device context
entry. Above code is just the reverse operation.

Can you see any practical problems caused by this sequence? If so, it
seems that we should carefully consider whether such problems already
exist.

Best regards,
baolu
