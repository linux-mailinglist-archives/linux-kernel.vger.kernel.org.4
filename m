Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F13065519C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiLWOvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiLWOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:50:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93B6A455;
        Fri, 23 Dec 2022 06:50:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4682561159;
        Fri, 23 Dec 2022 14:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4128EC433D2;
        Fri, 23 Dec 2022 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671807054;
        bh=4K2LR1mKGCEDbOYGpT+xa0qQCRxGXiezsVQLLM1EEPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N8YX3WO7Uxxpmwr1uYiej8yKMS+4faMag0f7Ev5bIdH8mkFpBuf2lQrW3jK7fMCrX
         AUw1xVHFHYiyReiPKvpSy863KaW4mJXFt0wFl43cW8SKxtu7QeWhVTqlUKrK9yOpjr
         FWOGgdCHtSBYHgH+XjDopMMCol9KyGBoSE0f0anjxVNQ/gzXtth+zeEWh8/bT5Sshz
         6hSOXRtwcpYM5O5i+8Syuyoo0+XHL5cvKko262+wB8cQgnunm2dpp0NLMqNn6twMik
         n2PI3At0xGEE/aWRimUPFcFPAVJSc2leHe9/RE7jixjv866kfP82+98+qDayeYZnbA
         YbyJZ+b/CUAzw==
Date:   Fri, 23 Dec 2022 15:04:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: add id registers support
Message-ID: <20221223150403.0566863e@jic23-huawei>
In-Reply-To: <20221222090806.934879-1-olivier.moysan@foss.st.com>
References: <20221222090806.934879-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 10:08:06 +0100
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add support of identification registers to STM32 DFSDM
> to allow hardware capabilities discovery and configuration check.
> The number of filters and channels, are read from registers,
> when they are available.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Hi Olivier,

A few minor comments inline.  The fact that this facility only exists
on some supported parts needs a little more documentation.

Thanks

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 93 +++++++++++++++++++++++++-----
>  drivers/iio/adc/stm32-dfsdm.h      | 69 ++++++++++++++++------
>  2 files changed, 127 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index a3d4de6ba4c2..7f1e4767d4ff 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -6,6 +6,7 @@
>   * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -20,6 +21,7 @@
>  #include "stm32-dfsdm.h"
>  

As we now have a situation where we 'either' set ipid or
num_filters + num_channels and that's non obvious, I'd like to see some
documentation for this structure to explain what is going on.

