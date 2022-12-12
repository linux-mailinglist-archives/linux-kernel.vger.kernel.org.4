Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90A3649FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiLLNOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiLLNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:14:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A79D1032;
        Mon, 12 Dec 2022 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670850867; x=1702386867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Mk/c1UnbOZ1TXK8FvpaAfqNr18tZtlpEe7k7RdUxSU=;
  b=OTGeF+dYTagj/aeud/pLnvGOm5xcqyxBGZlm/3lwNiiQb6W/r1SUh2+O
   nZbCubzBG6WQuRJTmY1gSi/9xo9KZKwimxUHmlVS09Ro4osffD8tDlRL5
   wEou3Jt4FLVia0kPNLMQkX0TWXoua0xXQ0cboOga/NjxPtgBQP+8fQZKe
   lkNQLodH9SC5IIKTtoR6ggXIgl4MTf5n0RbJFaFw6iqjkhvq4XESCohJA
   xqUH6OkH4YhvzrrQqmAw5kYZv/jDt0ls99X7jpbvQrLBrixtNC03/NRWa
   wicuGOE8KMVQ/M0iCANk10qHptqqEuELPc3gFoDtAU+GqPn1SY0pCAOsv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="305490537"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="305490537"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 05:14:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="680671043"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="680671043"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.252])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 05:14:23 -0800
Message-ID: <9c84dbf7-e80a-5281-1070-6aeb65cfe958@intel.com>
Date:   Mon, 12 Dec 2022 15:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
 <20221205105931.410686-4-vadym.kochan@plvision.eu>
 <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
 <VI1P190MB0317641905664AFF51F9F4EA951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <ce870974-3e4f-107f-2047-89dcaebff1a2@intel.com>
 <VI1P190MB0317A616976EC99EA0C44F47951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <69dd8714-4be1-6b1b-fa07-04c790a6c6fc@intel.com>
 <VI1P190MB0317DADE7450282444BFED32951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <44f642bc-8810-80d9-368a-15994de7f50d@intel.com>
 <VI1P190MB03171A8F65844DB789D85B0495E29@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <VI1P190MB03171A8F65844DB789D85B0495E29@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
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

On 12/12/22 13:34, Vadym Kochan wrote:
> Hi Adrian,
> 
> On Mon, 12 Dec 2022 10:42:36 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 9/12/22 15:27, Vadym Kochan wrote:
>>> On Fri, 9 Dec 2022 14:13:06 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 9/12/22 14:10, Vadym Kochan wrote:
>>>>> Hi Adrian,
>>>>>
>>>>> On Fri, 9 Dec 2022 13:53:58 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>> On 9/12/22 13:39, Vadym Kochan wrote:
>>>>>>> Hi Adrian,
>>>>>>>
>>>>>>> On Fri, 9 Dec 2022 09:23:05 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>> On 5/12/22 12:59, Vadym Kochan wrote:
>>>>>>>>> There is a limitation on AC5 SoC that mmc controller
>>>>>>>>> can't have DMA access over 2G memory, so use SDMA with
>>>>>>>>> a bounce buffer. Swiotlb can't help because on arm64 arch
>>>>>>>>> it reserves memblock's at the end of the memory.
>>>>>>>>>
>>>>>>>>> Additionally set mask to 34 bit since on AC5 SoC RAM starts
>>>>>>>>> at 0x2_00000000.
>>>>>>>>
>>>>>>>> Can you explain more about how a 34-bit DMA mask works when
>>>>>>>> SDMA only supports 32-bit addresses?
>>>>>>>>
>>>>>>>
>>>>>>> So, after I set
>>>>>>>
>>>>>>>>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
>>>>>>>
>>>>>>> then sdhc core sets mask to 32 bit, but then dma_map fails to map
>>>>>>> bounce buffer because the base address is higher than 32bit - 0x2_00000000,
>>>>>>> and 34bit mask fixed it.
>>>>>>
>>>>>> What happens if the bounce buffer gets mapped in the range
>>>>>> 0x1_00000000 to 0x1_ffffffff ?
>>>>>>
>>>>>
>>>>> From my understanding, on the AC5 SoC RAM starts at 0x2_00000000 so the bounce
>>>>> buffer can be mapped in the range 0x2_00000000..0x2_ffffffff
>>>>
>>>> Right but I guess I meant what about 0x3_00000000..0x3_ffffffff ?
>>>> Isn't that also in DMA_BIT_MASK(34)
>>>
>>> Yes, you are right.
>>
>> So it would fail in that case?  Is it possible to use devicetree
>> reserved memory or some such, to set aside 64k for the bounce
>> buffer DMA mapping?
>>
> 
> The main restriction is that only lower 2GB can be used for DMA.
> 
> I already did send solution based on reserved memory, I can send it again in context of this series.
> Also what about the solution which Linus suggested ?
> 
> [cut]
> 
> Let's just create a new quirk:
> 
> SDHCI_QUIRK_31BIT_DMA_ROOF
> 
> Define the semantics such that this will allow DMA for buffers that are below
> the 31st bit, but does not have the semantics to limit scatter-gather buffers to
> be 32-bit aligned.
> 
> [/cut]

Wouldn't that need to be done after DMA mapping?

In the SDMA case, the bounce buffer would need to be
checked only once and if wrong then it would be
PIO-only for all requests.  You probably don't need
need a quirk for that since the check could be done
at probe time.

