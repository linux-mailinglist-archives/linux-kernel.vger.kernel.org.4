Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAE25FAEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJKIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJKIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:48:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804CE58B76;
        Tue, 11 Oct 2022 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665478095; x=1697014095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QtPL0c22PULNLT4h8YrIaeDVBt8AgGleM3RozmCDUZ8=;
  b=VSpFpCF92NPhB+gYYZtyUoa1mJcgVwDM9kN3czW7zNP8Oa7te8LyCDfo
   p/xU7xu+vXrz7t7xjmUeFdQzv0mygkaQ3YdPdcNKkeKU627nvIZyRQVO5
   fcQomEQBQo573mmtIPO+JKl1wM3vuNmZLCF9O4jmblSk8wHhPJ6LQjben
   O/5vY+pN/hZqFw9jUJ/b5z1G9dYC9mswo8LHWsVf1uimmAjKKbbQjdfAm
   Dd+YyrgJTRtxf1OH4saAypBtGoRwIU9KpsCkuCcXVI/fIiBLU7vUhuwRo
   Mm7W/Ci/5KBR/qmYQGOcI2Yn1WN9bxX3sYSHN+p4OYewA8LUcwmFK5AKt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="302058024"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="302058024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 01:48:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="768720754"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="768720754"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 01:48:12 -0700
Message-ID: <e98b85ce-c382-09ca-a819-ab7c581158e4@intel.com>
Date:   Tue, 11 Oct 2022 11:48:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix minimum clock limit
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     ulf.hansson@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
References: <20221011063043.11074-1-wenchao.chen666@gmail.com>
 <beae901e-0fcd-c4ae-8a6e-a1a4357078da@intel.com>
 <CA+Da2qwe96J_EyJCG04UX5GBEsoU0mckWktPyTrZARk-XHAo0w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+Da2qwe96J_EyJCG04UX5GBEsoU0mckWktPyTrZARk-XHAo0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 11:40, Wenchao Chen wrote:
> On Tue, Oct 11, 2022 at 2:45 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 11/10/22 09:30, Wenchao Chen wrote:
>>> From: Wenchao Chen <wenchao.chen@unisoc.com>
>>>
>>> The minimum clock supported by SPRD Host is 100000.
>>
>> Commit messages are better if they say why a change
>> is being made.
>>
>> This begs the question, was there a problem with 400 kHz?
>> Are there cases that benefit from this change?
>> Should it have a fixes tag,cc stable?
>>
> 
> Code show as below:
> static struct sdhci_ops sdhci_sprd_ops = {
> ...
> .get_min_clock = sdhci_sprd_get_min_clock,
> ...
> };
> 
> int sdhci_setup_host(struct sdhci_host *host)
> {
> ...
> if (host->ops->get_min_clock)
> mmc->f_min = host->ops->get_min_clock(host);
> ...
> }
> 
> static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
> void mmc_rescan(struct work_struct *work)
> {
> ...
> for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> unsigned int freq = freqs[i];
> if (freq > host->f_max) {
> if (i + 1 < ARRAY_SIZE(freqs))
> continue;
> freq = host->f_max;
> }
> if (!mmc_rescan_try_freq(host, max(freq, host->f_min)))
> break;
> if (freqs[i] <= host->f_min) // If you start at 100K, you will try
> 400K, 300K, 200K, 100K.
> break;
> }
> ...
> }
> 
> Our controller supports 100K. During the test, it was found that mmc_rescan
> failed to scan the card at 400K, and did not try 300K, 200K, and 100K. After
> modifying the minimum clock limit to 100K, the card scan was successful.

Please add those last 3 lines to the commit message, then you can add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Also please consider adding a Fixes: tag.

> 
>>>
>>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
>>> ---
>>>  drivers/mmc/host/sdhci-sprd.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
>>> index 46c55ab4884c..b92a408f138d 100644
>>> --- a/drivers/mmc/host/sdhci-sprd.c
>>> +++ b/drivers/mmc/host/sdhci-sprd.c
>>> @@ -309,7 +309,7 @@ static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
>>>
>>>  static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
>>>  {
>>> -     return 400000;
>>> +     return 100000;
>>>  }
>>>
>>>  static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
>>

