Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663DB6224E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKIHuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKIHuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:50:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C43E101EE;
        Tue,  8 Nov 2022 23:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667980215; x=1699516215;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ie1lA+6hSXO9sv+rlIoCp+X4g+fMUMvw41kgHA+o76g=;
  b=bQj0+IblsX0HIl12m6epmkbxxm2AjTRpXS7C6HFA2d3d/W1NmfJ10SHB
   qOwJkY4yYepkyKO17WK+uToBj5o7n4XhfKAlgcriyt8OfsFkCN0kvxhEM
   PgtPqMGzBiPoFLMkyvC/9FptTQLNj+53tLJiT5apk2w2YefEFzBN4YOV3
   PKCbUrs2fpVwwEuRrBc0fAgDehJYxuKAkU2D12Brj4b7hoqNwI81IdRSe
   S49lhWIS96MWlls0wAFN5FeZEoYHhisKTfdDB786uTEuK88jfOehoyrzD
   BsN78dI17matbaa2Lzy/gRHMynQfIoNB+t6yXgvrCi8q5iWIncWJ1FVcG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298436391"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="298436391"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:50:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="761793388"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="761793388"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.10])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:50:11 -0800
Message-ID: <a9605f47-2f11-0ed3-d513-717c1935b83d@intel.com>
Date:   Wed, 9 Nov 2022 09:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
 <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
 <20220817160730.GA17202@plvision.eu>
 <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
 <20220818120740.GA21548@plvision.eu> <YwHOCHmKaf7yfgOD@infradead.org>
 <3b88438d-1bb0-e980-b4db-1f8663dc6042@arm.com>
 <VI1P190MB031779C030CAED8026D53D1895259@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <VI1P190MB0317DC34760DFDE69F69A700953F9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <VI1P190MB0317DC34760DFDE69F69A700953F9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 21:05, Vadym Kochan wrote:
> Hi Adrian,
> 
> On Thu, 13 Oct 2022 09:40:00 +0300, Vadym Kochan <vadym.kochan@plvision.eu> wrote:
>> Hi Robin,
>>
>> On Mon, 22 Aug 2022 11:06:43 +0100, Robin Murphy <robin.murphy@arm.com> wrote:
>>> On 2022-08-21 07:17, Christoph Hellwig wrote:
>>>> On Thu, Aug 18, 2022 at 03:07:40PM +0300, Vadym Kochan wrote:
>>>>> It works with the following changes:
>>>>>
>>>>>      #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
>>>>>
>>>>>      #3 swiotlb="force"
>>>>>
>>>>> Is it OK to force the memory allocation from the start for the swiotlb ?
>>>>
>>>> It should be ok, but isn't really optimal.
>>>>
>>>> I wonder if we should just allow DT to specify the swiotlb buffer
>>>> location.  Basically have yet another RESERVEDMEM_OF_DECLARE variant
>>>> for it, which shouldn't be all that much work except for figuring
>>>> out the interaction with the various kernel command line options.
>>>
>>> We already have all the information we need in the DT (and ACPI), the 
>>> arm64 init code just needs to do a better job of interpreting it 
>>> properly. I'll see what I can come up with once I've finished what I'm 
>>> currently tied up in.
>>>
>>> Thanks,
>>> Robin.
>>
>> Sorry to disturb you, I just 'd like to know if you have
>> some ideas to share or patches to test ?
>>
>> Thank you!
>>
> 
> Since AC5X eMMC controller can fail to work on boards with >2GB memory,
> and considering that the best fix may not be easy (as it requires arm64 infra changes),
> so would it be OK to use PIO mode as temporary solution ?
> 
> I understand that arm64 changes might not be trivial and it might take significant
> amount of time to implement considering this unusual case, I just think that better
> to make eMMC working even if it will be slow.

You can disable DMA if you wish:
	SDHCI_QUIRK_BROKEN_DMA | SDHCI_QUIRK_BROKEN_ADMA
however did you consider SDMA:
	SDHCI_QUIRK_BROKEN_ADMA
which uses a bounce buffer allocated by SDHCI?

In any case, you need to add comments to the code
and commit message explaining the swiotlb issue.

