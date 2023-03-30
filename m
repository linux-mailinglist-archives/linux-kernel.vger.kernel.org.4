Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED46D0C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjC3RHg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjC3RHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:07:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F6AF08;
        Thu, 30 Mar 2023 10:07:28 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phvjz-0005WC-Tv; Thu, 30 Mar 2023 19:07:11 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [RESEND] [PATCHv3 4/7] thermal: rockchip: Simplify channel id logic
Date:   Thu, 30 Mar 2023 19:07:11 +0200
Message-ID: <2066924.KlZ2vcFHjT@diego>
In-Reply-To: <bae80282-cb80-462d-e554-1934d090e216@linaro.org>
References: <20230308112253.15659-1-sebastian.reichel@collabora.com>
 <ec66d4e7-cb82-46c6-84ae-bd51df7cab7c@mercury.local>
 <bae80282-cb80-462d-e554-1934d090e216@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. März 2023, 11:05:25 CEST schrieb Daniel Lezcano:
> 
> Hi Heiko,
> 
> On 08/03/2023 19:42, Sebastian Reichel wrote:
> > Hi Daniel,
> > 
> > On Wed, Mar 08, 2023 at 07:13:22PM +0100, Daniel Lezcano wrote:
> >> On 08/03/2023 12:22, Sebastian Reichel wrote:
> >>> Replace the channel ID lookup table by a simple offset, since
> >>> the channel IDs are consecutive.
> >>>
> >>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>
> >> As all the other patches are reviewed by Heiko, is the tag missing here?
> > 
> > Heiko was not happy with this in PATCHv2, when he reviewed most
> > of the patches:
> > 
> > https://lore.kernel.org/all/3601039.e9J7NaK4W3@phil/
> > 
> > I replied, but never got a response, so I kept it as is:
> > 
> > https://lore.kernel.org/all/20221206170232.xsm4kcbfwrmlrriw@mercury.elektranox.org/
> > 
> > FWIW it is essential for the series and cannot be dropped, because
> > RK3588 has more than 2 channels.
> 
> Do you have a suggestion to improve the proposed change ?

I guess it's fine after all.

Sebastian's response makes sense and there is not really a reason to keep
infrastructure around for a hypothetical case that may never happen.

If that really changes with some SoC in the far future we can always
re-evaluate.


So,

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Sorry for dropping the ball on this
Heiko


> >>> ---
> >>>    drivers/thermal/rockchip_thermal.c | 48 +++++++++++++-----------------
> >>>    1 file changed, 21 insertions(+), 27 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> >>> index 9ed45b318344..bcbdd618daae 100644
> >>> --- a/drivers/thermal/rockchip_thermal.c
> >>> +++ b/drivers/thermal/rockchip_thermal.c
> >>> @@ -39,15 +39,6 @@ enum tshut_polarity {
> >>>    	TSHUT_HIGH_ACTIVE,
> >>>    };
> >>> -/*
> >>> - * The system has two Temperature Sensors.
> >>> - * sensor0 is for CPU, and sensor1 is for GPU.
> >>> - */
> >>> -enum sensor_id {
> >>> -	SENSOR_CPU = 0,
> >>> -	SENSOR_GPU,
> >>> -};
> >>> -
> >>>    /*
> >>>     * The conversion table has the adc value and temperature.
> >>>     * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_table)
> >>> @@ -82,7 +73,7 @@ struct chip_tsadc_table {
> >>>    /**
> >>>     * struct rockchip_tsadc_chip - hold the private data of tsadc chip
> >>> - * @chn_id: array of sensor ids of chip corresponding to the channel
> >>> + * @chn_offset: the channel offset of the first channel
> >>>     * @chn_num: the channel number of tsadc chip
> >>>     * @tshut_temp: the hardware-controlled shutdown temperature value
> >>>     * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
> >>> @@ -98,7 +89,7 @@ struct chip_tsadc_table {
> >>>     */
> >>>    struct rockchip_tsadc_chip {
> >>>    	/* The sensor id of chip correspond to the ADC channel */
> >>> -	int chn_id[SOC_MAX_SENSORS];
> >>> +	int chn_offset;
> >>>    	int chn_num;
> >>>    	/* The hardware-controlled tshut property */
> >>> @@ -925,8 +916,8 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
> >>>    }
> >>>    static const struct rockchip_tsadc_chip px30_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> >>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> >>> +	/* cpu, gpu */
> >>> +	.chn_offset = 0,
> >>>    	.chn_num = 2, /* 2 channels for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
> >>> @@ -949,7 +940,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_data = {
> >>>    };
> >>>    static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> >>> +	/* cpu */
> >>> +	.chn_offset = 0,
> >>>    	.chn_num = 1, /* one channel for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> >>> @@ -973,7 +965,8 @@ static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
> >>>    };
> >>>    static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> >>> +	/* cpu */
> >>> +	.chn_offset = 0,
> >>>    	.chn_num = 1, /* one channel for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> >>> @@ -997,8 +990,8 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
> >>>    };
> >>>    static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 1, /* cpu sensor is channel 1 */
> >>> -	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
> >>> +	/* cpu, gpu */
> >>> +	.chn_offset = 1,
> >>>    	.chn_num = 2, /* two channels for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> >>> @@ -1022,7 +1015,8 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
> >>>    };
> >>>    static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> >>> +	/* cpu */
> >>> +	.chn_offset = 0,
> >>>    	.chn_num = 1, /* one channels for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
> >>> @@ -1045,8 +1039,8 @@ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
> >>>    };
> >>>    static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> >>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> >>> +	/* cpu, gpu */
> >>> +	.chn_offset = 0,
> >>>    	.chn_num = 2, /* two channels for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> >>> @@ -1070,8 +1064,8 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
> >>>    };
> >>>    static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> >>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> >>> +	/* cpu, gpu */
> >>> +	.chn_offset = 0,
> >>>    	.chn_num = 2, /* two channels for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> >>> @@ -1095,8 +1089,8 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
> >>>    };
> >>>    static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> >>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> >>> +	/* cpu, gpu */
> >>> +	.chn_offset = 0,
> >>>    	.chn_num = 2, /* two channels for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> >>> @@ -1120,8 +1114,8 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
> >>>    };
> >>>    static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
> >>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
> >>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
> >>> +	/* cpu, gpu */
> >>> +	.chn_offset = 0,
> >>>    	.chn_num = 2, /* two channels for tsadc */
> >>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
> >>> @@ -1404,7 +1398,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
> >>>    	for (i = 0; i < thermal->chip->chn_num; i++) {
> >>>    		error = rockchip_thermal_register_sensor(pdev, thermal,
> >>>    						&thermal->sensors[i],
> >>> -						thermal->chip->chn_id[i]);
> >>> +						thermal->chip->chn_offset + i);
> >>>    		if (error)
> >>>    			return dev_err_probe(&pdev->dev, error,
> >>>    				"failed to register sensor[%d].\n", i);
> >>
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
> 
> 




