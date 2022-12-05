Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D48642F02
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLERmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLERmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:42:31 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937E1262B;
        Mon,  5 Dec 2022 09:42:29 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p2FTw-0000se-Sz; Mon, 05 Dec 2022 18:42:21 +0100
Date:   Mon, 5 Dec 2022 17:42:12 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>
Subject: Re: [PATCH v2 1/2] thermal: mediatek: add support for MT7986 and
 MT7981
Message-ID: <Y44tdASIQ2DpL9re@makrotopia.org>
References: <Y4dYazyXF02eRGC5@makrotopia.org>
 <0b72a12c-286f-79d0-09e9-b1761530850a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b72a12c-286f-79d0-09e9-b1761530850a@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Thu, Dec 01, 2022 at 02:24:17PM +0100, AngeloGioacchino Del Regno wrote:
> Il 30/11/22 14:19, Daniel Golle ha scritto:
> > Add support for V3 generation thermal found in MT7986 and MT7981 SoCs.
> > Brings code to assign values from efuse as well as new function to
> > convert raw temperature to millidegree celsius, as found in MediaTek's
> > SDK sources (but cleaned up and de-duplicated)
> > 
> > [1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/baf36c7eef477aae1f8f2653b6c29e2caf48475b
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Reviewed-by: Henry Yen <henry.yen@mediatek.com>
> > ---
> > Changes since v1: Drop use of adc_oe field in efuse, Henry Yen confirmed
> > its use has been dropped intentionally in MTK SDK as well.
> > 
> >   drivers/thermal/mtk_thermal.c | 122 +++++++++++++++++++++++++++++++++-
> >   1 file changed, 119 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index 8440692e3890..6a69419f8960 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -150,6 +150,21 @@
> >   #define CALIB_BUF1_VALID_V2(x)		(((x) >> 4) & 0x1)
> >   #define CALIB_BUF1_O_SLOPE_SIGN_V2(x)	(((x) >> 3) & 0x1)
> > +/*
> > + * Layout of the fuses providing the calibration data
> > + * These macros can be used for MT7981 and MT7986.
> > + */
> > +#define CALIB_BUF0_ADC_GE_V3(x)		(((x) >> 0) & 0x3ff)
> > +#define CALIB_BUF0_ADC_OE_V3(x)		(((x) >> 10) & 0x3ff)
> > +#define CALIB_BUF0_DEGC_CALI_V3(x)	(((x) >> 20) & 0x3f)
> > +#define CALIB_BUF0_O_SLOPE_V3(x)	(((x) >> 26) & 0x3f)
> > +#define CALIB_BUF1_VTS_TS1_V3(x)	(((x) >> 0) & 0x1ff)
> > +#define CALIB_BUF1_VTS_TS2_V3(x)	(((x) >> 21) & 0x1ff)
> > +#define CALIB_BUF1_VTS_TSABB_V3(x)	(((x) >> 9) & 0x1ff)
> > +#define CALIB_BUF1_VALID_V3(x)		(((x) >> 18) & 0x1)
> > +#define CALIB_BUF1_O_SLOPE_SIGN_V3(x)	(((x) >> 19) & 0x1)
> > +#define CALIB_BUF1_ID_V3(x)		(((x) >> 20) & 0x1)
> > +
> >   enum {
> >   	VTS1,
> >   	VTS2,
> > @@ -163,6 +178,7 @@ enum {
> >   enum mtk_thermal_version {
> >   	MTK_THERMAL_V1 = 1,
> >   	MTK_THERMAL_V2,
> > +	MTK_THERMAL_V3,
> >   };
> >   /* MT2701 thermal sensors */
> > @@ -245,6 +261,27 @@ enum mtk_thermal_version {
> >   /* The calibration coefficient of sensor  */
> >   #define MT8183_CALIBRATION	153
> > +/* AUXADC channel 11 is used for the temperature sensors */
> > +#define MT7986_TEMP_AUXADC_CHANNEL	11
> > +
> > +/* The total number of temperature sensors in the MT7986 */
> > +#define MT7986_NUM_SENSORS		1
> > +
> > +/* The number of banks in the MT7986 */
> > +#define MT7986_NUM_ZONES		1
> > +
> > +/* The number of sensing points per bank */
> > +#define MT7986_NUM_SENSORS_PER_ZONE	1
> > +
> > +/* MT7986 thermal sensors */
> > +#define MT7986_TS1			0
> > +
> > +/* The number of controller in the MT7986 */
> > +#define MT7986_NUM_CONTROLLER		1
> > +
> > +/* The calibration coefficient of sensor  */
> > +#define MT7986_CALIBRATION		165
> > +
> >   struct mtk_thermal;
> >   struct thermal_bank_cfg {
> > @@ -386,6 +423,14 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
> >   static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
> >   static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
> > +/* MT7986 thermal sensor data */
> > +static const int mt7986_bank_data[MT7986_NUM_SENSORS] = { MT7986_TS1, };
> > +static const int mt7986_msr[MT7986_NUM_SENSORS_PER_ZONE] = { TEMP_MSR0, };
> > +static const int mt7986_adcpnp[MT7986_NUM_SENSORS_PER_ZONE] = { TEMP_ADCPNP0, };
> > +static const int mt7986_mux_values[MT7986_NUM_SENSORS] = { 0, };
> > +static const int mt7986_vts_index[MT7986_NUM_SENSORS] = { VTS1 };
> > +static const int mt7986_tc_offset[MT7986_NUM_CONTROLLER] = { 0x0, };
> > +
> >   /*
> >    * The MT8173 thermal controller has four banks. Each bank can read up to
> >    * four temperature sensors simultaneously. The MT8173 has a total of 5
> > @@ -549,6 +594,30 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
> >   	.version = MTK_THERMAL_V1,
> >   };
> > +/*
> > + * MT7986 uses AUXADC Channel 11 for raw data access.
> > + */
> > +static const struct mtk_thermal_data mt7986_thermal_data = {
> > +	.auxadc_channel = MT7986_TEMP_AUXADC_CHANNEL,
> > +	.num_banks = MT7986_NUM_ZONES,
> > +	.num_sensors = MT7986_NUM_SENSORS,
> > +	.vts_index = mt7986_vts_index,
> > +	.cali_val = MT7986_CALIBRATION,
> > +	.num_controller = MT7986_NUM_CONTROLLER,
> > +	.controller_offset = mt7986_tc_offset,
> > +	.need_switch_bank = true,
> > +	.bank_data = {
> > +		{
> > +			.num_sensors = 1,
> > +			.sensors = mt7986_bank_data,
> > +		},
> > +	},
> > +	.msr = mt7986_msr,
> > +	.adcpnp = mt7986_adcpnp,
> > +	.sensor_mux_values = mt7986_mux_values,
> > +	.version = MTK_THERMAL_V3,
> > +};
> > +
> >   /**
> >    * raw_to_mcelsius - convert a raw ADC value to mcelsius
> >    * @mt:	The thermal controller
> > @@ -603,6 +672,22 @@ static int raw_to_mcelsius_v2(struct mtk_thermal *mt, int sensno, s32 raw)
> >   	return (format_2 - tmp) * 100;
> >   }
> > +static int raw_to_mcelsius_v3(struct mtk_thermal *mt, int sensno, s32 raw)
> > +{
> > +	s32 tmp;
> > +
> > +	if (raw == 0)
> > +		return 0;
> > +
> > +	raw &= 0xfff;
> > +	tmp = 100000 * 15 / 16 * 10000;
> > +	tmp /= 4096 - 512 + mt->adc_ge;
> > +	tmp /= 1490;
> > +	tmp *= raw - mt->vts[sensno] - 2900;
> > +
> > +	return mt->degc_cali * 500 - tmp;
> > +}
> > +
> >   /**
> >    * mtk_thermal_get_bank - get bank
> >    * @bank:	The bank
> > @@ -659,9 +744,12 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
> >   		if (mt->conf->version == MTK_THERMAL_V1) {
> >   			temp = raw_to_mcelsius_v1(
> >   				mt, conf->bank_data[bank->id].sensors[i], raw);
> > -		} else {
> > +		} else if (mt->conf->version == MTK_THERMAL_V2) {
> >   			temp = raw_to_mcelsius_v2(
> >   				mt, conf->bank_data[bank->id].sensors[i], raw);
> > +		} else {
> > +			temp = raw_to_mcelsius_v3(
> > +				mt, conf->bank_data[bank->id].sensors[i], raw);
> >   		}
> 
> What about optimizing this with assigning a function pointer?
> Like that, we wouldn't check any version in there... as in that case we'd
> simply do something like
> 
> temp = conf->raw_to_mcelsius(mt, conf->bank...blahblah...);
> 
> ...and this would also mean that the snippet saying "the first read of a sensor
> often contains very high bogus temperature value [...]" would get merged in the v2
> of raw_to_mcelsius (as that function is used only in mtk_thermal_bank_temperature).

I found that Amjad Ouled-Ameur is taking care of converting that series
of if-else options into a function pointer allowing to easily call the
right raw_to_mcelsius function.

[PATCH v7 0/4] thermal: mediatek: Add support for MT8365 SoC
https://lore.kernel.org/linux-arm-kernel/4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org/T/

Should I wait until this series is merged and then submit support
for MT7986 thermal on top of that?


> 
> >   		/*
> > @@ -887,6 +975,26 @@ static int mtk_thermal_extract_efuse_v2(struct mtk_thermal *mt, u32 *buf)
> >   	return 0;
> >   }
> > +static int mtk_thermal_extract_efuse_v3(struct mtk_thermal *mt, u32 *buf)
> > +{
> > +	if (!CALIB_BUF1_VALID_V3(buf[1]))
> > +		return -EINVAL;
> > +
> > +	mt->adc_oe = CALIB_BUF0_ADC_OE_V3(buf[0]);
> > +	mt->adc_ge = CALIB_BUF0_ADC_GE_V3(buf[0]);
> > +	mt->degc_cali = CALIB_BUF0_DEGC_CALI_V3(buf[0]);
> > +	mt->o_slope = CALIB_BUF0_O_SLOPE_V3(buf[0]);
> > +	mt->vts[VTS1] = CALIB_BUF1_VTS_TS1_V3(buf[1]);
> > +	mt->vts[VTS2] = CALIB_BUF1_VTS_TS2_V3(buf[1]);
> > +	mt->vts[VTSABB] = CALIB_BUF1_VTS_TSABB_V3(buf[1]);
> > +	mt->o_slope_sign = CALIB_BUF1_O_SLOPE_SIGN_V3(buf[1]);
> > +
> > +	if (CALIB_BUF1_ID_V3(buf[1]) == 0)
> > +		mt->o_slope = 0;
> > +
> > +	return 0;
> > +}
> > +
> >   static int mtk_thermal_get_calibration_data(struct device *dev,
> >   					    struct mtk_thermal *mt)
> >   {
> > @@ -897,6 +1005,7 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
> >   	/* Start with default values */
> >   	mt->adc_ge = 512;
> > +	mt->adc_oe = 512;
> >   	for (i = 0; i < mt->conf->num_sensors; i++)
> >   		mt->vts[i] = 260;
> >   	mt->degc_cali = 40;
> > @@ -924,8 +1033,10 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
> >   	if (mt->conf->version == MTK_THERMAL_V1)
> >   		ret = mtk_thermal_extract_efuse_v1(mt, buf);
> > -	else
> > +	else if (mt->conf->version == MTK_THERMAL_V2)
> >   		ret = mtk_thermal_extract_efuse_v2(mt, buf);
> > +	else
> > +		ret = mtk_thermal_extract_efuse_v3(mt, buf);
> 
> I propose to use a switch here instead.
> 
> 	switch(mt->conf->version) {
> 	case MTK_THERMAL_V1:
> 		....
> 	case MTK_THERMAL_V2:
> 		....
> 	case MTK_THERMAL_V3:
> 		....
> 	default:
> 		ret = -EINVAL;
> 		break;
> 	};
> 
> This would also prevent a potential issue with getting an invalid calibration
> due to us calling the wrong version of the get_calibration() function, in which
> case, using the default calibration values would be at that point preferred.
> 
> Regards,
> Angelo
> 
> 
> 
