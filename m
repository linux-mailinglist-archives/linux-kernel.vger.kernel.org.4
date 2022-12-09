Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E54648239
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLIMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:13:14 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8D429B8;
        Fri,  9 Dec 2022 04:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670587993; x=1702123993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e8BT/cDBFBQUQOIwZICPu/t7dhHgmsgsTGSNOL/gEao=;
  b=lx2pmjjxgLkPlO0+LQQRO04ftZpCLGR6/mWyf9Jd8gcBgeUSOyZb1Lpk
   PXhCWnldamrYEvzsIJJeHB2/VBbK6URgmQGtci4I0C0UFvdliY4LwP6MS
   HUuups6XTP8N14Y6YO9TZJ4u/BADPne4a/jP9Cdq+fveuF/dALciVgSTJ
   jKqR+rv9KuA0tHgvvVzJjRiB1zn8Ic/syy4bGXvx8hgfDQMW9FLLy0rXp
   nLhn7sJPFHo3heSBvLFRTPBgx758Eun+APjRR++R+7GRB5sKlkGXn7llQ
   nksjaF4Ex8V4aJjKUpOb1eeOg4Pzj0Tn0Dgqg5AE+7ZtrekXohnwVtuTj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="305089198"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="305089198"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 04:13:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="789703025"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="789703025"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.86])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 04:13:09 -0800
Message-ID: <69dd8714-4be1-6b1b-fa07-04c790a6c6fc@intel.com>
Date:   Fri, 9 Dec 2022 14:13:06 +0200
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <VI1P190MB0317A616976EC99EA0C44F47951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 14:10, Vadym Kochan wrote:
> Hi Adrian,
> 
> On Fri, 9 Dec 2022 13:53:58 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 9/12/22 13:39, Vadym Kochan wrote:
>>> Hi Adrian,
>>>
>>> On Fri, 9 Dec 2022 09:23:05 +0200, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 5/12/22 12:59, Vadym Kochan wrote:
>>>>> There is a limitation on AC5 SoC that mmc controller
>>>>> can't have DMA access over 2G memory, so use SDMA with
>>>>> a bounce buffer. Swiotlb can't help because on arm64 arch
>>>>> it reserves memblock's at the end of the memory.
>>>>>
>>>>> Additionally set mask to 34 bit since on AC5 SoC RAM starts
>>>>> at 0x2_00000000.
>>>>
>>>> Can you explain more about how a 34-bit DMA mask works when
>>>> SDMA only supports 32-bit addresses?
>>>>
>>>
>>> So, after I set
>>>
>>>>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
>>>
>>> then sdhc core sets mask to 32 bit, but then dma_map fails to map
>>> bounce buffer because the base address is higher than 32bit - 0x2_00000000,
>>> and 34bit mask fixed it.
>>
>> What happens if the bounce buffer gets mapped in the range
>> 0x1_00000000 to 0x1_ffffffff ?
>>
> 
> From my understanding, on the AC5 SoC RAM starts at 0x2_00000000 so the bounce
> buffer can be mapped in the range 0x2_00000000..0x2_ffffffff

Right but I guess I meant what about 0x3_00000000..0x3_ffffffff ?
Isn't that also in DMA_BIT_MASK(34)

> 
>>>
>>>>>
>>>>> Co-developed-by: Elad Nachman <enachman@marvell.com>
>>>>> Signed-off-by: Elad Nachman <enachman@marvell.com>
>>>>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>>>>> ---
>>>>>  drivers/mmc/host/sdhci-xenon.c | 38 ++++++++++++++++++++++++++++++++++
>>>>>  drivers/mmc/host/sdhci-xenon.h |  3 ++-
>>>>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>>>>> index 08e838400b52..5f3db0425674 100644
>>>>> --- a/drivers/mmc/host/sdhci-xenon.c
>>>>> +++ b/drivers/mmc/host/sdhci-xenon.c
>>>>> @@ -13,7 +13,9 @@
>>>>>  
>>>>>  #include <linux/acpi.h>
>>>>>  #include <linux/delay.h>
>>>>> +#include <linux/dma-mapping.h>
>>>>>  #include <linux/ktime.h>
>>>>> +#include <linux/mm.h>
>>>>>  #include <linux/module.h>
>>>>>  #include <linux/of.h>
>>>>>  #include <linux/pm.h>
>>>>> @@ -253,6 +255,22 @@ static unsigned int xenon_get_max_clock(struct sdhci_host *host)
>>>>>  		return pltfm_host->clock;
>>>>>  }
>>>>>  
>>>>> +static int xenon_set_dma_mask(struct sdhci_host *host)
>>>>> +{
>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>>> +	struct mmc_host *mmc = host->mmc;
>>>>> +	struct device *dev = mmc_dev(mmc);
>>>>> +
>>>>> +	if (priv->hw_version == XENON_AC5) {
>>>>> +		host->flags &= ~SDHCI_USE_64_BIT_DMA;
>>>>> +
>>>>> +		return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
>>>>> +	}
>>>>> +
>>>>> +	return sdhci_set_dma_mask(host);
>>>>> +}
>>>>> +
>>>>>  static const struct sdhci_ops sdhci_xenon_ops = {
>>>>>  	.voltage_switch		= xenon_voltage_switch,
>>>>>  	.set_clock		= sdhci_set_clock,
>>>>> @@ -261,6 +279,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
>>>>>  	.reset			= xenon_reset,
>>>>>  	.set_uhs_signaling	= xenon_set_uhs_signaling,
>>>>>  	.get_max_clock		= xenon_get_max_clock,
>>>>> +	.set_dma_mask		= xenon_set_dma_mask,
>>>>>  };
>>>>>  
>>>>>  static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
>>>>> @@ -486,6 +505,18 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
>>>>>  	xenon_disable_sdhc(host, sdhc_id);
>>>>>  }
>>>>>  
>>>>> +static int xenon_ac5_probe(struct sdhci_host *host)
>>>>> +{
>>>>> +	struct sysinfo si;
>>>>> +
>>>>> +	si_meminfo(&si);
>>>>> +
>>>>> +	if ((si.totalram * si.mem_unit) > SZ_2G)
>>>>> +		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>  static int xenon_probe(struct platform_device *pdev)
>>>>>  {
>>>>>  	struct sdhci_pltfm_host *pltfm_host;
>>>>> @@ -533,6 +564,12 @@ static int xenon_probe(struct platform_device *pdev)
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> +	if (priv->hw_version == XENON_AC5) {
>>>>> +		err = xenon_ac5_probe(host);
>>>>> +		if (err)
>>>>> +			goto err_clk_axi;
>>>>> +	}
>>>>> +
>>>>>  	err = mmc_of_parse(host->mmc);
>>>>>  	if (err)
>>>>>  		goto err_clk_axi;
>>>>> @@ -682,6 +719,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>>>>>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>>>>>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>>>>>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
>>>>> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AC5},
>>>>>  	{}
>>>>>  };
>>>>>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
>>>>> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
>>>>> index 3e9c6c908a79..0460d97aad26 100644
>>>>> --- a/drivers/mmc/host/sdhci-xenon.h
>>>>> +++ b/drivers/mmc/host/sdhci-xenon.h
>>>>> @@ -57,7 +57,8 @@ enum xenon_variant {
>>>>>  	XENON_A3700,
>>>>>  	XENON_AP806,
>>>>>  	XENON_AP807,
>>>>> -	XENON_CP110
>>>>> +	XENON_CP110,
>>>>> +	XENON_AC5
>>>>>  };
>>>>>  
>>>>>  struct xenon_priv {
>>>>
>>>
>>> Regards,
>>

