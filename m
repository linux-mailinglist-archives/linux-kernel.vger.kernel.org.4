Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2BB74D976
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjGJPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjGJPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:03:13 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE63918C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:03:09 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so5671842276.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689001389; x=1691593389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s421IWjAmZBeltR/8Aa0V0PWqbpCcvNvWqJTbDaztpI=;
        b=wPMLjL4WZAVODsnmBNinDZmwtF3y6k9Bf2RX4WN6jQ+cEeBxqOC3QDZ0IS3dDusPci
         NaTD2Jc9pmCuJCxDIzVMOSUwA15NMYg2rywcRFYbHD8Rk3RO7+Q4k5/60reo2QtdodtP
         SRwJJf1+bVcgCGW+oBdMvXrcuQUIU97wLLljr+RVIzSdVo+wFhSrtQlSHVFXka1YoPeq
         DRQGkyzMWoap/9ijxgGdfeFC8yDe3J00X0Ozl4nkpftKdD0asXOAmVKjQUA0wYne60R5
         47LXXKE0PEPub7IwSQ1E+dvwGg4keZO/qSXXiWODX4DxsF001PIw3wSzhOuX/0kVUKrv
         d5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001389; x=1691593389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s421IWjAmZBeltR/8Aa0V0PWqbpCcvNvWqJTbDaztpI=;
        b=PtldRxyXTi/LNL/9UViIWgREiOk0mySrzk1WkmLTiRBguqaimAbafxn/8j61r/SlUA
         G+XGualDt7RHQh8L8YEDJCt8awfr/RrkQlYtogQtdWZ7CI0Lm1IEzZQigqma9YL6ygk3
         RiHV2/1JwQEB1AoJARd15UhEmtYNrFIAaNgZv6AUiCCuEkSxkzuvSNKez8gzG1zQq9Ho
         0q9UrUPWZToUR89HU6SH21DBINU7AB3m6KH6GykqzKdwZ5yvnXdZt4RQju43ewNpquJN
         L65Sj/3yCfRWUG5N63m6cmzTFuMsID0VTaAhJHLbuXVMwhIDtcyr5iHfSUK5UOkulLUj
         a8Lg==
X-Gm-Message-State: ABy/qLZsgnaj1tf05td6saNmdwwxXPYIbx9R/3Feo1wn2Ory45PXBHwb
        zYLJmIeoXzhGxEI9EfsbQPXQXQigpgTa5eDXugUGTA==
X-Google-Smtp-Source: APBJJlGStsQv6v6IuY+A8mpXK4kngqyv2SRMKnviP3Ad+/K2t0ltKZsxxZ0JU/s+eRyhETvgkSUuffBXpH53zgf5I2w=
X-Received: by 2002:a25:1603:0:b0:c5d:953b:db6 with SMTP id
 3-20020a251603000000b00c5d953b0db6mr11092259ybw.41.1689001388728; Mon, 10 Jul
 2023 08:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-3-quic_ipkumar@quicinc.com> <cf2cae88-e226-8df1-6c4f-543b683cbc8c@linaro.org>
 <a03d6823-2084-e4c6-1c9d-853127956f69@quicinc.com>