In the ADMA case the ADMA table would have to be
checked also.  And then after every dma_map_sg().

Seems a bit messy?

> 
> Thanks,
> 
>>>
>>>>
>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> Co-developed-by: Elad Nachman <enachman@marvell.com>
>>>>>>>>> Signed-off-by: Elad Nachman <enachman@marvell.com>
>>>>>>>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>>>>>>>>> ---
>>>>>>>>>  drivers/mmc/host/sdhci-xenon.c | 38 ++++++++++++++++++++++++++++++++++
>>>>>>>>>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
>>>>>>>>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>>>>>>>>> index 08e838400b52..5f3db0425674 100644
>>>>>>>>> --- a/drivers/mmc/host/sdhci-xenon.c
>>>>>>>>> +++ b/drivers/mmc/host/sdhci-xenon.c
>>>>>>>>> @@ -13,7 +13,9 @@
>>>>>>>>>  
>>>>>>>>>  #include <linux/acpi.h>
>>>>>>>>>  #include <linux/delay.h>
>>>>>>>>> +#include <linux/dma-mapping.h>
>>>>>>>>>  #include <linux/ktime.h>
>>>>>>>>> +#include <linux/mm.h>
>>>>>>>>>  #include <linux/module.h>
>>>>>>>>>  #include <linux/of.h>
>>>>>>>>>  #include <linux/pm.h>
>>>>>>>>> @@ -253,6 +255,22 @@ static unsigned int xenon_get_max_clock(struct sdhci_host *host)
>>>>>>>>>  		return pltfm_host->clock;
>>>>>>>>>  }
>>>>>>>>>  
>>>>>>>>> +static int xenon_set_dma_mask(struct sdhci_host *host)
>>>>>>>>> +{
>>>>>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>>>>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>>>>>>> +	struct mmc_host *mmc = host->mmc;
>>>>>>>>> +	struct device *dev = mmc_dev(mmc);
>>>>>>>>> +
>>>>>>>>> +	if (priv->hw_version == XENON_AC5) {
>>>>>>>>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
>>>>>>>>> +
>>>>>>>>> +		return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>> +	return sdhci_set_dma_mask(host);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>  static const struct sdhci_ops sdhci_xenon_ops = {
>>>>>>>>>  	.voltage_switch		= xenon_voltage_switch,
>>>>>>>>>  	.set_clock		= sdhci_set_clock,
>>>>>>>>> @@ -261,6 +279,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
>>>>>>>>>  	.reset			= xenon_reset,
>>>>>>>>>  	.set_uhs_signaling	= xenon_set_uhs_signaling,
>>>>>>>>>  	.get_max_clock		= xenon_get_max_clock,
>>>>>>>>> +	.set_dma_mask		= xenon_set_dma_mask,
>>>>>>>>>  };
>>>>>>>>>  
>>>>>>>>>  static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
>>>>>>>>> @@ -486,6 +505,18 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
>>>>>>>>>  	xenon_disable_sdhc(host, sdhc_id);
>>>>>>>>>  }
>>>>>>>>>  
>>>>>>>>> +static int xenon_ac5_probe(struct sdhci_host *host)
>>>>>>>>> +{
>>>>>>>>> +	struct sysinfo si;
>>>>>>>>> +
>>>>>>>>> +	si_meminfo(&si);
>>>>>>>>> +
>>>>>>>>> +	if ((si.totalram * si.mem_unit) > SZ_2G)
>>>>>>>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>>>>>>>>> +
>>>>>>>>> +	return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>  static int xenon_probe(struct platform_device *pdev)
>>>>>>>>>  {
>>>>>>>>>  	struct sdhci_pltfm_host *pltfm_host;
>>>>>>>>> @@ -533,6 +564,12 @@ static int xenon_probe(struct platform_device *pdev)
>>>>>>>>>  		}
>>>>>>>>>  	}
>>>>>>>>>  
>>>>>>>>> +	if (priv->hw_version == XENON_AC5) {
>>>>>>>>> +		err = xenon_ac5_probe(host);
>>>>>>>>> +		if (err)
>>>>>>>>> +			goto err_clk_axi;
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>>  	err = mmc_of_parse(host->mmc);
>>>>>>>>>  	if (err)
>>>>>>>>>  		goto err_clk_axi;
>>>>>>>>> @@ -682,6 +719,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>>>>>>>>>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>>>>>>>>>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>>>>>>>>>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
>>>>>>>>> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AC5},
>>>>>>>>>  	{}
>>>>>>>>>  };
>>>>>>>>>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
>>>>>>>>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
>>>>>>>>> index 3e9c6c908a79..0460d97aad26 100644
>>>>>>>>> --- a/drivers/mmc/host/sdhci-xenon.h
>>>>>>>>> +++ b/drivers/mmc/host/sdhci-xenon.h
>>>>>>>>> @@ -57,7 +57,8 @@ enum xenon_variant {
>>>>>>>>>  	XENON_A3700,
>>>>>>>>>  	XENON_AP806,
>>>>>>>>>  	XENON_AP807,
>>>>>>>>> -	XENON_CP110
>>>>>>>>> +	XENON_CP110,
>>>>>>>>> +	XENON_AC5
>>>>>>>>>  };
>>>>>>>>>  
>>>>>>>>>  struct xenon_priv {
>>>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>
>>>>
>>

