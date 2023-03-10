Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD336B3D52
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCJLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJLKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:10:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDE3F209B;
        Fri, 10 Mar 2023 03:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678446631; x=1709982631;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vJqPlIdV6UQrU8di3GtSZjZo8V4cHDZdnObXwRJMPHk=;
  b=hMtFI7P+9osXKgKFM2eYty36w3u157cWMzVKUbfCPiMkYwbfxd5DGGS6
   72I1gS8WZwKZRuGGFbzQm37flQHU2j5XKoixPbnDmAQwF+wrZKlkmNfyi
   /hlEfq5Q8/RweAObLZCNXUhhD/Dik3XvQ5oJ4rDRLxlLtZbdQqqzVO9Sl
   HXMiQIwOFcJmGocqhTaySN8IpcD6cjKoEr5B/4f8cnVx9Q3jzR70x1Fdb
   d/2Epk9KYUuwtp/BAhh/mud80GhuEtpKI4Z9jwaxrq9c6LkzOS7bSea0m
   K/skHfnrcLDaS18wzmTtWrHYzFZ5sN2TaFK6nqz31jx0UMyB8B69SSMY0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336723078"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="336723078"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:10:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707974042"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="707974042"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:10:22 -0800
Message-ID: <dd4f8ab5-88c6-b992-dd83-fc3faf623175@intel.com>
Date:   Fri, 10 Mar 2023 13:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v10 12/15] mmc: sdhci-cadence: Support device specific
 init during probe
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-13-blarson@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230306040739.51488-13-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/03/23 06:07, Brad Larson wrote:
> Move struct sdhci_pltfm_data under new struct sdhci_cdns_drv_data.
> Add an init() into sdhci_cdns_drv_data for platform specific device
> initialization in the device probe which is not used for existing devices.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> v10 changes:
> - New patch to provide for platform specific init() with no change
>   to existing designs.
> 
> ---
>  drivers/mmc/host/sdhci-cadence.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 708d4297f241..c528a25f48b8 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -77,6 +77,11 @@ struct sdhci_cdns_phy_cfg {
>  	u8 addr;
>  };
>  
> +struct sdhci_cdns_drv_data {
> +	int (*init)(struct platform_device *pdev);
> +	const struct sdhci_pltfm_data pltfm_data;
> +};
> +
>  static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>  	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>  	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> @@ -325,13 +330,17 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> -	.ops = &sdhci_cdns_ops,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
> +	.pltfm_data = {
> +		.ops = &sdhci_cdns_ops,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
> -	.ops = &sdhci_cdns_ops,
> +static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> +	.pltfm_data = {
> +		.ops = &sdhci_cdns_ops,
> +	},
>  };
>  
>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> @@ -357,7 +366,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
> -	const struct sdhci_pltfm_data *data;
> +	const struct sdhci_cdns_drv_data *data;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> @@ -376,10 +385,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(dev);
>  	if (!data)
> -		data = &sdhci_cdns_pltfm_data;
> +		data = &sdhci_cdns_drv_data;
>  
>  	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -	host = sdhci_pltfm_init(pdev, data,
> +	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>  				struct_size(priv, phy_params, nr_phy_params));
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
> @@ -397,6 +406,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
> +	if (data->init) {
> +		ret = data->init(pdev);
> +		if (ret)
> +			goto free;
> +	}
>  	sdhci_enable_v4_mode(host);
>  	__sdhci_read_caps(host, &version, NULL, NULL);
>  
> @@ -461,7 +475,7 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
>  static const struct of_device_id sdhci_cdns_match[] = {
>  	{
>  		.compatible = "socionext,uniphier-sd4hc",
> -		.data = &sdhci_cdns_uniphier_pltfm_data,
> +		.data = &sdhci_cdns_uniphier_drv_data,
>  	},
>  	{ .compatible = "cdns,sd4hc" },
>  	{ /* sentinel */ }