In-Reply-To: <a03d6823-2084-e4c6-1c9d-853127956f69@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 10 Jul 2023 18:02:57 +0300
Message-ID: <CAA8EJpo+r48uj1-X6O0r3wOodydMfMrPQHt+afXO7PNGqCJk3A@mail.gmail.com>
Subject: Re: [PATCH 2/6] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 16:22, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
>
> On 7/10/2023 4:49 PM, Dmitry Baryshkov wrote:
> > On 10/07/2023 13:37, Praveenkumar I wrote:
> >> SoCs without RPM have to enable sensors and calibrate from the kernel.
> >> Though TSENS IP supports 16 sensors, not all are used. So added
> >> sensors_to_en in tsens data help enable the relevant sensors.
> >>
> >> Added new calibration function for V2 as the tsens.c calib function
> >> only supports V1.
> >>
> >> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> >> ---
> >>   drivers/thermal/qcom/tsens-v2.c | 116 ++++++++++++++++++++++++++++++++
> >>   drivers/thermal/qcom/tsens.c    |  37 +++++++++-
> >>   drivers/thermal/qcom/tsens.h    |  56 +++++++++++++++
> >>   3 files changed, 208 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v2.c
> >> b/drivers/thermal/qcom/tsens-v2.c
> >> index 29a61d2d6ca3..db48b1d95348 100644
> >> --- a/drivers/thermal/qcom/tsens-v2.c
> >> +++ b/drivers/thermal/qcom/tsens-v2.c
> >> @@ -6,11 +6,20 @@
> >>     #include <linux/bitops.h>
> >>   #include <linux/regmap.h>
> >> +#include <linux/nvmem-consumer.h>
> >>   #include "tsens.h"
> >>     /* ----- SROT ------ */
> >>   #define SROT_HW_VER_OFF    0x0000
> >>   #define SROT_CTRL_OFF        0x0004
> >> +#define SROT_MEASURE_PERIOD    0x0008
> >> +#define SROT_Sn_CONVERSION    0x0060
> >> +#define V2_SHIFT_DEFAULT    0x0003
> >> +#define V2_SLOPE_DEFAULT    0x0cd0
> >> +#define V2_CZERO_DEFAULT    0x016a
> >> +#define ONE_PT_SLOPE        0x0cd0
> >> +#define TWO_PT_SHIFTED_GAIN    921600
> >> +#define ONE_PT_CZERO_CONST    94
> >>     /* ----- TM ------ */
> >>   #define TM_INT_EN_OFF            0x0004
> >> @@ -59,6 +68,16 @@ static const struct reg_field
> >> tsens_v2_regfields[MAX_REGFIELDS] = {
> >>       /* CTRL_OFF */
> >>       [TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
> >>       [TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
> >> +    [SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
> >> +    [CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
> >> +
> >> +    /* MAIN_MEASURE_PERIOD */
> >> +    [MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
> >> +
> >> +    /* Sn Conversion */
> >> +    REG_FIELD_FOR_EACH_SENSOR16(SHIFT, SROT_Sn_CONVERSION, 23, 24),
> >> +    REG_FIELD_FOR_EACH_SENSOR16(SLOPE, SROT_Sn_CONVERSION, 10, 22),
> >> +    REG_FIELD_FOR_EACH_SENSOR16(CZERO, SROT_Sn_CONVERSION, 0, 9),
> >>         /* ----- TM ------ */
> >>       /* INTERRUPT ENABLE */
> >> @@ -104,6 +123,103 @@ static const struct reg_field
> >> tsens_v2_regfields[MAX_REGFIELDS] = {
> >>       [TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
> >>   };
> >>   +static int tsens_v2_calibration(struct tsens_priv *priv)
> >> +{
> >> +    struct device *dev = priv->dev;
> >> +    u32 mode, base0, base1;
> >> +    u32 slope, czero;
> >> +    char name[15];
> >> +    int i, j, ret;
> >> +
> >> +    if (priv->num_sensors > MAX_SENSORS)
> >> +        return -EINVAL;
> >> +
> >> +    ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
> >> +    if (ret == -ENOENT)
> >> +        dev_warn(priv->dev, "Calibration data not present in DT\n");
> >> +    if (ret < 0)
> >> +        return ret;
> >> +
> >> +    dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> >> +
> >> +    ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
> >> +    if (ret < 0)
> >> +        return ret;
> >> +
> >> +    ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
> >> +    if (ret < 0)
> >> +        return ret;
> >> +
> >> +    /* Read offset values and allocate SHIFT, SLOPE & CZERO regmap
> >> for enabled sensors */
> >> +    for (i = 0; i < priv->num_sensors; i++) {
> >> +        if (!(priv->sensors_to_en & (0x1 << i)))
> >> +            continue;
> >> +
> >> +        ret = snprintf(name, sizeof(name), "s%d_offset",
> >> priv->sensor[i].hw_id);
> >> +        if (ret < 0)
> >> +            return ret;
> >> +
> >> +        ret = nvmem_cell_read_variable_le_u32(priv->dev, name,
> >> &priv->sensor[i].offset);
> >> +        if (ret)
> >> +            return ret;
> >> +
> >> +        for (j = SHIFT_0; j <= CZERO_0; j++) {
> >> +            int idx = (i * 3) + j;
> >> +
> >> +            priv->rf[idx] = devm_regmap_field_alloc(dev,
> >> priv->srot_map,
> >> +                                priv->fields[idx]);
> >> +            if (IS_ERR(priv->rf[idx]))
> >> +                return PTR_ERR(priv->rf[idx]);
> >
> > I think, allocating data structures for 48 regfields, which are
> > written just once, to be an overkill.
> Can we change it to single field for each sensor. For example,
> CONVERSION_0 instead of SHIFT_0, SLOPE_0 and CZERO_0? This way it will
> be max 16 regfields.

If you move writing of the registers to the loop, you won't need
regfields. You can just call regmap_update_bits. The point is that you
don't have to allocate a one-time instance.

> >
> >> +        }
> >> +    }
> >> +
> >> +    /* Based on calib mode, program SHIFT, SLOPE and CZERO for
> >> enabled sensors */
> >> +    switch (mode) {
> >> +    case TWO_PT_CALIB:
> >> +        slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
> >> +
> >> +        for (i = 0; i < priv->num_sensors; i++) {
> >> +            if (!(priv->sensors_to_en & (0x1 << i)))
> >> +                continue;
> >> +
> >> +            int idx = i * 3;
> >> +
> >> +            czero = (base0 + priv->sensor[i].offset - ((base1 -
> >> base0) / 3));
> >> +            regmap_field_write(priv->rf[SHIFT_0 + idx],
> >> V2_SHIFT_DEFAULT);
> >> +            regmap_field_write(priv->rf[SLOPE_0 + idx], slope);
> >> +            regmap_field_write(priv->rf[CZERO_0 + idx], czero);
> >> +        }
> >> +        fallthrough;
> >> +    case ONE_PT_CALIB2:
> >> +        for (i = 0; i < priv->num_sensors; i++) {
> >> +            if (!(priv->sensors_to_en & (0x1 << i)))
> >> +                continue;
> >> +
> >> +            int idx = i * 3;
> >> +
> >> +            czero = base0 + priv->sensor[i].offset -
> >> ONE_PT_CZERO_CONST;
> >> +            regmap_field_write(priv->rf[SHIFT_0 + idx],
> >> V2_SHIFT_DEFAULT);
> >> +            regmap_field_write(priv->rf[SLOPE_0 + idx], ONE_PT_SLOPE);
> >> +            regmap_field_write(priv->rf[CZERO_0 + idx], czero);
> >> +        }
> >> +        break;
> >> +    default:
> >> +        dev_dbg(priv->dev, "calibrationless mode\n");
> >> +        for (i = 0; i < priv->num_sensors; i++) {
> >> +            if (!(priv->sensors_to_en & (0x1 << i)))
> >> +                continue;
> >> +
> >> +            int idx = i * 3;
> >> +
> >> +            regmap_field_write(priv->rf[SHIFT_0 + idx],
> >> V2_SHIFT_DEFAULT);
> >> +            regmap_field_write(priv->rf[SLOPE_0 + idx],
> >> V2_SLOPE_DEFAULT);
> >> +            regmap_field_write(priv->rf[CZERO_0 + idx],
> >> V2_CZERO_DEFAULT);
> >> +        }
> >> +    }
> >
> > This code iterates over the sensors field several times. Please
> > consider extracting a function that handles all setup for a single
> > sensor, then calling it in a loop (I should probably do the same for
> > tsens-v0/v1 too).
> Sure. After reading the mode0, base0 and base1 from QFPROM, we can call
> a function in a loop to setup the calibration for each sensor.
> >
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>   static const struct tsens_ops ops_generic_v2 = {
> >>       .init        = init_common,
> >>       .get_temp    = get_temp_tsens_valid,
> >> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> >> index 98c356acfe98..169690355dad 100644
> >> --- a/drivers/thermal/qcom/tsens.c
> >> +++ b/drivers/thermal/qcom/tsens.c
> >> @@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
> >>       ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
> >>       if (ret)
> >>           goto err_put_device;
> >> -    if (!enabled) {
> >> +    if (!enabled && !priv->sensors_to_en) {
> >>           dev_err(dev, "%s: device not enabled\n", __func__);
> >>           ret = -ENODEV;
> >>           goto err_put_device;
> >> @@ -1006,6 +1006,40 @@ int __init init_common(struct tsens_priv *priv)
> >>           goto err_put_device;
> >>       }
> >>   +    /* Do TSENS initialization if required */
> >> +    if (priv->sensors_to_en) {
> >
> > Maybe it would be better to explicitly add VER_2_X_NO_RPM and check it
> > here?
> Sure, will add a separate version macro.
> >
> >> +        priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev,
> >> priv->srot_map,
> >> + priv->fields[CODE_OR_TEMP]);
> >> +        if (IS_ERR(priv->rf[CODE_OR_TEMP])) {
> >> +            ret = PTR_ERR(priv->rf[CODE_OR_TEMP]);
> >> +            goto err_put_device;
> >> +        }
> >> +
> >> +        priv->rf[MAIN_MEASURE_PERIOD] =
> >> +            devm_regmap_field_alloc(dev, priv->srot_map,
> >> +                        priv->fields[MAIN_MEASURE_PERIOD]);
> >> +        if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD])) {
> >> +            ret = PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
> >> +            goto err_put_device;
> >> +        }
> >> +
> >> +        regmap_field_write(priv->rf[TSENS_SW_RST], 0x1);
> >> +
> >> +        /* Update measure period to 2ms */
> >> +        regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], 0x1);
> >> +
> >> +        /* Enable available sensors */
> >> +        regmap_field_write(priv->rf[SENSOR_EN], priv->sensors_to_en);
> >> +
> >> +        /* Real temperature format */
> >> +        regmap_field_write(priv->rf[CODE_OR_TEMP], 0x1);
> >> +
> >> +        regmap_field_write(priv->rf[TSENS_SW_RST], 0x0);
> >> +
> >> +        /* Enable TSENS */
> >> +        regmap_field_write(priv->rf[TSENS_EN], 0x1);
> >> +    }
> >> +
> >>       /* This loop might need changes if enum regfield_ids is
> >> reordered */
> >>       for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
> >>           for (i = 0; i < priv->feat->max_sensors; i++) {
> >> @@ -1282,6 +1316,7 @@ static int tsens_probe(struct platform_device
> >> *pdev)
> >>         priv->dev = dev;
> >>       priv->num_sensors = num_sensors;
> >> +    priv->sensors_to_en = data->sensors_to_en;
> >>       priv->ops = data->ops;
> >>       for (i = 0;  i < priv->num_sensors; i++) {
> >>           if (data->hw_ids)
> >> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> >> index 2805de1c6827..f8897bc8944e 100644
> >> --- a/drivers/thermal/qcom/tsens.h
> >> +++ b/drivers/thermal/qcom/tsens.h
> >> @@ -168,6 +168,58 @@ enum regfield_ids {
> >>       TSENS_SW_RST,
> >>       SENSOR_EN,
> >>       CODE_OR_TEMP,
> >> +    /* MEASURE_PERIOD */
> >> +    MAIN_MEASURE_PERIOD,
> >> +
> >> +    /* Sn_CONVERSION */
> >> +    SHIFT_0,
> >> +    SLOPE_0,
> >> +    CZERO_0,
> >> +    SHIFT_1,
> >> +    SLOPE_1,
> >> +    CZERO_1,
> >> +    SHIFT_2,
> >> +    SLOPE_2,
> >> +    CZERO_2,
> >> +    SHIFT_3,
> >> +    SLOPE_3,
> >> +    CZERO_3,
> >> +    SHIFT_4,
> >> +    SLOPE_4,
> >> +    CZERO_4,
> >> +    SHIFT_5,
> >> +    SLOPE_5,
> >> +    CZERO_5,
> >> +    SHIFT_6,
> >> +    SLOPE_6,
> >> +    CZERO_6,
> >> +    SHIFT_7,
> >> +    SLOPE_7,
> >> +    CZERO_7,
> >> +    SHIFT_8,
> >> +    SLOPE_8,
> >> +    CZERO_8,
> >> +    SHIFT_9,
> >> +    SLOPE_9,
> >> +    CZERO_9,
> >> +    SHIFT_10,
> >> +    SLOPE_10,
> >> +    CZERO_10,
> >> +    SHIFT_11,
> >> +    SLOPE_11,
> >> +    CZERO_11,
> >> +    SHIFT_12,
> >> +    SLOPE_12,
> >> +    CZERO_12,
> >> +    SHIFT_13,
> >> +    SLOPE_13,
> >> +    CZERO_13,
> >> +    SHIFT_14,
> >> +    SLOPE_14,
> >> +    CZERO_14,
> >> +    SHIFT_15,
> >> +    SLOPE_15,
> >> +    CZERO_15,
> >>         /* ----- TM ------ */
> >>       /* TRDY */
> >> @@ -524,6 +576,7 @@ struct tsens_features {
> >>   /**
> >>    * struct tsens_plat_data - tsens compile-time platform data
> >>    * @num_sensors: Number of sensors supported by platform
> >> + * @sensors_to_en: Sensors to be enabled. Each bit represent a sensor
> >>    * @ops: operations the tsens instance supports
> >>    * @hw_ids: Subset of sensors ids supported by platform, if not the
> >> first n
> >>    * @feat: features of the IP
> >> @@ -531,6 +584,7 @@ struct tsens_features {
> >>    */
> >>   struct tsens_plat_data {
> >>       const u32        num_sensors;
> >> +    const u16        sensors_to_en;
> >
> > There is already a similar field, hw_ids. Can it be used instead?
> Yes, it can be used. I missed to check this hw_ids. Will change the
> num_sensors to 5 and use the hw_ids.
> >
> >>       const struct tsens_ops    *ops;
> >>       unsigned int        *hw_ids;
> >>       struct tsens_features    *feat;
> >> @@ -551,6 +605,7 @@ struct tsens_context {
> >>    * struct tsens_priv - private data for each instance of the tsens IP
> >>    * @dev: pointer to struct device
> >>    * @num_sensors: number of sensors enabled on this device
> >> + * @sensors_to_en: sensors to be enabled. Each bit represents a sensor
> >>    * @tm_map: pointer to TM register address space
> >>    * @srot_map: pointer to SROT register address space
> >>    * @tm_offset: deal with old device trees that don't address TM and
> >> SROT
> >> @@ -569,6 +624,7 @@ struct tsens_context {
> >>   struct tsens_priv {
> >>       struct device            *dev;
> >>       u32                num_sensors;
> >> +    u16                sensors_to_en;
> >>       struct regmap            *tm_map;
> >>       struct regmap            *srot_map;
> >>       u32                tm_offset;
> >
> --
> Thanks,
> Praveenkumar



-- 
With best wishes
Dmitry
