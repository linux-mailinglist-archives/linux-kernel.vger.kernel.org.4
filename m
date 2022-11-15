Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770A3629769
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiKOLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKOLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:31:02 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F294E1010;
        Tue, 15 Nov 2022 03:30:59 -0800 (PST)
Received: from wf0498.dip.tu-dresden.de ([141.76.181.242] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ouu9U-0007nD-OJ; Tue, 15 Nov 2022 12:30:52 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH 4/7] thermal: rockchip: Simplify channel id logic
Date:   Tue, 15 Nov 2022 12:30:51 +0100
Message-ID: <3601039.e9J7NaK4W3@phil>
In-Reply-To: <20221031175058.175698-5-sebastian.reichel@collabora.com>
References: <20221031175058.175698-1-sebastian.reichel@collabora.com> <20221031175058.175698-5-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 31. Oktober 2022, 18:50:55 CET schrieb Sebastian Reichel:
> Replace the channel ID lookup table by a simple offset, since
> the channel IDs are consecutive.

Hmm, I don't really like going this way.

While it may be true _right now_ that all tsadcs have the cpu-sensor
at channel "x" and the gpu-sensor at "x+1", hardware engineers are
always waaaaay too creative in what they do.

So I really expect a future soc to turn this around or add other
"interesting" variants.


Heiko


> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/thermal/rockchip_thermal.c | 48 +++++++++++++-----------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 3dab31f163b3..a547e44e2b64 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -39,15 +39,6 @@ enum tshut_polarity {
>  	TSHUT_HIGH_ACTIVE,
>  };
>  
> -/*
> - * The system has two Temperature Sensors.
> - * sensor0 is for CPU, and sensor1 is for GPU.
> - */
> -enum sensor_id {
> -	SENSOR_CPU = 0,
> -	SENSOR_GPU,
> -};
> -
>  /*
>   * The conversion table has the adc value and temperature.
>   * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_table)
> @@ -82,7 +73,7 @@ struct chip_tsadc_table {
>  
>  /**
>   * struct rockchip_tsadc_chip - hold the private data of tsadc chip
> - * @chn_id: array of sensor ids of chip corresponding to the channel
> + * @chn_offset: the channel offset of the first channel
>   * @chn_num: the channel number of tsadc chip
>   * @tshut_temp: the hardware-controlled shutdown temperature value
>   * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
> @@ -98,7 +89,7 @@ struct chip_tsadc_table {
>   */
>  struct rockchip_tsadc_chip {
>  	/* The sensor id of chip correspond to the ADC channel */
> -	int chn_id[SOC_MAX_SENSORS];
> +	int chn_offset;
>  	int chn_num;
>  
>  	/* The hardware-controlled tshut property */
> @@ -925,8 +916,8 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>  }
>  
>  static const struct rockchip_tsadc_chip px30_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>  	.chn_num = 2, /* 2 channels for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
> @@ -949,7 +940,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_data = {
>  };
>  
>  static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	/* cpu */
> +	.chn_offset = 0,
>  	.chn_num = 1, /* one channel for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -973,7 +965,8 @@ static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
>  };
>  
>  static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	/* cpu */
> +	.chn_offset = 0,
>  	.chn_num = 1, /* one channel for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -997,8 +990,8 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
>  };
>  
>  static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 1, /* cpu sensor is channel 1 */
> -	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
> +	/* cpu, gpu */
> +	.chn_offset = 1,
>  	.chn_num = 2, /* two channels for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1022,7 +1015,8 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
>  };
>  
>  static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> +	/* cpu */
> +	.chn_offset = 0,
>  	.chn_num = 1, /* one channels for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
> @@ -1045,8 +1039,8 @@ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
>  };
>  
>  static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>  	.chn_num = 2, /* two channels for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1070,8 +1064,8 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
>  };
>  
>  static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>  	.chn_num = 2, /* two channels for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1095,8 +1089,8 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
>  };
>  
>  static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>  	.chn_num = 2, /* two channels for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1120,8 +1114,8 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>  };
>  
>  static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> +	/* cpu, gpu */
> +	.chn_offset = 0,
>  	.chn_num = 2, /* two channels for tsadc */
>  
>  	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> @@ -1406,7 +1400,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>  	for (i = 0; i < thermal->chip->chn_num; i++) {
>  		error = rockchip_thermal_register_sensor(pdev, thermal,
>  						&thermal->sensors[i],
> -						thermal->chip->chn_id[i]);
> +						thermal->chip->chn_offset + i);
>  		if (error)
>  			return dev_err_probe(&pdev->dev, error,
>  				"failed to register sensor[%d].\n", i);
> 




