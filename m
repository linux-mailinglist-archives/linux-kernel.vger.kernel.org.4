Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC2D6F944B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 23:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjEFV6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 17:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFV6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 17:58:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E93C21E98F;
        Sat,  6 May 2023 14:58:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBAE81FB;
        Sat,  6 May 2023 14:59:29 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CF0A3F5A1;
        Sat,  6 May 2023 14:58:42 -0700 (PDT)
Date:   Sat, 6 May 2023 22:58:28 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] spi: sun6i: change OF match data to a struct
Message-ID: <20230506225828.3a2d1ef0@slackpad.lan>
In-Reply-To: <20230506073018.1411583-3-bigunclemax@gmail.com>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
        <20230506073018.1411583-3-bigunclemax@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 May 2023 10:30:10 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
> 
> As we're adding more properties to the OF match data, convert it to a
> struct now.

Confirmed to be just a refactor of the existing code.

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Even if you don't change anything, and just send a patch on her behalf,
you need to add you own Signed-off-by: (applies to the other patches as
well). With that fixed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/spi/spi-sun6i.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 7532c85a352c..01a01cd86db5 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -85,6 +85,10 @@
>  #define SUN6I_TXDATA_REG		0x200
>  #define SUN6I_RXDATA_REG		0x300
>  
> +struct sun6i_spi_cfg {
> +	unsigned long		fifo_depth;
> +};
> +
>  struct sun6i_spi {
>  	struct spi_master	*master;
>  	void __iomem		*base_addr;
> @@ -99,7 +103,7 @@ struct sun6i_spi {
>  	const u8		*tx_buf;
>  	u8			*rx_buf;
>  	int			len;
> -	unsigned long		fifo_depth;
> +	const struct sun6i_spi_cfg *cfg;
>  };
>  
>  static inline u32 sun6i_spi_read(struct sun6i_spi *sspi, u32 reg)
> @@ -156,7 +160,7 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi)
>  	u8 byte;
>  
>  	/* See how much data we can fit */
> -	cnt = sspi->fifo_depth - sun6i_spi_get_tx_fifo_count(sspi);
> +	cnt = sspi->cfg->fifo_depth - sun6i_spi_get_tx_fifo_count(sspi);
>  
>  	len = min((int)cnt, sspi->len);
>  
> @@ -289,14 +293,14 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  		 * the hardcoded value used in old generation of Allwinner
>  		 * SPI controller. (See spi-sun4i.c)
>  		 */
> -		trig_level = sspi->fifo_depth / 4 * 3;
> +		trig_level = sspi->cfg->fifo_depth / 4 * 3;
>  	} else {
>  		/*
>  		 * Setup FIFO DMA request trigger level
>  		 * We choose 1/2 of the full fifo depth, that value will
>  		 * be used as DMA burst length.
>  		 */
> -		trig_level = sspi->fifo_depth / 2;
> +		trig_level = sspi->cfg->fifo_depth / 2;
>  
>  		if (tfr->tx_buf)
>  			reg |= SUN6I_FIFO_CTL_TF_DRQ_EN;
> @@ -410,9 +414,9 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  	reg = SUN6I_INT_CTL_TC;
>  
>  	if (!use_dma) {
> -		if (rx_len > sspi->fifo_depth)
> +		if (rx_len > sspi->cfg->fifo_depth)
>  			reg |= SUN6I_INT_CTL_RF_RDY;
> -		if (tx_len > sspi->fifo_depth)
> +		if (tx_len > sspi->cfg->fifo_depth)
>  			reg |= SUN6I_INT_CTL_TF_ERQ;
>  	}
>  
> @@ -543,7 +547,7 @@ static bool sun6i_spi_can_dma(struct spi_master *master,
>  	 * the fifo length we can just fill the fifo and wait for a single
>  	 * irq, so don't bother setting up dma
>  	 */
> -	return xfer->len > sspi->fifo_depth;
> +	return xfer->len > sspi->cfg->fifo_depth;
>  }
>  
>  static int sun6i_spi_probe(struct platform_device *pdev)
> @@ -582,7 +586,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
>  	}
>  
>  	sspi->master = master;
> -	sspi->fifo_depth = (unsigned long)of_device_get_match_data(&pdev->dev);
> +	sspi->cfg = of_device_get_match_data(&pdev->dev);
>  
>  	master->max_speed_hz = 100 * 1000 * 1000;
>  	master->min_speed_hz = 3 * 1000;
> @@ -695,9 +699,17 @@ static void sun6i_spi_remove(struct platform_device *pdev)
>  		dma_release_channel(master->dma_rx);
>  }
>  
> +static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
> +	.fifo_depth	= SUN6I_FIFO_DEPTH,
> +};
> +
> +static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
> +	.fifo_depth	= SUN8I_FIFO_DEPTH,
> +};
> +
>  static const struct of_device_id sun6i_spi_match[] = {
> -	{ .compatible = "allwinner,sun6i-a31-spi", .data = (void *)SUN6I_FIFO_DEPTH },
> -	{ .compatible = "allwinner,sun8i-h3-spi",  .data = (void *)SUN8I_FIFO_DEPTH },
> +	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
> +	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_spi_match);

