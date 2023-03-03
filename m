Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F026A92B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCCIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCCIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:37:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6547CC2F;
        Fri,  3 Mar 2023 00:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677832649; x=1709368649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jgqCcaaTy6XGYEogKpJyZEBzrEoOPU1cGTc6AefLEFA=;
  b=bU02T68oIhBZ2TUoyqlrGSwwYjg+jCUfeHMGpj4mJ0JRmbwU1/emFZE/
   B+YsSU/bcY534ZEuhGqIEsP23CAQRispv1t1ATQjnhFLop4fLdbrhNWNH
   SMLcmtAiFSGH39LUwSa8FnJI8DVbFPrQk31AzTgAFt3qd8Nv89IDE5uiK
   PRkbE4vhj527jQfJ1hOmazJa48fg8ByBTjx9u3g0r10CW//ZmjeoU7TfF
   AebHua0XetzM2NCssQtS0ww6mQrtaozbnb16NDEVrmovKbwlF0eGeB5Nw
   6KbWrP/l1qiZOUIfNZ6Slm8zSm1bZAxrMHr+ayCwYuQI7+5MnW1qtvnxz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="314650785"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="314650785"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="707745291"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="707745291"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.216.227])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:36:33 -0800
Message-ID: <e77b9471-806c-7603-7351-76422c42df88@intel.com>
Date:   Fri, 3 Mar 2023 10:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] mmc: sdhci-cadence: Restructure the code
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-3-pmalgujar@marvell.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230227183151.27912-3-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/23 20:31, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 
> Restructured the code, added new structures and functions for
> SD4 operations. Also this adds some abstraction to the code
> which will make it modular and adaptable for further SD6 operations.
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 100 ++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 5276cdbc652f7faac13bb0244af4926b63dc119a..4f7e63c90e3d68da338b8964f08b7c65ebaf1ffd 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -59,16 +59,28 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> +struct sdhci_cdns_priv;
> +
>  struct sdhci_cdns_sd4_phy_param {
>  	u8 addr;
>  	u8 data;
>  };
>  
> +struct sdhci_cdns_data {
> +	int (*phy_init)(struct sdhci_cdns_priv *priv);
> +	int (*set_tune_val)(struct sdhci_host *host, unsigned int val);
> +};
> +
> +struct sdhci_cdns_sd4_phy {
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns_sd4_phy_param phy_params[];
> +};
> +
>  struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
>  	bool enhanced_strobe;
> -	unsigned int nr_phy_params;
> -	struct sdhci_cdns_sd4_phy_param phy_params[];
> +	const struct sdhci_cdns_data *cdns_data;

Simpler if there is just a pointer to struct sdhci_cdns_of_data
and get rid of struct sdhci_cdns_data.

