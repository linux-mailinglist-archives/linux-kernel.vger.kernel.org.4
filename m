Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8516F9450
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 23:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjEFV7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 17:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEFV7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 17:59:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FA4D203E6;
        Sat,  6 May 2023 14:59:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AC2C1FB;
        Sat,  6 May 2023 15:00:04 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CEFA3F5A1;
        Sat,  6 May 2023 14:59:16 -0700 (PDT)
Date:   Sat, 6 May 2023 22:59:02 +0100
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/6] spi: sun6i: add support for R329 SPI controllers
Message-ID: <20230506225902.018ab828@slackpad.lan>
In-Reply-To: <20230506073018.1411583-5-bigunclemax@gmail.com>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
        <20230506073018.1411583-5-bigunclemax@gmail.com>
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

On Sat,  6 May 2023 10:30:12 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
> 
> R329 has two SPI controllers. One of it is quite similar to previous
> ones, but with internal clock divider removed; the other added MIPI DBI
> Type-C offload based on the first one.
> 
> Add basical support for these controllers. As we're not going to
> support the DBI functionality now, just implement the two kinds of
> controllers as the same.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/spi/spi-sun6i.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 82523011a3a5..fe287a45df9b 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -715,9 +715,21 @@ static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
>  	.has_clk_ctl	= true,
>  };
>  
> +static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
> +	.fifo_depth	= SUN8I_FIFO_DEPTH,
> +};
> +
>  static const struct of_device_id sun6i_spi_match[] = {
>  	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
>  	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
> +	{
> +		.compatible = "allwinner,sun50i-r329-spi",
> +		.data = &sun50i_r329_spi_cfg
> +	},
> +	{
> +		.compatible = "allwinner,sun50i-r329-spi-dbi",
> +		.data = &sun50i_r329_spi_cfg
> +	},

As mentioned by others, we would not need to mention this compatible
string in the driver, the fallback string in the DT should take care
of the detection.

Rest looks fine.

Cheers,
Andre

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_spi_match);

