Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3EA750899
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjGLMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGLMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:46:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F71712;
        Wed, 12 Jul 2023 05:46:04 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CAr1Ci009129;
        Wed, 12 Jul 2023 12:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7s3FHK+iotGsmFnZY2tJkUZbTQ4n9+DvzGxUQdo2AXI=;
 b=ZQK67qhN38ctk1oXiHp773IxyRLEh/UsJQSptXFw4+GApFnCy/WrZRHqmfccm9kR4mQ3
 JGWcPO4Z0jVdaPjLtVo1eMIZGpn7V4911bd3ylyD67FwsIAWKm64M/0S3jTin8V3wSuK
 K+MHyZeP7z9BPoSCz1ckE9m2G+zcUsRu9DW3kY9S+zM4UomkuLyAL0jctO0yz2y9ND1a
 pd+dwUd3qYASpmmOm1J/boK0UojHp/QUNYry1CQLRIVVIDjDEc+3mJHP80imKbLDWAu3
 l6/x/R9GAgxLMddGEmZurUOwxBdutiGEoMDNKeyNamh7GWaDnDns2/T7rpAt+1osKgyO rQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rseqpshuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:45:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CCjngR010008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 12:45:49 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 05:45:44 -0700
Message-ID: <45b7520f-6108-3d58-1e0c-eaab108f1653@quicinc.com>
Date:   Wed, 12 Jul 2023 18:15:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/5] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-2-quic_ipkumar@quicinc.com>
 <44043ff6-e109-fa66-58c8-08cc25b9a4ad@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <44043ff6-e109-fa66-58c8-08cc25b9a4ad@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kj6YqaMn-7JLrjU25kMyBBPNMt6sQcSx