>  struct stm32_dfsdm_dev_data {
> +	u32 ipid;
>  	unsigned int num_filters;
>  	unsigned int num_channels;
>  	const struct regmap_config *regmap_cfg;
> @@ -27,8 +29,6 @@ struct stm32_dfsdm_dev_data {
>  
>  #define STM32H7_DFSDM_NUM_FILTERS	4
>  #define STM32H7_DFSDM_NUM_CHANNELS	8
> -#define STM32MP1_DFSDM_NUM_FILTERS	6
> -#define STM32MP1_DFSDM_NUM_CHANNELS	8
>  
>  static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
>  {
> @@ -75,8 +75,7 @@ static const struct regmap_config stm32mp1_dfsdm_regmap_cfg = {
>  };
>  
>  static const struct stm32_dfsdm_dev_data stm32mp1_dfsdm_data = {
> -	.num_filters = STM32MP1_DFSDM_NUM_FILTERS,
> -	.num_channels = STM32MP1_DFSDM_NUM_CHANNELS,
> +	.ipid = STM32MP15_IPIDR_NUMBER,
>  	.regmap_cfg = &stm32mp1_dfsdm_regmap_cfg,
>  };
>  
> @@ -295,6 +294,66 @@ static const struct of_device_id stm32_dfsdm_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
>  
> +static int stm32_dfsdm_probe_identification(struct platform_device *pdev,
> +					    struct dfsdm_priv *priv,
> +					    const struct stm32_dfsdm_dev_data *dev_data)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *child;
> +	struct stm32_dfsdm *dfsdm = &priv->dfsdm;
> +	const char *compat;
> +	int ret, count = 0;
> +	u32 id, val;
> +
> +	if (!dev_data->ipid) {
> +		dfsdm->num_fls = dev_data->num_filters;
> +		dfsdm->num_chs = dev_data->num_channels;
> +		return 0;
> +	}
> +
> +	ret = regmap_read(dfsdm->regmap, DFSDM_IPIDR, &val);
> +	if (ret)
> +		return ret;
> +
> +	id = FIELD_GET(DFSDM_IPIDR_MASK, val);

As mentioned below. This is the whole register, so I would not bother
masking it.

> +	if (id != dev_data->ipid) {
> +		dev_err(&pdev->dev, "Unexpected IP version: 0x%x", id);
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(np, child) {
> +		ret = of_property_read_string(child, "compatible", &compat);
> +		if (ret)
> +			continue;
> +		/* Count only child nodes with dfsdm compatible */
> +		if (strstr(compat, "dfsdm"))
> +			count++;
> +	}
> +
> +	ret = regmap_read(dfsdm->regmap, DFSDM_HWCFGR, &val);
> +	if (ret)
> +		return ret;
> +
> +	dfsdm->num_fls = FIELD_GET(DFSDM_HWCFGR_NBF_MASK, val);
> +	dfsdm->num_chs = FIELD_GET(DFSDM_HWCFGR_NBT_MASK, val);
> +
> +	if (count > dfsdm->num_fls) {
> +		dev_err(&pdev->dev, "Unexpected child number: %d", count);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(dfsdm->regmap, DFSDM_VERR, &val);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(&pdev->dev, "DFSDM version: %lu.%lu. %d channels/%d filters\n",
> +		FIELD_GET(DFSDM_VERR_MAJREV_MASK, val),
> +		FIELD_GET(DFSDM_VERR_MINREV_MASK, val),
> +		dfsdm->num_chs, dfsdm->num_fls);
> +
> +	return 0;
> +}
> +

> diff --git a/drivers/iio/adc/stm32-dfsdm.h b/drivers/iio/adc/stm32-dfsdm.h
> index 4afc1f528b78..4f230e2a7692 100644
> --- a/drivers/iio/adc/stm32-dfsdm.h
> +++ b/drivers/iio/adc/stm32-dfsdm.h
> @@ -13,25 +13,28 @@
>  
>  /*
>   * STM32 DFSDM - global register map
> - * ________________________________________________________
> - * | Offset |                 Registers block             |
> - * --------------------------------------------------------
> - * | 0x000  |      CHANNEL 0 + COMMON CHANNEL FIELDS      |
> - * --------------------------------------------------------
> - * | 0x020  |                CHANNEL 1                    |
> - * --------------------------------------------------------
> - * | ...    |                .....                        |
> - * --------------------------------------------------------
> - * | 0x0E0  |                CHANNEL 7                    |
> - * --------------------------------------------------------
> - * | 0x100  |      FILTER  0 + COMMON  FILTER FIELDs      |
> - * --------------------------------------------------------
> - * | 0x200  |                FILTER  1                    |
> - * --------------------------------------------------------
> - * | 0x300  |                FILTER  2                    |
> - * --------------------------------------------------------
> - * | 0x400  |                FILTER  3                    |
> - * --------------------------------------------------------
> + * __________________________________________________________
> + * | Offset   |                 Registers block             |

Original alignment is odd.  Maybe pull that "Registers block"
somewhere near central?

> + * ----------------------------------------------------------
> + * | 0x000    |      CHANNEL 0 + COMMON CHANNEL FIELDS      |
> + * ----------------------------------------------------------
> + * | 0x020    |                CHANNEL 1                    |
> + * ----------------------------------------------------------
> + * | ...      |                .....                        |
> + * ----------------------------------------------------------
> + * | 0x20 x n |                CHANNEL n                    |
> + * ----------------------------------------------------------
> + * | 0x100    |      FILTER  0 + COMMON FILTER FIELDs       |
> + * ----------------------------------------------------------
> + * | 0x200    |                FILTER  1                    |
> + * ----------------------------------------------------------
> + * |          |                .....                        |
> + * ----------------------------------------------------------
> + * | 0x100 x m|                FILTER  m                    |
> + * ----------------------------------------------------------
> + * ----------------------------------------------------------
> + * | 0x7F0-7FC|         Identification registers            |
> + * ----------------------------------------------------------

Nicer to future proof it a little and add at least one or
two more spaces before the column separator.

>   */
>  
>  /*
> @@ -231,6 +234,34 @@
>  #define DFSDM_AWCFR_AWHTF_MASK	GENMASK(15, 8)
>  #define DFSDM_AWCFR_AWHTF(v)	FIELD_PREP(DFSDM_AWCFR_AWHTF_MASK, v)
>  
> +/*
> + * Identification register definitions
> + */
> +#define DFSDM_HWCFGR		0x7F0
> +#define DFSDM_VERR		0x7F4
> +#define DFSDM_IPIDR		0x7F8
> +#define DFSDM_SIDR		0x7FC
> +
> +/* HWCFGR: Hardware configuration register */
> +#define DFSDM_HWCFGR_NBT_SHIFT	0
> +#define DFSDM_HWCFGR_NBT_MASK	GENMASK(7, 0)
> +#define DFSDM_HWCFGR_NBF_SHIFT	8
> +#define DFSDM_HWCFGR_NBF_MASK	GENMASK(15, 8)
> +
> +/* VERR: Version register */
> +#define DFSDM_VERR_MINREV_SHIFT	0
> +#define DFSDM_VERR_MINREV_MASK	GENMASK(3, 0)
> +#define DFSDM_VERR_MAJREV_SHIFT	4
> +#define DFSDM_VERR_MAJREV_MASK	GENMASK(7, 4)
> +
> +/* IPDR: Identification register */
> +#define DFSDM_IPIDR_MASK	GENMASK(31, 0)
Isn't this the whole register?  Under those circumstances, 
I don't see any point in having a mask.
> +
> +/* SIDR: Size identification register */
> +#define DFSDM_SIDR_MASK		GENMASK(31, 0)
> +
> +#define STM32MP15_IPIDR_NUMBER	0x00110031
> +
>  /* DFSDM filter order  */
>  enum stm32_dfsdm_sinc_order {
>  	DFSDM_FASTSINC_ORDER, /* FastSinc filter type */

