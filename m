Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF46F944D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 23:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEFV7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEFV7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 17:59:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 187D421572;
        Sat,  6 May 2023 14:59:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35B8E1FB;
        Sat,  6 May 2023 14:59:50 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 990333F5A1;
        Sat,  6 May 2023 14:59:02 -0700 (PDT)
Date:   Sat, 6 May 2023 22:58:48 +0100
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
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/6] spi: sun6i: add quirk for in-controller clock
 divider
Message-ID: <20230506225848.3278d7ab@slackpad.lan>
In-Reply-To: <20230506073018.1411583-4-bigunclemax@gmail.com>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
        <20230506073018.1411583-4-bigunclemax@gmail.com>
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

On Sat,  6 May 2023 10:30:11 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Previously SPI controllers in Allwinner SoCs has a clock divider inside.
> However now the clock divider is removed and to set the transfer clock
> rate it's only needed to set the SPI module clock to the target value.
> 
> Add a quirk for this kind of SPI controllers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/spi/spi-sun6i.c | 68 +++++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 01a01cd86db5..82523011a3a5 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -87,6 +87,7 @@
>  
>  struct sun6i_spi_cfg {
>  	unsigned long		fifo_depth;
> +	bool			has_clk_ctl;
>  };
>  
>  struct sun6i_spi {
> @@ -260,7 +261,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  				  struct spi_transfer *tfr)
>  {
>  	struct sun6i_spi *sspi = spi_master_get_devdata(master);
> -	unsigned int mclk_rate, div, div_cdr1, div_cdr2, timeout;
> +	unsigned int div, div_cdr1, div_cdr2, timeout;
>  	unsigned int start, end, tx_time;
>  	unsigned int trig_level;
>  	unsigned int tx_len = 0, rx_len = 0;
> @@ -350,39 +351,44 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  
>  	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
>  
> -	/* Ensure that we have a parent clock fast enough */
> -	mclk_rate = clk_get_rate(sspi->mclk);
> -	if (mclk_rate < (2 * tfr->speed_hz)) {
> -		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> -		mclk_rate = clk_get_rate(sspi->mclk);
> -	}
> +	if (sspi->cfg->has_clk_ctl) {
> +		unsigned int mclk_rate = clk_get_rate(sspi->mclk);

New line here please, to separate variable declaration from code.

> +		/* Ensure that we have a parent clock fast enough */
> +		if (mclk_rate < (2 * tfr->speed_hz)) {
> +			clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> +			mclk_rate = clk_get_rate(sspi->mclk);
> +		}
>  
> -	/*
> -	 * Setup clock divider.
> -	 *
> -	 * We have two choices there. Either we can use the clock
> -	 * divide rate 1, which is calculated thanks to this formula:
> -	 * SPI_CLK = MOD_CLK / (2 ^ cdr)
> -	 * Or we can use CDR2, which is calculated with the formula:
> -	 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
> -	 * Wether we use the former or the latter is set through the
> -	 * DRS bit.
> -	 *
> -	 * First try CDR2, and if we can't reach the expected
> -	 * frequency, fall back to CDR1.
> -	 */
> -	div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
> -	div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
> -	if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
> -		reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
> -		tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
> +		/*
> +		 * Setup clock divider.
> +		 *
> +		 * We have two choices there. Either we can use the clock
> +		 * divide rate 1, which is calculated thanks to this formula:
> +		 * SPI_CLK = MOD_CLK / (2 ^ cdr)
> +		 * Or we can use CDR2, which is calculated with the formula:
> +		 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
> +		 * Wether we use the former or the latter is set through the
> +		 * DRS bit.
> +		 *
> +		 * First try CDR2, and if we can't reach the expected
> +		 * frequency, fall back to CDR1.
> +		 */
> +		div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
> +		div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
> +		if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
> +			reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
> +			tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
> +		} else {
> +			div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
> +			reg = SUN6I_CLK_CTL_CDR1(div);
> +			tfr->effective_speed_hz = mclk_rate / (1 << div);
> +		}
> +
> +		sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
>  	} else {
> -		div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
> -		reg = SUN6I_CLK_CTL_CDR1(div);
> -		tfr->effective_speed_hz = mclk_rate / (1 << div);
> +		clk_set_rate(sspi->mclk, tfr->speed_hz);

Don't we need to set tfr->effective_speed_hz to the actually programmed
clock rate here?

The rest looks fine, it's really mostly that old block indented.

Cheers,
Andre

>  	}
>  
> -	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
>  	/* Finally enable the bus - doing so before might raise SCK to HIGH */
>  	reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
>  	reg |= SUN6I_GBL_CTL_BUS_ENABLE;
> @@ -701,10 +707,12 @@ static void sun6i_spi_remove(struct platform_device *pdev)
>  
>  static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
>  	.fifo_depth	= SUN6I_FIFO_DEPTH,
> +	.has_clk_ctl	= true,
>  };
>  
>  static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
>  	.fifo_depth	= SUN8I_FIFO_DEPTH,
> +	.has_clk_ctl	= true,
>  };
>  
>  static const struct of_device_id sun6i_spi_match[] = {

