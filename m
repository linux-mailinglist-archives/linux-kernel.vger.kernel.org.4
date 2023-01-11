Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DFA6655F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjAKIYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbjAKIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:23:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17CD1000;
        Wed, 11 Jan 2023 00:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673425430; x=1704961430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iNWrT922LmReXHq/JGYW4tBxvn+UkA4L0Brokd55I1k=;
  b=eYgcFbIbYCkG4dXR+YBAm9mLqLMAlq+Weq6M+vYK3uaWbjo/4WrADr/4
   b7lFA9M4O0MeE3UHb8Xy9j1YXRhhCOtJiatzhzh2ha+MMzrKA881XZ6dD
   1kIsf+/zcSe8Bix/mgx+nkIC0lohSt8lOfvK7ZNnQ6itV+9Aa/BsxNxVR
   M5GztPdzK3pX3Trgodd+BviNYRkDiNeNnt4vTtYtB5OLZledvf+V9OVJn
   tzSiuj+gNuEDK7WYz0AksdReaKZtCs7xYPnVH+iwzaG3XafdPlCXrE3ae
   7S5BINul8UdWfM/Ub4fSDH7PLaaTNasrzlkRpn3V+C5Y7xhkLUBCeT7n/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387820503"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="387820503"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:23:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607281441"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="607281441"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.49])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:23:46 -0800
Message-ID: <35ea0a7a-3d63-26b7-4dc3-69f6ca41909a@intel.com>
Date:   Wed, 11 Jan 2023 10:23:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 2/5] drivers: mmc: sdhci-cadence: enable
 MMC_SDHCI_IO_ACCESSORS
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-3-pmalgujar@marvell.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221219142418.27949-3-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/22 16:24, Piyush Malgujar wrote:
> From: Jayanthi Annadurai <jannadurai@marvell.com>
> 
> Add support for CONFIG_MMC_SDHCI_IO_ACCESSORS for controller
> specific register read and write APIs.
> 
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/Kconfig         | 12 ++++++
>  drivers/mmc/host/sdhci-cadence.c | 63 ++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5e19a961c34d7b5664ab2fd43cfba82dc90913ac..b5b2ae0bb4625bdb9d17acdbb1887c9caa3a1f32 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -262,6 +262,18 @@ config MMC_SDHCI_CADENCE
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_CN10K
> +	tristate "SDHCI Cadence support for Marvell CN10K platforms"
> +	select MMC_SDHCI_CADENCE
> +	select MMC_SDHCI_IO_ACCESSORS

Probably better to just add MMC_SDHCI_IO_ACCESSORS to 
config MMC_SDHCI_CADENCE and drop MMC_SDHCI_CN10K

> +	help
> +	  This selects the SDHCI cadence driver and IO Accessors
> +	  for Marvell CN10K platforms
> +
> +	  If you have Marvell CN10K platform, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_CNS3XXX
>  	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
>  	depends on ARCH_CNS3XXX || COMPILE_TEST
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 5332d19e489be936d6814feba4f0fc046f5e130e..6bf703f15bc5be7e3be4cb1144b78ec3585ec540 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -449,6 +449,61 @@ static u32 read_dqs_cmd_delay, clk_wrdqs_delay, clk_wr_delay, read_dqs_delay;
>  
>  static u32 sdhci_cdns_sd6_get_mode(struct sdhci_host *host, unsigned int timing);
>  
> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> +static u32 sdhci_cdns_sd6_readl(struct sdhci_host *host, int reg)
> +{
> +	return readl(host->ioaddr + reg);
> +}
> +
> +static void sdhci_cdns_sd6_writel(struct sdhci_host *host, u32 val, int reg)
> +{
> +	writel(val, host->ioaddr + reg);
> +}
> +
> +static u16 sdhci_cdns_sd6_readw(struct sdhci_host *host, int reg)
> +{
> +	u32 val, regoff;
> +
> +	regoff = reg & ~3;
> +
> +	val = readl(host->ioaddr + regoff);
> +	if ((reg & 0x3) == 0)
> +		return (val & 0xFFFF);
> +	else
> +		return ((val >> 16) & 0xFFFF);
> +}
> +
> +static void sdhci_cdns_sd6_writew(struct sdhci_host *host, u16 val, int reg)
> +{
> +	writew(val, host->ioaddr + reg);
> +}
> +
> +static u8 sdhci_cdns_sd6_readb(struct sdhci_host *host, int reg)
> +{
> +	u32 val, regoff;
> +
> +	regoff = reg & ~3;
> +
> +	val = readl(host->ioaddr + regoff);
> +	switch (reg & 3) {
> +	case 0:
> +		return (val & 0xFF);
> +	case 1:
> +		return ((val >> 8) & 0xFF);
> +	case 2:
> +		return ((val >> 16) & 0xFF);
> +	case 3:
> +		return ((val >> 24) & 0xFF);
> +	}
> +	return 0;
> +}
> +
> +static void sdhci_cdns_sd6_writeb(struct sdhci_host *host, u8 val, int reg)
> +{
> +	writeb(val, host->ioaddr + reg);
> +}
> +#endif
> +
>  static int sdhci_cdns_sd6_phy_lock_dll(struct sdhci_cdns_sd6_phy *phy)
>  {
>  	u32 delay_element = phy->d.delay_element_org;
> @@ -1576,6 +1631,14 @@ static const struct sdhci_ops sdhci_cdns_sd4_ops = {
>  };
>  
>  static const struct sdhci_ops sdhci_cdns_sd6_ops = {
> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> +	.read_l = sdhci_cdns_sd6_readl,
> +	.write_l = sdhci_cdns_sd6_writel,
> +	.read_w = sdhci_cdns_sd6_readw,
> +	.write_w = sdhci_cdns_sd6_writew,
> +	.read_b = sdhci_cdns_sd6_readb,
> +	.write_b = sdhci_cdns_sd6_writeb,
> +#endif
>  	.get_max_clock = sdhci_cdns_get_max_clock,
>  	.set_clock = sdhci_cdns_sd6_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,