> +	void *phy;
>  };
>  
>  struct sdhci_cdns_sd4_phy_cfg {
> @@ -76,6 +88,13 @@ struct sdhci_cdns_sd4_phy_cfg {
>  	u8 addr;
>  };
>  
> +struct sdhci_cdns_of_data {
> +	const struct sdhci_pltfm_data *pltfm_data;

Kernel style is not to unnecessarily have structures that point to
other structures or contain other structures.

Here, please just put the struct not a pointer i.e.

	struct sdhci_pltfm_data *pltfm_data;

> +	const struct sdhci_cdns_data *cdns_data;

Please get rid of struct sdhci_cdns_data. Instead just put its members here

> +	int (*phy_probe)(struct platform_device *pdev,
> +			 struct sdhci_cdns_priv *priv);
> +};
> +
>  static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
>  	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>  	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> @@ -135,9 +154,9 @@ static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
>  }
>  
>  static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
> -					   struct sdhci_cdns_priv *priv)
> +					   struct sdhci_cdns_sd4_phy *phy)
>  {
> -	struct sdhci_cdns_sd4_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns_sd4_phy_param *p = phy->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> @@ -156,10 +175,11 @@ static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
>  static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
>  {
>  	int ret, i;
> +	struct sdhci_cdns_sd4_phy *phy = priv->phy;
>  
> -	for (i = 0; i < priv->nr_phy_params; i++) {
> -		ret = sdhci_cdns_sd4_write_phy_reg(priv, priv->phy_params[i].addr,
> -						   priv->phy_params[i].data);
> +	for (i = 0; i < phy->nr_phy_params; i++) {
> +		ret = sdhci_cdns_sd4_write_phy_reg(priv, phy->phy_params[i].addr,
> +						   phy->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -202,6 +222,27 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>  	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
>  }
>  
> +static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
> +				    struct sdhci_cdns_priv *priv)
> +{
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns_sd4_phy *phy;
> +	struct device *dev = &pdev->dev;
> +
> +	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
> +	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
> +			   GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->nr_phy_params = nr_phy_params;
> +
> +	sdhci_cdns_sd4_phy_param_parse(dev->of_node, phy);
> +	priv->phy = phy;
> +
> +	return 0;
> +}
> +
>  static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
>  {
>  	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> @@ -323,10 +364,25 @@ static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> +static const struct sdhci_cdns_of_data sdhci_cdns_uniphier_of_data = {
> +	.pltfm_data = &sdhci_cdns_uniphier_pltfm_data,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_cdns_sd4_pltfm_data = {
>  	.ops = &sdhci_cdns_sd4_ops,
>  };
>  
> +static const struct sdhci_cdns_data sdhci_cdns_sd4_data = {
> +	.phy_init = sdhci_cdns_sd4_phy_init,
> +	.set_tune_val = sdhci_cdns_sd4_set_tune_val,
> +};
> +
> +static const struct sdhci_cdns_of_data sdhci_cdns_sd4_of_data = {
> +	.pltfm_data = &sdhci_cdns_sd4_pltfm_data,
> +	.cdns_data = &sdhci_cdns_sd4_data,
> +	.phy_probe = sdhci_cdns_sd4_phy_probe,
> +};
> +
>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					     struct mmc_ios *ios)
>  {
> @@ -350,11 +406,10 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
> -	const struct sdhci_pltfm_data *data;
> +	const struct sdhci_cdns_of_data *data;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> -	unsigned int nr_phy_params;
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> @@ -368,12 +423,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	data = of_device_get_match_data(dev);
> -	if (!data)
> -		data = &sdhci_cdns_sd4_pltfm_data;
> +	if (!data) {
> +		ret = -EINVAL;
> +		goto disable_clk;
> +	}
>  
> -	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
> -	host = sdhci_pltfm_init(pdev, data,
> -				struct_size(priv, phy_params, nr_phy_params));
> +	host = sdhci_pltfm_init(pdev, data->pltfm_data, sizeof(*priv));
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
>  		goto disable_clk;
> @@ -383,9 +438,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	pltfm_host->clk = clk;
>  
>  	priv = sdhci_pltfm_priv(pltfm_host);
> -	priv->nr_phy_params = nr_phy_params;
>  	priv->hrs_addr = host->ioaddr;
>  	priv->enhanced_strobe = false;
> +	priv->cdns_data = data->cdns_data;
>  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;
> @@ -398,9 +453,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free;
>  
> -	sdhci_cdns_sd4_phy_param_parse(dev->of_node, priv);
> +	ret = data->phy_probe(pdev, priv);
> +	if (ret)
> +		goto free;
>  
> -	ret = sdhci_cdns_sd4_phy_init(priv);
> +	ret = priv->cdns_data->phy_init(priv);

As was pointed out last time, you are dereferncing cdns_data unconditionally
when it could be NULL e.g. in the case of sdhci_cdns_uniphier_of_data

>  	if (ret)
>  		goto free;
>  
> @@ -429,7 +486,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns_sd4_phy_init(priv);
> +	ret = priv->cdns_data->phy_init(priv);
>  	if (ret)
>  		goto disable_clk;
>  
> @@ -453,9 +510,12 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
>  static const struct of_device_id sdhci_cdns_match[] = {
>  	{
>  		.compatible = "socionext,uniphier-sd4hc",
> -		.data = &sdhci_cdns_uniphier_pltfm_data,
> +		.data = &sdhci_cdns_uniphier_of_data,
> +	},
> +	{
> +		.compatible = "cdns,sd4hc",
> +		.data = &sdhci_cdns_sd4_of_data,
>  	},
> -	{ .compatible = "cdns,sd4hc" },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_cdns_match);