X-Proofpoint-ORIG-GUID: Kj6YqaMn-7JLrjU25kMyBBPNMt6sQcSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120114
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/2023 5:52 PM, Dmitry Baryshkov wrote:
> On 12/07/2023 14:35, Praveenkumar I wrote:
>> SoCs without RPM have to enable sensors and calibrate from the kernel.
>> Though TSENS IP supports 16 sensors, not all are used. So used hw_id
>> to enable the relevant sensors.
>>
>> Added new calibration function for V2 as the tsens.c calib function
>> only supports V1.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>> [v2]:
>>     Added separate init function for tsens v2 which calls init_common
>>     and initialize the remaining fields. Reformatted calibrate function
>>     and used hw_ids for sensors to enable.
>>
>>   drivers/thermal/qcom/tsens-v2.c | 144 ++++++++++++++++++++++++++++++++
>>   drivers/thermal/qcom/tsens.c    |   2 +-
>>   drivers/thermal/qcom/tsens.h    |   3 +
>>   3 files changed, 148 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c 
>> b/drivers/thermal/qcom/tsens-v2.c
>> index 29a61d2d6ca3..ba74d971fe95 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -6,11 +6,23 @@
>>     #include <linux/bitops.h>
>>   #include <linux/regmap.h>
>> +#include <linux/nvmem-consumer.h>
>>   #include "tsens.h"
>>     /* ----- SROT ------ */
>>   #define SROT_HW_VER_OFF    0x0000
>>   #define SROT_CTRL_OFF        0x0004
>> +#define SROT_MEASURE_PERIOD    0x0008
>> +#define SROT_Sn_CONVERSION    0x0060
>> +#define V2_SHIFT_DEFAULT    0x0003
>> +#define V2_SLOPE_DEFAULT    0x0cd0
>> +#define V2_CZERO_DEFAULT    0x016a
>> +#define ONE_PT_SLOPE        0x0cd0
>> +#define TWO_PT_SHIFTED_GAIN    921600
>> +#define ONE_PT_CZERO_CONST    94
>> +#define SENSOR_CONVERSION(n)    (((n) * 4) + SROT_Sn_CONVERSION)
>> +#define CONVERSION_SLOPE_SHIFT    10
>> +#define CONVERSION_SHIFT_SHIFT    23
>>     /* ----- TM ------ */
>>   #define TM_INT_EN_OFF            0x0004
>> @@ -59,6 +71,11 @@ static const struct reg_field 
>> tsens_v2_regfields[MAX_REGFIELDS] = {
>>       /* CTRL_OFF */
>>       [TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>>       [TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
>> +    [SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
>> +    [CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
>> +
>> +    /* MAIN_MEASURE_PERIOD */
>> +    [MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>>         /* ----- TM ------ */
>>       /* INTERRUPT ENABLE */
>> @@ -104,6 +121,133 @@ static const struct reg_field 
>> tsens_v2_regfields[MAX_REGFIELDS] = {
>>       [TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>>   };
>>   +static int tsens_v2_calibrate_sensor(struct device *dev, struct 
>> tsens_sensor *sensor,
>> +                     struct regmap *map,  u32 mode, u32 base0, u32 
>> base1)
>> +{
>> +    u32 slope, czero, val;
>> +    char name[15];
>> +    int ret;
>> +
>> +    /* Read offset value */
>> +    ret = snprintf(name, sizeof(name), "s%d", sensor->hw_id);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    ret = nvmem_cell_read_variable_le_u32(dev, name, &sensor->offset);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Based on calib mode, program SHIFT, SLOPE and CZERO */
>> +    switch (mode) {
>> +    case TWO_PT_CALIB:
>> +        slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
>> +
>> +        czero = (base0 + sensor->offset - ((base1 - base0) / 3));
>> +
>> +        val = (V2_SHIFT_DEFAULT << CONVERSION_SHIFT_SHIFT) |
>> +              (slope << CONVERSION_SLOPE_SHIFT) | czero;
>> +
>> +        fallthrough;
>> +    case ONE_PT_CALIB2:
>> +        czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;
>> +
>> +        val = (V2_SHIFT_DEFAULT << CONVERSION_SHIFT_SHIFT) |
>> +              (ONE_PT_SLOPE << CONVERSION_SLOPE_SHIFT) | czero;
>> +
>> +        break;
>> +    default:
>> +        dev_dbg(dev, "calibrationless mode\n");
>> +
>> +        val = (V2_SHIFT_DEFAULT << CONVERSION_SHIFT_SHIFT) |
>> +              (V2_SLOPE_DEFAULT << CONVERSION_SLOPE_SHIFT) | 
>> V2_CZERO_DEFAULT;
>> +    }
>> +
>> +    regmap_write(map, SENSOR_CONVERSION(sensor->hw_id), val);
>> +
>> +    return 0;
>> +}
>> +
>> +static int tsens_v2_calibration(struct tsens_priv *priv)
>> +{
>> +    struct device *dev = priv->dev;
>> +    u32 mode, base0, base1;
>> +    int i, ret;
>> +
>> +    if (priv->num_sensors > MAX_SENSORS)
>> +        return -EINVAL;
>> +
>> +    ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
>> +    if (ret == -ENOENT)
>> +        dev_warn(priv->dev, "Calibration data not present in DT\n");
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>> +
>> +    ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    /* Calibrate each sensor */
>> +    for (i = 0; i < priv->num_sensors; i++) {
>> +        ret = tsens_v2_calibrate_sensor(dev, &priv->sensor[i], 
>> priv->srot_map,
>> +                        mode, base0, base1);
>> +        if (ret < 0)
>> +            return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int __init init_tsens_v2(struct tsens_priv *priv)
>> +{
>> +    int i, ret;
>> +    u32 val = 0;
>> +    struct device *dev = priv->dev;
>> +
>> +    ret = init_common(priv);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    if (priv->feat->ver_major != VER_2_X_NO_RPM)
>> +        return 0;
>
> No need to, you can rename the function to init_tsens_v2_no_rpm(h?) 
> and use it just for non-rpm platforms.
Sure, will remove the version check and rename the function.
>
>> +
>> +    priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev, 
>> priv->srot_map,
>> +                             priv->fields[CODE_OR_TEMP]);
>> +    if (IS_ERR(priv->rf[CODE_OR_TEMP]))
>> +        return PTR_ERR(priv->rf[CODE_OR_TEMP]);
>> +
>> +    priv->rf[MAIN_MEASURE_PERIOD] = devm_regmap_field_alloc(dev, 
>> priv->srot_map,
>> + priv->fields[MAIN_MEASURE_PERIOD]);
>> +    if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD]))
>> +        return PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
>> +
>> +    regmap_field_write(priv->rf[TSENS_SW_RST], 0x1);
>> +
>> +    /* Update measure period to 2ms */
>> +    regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], 0x1);
>> +
>> +    /* Enable available sensors */
>> +    for (i = 0; i < priv->num_sensors; i++)
>> +        val |= 1 << priv->sensor[i].hw_id;
>> +
>> +    regmap_field_write(priv->rf[SENSOR_EN], val);
>> +
>> +    /* Real temperature format */
>> +    regmap_field_write(priv->rf[CODE_OR_TEMP], 0x1);
>> +
>> +    regmap_field_write(priv->rf[TSENS_SW_RST], 0x0);
>> +
>> +    /* Enable TSENS */
>> +    regmap_field_write(priv->rf[TSENS_EN], 0x1);
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct tsens_ops ops_generic_v2 = {
>>       .init        = init_common,
>>       .get_temp    = get_temp_tsens_valid,
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 98c356acfe98..5d2ad3b155ec 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
>>       ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>>       if (ret)
>>           goto err_put_device;
>> -    if (!enabled) {
>> +    if (!enabled && !VER_2_X_NO_RPM) {
>
> You probably meant something else here. `!const' is going to evaluate 
> to false.

Sorry, my bad. Missed to compare it with the version. Will update in the 
next path.

--
Thanks,
Praveenkumar
>
>>           dev_err(dev, "%s: device not enabled\n", __func__);
>>           ret = -ENODEV;
>>           goto err_put_device;
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index 2805de1c6827..b2e8f0f2b466 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -35,6 +35,7 @@ enum tsens_ver {
>>       VER_0_1,
>>       VER_1_X,
>>       VER_2_X,
>> +    VER_2_X_NO_RPM,
>>   };
>>     enum tsens_irq_type {
>> @@ -168,6 +169,8 @@ enum regfield_ids {
>>       TSENS_SW_RST,
>>       SENSOR_EN,
>>       CODE_OR_TEMP,
>> +    /* MEASURE_PERIOD */
>> +    MAIN_MEASURE_PERIOD,
>>         /* ----- TM ------ */
>>       /* TRDY */
>
