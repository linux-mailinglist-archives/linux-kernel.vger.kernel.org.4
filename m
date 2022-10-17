Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985916016BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJQS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJQS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:57:32 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2E754AE;
        Mon, 17 Oct 2022 11:57:31 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-134072c15c1so14349921fac.2;
        Mon, 17 Oct 2022 11:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhi01nIKMu8oS63Us1m9T4vtO8yAbuN6/vPxNd3xC04=;
        b=Zh5B6ZViLeAtu7JJ7aZYHQqghCUrS29QLD9jB6hc286jDTc5gNqGK/CRu0jtOkFgKs
         hlFXTRck4FrXaRcVKt7tW6+U26COll4eN3Gu+d26tJIB4ijYcPQvmJTguzYeCFlIINpZ
         9RBPHEL+XY4EU/At81Fhl4JLlZLhgq4xL0jQTgvqxQBaN6UhfZ0e/bz6Z2arn/ETzXpo
         8diArGkLuZ1VlR6km4VVc+MXeq68rdIyicUOeZeP1moyRTnQ7NUuIhTCElbKG3E0Tw8d
         H4frCInSwPa5BRk6HrEYylAUT2gDSXP4fln+uE2FuWzQa3OUF33bcB9g9+iM7rHpHquO
         L4IQ==
X-Gm-Message-State: ACrzQf37Yc/exKDQ8BSWGKdV17nqTVPayWe6fzETCTRW2grFgPu9Z9wT
        CdVLjkaHTDhG6k2SydTJjw==
X-Google-Smtp-Source: AMsMyM6hd4KpSHEGg5rpmw44Oeh0ybM1WiVTBmJIC/qj0uwN3RJKLDIGEfvrnaZYCvC5RjxH/lV8IQ==
X-Received: by 2002:a05:6870:c8a2:b0:136:5491:8f08 with SMTP id er34-20020a056870c8a200b0013654918f08mr15781649oab.225.1666033050385;
        Mon, 17 Oct 2022 11:57:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a4a8244000000b004805c328971sm4500369oog.42.2022.10.17.11.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:57:30 -0700 (PDT)
Received: (nullmailer pid 2279555 invoked by uid 1000);
        Mon, 17 Oct 2022 18:57:30 -0000
Date:   Mon, 17 Oct 2022 13:57:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>
Subject: Re: [PATCH linux v2 2/3] spi: aspeed: Handle custom decoding ranges
Message-ID: <20221017185730.GB2264550-robh@kernel.org>
References: <20221017091624.130227-1-clg@kaod.org>
 <20221017091624.130227-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221017091624.130227-3-clg@kaod.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:16:23AM +0200, Cédric Le Goater wrote:
> The "ranges" property predefines settings for the decoding ranges of
> each CS. If found in the DT, the driver applies the settings at probe
> time. The default behavior is to set the decoding range of each CS
> using the flash device size when the spi slave is setup.
> 
> Cc: Naresh Solanki <naresh.solanki@9elements.com>
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c | 65 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index b90571396a60..75e1d08bbd00 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -96,6 +96,7 @@ struct aspeed_spi {
>  	u32			 ahb_base_phy;
>  	u32			 ahb_window_size;
>  	struct device		*dev;
> +	bool                     fixed_windows;
>  
>  	struct clk		*clk;
>  	u32			 clk_freq;
> @@ -382,6 +383,7 @@ static const char *aspeed_spi_get_name(struct spi_mem *mem)
>  
>  struct aspeed_spi_window {
>  	u32 cs;
> +	u32 reg;
>  	u32 offset;
>  	u32 size;
>  };
> @@ -396,6 +398,7 @@ static void aspeed_spi_get_windows(struct aspeed_spi *aspi,
>  	for (cs = 0; cs < aspi->data->max_cs; cs++) {
>  		reg_val = readl(aspi->regs + CE0_SEGMENT_ADDR_REG + cs * 4);
>  		windows[cs].cs = cs;
> +		windows[cs].reg = reg_val;
>  		windows[cs].size = data->segment_end(aspi, reg_val) -
>  			data->segment_start(aspi, reg_val);
>  		windows[cs].offset = data->segment_start(aspi, reg_val) - aspi->ahb_base_phy;
> @@ -572,7 +575,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  	if (op->data.dir != SPI_MEM_DATA_IN)
>  		return -EOPNOTSUPP;
>  
> -	aspeed_spi_chip_adjust_window(chip, desc->info.offset, desc->info.length);
> +	if (!aspi->fixed_windows)
> +		aspeed_spi_chip_adjust_window(chip, desc->info.offset, desc->info.length);
>  
>  	if (desc->info.length > chip->ahb_window_size)
>  		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
> @@ -712,6 +716,61 @@ static void aspeed_spi_enable(struct aspeed_spi *aspi, bool enable)
>  		aspeed_spi_chip_enable(aspi, cs, enable);
>  }
>  
> +static int aspeed_spi_chip_read_ranges(struct device_node *node, struct aspeed_spi *aspi)
> +{
> +	const char *range_prop = "ranges";
> +	struct property *prop;
> +	struct aspeed_spi_window ranges[ASPEED_SPI_MAX_NUM_CS];
> +	int prop_size;
> +	int count;
> +	int ret;
> +	int i;
> +
> +	prop = of_find_property(node, range_prop, &prop_size);
> +	if (!prop)
> +		return 0;

Parsing common properties yourself is generally a bad sign.

> +
> +	count = prop_size / sizeof(*ranges);
> +	if (count > aspi->data->max_cs) {
> +		dev_err(aspi->dev, "invalid '%s' property %d\n", range_prop, count);
> +		return -EINVAL;
> +	}
> +
> +	if (count < aspi->data->max_cs)
> +		dev_dbg(aspi->dev, "'%s' property does not cover all CE\n",
> +			range_prop);
> +
> +	ret = of_property_read_u32_array(node, range_prop, (u32 *)ranges, count * 4);

You've just gotten it horribly wrong because you ignored #size-cells and 
#address-cells.

Rob
