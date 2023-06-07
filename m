Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88EE7253DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjFGGGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFGGGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:06:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540919BC;
        Tue,  6 Jun 2023 23:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686118005; x=1717654005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F2dblgq0/jqWKrEBIBiR9lrvjHI50eHV+ew7tXhlMBI=;
  b=aOG1JEdEp5UxDYxvXWWUu6sUiG0kN6b7KAvhTOG6BxkLKON0CmUnjY8T
   n2MiD72+uaQnyge+BEWM8K14djfLpkJUYnF1juSLNLKRIu1nftT85Dkiw
   hpqrgAOatRMlKr95AyzvMVPUEAzJ43YOQBLBIJXg5HEMOOV1tniR2xCgL
   ycKDsdbLbFzcVk/2bbNBIxE1W7bp5brbe7ysGsDW3Uiawmga4kzdYyjiQ
   SzvpoQGtqUiza6IO0aMpw9tuWF6uwvbl3m3KmZROY920eMniztOhgZuhM
   pQf69SZtQFgb0j2pGG4fFxLT/5jEf+odxXlTNmj5jcDZqWc8/UT40XPeR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="346506618"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="346506618"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 23:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="956073288"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="956073288"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.234])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 23:06:41 -0700
Message-ID: <60054ec8-43d4-059c-0128-68815340c631@intel.com>
Date:   Wed, 7 Jun 2023 09:06:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/1] mmc: mtk-sd: reduce CIT for better performance
Content-Language: en-US
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20230606113249.28057-1-wenbin.mei@mediatek.com>
 <20230606113249.28057-2-wenbin.mei@mediatek.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230606113249.28057-2-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/06/23 14:32, Wenbin Mei wrote:
> CQHCI_SSC1 indicates to CQE the polling period to use when using periodic
> SEND_QUEUE_STATUS(CMD13) polling.
> Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
> frequency to get the actual time.
> The default value 0x1000 that corresponds to 150us for MediaTek SoCs, let's
> decrease it to 0x40 that corresponds to 2.35us, which can improve the
> performance of some eMMC devices.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

For cqhci:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> the previous patche link:
> v4: https://patchwork.kernel.org/project/linux-mediatek/patch/20230605121442.23622-1-wenbin.mei@mediatek.com/
> v3: https://patchwork.kernel.org/project/linux-mediatek/patch/20230605060107.22044-1-wenbin.mei@mediatek.com/
> v2: https://patchwork.kernel.org/project/linux-mediatek/patch/20230510015851.11830-1-wenbin.mei@mediatek.com/
> v1: https://patchwork.kernel.org/project/linux-mediatek/patch/20230419063048.10516-1-wenbin.mei@mediatek.com/
> ---
>  drivers/mmc/host/cqhci.h  |  2 ++
>  drivers/mmc/host/mtk-sd.c | 47 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ba9387ed90eb..e35c655edefc 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -23,6 +23,8 @@
>  /* capabilities */
>  #define CQHCI_CAP			0x04
>  #define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
> +#define CQHCI_CAP_ITCFMUL		GENMASK(15, 12)
> +#define CQHCI_ITCFMUL(x)		FIELD_GET(CQHCI_CAP_ITCFMUL, (x))
>  
>  /* configuration */
>  #define CQHCI_CFG			0x08
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 8ce864169986..b582f19f82f2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -473,6 +473,7 @@ struct msdc_host {
>  	struct msdc_tune_para def_tune_para; /* default tune setting */
>  	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
>  	struct cqhci_host *cq_host;
> +	u32 cq_ssc1_time;
>  };
>  
>  static const struct mtk_mmc_compatible mt2701_compat = {
> @@ -2450,9 +2451,50 @@ static void msdc_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	}
>  }
>  
> +static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
> +{
> +	struct mmc_host *mmc = mmc_from_priv(host);
> +	struct cqhci_host *cq_host = mmc->cqe_private;
> +	u8 itcfmul;
> +	unsigned long hclk_freq;
> +	u64 value;
> +
> +	/*
> +	 * On MediaTek SoCs the MSDC controller's CQE uses msdc_hclk as ITCFVAL
> +	 * so we multiply/divide the HCLK frequency by ITCFMUL to calculate the
> +	 * Send Status Command Idle Timer (CIT) value.
> +	 */
> +	hclk_freq = clk_get_rate(host->h_clk);
> +	itcfmul = CQHCI_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
> +	switch (itcfmul) {
> +	case 0x0:
> +		do_div(hclk_freq, 1000);
> +		break;
> +	case 0x1:
> +		do_div(hclk_freq, 100);
> +		break;
> +	case 0x2:
> +		do_div(hclk_freq, 10);
> +		break;
> +	case 0x3:
> +		break;
> +	case 0x4:
> +		hclk_freq = hclk_freq * 10;
> +		break;
> +	default:
> +		host->cq_ssc1_time = 0x40;
> +		return;
> +	}
> +
> +	value = hclk_freq * timer_ns;
> +	do_div(value, 1000000000);
> +	host->cq_ssc1_time = value;
> +}
> +
>  static void msdc_cqe_enable(struct mmc_host *mmc)
>  {
>  	struct msdc_host *host = mmc_priv(mmc);
> +	struct cqhci_host *cq_host = mmc->cqe_private;
>  
>  	/* enable cmdq irq */
>  	writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
> @@ -2462,6 +2504,9 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>  	msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
>  	/* default read data timeout 1s */
>  	msdc_set_timeout(host, 1000000000ULL, 0);
> +
> +	/* Set the send status command idle timer */
> +	cqhci_writel(cq_host, host->cq_ssc1_time, CQHCI_SSC1);
>  }
>  
>  static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
> @@ -2803,6 +2848,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		/* cqhci 16bit length */
>  		/* 0 size, means 65536 so we don't have to -1 here */
>  		mmc->max_seg_size = 64 * 1024;
> +		/* Reduce CIT to 0x40 that corresponds to 2.35us */
> +		msdc_cqe_cit_cal(host, 2350);
>  	}
>  
>  	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,

