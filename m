Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A7A714BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjE2OLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjE2OLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:11:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA4B1;
        Mon, 29 May 2023 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685369467; x=1716905467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9TesWThXpKxD87Td7aD1y10ImSaXLOK76jjih9rvQ4o=;
  b=RiSf3vqt9n3RM7rQm982wWrO3ee5Lt8yqxijk+MRdWWGgx8HyV28mtG1
   5HU37OyKpuJvNO3JjjmFynOTiTxL+cDzLfRKbsnwZWKzsYIheoi7knro+
   qMLEpjfzr50ln7FU4cpRqm5+o/XOD9+oGj78khYsnYjiCBBgZD4jQw7US
   DEj+u3GK3aM7bdpN4Q7Gu8cuRdm6jjUZskdUJY7OtlZaQzqOA+c7F/vU1
   uN/eOMWnYc+iX2CAgd2ARrZtLl2IQAFI8NNniUSAMmW8lZnn76oHK0G/J
   Imof9iTC1PR7Yu4rTfGDL4JIgFJCwOVj5AcVuQRQY/LK2p2HgU0bujB0s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="352216825"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="352216825"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 07:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="952774560"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="952774560"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.110])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 07:10:50 -0700
Message-ID: <7982aae5-ac38-03df-aa0a-165c3c3f7764@intel.com>
Date:   Mon, 29 May 2023 17:10:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] mmc: sdhci-msm: Disable broken 64-bit DMA on MSM8916
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230518-msm8916-64bit-v1-1-5694b0f35211@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/23 12:39, Stephan Gerhold wrote:
> While SDHCI claims to support 64-bit DMA on MSM8916 it does not seem to
> be properly functional. It is not immediately obvious because SDHCI is
> usually used with IOMMU bypassed on this SoC, and all physical memory
> has 32-bit addresses. But when trying to enable the IOMMU it quickly
> fails with an error such as the following:
> 
>   arm-smmu 1e00000.iommu: Unhandled context fault:
>     fsr=0x402, iova=0xfffff200, fsynr=0xe0000, cbfrsynra=0x140, cb=3
>   mmc1: ADMA error: 0x02000000
>   mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>   mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00002e02
>   mmc1: sdhci: Blk size:  0x00000008 | Blk cnt:  0x00000000
>   mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
>   mmc1: sdhci: Present:   0x03f80206 | Host ctl: 0x00000019
>   mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>   mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>   mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000001
>   mmc1: sdhci: Int enab:  0x03ff900b | Sig enab: 0x03ff100b
>   mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>   mmc1: sdhci: Caps:      0x322dc8b2 | Caps_1:   0x00008007
>   mmc1: sdhci: Cmd:       0x0000333a | Max curr: 0x00000000
>   mmc1: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x5b590000
>   mmc1: sdhci: Resp[2]:   0xe6487f80 | Resp[3]:  0x0a404094
>   mmc1: sdhci: Host ctl2: 0x00000008
>   mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x0000000ffffff224
>   mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP -----------
>   mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:  0x60006400 | DLL cfg2: 0x00000000
>   mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:  0x00000000 | DDR cfg: 0x00000000
>   mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88018a8 Vndr func3: 0x00000000
>   mmc1: sdhci: ============================================
>   mmc1: sdhci: fffffffff200: DMA 0x0000ffffffffe100, LEN 0x0008, Attr=0x21
>   mmc1: sdhci: fffffffff20c: DMA 0x0000000000000000, LEN 0x0000, Attr=0x03
> 
> Looking closely it's obvious that only the 32-bit part of the address
> (0xfffff200) arrives at the SMMU, the higher 16-bit (0xffff...) get
> lost somewhere. This might not be a limitation of the SDHCI itself but
> perhaps the bus/interconnect it is connected to, or even the connection
> to the SMMU.
> 
> Work around this by setting SDHCI_QUIRK2_BROKEN_64_BIT_DMA to avoid
> using 64-bit addresses.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ac81d57a3df..1877d583fe8c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2479,6 +2479,9 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>  		msm_host->ddr_config = DDR_CONFIG_POR_VAL;
>  
>  	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
> +
> +	if (of_device_is_compatible(node, "qcom,msm8916-sdhci"))
> +		host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
>  }
>  
>  static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
> 
> ---
> base-commit: d4ebc9419afbac330e9ec0d2936108742aa4d97a
> change-id: 20230518-msm8916-64bit-f5bcf6af7679
> 
> Best regards,

