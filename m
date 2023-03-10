Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327666B3D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCJLKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:10:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29B1F2090;
        Fri, 10 Mar 2023 03:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678446604; x=1709982604;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/+tFdW/YBwQDnb1ty9VRIvJdaL18kxs2PMLLcO8L0DU=;
  b=RGRp34MJUxpUfyxEl78Xy3HzzGeoAJi4WtxRovbJxSJRddhgJ3K56YKc
   XILKCq3yc2GT6ff2zmtQsybILkRXFYD2qFeUVCNfhkD/GmSgjD8n9zbt9
   IzRC6ziw0+qLgak0XkKJ3IMe302eQro2BHlkoICIazCxHDQ5iU70Yxrai
   ZpqfkWD2outhHzhds7DwPNA41FGb+22qS1/62If9Ict33pVZYanPAKDK9
   K6qc3DWXYwfcp6/UXlBeNZWy2bZsG/kaCZnqYRzD1p6wlp6MD0z2XKfwJ
   qYRpJz9ajqpMy6n//eO/t7/uEbTzIOfgqwj71Q6wm1I5N8AF0npEm+tS8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="336722988"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="336722988"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707973911"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="707973911"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:09:55 -0800
Message-ID: <8d034a7c-8702-a146-3021-2101b3382848@intel.com>
Date:   Fri, 10 Mar 2023 13:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v10 11/15] mmc: sdhci-cadence: Enable device specific
 override of writel()
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
 <20230306040739.51488-12-blarson@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230306040739.51488-12-blarson@amd.com>
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
> SoCs with device specific Cadence implementation, such as setting
> byte-enables before the write, need to override writel().  Add a
> callback where the default is writel() for all existing chips.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> v10 changes:
> - The 1st patch adding private writel() is unchanged.  The 2nd patch is split
>   into two patches to provide for device specific init in one patch with no
>   effect on existing designs.  Then add the pensando support into the next patch.
>   Then the 4th patch is mmc hardware reset support which is unchanged.
> 
> v9 changes:
> - No change to this patch but as some patches are deleted and this is
>   a respin the three successive patches to sdhci-cadence.c are
>   patches 12, 13, and 14 which do the following:
> 
>   1. Add ability for Cadence specific design to have priv writel().
>   2. Add Elba SoC support that requires its own priv writel() for
>      byte-lane control .
>   3. Add support for mmc hardware reset.
> 
> ---
>  drivers/mmc/host/sdhci-cadence.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 6f2de54a5987..708d4297f241 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -67,6 +67,7 @@ struct sdhci_cdns_phy_param {
>  struct sdhci_cdns_priv {
>  	void __iomem *hrs_addr;
>  	bool enhanced_strobe;
> +	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	unsigned int nr_phy_params;
>  	struct sdhci_cdns_phy_param phy_params[];
>  };
> @@ -90,6 +91,12 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>  	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
>  };
>  
> +static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
> +			       void __iomem *reg)
> +{
> +	writel(val, reg);
> +}
> +
>  static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>  				    u8 addr, u8 data)
>  {
> @@ -104,17 +111,17 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>  
>  	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
>  	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
> -	writel(tmp, reg);
> +	priv->priv_writel(priv, tmp, reg);
>  
>  	tmp |= SDHCI_CDNS_HRS04_WR;
> -	writel(tmp, reg);
> +	priv->priv_writel(priv, tmp, reg);
>  
>  	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
>  	if (ret)
>  		return ret;
>  
>  	tmp &= ~SDHCI_CDNS_HRS04_WR;
> -	writel(tmp, reg);
> +	priv->priv_writel(priv, tmp, reg);
>  
>  	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
>  				 0, 10);
> @@ -191,7 +198,7 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
>  	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
>  	tmp &= ~SDHCI_CDNS_HRS06_MODE;
>  	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
> -	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
> +	priv->priv_writel(priv, tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
>  }
>  
>  static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
> @@ -223,7 +230,7 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>  	 */
>  	for (i = 0; i < 2; i++) {
>  		tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
> -		writel(tmp, reg);
> +		priv->priv_writel(priv, tmp, reg);
>  
>  		ret = readl_poll_timeout(reg, tmp,
>  					 !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
> @@ -386,6 +393,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	priv->nr_phy_params = nr_phy_params;
>  	priv->hrs_addr = host->ioaddr;
>  	priv->enhanced_strobe = false;
> +	priv->priv_writel = cdns_writel;
>  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  				sdhci_cdns_hs400_enhanced_strobe;

