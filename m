Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E747426CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjF2M5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2M5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:57:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F7FE58;
        Thu, 29 Jun 2023 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688043434; x=1719579434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/QmFOMe/PCvIGdXwXzdOv9tn5csW9W1bsdoNeEspJYI=;
  b=ATFX5TKPmNVun4Nttjd9AscGUkC1vEob/YQjt7PIltZOII7iBS03QbHn
   hDHZCiX2aluZi9XkneXb7INPf4EMAo+uMr1RiiesgrbyDx1QdY8w9Mg3k
   YeB+pafkRBV03xM0kHvHvf96P2qMt69wJAaRYliZHRdrnz6yZOa7dusM+
   5IxI4fE0P6g4CgC4OB6t8v+8YXOwdvZ17n4WSQ6Er88cgvlrJZHQXkj0+
   QyBuZWdnLKn2a68YCeR9xFy+/9e6PhYzgQ02K/nx7xpma3n2s3rgTmPaR
   XY39Xd6y3scWZ1VwFcCR1I1KBzKyB1bbyGyETW5SII/VXX97UHeEXg0l0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="342437532"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="342437532"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 05:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="891396985"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="891396985"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.81])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 05:57:11 -0700
Message-ID: <57dd6bdc-c8dc-219c-f9dd-d2f210a5ce2c@intel.com>
Date:   Thu, 29 Jun 2023 15:57:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230629004959.22825-1-hayashi.kunihiko@socionext.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230629004959.22825-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/23 03:49, Kunihiko Hayashi wrote:
> Even if sdhci_pltfm_pmops is specified for PM, this driver doesn't apply
> sdhci_pltfm, so the structure is not correctly referenced in PM functions.
> This applies sdhci_pltfm to this driver to fix this issue.
> 
> - Call sdhci_pltfm_init() instead of sdhci_alloc_host() and
>   other functions that covered by sdhci_pltfm.
> - Move ops and quirks to sdhci_pltfm_data
> - Replace sdhci_priv() with own private function sdhci_f_sdh30_priv().
> 

Does it need a Fixes tag?

> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 60 ++++++++++++++------------------
>  1 file changed, 27 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index a202a69a4b08..b01ffb4d0973 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -29,9 +29,16 @@ struct f_sdhost_priv {
>  	bool enable_cmd_dat_delay;
>  };
>  
> +static void *sdhci_f_sdhost_priv(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	return sdhci_pltfm_priv(pltfm_host);
> +}
> +
>  static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
>  {
> -	struct f_sdhost_priv *priv = sdhci_priv(host);
> +	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>  	u32 ctrl = 0;
>  
>  	usleep_range(2500, 3000);
> @@ -64,7 +71,7 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>  
>  static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>  {
> -	struct f_sdhost_priv *priv = sdhci_priv(host);
> +	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>  	u32 ctl;
>  
>  	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
> @@ -95,30 +102,32 @@ static const struct sdhci_ops sdhci_f_sdh30_ops = {
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_f_sdh30_pltfm_data = {
> +	.ops = &sdhci_f_sdh30_ops,
> +	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> +		| SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> +	.quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE
> +		|  SDHCI_QUIRK2_TUNING_WORK_AROUND,
> +};
> +
>  static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
>  	struct device *dev = &pdev->dev;
> -	int irq, ctrl = 0, ret = 0;
> +	int ctrl = 0, ret = 0;
>  	struct f_sdhost_priv *priv;
> +	struct sdhci_pltfm_host *pltfm_host;
>  	u32 reg = 0;
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return irq;
> -
> -	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
> +	host = sdhci_pltfm_init(pdev, &sdhci_f_sdh30_pltfm_data,
> +				sizeof(struct f_sdhost_priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> -	priv = sdhci_priv(host);
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
>  	priv->dev = dev;
>  
> -	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> -		       SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> -	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
> -			SDHCI_QUIRK2_TUNING_WORK_AROUND;
> -
>  	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
>  						"fujitsu,cmd-dat-delay-select");
>  
> @@ -126,18 +135,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err;
>  
> -	platform_set_drvdata(pdev, host);
> -
> -	host->hw_name = "f_sdh30";
> -	host->ops = &sdhci_f_sdh30_ops;
> -	host->irq = irq;
> -
> -	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(host->ioaddr)) {
> -		ret = PTR_ERR(host->ioaddr);
> -		goto err;
> -	}
> -
>  	if (dev_of_node(dev)) {
>  		sdhci_get_of_property(pdev);
>  
> @@ -204,24 +201,21 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  err_clk:
>  	clk_disable_unprepare(priv->clk_iface);
>  err:
> -	sdhci_free_host(host);
> +	sdhci_pltfm_free(pdev);
> +
>  	return ret;
>  }
>  
>  static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> -	struct f_sdhost_priv *priv = sdhci_priv(host);
> -
> -	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
> -			  0xffffffff);
> +	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>  
>  	reset_control_assert(priv->rst);
>  	clk_disable_unprepare(priv->clk);
>  	clk_disable_unprepare(priv->clk_iface);
>  
> -	sdhci_free_host(host);
> -	platform_set_drvdata(pdev, NULL);
> +	sdhci_pltfm_unregister(pdev);
>  
>  	return 0;
>  }

