Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E0360EFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiJ0Fpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiJ0Fp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:45:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A7F3D5A5;
        Wed, 26 Oct 2022 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666849523; x=1698385523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/g8s4f7kmFiKzd9ZEGsfSC/qwsPn27mT53xEaWFg3Xw=;
  b=JPiqAziPCXW/8IdU7vUrP6mLuQHT4TZLdbY668g89Adv2Fc4ZuG2yOV7
   AgCVLtIbRULq8hNXlWKZDeHX06J5+lxatNmDRR+AJ/XZROW85X30fVF2r
   iJcXZZMlziMao6zbS/vdvj6l9V0c+P6NL+OZcnzrNOW92RLYq6FsjUrA7
   QAU43kVJ1y7j40YSd7hF6Av/Pe9u2ok4R2rrpUZZOYyMDh0hqvM8IUi7T
   zxrqzz+QdpsnKkvm/f1UhuxWykapI2yreYI7r4q9B5r2muW5xQQMVPDYq
   cuhcRGhMEkmSil+srcG5MVWy2wpWJNKreOYG/M/my1zxfDv4MZnsSykFh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="295544235"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="295544235"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 22:45:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="774864507"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="774864507"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.150])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 22:45:17 -0700
Message-ID: <cbeb7a0d-16b4-2774-178d-8a83954a46a2@intel.com>
Date:   Thu, 27 Oct 2022 08:45:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
To:     Brian Norris <briannorris@chromium.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
 <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
 <Y1hY57vkkOhybwE1@google.com>
 <6268199c-78ca-8f55-0377-c14bb0299443@gmail.com>
 <Y1higmSUMLsxvXyq@google.com>
 <7db0a98e-36c8-afee-5b0d-16b836ac8de0@intel.com>
 <Y1l5/U3WnbDIIMOj@google.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Y1l5/U3WnbDIIMOj@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/22 21:18, Brian Norris wrote:
> Hi Adrian,
> 
> On Wed, Oct 26, 2022 at 08:36:48AM +0300, Adrian Hunter wrote:
>> On 26/10/22 01:26, Brian Norris wrote:
>>> On Tue, Oct 25, 2022 at 02:53:46PM -0700, Florian Fainelli wrote:
>>>> On 10/25/22 14:45, Brian Norris wrote:
>>>>> On Tue, Oct 25, 2022 at 04:10:44PM +0300, Adrian Hunter wrote:
>>>>>> On 24/10/22 20:55, Brian Norris wrote:
>>>>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>>>>>> index 8f1023480e12..6a282c7a221e 100644
>>>>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>>>
>>>>>>> @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
>>>>>>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>>>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>>>>>> -	sdhci_reset(host, mask);
>>>>>>> +	sdhci_and_cqhci_reset(host, mask);
>>>>>>>   	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
>>>>>>>   		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>>>>>>
>>>>>> What about sdhci_reset in sdhci_am654_ops ?
>>>>>
>>>>> Oops, I think you caught a big fallacy in some of my patches: I assumed
>>>>> there was a single reset() implementation in a given driver (an unwise
>>>>> assumption, I realize). I see at least sdhci-brcmstb.c also has several
>>>>> variant ops that call sdhci_reset(), and I should probably convert them
>>>>> too.
>>
>> I checked and found only sdhci_am654_ops
> 
> And...how about sdhci_j721e_8bit_ops in that same driver?
> 
>>>> You got it right for sdhci-brcmstb.c because "supports-cqe" which gates the
>>>> enabling of CQE can only be found with the "brcm,bcm7216-sdhci" compatible
>>>> which implies using brcmstb_reset().
>>>
>>> I don't see any in-tree device trees for these chips (which is OK), and
>>> that's not what the Documentation/ says, and AFAICT nothing in the
>>> driver is limiting other variants from specifying the "supports-cqe"
>>> flag in their (out-of-tree) device tree. The closest thing I see is that
>>> an *example* in brcm,sdhci-brcmstb.yaml shows "supports-cqe" only on
>>> brcm,bcm7216-sdhci -- but an example is not a binding agreement. Am I
>>> missing something?
>>
>> It was mentioned in the patch from the Fixes tag.
> 
> OK, good note. If I don't patch the other seemingly-unaffected variants
> in brcmstb, I'll at least update the commit message, since the code
> doesn't tell me they're unaffected.
> 
>>> Now of course, you probably know behind the scenes that there are no
>>> other sdhci-brcmstb-relevant controllers that "support cqe", but AFAICT
>>> I have no way of knowing that a priori. The driver and bindings give
>>> (too much?) flexibility.
>>>
>>> Poking around, I think the only other one I might have missed would be
>>> gl9763e in sdhci-pci-gli.c. That also calls cqhci_init() but is
>>> otherwise relying on the default sdhci_pci_ops. So I'd either have to
>>
>> It uses sdhci_gl9763e_ops not the default sdhci_pci_ops.  It looks OK
>> to me.
> 
> Ugh, of course you're right. I think I'm mixing up past history and
> stuff I'm trying to patch now. I *am* patching gl9763e already in this
> series, but simply as a refactor, and not any additional bugfix.
> 
>>> change the common sdhci_pci_ops, or else start a new copy/paste/modify
>>> 'struct sdhci_ops' for it... This really does start to get messy when
>>> poking around on drivers I can't test. As in, it shouldn't be harmful
>>> to change most sdhci_reset() to sdhci_and_cqhci_reset() (as long as they
>>> aren't using some other CQE implementation), but the more invasive it
>>> gets (say, rewriting a bunch of other ops), the easier it is to get
>>> something wrong.
>>
>> AFAICS it was just sdhci_am654_ops
> 
> Agreed it's less to change than I thought. But I think you (and I) also
> missed sdhci_j721e_8bit_ops.

You are right!  Thanks for spotting that!

> 
> Assuming I'm not totally off-base yet again...v4 is coming sooner or
> later.
> 
> Brian

