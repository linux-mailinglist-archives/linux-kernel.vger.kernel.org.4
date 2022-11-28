Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2D63AA03
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiK1Ntb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiK1Nt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:49:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F961EECF;
        Mon, 28 Nov 2022 05:49:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E15EE6118A;
        Mon, 28 Nov 2022 13:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF178C433D7;
        Mon, 28 Nov 2022 13:49:18 +0000 (UTC)
Message-ID: <738a2461-7a6a-286b-89e8-d46a26ec6506@xs4all.nl>
Date:   Mon, 28 Nov 2022 14:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 6/9] media: i2c: ov5645: Use runtime PM
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221031232202.131945-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221031232202.131945-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On 11/1/22 00:21, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Switch to using runtime PM for power management.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v3->v4
> * Fixed comments pointed by Sakari
> 
> v2->v3
> * Jumped to err_pm_runtime label in case of sd register failure
> * Now calling pm_runtime_mark_last_busy() before pm_runtime_put_autosuspend()
>   call
> * Now calling pm_runtime_put_sync() in case s_stream(1) fails
> * In s_stream(0) no calling pm_runtime_mark_last_busy() and
>   pm_runtime_put_autosuspend()
> * Included RB tag from Laurent.
> 
> v1->v2
> * Moved pm_runtime_*_autosuspend() calls after registering the subdev.
> ---
>  drivers/media/i2c/ov5645.c | 133 +++++++++++++++++++------------------
>  1 file changed, 68 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> index 47451238ca05..2e6135d0a31a 100644
> --- a/drivers/media/i2c/ov5645.c
> +++ b/drivers/media/i2c/ov5645.c
> @@ -27,6 +27,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_graph.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -108,7 +109,6 @@ struct ov5645 {
>  	u8 timing_tc_reg21;
>  
>  	struct mutex power_lock; /* lock to protect power state */
> -	int power_count;
>  
>  	struct gpio_desc *enable_gpio;
>  	struct gpio_desc *rst_gpio;
> @@ -635,8 +635,24 @@ static int ov5645_set_register_array(struct ov5645 *ov5645,
>  	return 0;
>  }
>  
> -static int ov5645_set_power_on(struct ov5645 *ov5645)
> +static int ov5645_set_power_off(struct device *dev)
>  {
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct ov5645 *ov5645 = to_ov5645(sd);
> +
> +	ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> +	gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> +	gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> +	clk_disable_unprepare(ov5645->xclk);
> +	regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> +
> +	return 0;
> +}
> +
> +static int ov5645_set_power_on(struct device *dev)
> +{
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct ov5645 *ov5645 = to_ov5645(sd);
>  	int ret;
>  
>  	ret = regulator_bulk_enable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> @@ -658,57 +674,19 @@ static int ov5645_set_power_on(struct ov5645 *ov5645)
>  
>  	msleep(20);
>  
> -	return 0;
> -}
> -
> -static void ov5645_set_power_off(struct ov5645 *ov5645)
> -{
> -	gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> -	gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> -	clk_disable_unprepare(ov5645->xclk);
> -	regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> -}
> -
> -static int ov5645_s_power(struct v4l2_subdev *sd, int on)
> -{
> -	struct ov5645 *ov5645 = to_ov5645(sd);
> -	int ret = 0;
> -
> -	mutex_lock(&ov5645->power_lock);
> -
> -	/* If the power count is modified from 0 to != 0 or from != 0 to 0,
> -	 * update the power state.
> -	 */
> -	if (ov5645->power_count == !on) {
> -		if (on) {
> -			ret = ov5645_set_power_on(ov5645);
> -			if (ret < 0)
> -				goto exit;
> -
> -			ret = ov5645_set_register_array(ov5645,
> -					ov5645_global_init_setting,
> +	ret = ov5645_set_register_array(ov5645, ov5645_global_init_setting,
>  					ARRAY_SIZE(ov5645_global_init_setting));
> -			if (ret < 0) {
> -				dev_err(ov5645->dev,
> -					"could not set init registers\n");
> -				ov5645_set_power_off(ov5645);
> -				goto exit;
> -			}
> -
> -			usleep_range(500, 1000);
> -		} else {
> -			ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> -			ov5645_set_power_off(ov5645);
> -		}
> +	if (ret < 0) {
> +		dev_err(ov5645->dev, "could not set init registers\n");
> +		goto exit;
>  	}
>  
> -	/* Update the power count. */
> -	ov5645->power_count += on ? 1 : -1;
> -	WARN_ON(ov5645->power_count < 0);
> +	usleep_range(500, 1000);
>  
> -exit:
> -	mutex_unlock(&ov5645->power_lock);
> +	return 0;
>  
> +exit:
> +	ov5645_set_power_off(dev);
>  	return ret;

smatch gives this warning:

drivers/media/i2c/ov5645.c:687 ov5645_set_power_on() warn: 'ov5645->xclk' from clk_prepare_enable() not released on lines: 687.

Can you take a look?

Thanks!

	Hans

>  }

