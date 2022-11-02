Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D995A616170
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKBLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:07:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EBD24969;
        Wed,  2 Nov 2022 04:07:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2Av2re009165;
        Wed, 2 Nov 2022 11:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d4AfVhPanCSgGUILhg3HnZsXcF5KG62HY7w19NJ4c8E=;
 b=UPl2PpfH9BviqGBq+mKiYKj4GzNQN43UMVgqeZGNuM42JcAkMySS+88amB/HFuopvudm
 UJgBMkZRXvkvFWPxTDeb53IFoW+yCF+TVdY6B1Hbq+0RMwtKwltN+CHy85Zt53/b3C7k
 OS2P3UW0DPwj5UVGqp7o2WFYmN/EKvi3Lvb9OMzIYpj2GP4mAxxjMwq9Crz1JL7+l9se
 FbaMPLpw/yqVAa46c232Bej8pxKrSyo8R/uTDET5sKAMDufEugvoxdOTbVPGGo8PVvpz
 tnmxLvhfiGNxfzjGptCgut3Tovg2hH1DtXDjO/3VMw0rUzewLP+XOaLMZAFMH/Hju1Nj 9Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkq7qg0st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 11:06:54 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A2B6rOf008091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 11:06:53 GMT
Received: from [10.239.155.106] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 04:06:50 -0700
Message-ID: <54442085-5e72-dd12-2eed-3cda261fcbe0@quicinc.com>
Date:   Wed, 2 Nov 2022 19:06:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, "Pavel Machek" <pavel@ucw.cz>,
        Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
References: <20221025073802.2662564-1-quic_fenglinw@quicinc.com>
 <20221025073802.2662564-2-quic_fenglinw@quicinc.com>
 <0212be2972991ef2803c7f92c01217443def3dfd.camel@dylanvanassche.be>
 <578b6d6c-7a66-949c-c18f-3a962f9d37ff@quicinc.com>
 <adec3d56a1dbfbb97ce3d7a9dd172d593aff67c3.camel@dylanvanassche.be>
 <b92e9e09-f56c-1f0b-c718-d6e60f6253a7@quicinc.com>
 <b5a1c376200858f67f870766c4250ce810ed19db.camel@dylanvanassche.be>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <b5a1c376200858f67f870766c4250ce810ed19db.camel@dylanvanassche.be>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z-joO0phZD4v_Y-z1Jh-d3GXNvZc490I
X-Proofpoint-GUID: z-joO0phZD4v_Y-z1Jh-d3GXNvZc490I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_07,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/2 16:14, Dylan Van Assche wrote:
> 
> Hi Fenglin,
> 
>> Hi Dylan,
>>
>>
>> On 2022/11/2 1:39, Dylan Van Assche wrote:
>>>
>>> Hi Fenglin,
>>>
>>>> On 2022/10/31 18:34, Dylan Van Assche wrote:
>>>>>
>>>>> Hi Fenglin,
>>>>>
>>>>> Thanks for submitting these patches! They are really nice!
>>>>> I tested these patches on an SDM845 based device as the
>>>>> downstream
>>>>> driver is the same for the PMI8998 compared to the mentioned
>>>>> PMICs
>>>>> in
>>>>> this patchseries.
>>>>>
>>>>> Tested-by: Dylan Van Assche <me@dylanvanassche.be> # sdm845-
>>>>> shift-
>>>>> axolotl + pmi8998
>>>>>
>>>> Thanks for testing the patch at your side, Dylan!
>>>>
>>>>>>> Add initial driver to support flash LED module found in
>>>>>>> Qualcomm
>>>>>>> Technologies, Inc. PMICs. The flash module can have 3 or 4
>>>>>>> channels
>>>>>>> and each channel can be controlled indepedently and support
>>>>>>> full >
>>>>>>> scale
>>>>>>> current up to 1.5 A. It also supports connecting two
>>>>>>> channels >
>>>>>>> together
>>>>>>> to supply one LED component with full scale current up to 2
>>>>>>> A.
>>>>>>> In >
>>>>>>> that
>>>>>>> case, the current will be split on each channel
>>>>>>> symmetrically
>>>>>>> and
>>>>>>> the
>>>>>>> channels will be enabled and disabled at the same time.
>>>>>>>
>>>>>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>>>>> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # >
>>>>>>> sm7225-
>>>>>>> fairphone-fp4 + pm6150l
>>>>>>> ---
>>>>>>>     drivers/leds/flash/Kconfig           |  15 +
>>>>>>>     drivers/leds/flash/Makefile          |   1 +
>>>>>>>     drivers/leds/flash/leds-qcom-flash.c | 700 >
>>>>>>> +++++++++++++++++++++++++++
>>>>>>>     3 files changed, 716 insertions(+)
>>>>>>>     create mode 100644 drivers/leds/flash/leds-qcom-flash.c
>>>>>>>
>>>>>>> diff --git a/drivers/leds/flash/Kconfig
>>>>>>> b/drivers/leds/flash/Kconfig
>>>>>>> index d3eb689b193c..f36a60409290 100644
>>>>>>> --- a/drivers/leds/flash/Kconfig
>>>>>>> +++ b/drivers/leds/flash/Kconfig
>>>>>>> @@ -61,6 +61,21 @@ config LEDS_MT6360
>>>>>>>              Independent current sources supply for each
>>>>>>> flash
>>>>>>> LED >
>>>>>>> support torch
>>>>>>>              and strobe mode.
>>>>>>>     
>>>>>>> +config LEDS_QCOM_FLASH
>>>>>>> +       tristate "LED support for flash module inside
>>>>>>> Qualcomm
>>>>>>>>
>>>>>>> Technologies, Inc. PMIC"
>>>>>>> +       depends on MFD_SPMI_PMIC || COMPILE_TEST
>>>>>>> +       depends on LEDS_CLASS && OF
>>>>>>> +       depends on V4L2_FLASH_LED_CLASS ||
>>>>>>> !V4L2_FLASH_LED_CLASS
>>>>>>> +       select REGMAP
>>>>>>> +       help
>>>>>>> +         This option enables support for the flash module
>>>>>>> found in
>>>>>>>> Qualcomm
>>>>>>> +         Technologies, Inc. PMICs. The flash module can
>>>>>>> have 3
>>>>>>> or
>>>>>>> 4 > flash LED
>>>>>>> +         channels and each channel is programmable to
>>>>>>> support
>>>>>>> up
>>>>>>> to > 1.5 A full
>>>>>>> +         scale current. It also supports connecting two
>>>>>>> channels'
>>>>>>>> output together
>>>>>>> +         to supply one LED component to achieve current up
>>>>>>> to
>>>>>>> 2 A.
>>>>>>>> In such case,
>>>>>>> +         the total LED currentwill be split symmetrically
>>>>>>> on
>>>>>>> each
>>>>>>>> channel and
>>>>>>> +         they will be enabled/disabled at the same time.
>>>>>>> +
>>>>>>>     config LEDS_RT4505
>>>>>>>            tristate "LED support for RT4505 flashlight
>>>>>>> controller"
>>>>>>>            depends on I2C && OF
>>>>>>> diff --git a/drivers/leds/flash/Makefile >
>>>>>>> b/drivers/leds/flash/Makefile
>>>>>>> index 0acbddc0b91b..8a60993f1a25 100644
>>>>>>> --- a/drivers/leds/flash/Makefile
>>>>>>> +++ b/drivers/leds/flash/Makefile
>>>>>>> @@ -6,6 +6,7 @@ obj-$(CONFIG_LEDS_AS3645A)      += leds-
>>>>>>> as3645a.o
>>>>>>>     obj-$(CONFIG_LEDS_KTD2692)     += leds-ktd2692.o
>>>>>>>     obj-$(CONFIG_LEDS_LM3601X)     += leds-lm3601x.o
>>>>>>>     obj-$(CONFIG_LEDS_MAX77693)    += leds-max77693.o
>>>>>>> +obj-$(CONFIG_LEDS_QCOM_FLASH)  += leds-qcom-flash.o
>>>>>>>     obj-$(CONFIG_LEDS_RT4505)      += leds-rt4505.o
>>>>>>>     obj-$(CONFIG_LEDS_RT8515)      += leds-rt8515.o
>>>>>>>     obj-$(CONFIG_LEDS_SGM3140)     += leds-sgm3140.o
>>>>>>> diff --git a/drivers/leds/flash/leds-qcom-flash.c >
>>>>>>> b/drivers/leds/flash/leds-qcom-flash.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..a9fcf61600c3
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/leds/flash/leds-qcom-flash.c
>>>>>>> @@ -0,0 +1,700 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All
>>>>>>> rights
>>>>>>>> reserved.
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/bitfield.h>
>>>>>>> +#include <linux/bits.h>
>>>>>>> +#include <linux/leds.h>
>>>>>>> +#include <linux/led-class-flash.h>
>>>>>>> +#include <linux/module.h>
>>>>>>> +#include <linux/platform_device.h>
>>>>>>> +#include <linux/property.h>
>>>>>>> +#include <linux/regmap.h>
>>>>>>> +#include <media/v4l2-flash-led-class.h>
>>>>>>> +
>>>>>>> +/* registers definitions */
>>>>>>> +#define FLASH_TYPE_REG                 0x04
>>>>>>> +#define FLASH_TYPE_VAL                 0x18
>>>>>>> +
>>>>>>> +#define FLASH_SUBTYPE_REG              0x05
>>>>>>> +#define FLASH_SUBTYPE_3CH_VAL          0x04
>>>>>
>>>>> PMI8998 has also a 3 channel flash subtype, but reports 0x03 as
>>>>> subtype. The driver won't probe because of this since the
>>>>> subtype
>>>>> did
>>>>> not match. Changing this value to 0x03 made this driver work on
>>>>> SDM845
>>>>> based device as well with PMI8998. Would you consider
>>>>> supporting
>>>>> SDM845+PMI8998 as well?
>>>>>
>>>> I just double checked, flash module in PMI8998 (with subtype 0x3)
>>>> has
>>>> very similar register definition as the flash module in PM8150C
>>>> (with
>>>> subtype 0x4) that the driver is intended to support, it's good
>>>> know
>>>> that
>>>> it's 99% work.
>>>> I can add the 0x3 subtype support but the only problem is I
>>>> couldn't
>>>> find a device with PMI8998 to test it out. Would it be good if I
>>>> add
>>>> the
>>>> support and rely on your test result?
>>>
>>> Sure! I already have a branch locally to test your patches, happy
>>> to
>>> help! I have an SDM845 device here with PMI8998 with 2 LEDs: cold
>>> and
>>> warm white.
>>>
>> Thank you for the help!
>>>>
>>>>>>> +#define FLASH_SUBTYPE_4CH_VAL          0x07
>>>>>>> +
>>>>>>> +#define FLASH_TIMER_EN_BIT             BIT(7)
>>>>>>> +#define FLASH_TIMER_VAL_MASK           GENMASK(6, 0)
>>>>>>> +#define FLASH_TIMER_STEP_MS            10
>>>>>>> +
>>>>>>> +#define FLASH_STROBE_HW_SW_SEL_BIT     BIT(2)
>>>>>>> +#define SW_STROBE_VAL                  0
>>>>>>> +#define HW_STROBE_VAL                  1
>>>>>>> +#define FLASH_HW_STROBE_TRIGGER_SEL_BIT        BIT(1)
>>>>>>> +#define STROBE_LEVEL_TRIGGER_VAL       0
>>>>>>> +#define STROBE_EDGE_TRIGGER_VAL                1
>>>>>>> +#define FLASH_STROBE_POLARITY_BIT      BIT(0)
>>>>>>> +#define STROBE_ACTIVE_HIGH_VAL         1
>>>>>>> +
>>>>>>> +#define FLASH_IRES_MASK_4CH            BIT(0)
>>>>>>> +#define FLASH_IRES_MASK_3CH            GENMASK(1, 0)
>>>>>>> +#define FLASH_IRES_12P5MA_VAL          0
>>>>>>> +#define FLASH_IRES_5MA_VAL_4CH         1
>>>>>>> +#define FLASH_IRES_5MA_VAL_3CH         3
>>>>>>> +
>>>>>>> +/* constants */
>>>>>>> +#define FLASH_CURRENT_MAX_UA           1500000
>>>>>>> +#define TORCH_CURRENT_MAX_UA           500000
>>>>>>> +#define FLASH_TOTAL_CURRENT_MAX_UA     2000000
>>>>>>> +#define FLASH_CURRENT_DEFAULT_UA       1000000
>>>>>>> +#define TORCH_CURRENT_DEFAULT_UA       200000
>>>>>>> +
>>>>>>> +#define TORCH_IRES_UA                  5000
>>>>>>> +#define FLASH_IRES_UA                  12500
>>>>>>> +
>>>>>>> +#define FLASH_TIMEOUT_MAX_US           1280000
>>>>>>> +#define FLASH_TIMEOUT_STEP_US          10000
>>>>>>> +
>>>>>>> +enum hw_type {
>>>>>>> +       QCOM_MVFLASH_3CH,
>>>>>>> +       QCOM_MVFLASH_4CH,
>>>>>>> +};
>>>>>>> +
>>>>>>> +enum led_mode {
>>>>>>> +       FLASH_MODE,
>>>>>>> +       TORCH_MODE,
>>>>>>> +};
>>>>>>> +
>>>>>>> +enum led_strobe {
>>>>>>> +       SW_STROBE,
>>>>>>> +       HW_STROBE,
>>>>>>> +};
>>>>>>> +
>>>>>>> +enum {
>>>>>>> +       REG_STATUS1,
>>>>>>> +       REG_STATUS2,
>>>>>>> +       REG_STATUS3,
>>>>>>> +       REG_CHAN_TIMER,
>>>>>>> +       REG_ITARGET,
>>>>>>> +       REG_MODULE_EN,
>>>>>>> +       REG_IRESOLUTION,
>>>>>>> +       REG_CHAN_STROBE,
>>>>>>> +       REG_CHAN_EN,
>>>>>>> +       REG_MAX_COUNT,
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
>>>>>>> +       REG_FIELD(0x08, 0, 7),                  /*
>>>>>>> status1      */
>>>>>>> +       REG_FIELD(0x09, 0, 7),                  /*
>>>>>>> status2      */
>>>>>>> +       REG_FIELD(0x0a, 0, 7),                  /*
>>>>>>> status3      */
>>>>>>> +       REG_FIELD_ID(0x40, 0, 7, 3, 1),         /*
>>>>>>> chan_timer   */
>>>>>>> +       REG_FIELD_ID(0x43, 0, 6, 3, 1),         /*
>>>>>>> itarget      */
>>>>>>> +       REG_FIELD(0x46, 7, 7),                  /*
>>>>>>> module_en    */
>>>>>>> +       REG_FIELD(0x47, 0, 5),                  /*
>>>>>>> iresolution  */
>>>>>>> +       REG_FIELD_ID(0x49, 0, 2, 3, 1),         /*
>>>>>>> chan_strobe  */
>>>>>>> +       REG_FIELD(0x4c, 0, 2),                  /*
>>>>>>> chan_en      */
>>>>>>> +};
>>>>>
>>>>> These registers map perfectly for SDM845 with PMI8998 as well,
>>>>> adding
>>>>> support for this subtype (0x03) would be great.
>>>>>
>>>>>>> +
>>>>>>> +struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
>>>>>>> +       REG_FIELD(0x06, 0, 7),                  /*
>>>>>>> status1      */
>>>>>>> +       REG_FIELD(0x07, 0, 6),                  /*
>>>>>>> status2      */
>>>>>>> +       REG_FIELD(0x09, 0, 7),                  /*
>>>>>>> status3      */
>>>>>>> +       REG_FIELD_ID(0x3e, 0, 7, 4, 1),         /*
>>>>>>> chan_timer   */
>>>>>>> +       REG_FIELD_ID(0x42, 0, 6, 4, 1),         /*
>>>>>>> itarget      */
>>>>>>> +       REG_FIELD(0x46, 7, 7),                  /*
>>>>>>> module_en    */
>>>>>>> +       REG_FIELD(0x49, 0, 3),                  /*
>>>>>>> iresolution  */
>>>>>>> +       REG_FIELD_ID(0x4a, 0, 6, 4, 1),         /*
>>>>>>> chan_strobe  */
>>>>>>> +       REG_FIELD(0x4e, 0, 3),                  /*
>>>>>>> chan_en      */
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct qcom_flash_led {
>>>>>>> +       struct qcom_flash_chip          *chip;
>>>>>>> +       struct led_classdev_flash       flash;
>>>>>>> +       struct v4l2_flash               *v4l2_flash;
>>>>>>> +       u32                             max_flash_current_m
>>>>>>> a;
>>>>>>> +       u32                             max_torch_current_m
>>>>>>> a;
>>>>>>> +       u32                             max_timeout_ms;
>>>>>>> +       u32                             flash_current_ma;
>>>>>>> +       u32                             flash_timeout_ms;
>>>>>>> +       u8                              *chan_id;
>>>>>>> +       u8                              chan_count;
>>>>>>> +       bool                            enabled;
>>>>>>> +};
>>>>>>> +
>>>>>>> +struct qcom_flash_chip {
>>>>>>> +       struct qcom_flash_led   *leds;
>>>>>>> +       struct regmap_field     *r_fields[REG_MAX_COUNT];
>>>>>>> +       struct device           *dev;
>>>>>>> +       struct mutex            lock;
>>>>>>> +       enum hw_type            hw_type;
>>>>>>> +       u8                      leds_count;
>>>>>>> +       u8                      max_channels;
>>>>>>> +       u8                      chan_en_bits;
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int set_flash_module_en(struct qcom_flash_led *led,
>>>>>>> bool
>>>>>>> en)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_chip *chip= led->chip;
>>>>>>> +       u8 led_mask = 0, val;
>>>>>>> +       int i, rc;
>>>>>>> +
>>>>>>> +       for (i = 0; i < led->chan_count; i++)
>>>>>>> +               led_mask |= BIT(led->chan_id[i] - 1);
>>>>>>> +
>>>>>>> +       mutex_lock(&chip->lock);
>>>>>>> +       if (en)
>>>>>>> +               chip->chan_en_bits |= led_mask;
>>>>>>> +       else
>>>>>>> +               chip->chan_en_bits &= ~led_mask;
>>>>>>> +
>>>>>>> +       val = !!chip->chan_en_bits;
>>>>>>> +       rc = regmap_field_write(chip-
>>>>>>>> r_fields[REG_MODULE_EN],
>>>>>>> val);
>>>>>>> +       if (rc < 0)
>>>>>>> +               dev_err(chip->dev, "write module_en failed,
>>>>>>> rc=%d\n", > rc);
>>>>>>> +       mutex_unlock(&chip->lock);
>>>>>>> +
>>>>>>> +       return rc;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int set_flash_current(struct qcom_flash_led *led,
>>>>>>> u32 >
>>>>>>> current_ma, enum led_mode mode)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_chip *chip= led->chip;
>>>>>>> +       u32 itarg_ua = current_ma * 1000 / led->chan_count
>>>>>>> + 1;
>>>>>>> +       u32 ires_ua = (mode ==FLASH_MODE) ? FLASH_IRES_UA :
>>>>>>>>
>>>>>>> TORCH_IRES_UA;
>>>>>>> +       u8 val, shift, ires_mask =0, ires_val = 0, chan_id;
>>>>>>> +       int i, rc;
>>>>>>> +
>>>>>>> +       /*
>>>>>>> +        * Split the current across the channels and set
>>>>>>> the
>>>>>>> +        * IRESOLUTION and ITARGET registers accordingly.
>>>>>>> +        */
>>>>>>> +       for (i = 0; i < led->chan_count; i++) {
>>>>>>> +               chan_id = led->chan_id[i];
>>>>>>> +               if (itarg_ua < ires_ua)
>>>>>>> +                       val = 0;
>>>>>>> +               else
>>>>>>> +                       val = itarg_ua / ires_ua - 1;
>>>>>>> +
>>>>>>> +               rc = regmap_fields_write(chip-
>>>>>>>> r_fields[REG_ITARGET], > chan_id - 1, val);
>>>>>>> +               if (rc < 0)
>>>>>>> +                       returnrc;
>>>>>>> +
>>>>>>> +               if (chip->hw_type == QCOM_MVFLASH_3CH) {
>>>>>>> +                       shift = (chan_id - 1) * 2;
>>>>>>> +                       ires_mask |= FLASH_IRES_MASK_3CH <<
>>>>>>> shift;
>>>>>>> +                       ires_val |= ((mode == FLASH_MODE) ?
>>>>>>> +                               (FLASH_IRES_12P5MA_VAL <<
>>>>>>> shift) :
>>>>>>> +                               (FLASH_IRES_5MA_VAL_3CH <<
>>>>>>> shift));
>>>>>>> +               } else if (chip->hw_type ==
>>>>>>> QCOM_MVFLASH_4CH) {
>>>>>>> +                       shift = chan_id - 1;
>>>>>>> +                       ires_mask |= FLASH_IRES_MASK_4CH <<
>>>>>>> shift;
>>>>>>> +                       ires_val |= ((mode == FLASH_MODE) ?
>>>>>>> +                               (FLASH_IRES_12P5MA_VAL <<
>>>>>>> shift) :
>>>>>>> +                               (FLASH_IRES_5MA_VAL_4CH <<
>>>>>>> shift));
>>>>>>> +               }
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       return > regmap_field_update_bits(chip-
>>>>>>>> r_fields[REG_IRESOLUTION], ires_mask, > ires_val);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int set_flash_timeout(struct qcom_flash_led *led,
>>>>>>> u32 >
>>>>>>> timeout_ms)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_chip *chip= led->chip;
>>>>>>> +       u8 val, chan_id;
>>>>>>> +       int rc, i;
>>>>>>> +
>>>>>>> +       /* set SAFETY_TIMER for all the channels connected
>>>>>>> to
>>>>>>> the >
>>>>>>> same LED */
>>>>>>> +       timeout_ms = min_t(u32, timeout_ms, led-
>>>>>>>> max_timeout_ms);
>>>>>>> +       for (i = 0; i < led->chan_count; i++) {
>>>>>>> +               chan_id = led->chan_id[i];
>>>>>>> +               val = timeout_ms / FLASH_TIMER_STEP_MS;
>>>>>>> +               val = clamp_t(u8, val, 0,
>>>>>>> FLASH_TIMER_VAL_MASK);
>>>>>>> +               if (timeout_ms)
>>>>>>> +                       val |= FLASH_TIMER_EN_BIT;
>>>>>>> +
>>>>>>> +               rc = > regmap_fields_write(chip-
>>>>>>>> r_fields[REG_CHAN_TIMER], chan_id - 1, > val);
>>>>>>> +               if (rc < 0)
>>>>>>> +                       returnrc;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int set_flash_strobe(struct qcom_flash_led *led,
>>>>>>> enum >
>>>>>>> led_strobe strobe, bool state)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_chip *chip= led->chip;
>>>>>>> +       u8 mask, val, chan_id = 0,chan_mask = 0;
>>>>>>> +       int rc, i;
>>>>>>> +
>>>>>>> +       /* Set SW strobe config for all channels connected
>>>>>>> to
>>>>>>> the
>>>>>>> LED > */
>>>>>>> +       for (i = 0; i < led->chan_count; i++) {
>>>>>>> +               chan_id = led->chan_id[i];
>>>>>>> +               if (strobe == SW_STROBE)
>>>>>>> +                       val =
>>>>>>> FIELD_PREP(FLASH_STROBE_HW_SW_SEL_BIT, > SW_STROBE_VAL);
>>>>>>> +               else
>>>>>>> +                       val =
>>>>>>> FIELD_PREP(FLASH_STROBE_HW_SW_SEL_BIT, > HW_STROBE_VAL);
>>>>>>> +
>>>>>>> +               val |=
>>>>>>> FIELD_PREP(FLASH_HW_STROBE_TRIGGER_SEL_BIT,
>>>>>>>> STROBE_LEVEL_TRIGGER_VAL) |
>>>>>>> +                       FIELD_PREP(FLASH_STROBE_POLARITY_BI
>>>>>>> T, >
>>>>>>> STROBE_ACTIVE_HIGH_VAL);
>>>>>>> +               rc = > regmap_fields_write(chip-
>>>>>>>> r_fields[REG_CHAN_STROBE], chan_id - 1, > val);
>>>>>>> +               if (rc < 0)
>>>>>>> +                       returnrc;
>>>>>>> +
>>>>>>> +               chan_mask |= BIT(chan_id - 1);
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       /* enable/disable flash channels */
>>>>>>> +       mask = chan_mask;
>>>>>>> +       val = state ? mask : 0;
>>>>>>> +       rc = regmap_field_update_bits(chip-
>>>>>>>> r_fields[REG_CHAN_EN],
>>>>>>>> mask, val);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       led->enabled = state;
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int qcom_flash_brightness_set(struct
>>>>>>> led_classdev_flash
>>>>>>>>
>>>>>>> *fled_cdev, u32 brightness)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_led *led =
>>>>>>> container_of(fled_cdev,
>>>>>>> struct
>>>>>>>> qcom_flash_led, flash);
>>>>>>> +
>>>>>>> +       led->flash_current_ma = min_t(u32, led-
>>>>>>>> max_flash_current_ma, > brightness / 1000);
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>
>>>>> This doesn't seem to work in torch mode for me on PMI8998. If
>>>>> the
>>>>> brightness is 0, the torch is OFF as expected, but when the
>>>>> torch
>>>>> is
>>>>> ON, you cannot control the brightness. The brightness is the
>>>>> same
>>>>> for
>>>>> [1, 255]. If the hardware cannot change the brightness in torch
>>>>> mode,
>>>>> it would be nice to report a max_brightness value of 1 instead
>>>>> of
>>>>> 255
>>>>> for userspace. This could be a limitation of the PMI8998, not
>>>>> sure.
>>>>> Do you have any insights here? This driver is already 99%
>>>>> working
>>>>> for
>>>>> SDM845+PMI8998.
>>>>>
>>>>> Flash mode works great, timeout & brightness can be configured
>>>>> just
>>>>> fine.
>>>>>
>>>>
>>>> Here, function qcom_flash_brightness_set() is used for setting
>>>> brightness in flash mode and it was supposed to be working with
>>>> following commands combination:
>>>>           echo xxx > flash_brightness
>>>>           echo 1 > flash_strobe  (you will need to toggle
>>>> flash_strobe
>>>> when you
>>>> enabling it again)
>>>>
>>>> Can you check if you can see the brightness change in flash mode
>>>> when
>>>> you updating the flash_brightness value with these commands?
>>>>
>>>> You can echo any value between [0, max_flash_brightness] into the
>>>> flash_brightness, there is a "max_flash_brightness" sysfs node
>>>> and
>>>> the
>>>> value comes from DT property "flash-max-microamp", ex. my dtsi
>>>> node
>>>> has
>>>> "flash-max-microamp = <2000000>;" defined so I am having
>>>> following
>>>> value
>>>> for max_flash_brightness:
>>>>
>>>> kalama:/sys/class/leds/white:flash-0 # cat max_flash_brightness
>>>> 2000000
>>>>
>>>> And by default flash mode uses 12500uA resolution so you won't
>>>> see
>>>> brightness change when you update it with values between [1,
>>>> 12500].
>>>
>>> Yes, this works perfectly fine on PMI8998. I can adjust the flash
>>> brightness and flash timeout perfectly.
>>>
>>>>
>>>> If you want to update the brightness for torch node, you can
>>>> directly
>>>> update the "brightness" node with values between [0, 255], and
>>>> it's
>>>> mapping to the torch current between [0, led-max-microamp].
>>>> "led-max-microamp" is also has value coming from the DT property.
>>>>
>>>> This worked at my side on both pm8150C and pm8550.I think it
>>>> should
>>>> work
>>>> on PMI8998 as well because the flash module in it is very similar
>>>> to
>>>> the
>>>> one in PM8150c. Let me know if you still see such issues at your
>>>> side.
>>>> Thanks
>>>
>>> Only here I have an issue with PMI8998: the "brightness" nodes
>>> should
>>> change the brightness of the torch, but it doesn't make a
>>> difference
>>> here. When I do:
>>>
>>> - echo 0 > brightness --> LED turns OFF
>>> - echo 255 > brightness --> LED turns ON
>>> - echo 100 > brightness --> LED is still ON, but brightness is the
>>> same
>>> as with 255.
>>>
>>> Could it be that PMI8998 is slightly different here than with
>>> PM8150c
>>> for example? Maybe it doesn't support brightness for torch?
>>>
>>> Here's my DTS:
>>>
>>> *PMI8998*
>>>
>>> pmi8998_flash: led-controller@d300 {
>>>          compatible = "qcom,pm6150l-flash-led", "qcom,spmi-flash-
>>> led";
>>>          reg = <0xd300>;
>>>          status = "disabled";
>>> };
>>>
>>> *SDM845 SHIFT axolotl*
>>>
>>> &pmi8998_flash {
>>>          status = "okay";
>>>
>>>          led-0 {
>>>                  function = LED_FUNCTION_FLASH;
>>>                  color = <LED_COLOR_ID_WHITE>;
>>>                  led-sources = <1>;
>>>                  led-max-microamp = <180000>;
>>>                  flash-max-microamp = <1000000>;
>>>                  flash-max-timeout-us = <1280000>;
>>>          };
>>>
>>>          led-1 {
>>>                  function = LED_FUNCTION_FLASH;
>>>                  color = <LED_COLOR_ID_YELLOW>;
>>>                  led-sources = <2>;
>>>                  led-max-microamp = <180000>;
>>>                  flash-max-microamp = <1000000>;
>>>                  flash-max-timeout-us = <1280000>;
>>>          };
>>> };
>>>
>> Thank you for getting back all the details. The devicetree node looks
>> good to me.
>>
>> I checked again and confirmed that the flash modules in PMI8998 and
>> PM8150C have the same register definition for ITARGETx (0xD343 + x)
>> and
>> IRESOLUTION (0xD347), these are the only 2 settings would impact LED
>> brightness, and in torch mode, IRESOLUTION is fixed to 5mA and only
>> ITARGET is updated accordingly.
>>
>> I updated my workspace to use the same current for torch mode as your
>> settings in devicetree and tried again on my PM8150C device,I could
>> notice the brightness change when echoing different values to the
>> brightness sysfs node, however, when I updating values between 255
>> and
>> 200, it wasn't a very noticeable brightness change with naked eys,
>> but I
>> could see the ITRAGETx register changed accordingly when reading its
>> value back from the regmap debugfs node.
>>
>> Can you try the same and see if the register got updated accordingly
>> when you updating brightness values? If yes, I would wonder if the
>> LED
>> component on your device has upper current limit in torch mode close
>> to
>> (100 / 255 ) * 180mA so you that you can't observe the brightness
>> change
>> when updating between 100 to 255. Another easier thing to try, can
>> you
>> echo a lower brightness value, such as 10, to see if you can notice
>> the
>> brightness change?
>>
> 
> Aha! It does seem to work partially!
> 
> I tried it with brightness 0 --> 255 --> 1. This order keeps the
> highest brightness at all times, matching 255. The other way around: 0
> --> 1 --> 255 keeps the lowest brightness, matching 1.
> Changing the brightness only works if the LED was turned OFF first:
> 
> 0 --> 255 --> 0 --> 1
> 0 --> 1 --> 0 --> 255
> 
> both work fine, verified it with the following shell commands (assumed
> that the LED was turned OFF to start):
> 
> echo 1 > brightness && sleep 3 && echo 0 > brightness && echo 255 >
> brightness
> echo 255 > brightness && sleep 3 &&  echo 0 > brightness && echo 1 >
> brightness
> 
> Maybe a register needs to be reset when the brightness changes?
> 

Hi Dylan,

Would you mind to help me testing this small change on PMI8998? It 
simply toggles the CHANNEL_EN bit when updating LED brightness. If it 
works, I will add it specifically for PMI8998 in patch v5.

@@ -241,8 +243,21 @@ static int set_flash_strobe(struct qcom_flash_led 
*led, enum led_strobe s
trobe,
                 chan_mask |= BIT(chan_id - 1);
         }

-       /* enable/disable flash channels */
         mask = chan_mask;
+       /*
+        * For flash module inside PMI8998, if strobe(true) is called when
+        * the LED is already enabled, disable the channel 1st and then
+        * enable it again.  This could happen when updating LED brightness
+        * after LED is turned on.
+        */
+       if (led->enabled && (led->enabled == state)) {
+               rc = 
regmap_field_update_bits(chip->r_fields[REG_CHAN_EN], mask, 0);
+               if (rc < 0)
+                       return rc;
+       }
+
+       /* enable/disable flash channels */
         val = state ? mask : 0;
         rc = regmap_field_update_bits(chip->r_fields[REG_CHAN_EN], 
mask, val);
         if (rc < 0)

Thanks
Fenglin Wu

>>>
>>>>
>>>>>>> +
>>>>>>> +static int qcom_flash_timeout_set(struct
>>>>>>> led_classdev_flash >
>>>>>>> *fled_cdev, u32 timeout)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_led *led =
>>>>>>> container_of(fled_cdev,
>>>>>>> struct
>>>>>>>> qcom_flash_led, flash);
>>>>>>> +
>>>>>>> +       led->flash_timeout_ms = timeout / 1000;
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int qcom_flash_strobe_set(struct led_classdev_flash
>>>>>>>>
>>>>>>> *fled_cdev, bool state)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_led *led =
>>>>>>> container_of(fled_cdev,
>>>>>>> struct
>>>>>>>> qcom_flash_led, flash);
>>>>>>> +       int rc;
>>>>>>> +
>>>>>>> +       rc = set_flash_current(led, led->flash_current_ma,
>>>>>>>>
>>>>>>> FLASH_MODE);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       rc = set_flash_timeout(led, led->flash_timeout_ms);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       rc = set_flash_module_en(led, state);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       return set_flash_strobe(led,SW_STROBE, state);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int qcom_flash_strobe_get(struct led_classdev_flash
>>>>>>>>
>>>>>>> *fled_cdev, bool *state)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_led *led =
>>>>>>> container_of(fled_cdev,
>>>>>>> struct
>>>>>>>> qcom_flash_led, flash);
>>>>>>> +
>>>>>>> +       *state = led->enabled;
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int qcom_flash_fault_get(struct led_classdev_flash
>>>>>>>>
>>>>>>> *fled_cdev, u32 *fault)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_led *led =
>>>>>>> container_of(fled_cdev,
>>>>>>> struct
>>>>>>>> qcom_flash_led, flash);
>>>>>>> +       struct qcom_flash_chip *chip= led->chip;
>>>>>>> +       u8 shift, chan_id = 0, chan_mask = 0;
>>>>>>> +       u8 ot_mask = 0, oc_mask = 0, uv_mask = 0;
>>>>>>> +       u32 val, fault_sts = 0;
>>>>>>> +       int i, rc;
>>>>>>> +
>>>>>>> +       rc = regmap_field_read(chip->r_fields[REG_STATUS1],
>>>>>>> &val);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       for (i = 0; i < led->chan_count; i++) {
>>>>>>> +               chan_id = led->chan_id[i];
>>>>>>> +               shift = (chan_id - 1) * 2;
>>>>>>> +               if (val & BIT(shift))
>>>>>>> +                       fault_sts |=
>>>>>>> LED_FAULT_SHORT_CIRCUIT;
>>>>>>> +               chan_mask |= BIT(chan_id - 1);
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       rc = regmap_field_read(chip->r_fields[REG_STATUS2],
>>>>>>> &val);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       if (chip->hw_type == QCOM_MVFLASH_3CH) {
>>>>>>> +               ot_mask = 0x0f;
>>>>>>> +               oc_mask = 0xe0;
>>>>>>> +               uv_mask = 0x10;
>>>>>>> +       } else if (chip->hw_type == QCOM_MVFLASH_4CH) {
>>>>>>> +               ot_mask = 0x70;
>>>>>>> +               oc_mask = 0x0e;
>>>>>>> +               uv_mask = 0x01;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       if (val & ot_mask)
>>>>>>> +               fault_sts |= LED_FAULT_OVER_TEMPERATURE;
>>>>>>> +       if (val & oc_mask)
>>>>>>> +               fault_sts |= LED_FAULT_OVER_CURRENT;
>>>>>>> +       if (val & uv_mask)
>>>>>>> +               fault_sts |= LED_FAULT_INPUT_VOLTAGE;
>>>>>>> +
>>>>>>> +       rc = regmap_field_read(chip->r_fields[REG_STATUS3],
>>>>>>> &val);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       if (chip->hw_type == QCOM_MVFLASH_3CH) {
>>>>>>> +               if (val & chan_mask)
>>>>>>> +                       fault_sts |= LED_FAULT_TIMEOUT;
>>>>>>> +       } else if (chip->hw_type == QCOM_MVFLASH_4CH) {
>>>>>>> +               for (i = 0; i < led->chan_count; i++) {
>>>>>>> +                       chan_id = led->chan_id[i];
>>>>>>> +                       shift = (chan_id - 1) * 2;
>>>>>>> +                       if (val & BIT(shift))
>>>>>>> +                               fault_sts |=
>>>>>>> LED_FAULT_TIMEOUT;
>>>>>>> +               }
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       *fault = fault_sts;
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int qcom_flash_led_brightness_set(struct
>>>>>>> led_classdev >
>>>>>>> *led_cdev,
>>>>>>> +                                       enum led_brightness
>>>>>>>>
>>>>>>> brightness)
>>>>>>> +{
>>>>>>> +       struct led_classdev_flash *fled_cdev =
>>>>>>> +               container_of(led_cdev, struct
>>>>>>> led_classdev_flash, >
>>>>>>> led_cdev);
>>>>>>> +       struct qcom_flash_led *led =
>>>>>>> +               container_of(fled_cdev, struct
>>>>>>> qcom_flash_led,
>>>>>>>>
>>>>>>> flash);
>>>>>>> +       u32 current_ma = brightness * led-
>>>>>>>> max_torch_current_ma
>>>>>>> / >
>>>>>>> LED_FULL;
>>>>>>> +       bool enable = !!brightness;
>>>>>>> +       int rc;
>>>>>>> +
>>>>>>> +       rc = set_flash_current(led, current_ma,
>>>>>>> TORCH_MODE);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       /* disable flash timeout fortorch LED */
>>>>>>> +       rc = set_flash_timeout(led, 0);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       rc = set_flash_module_en(led, enable);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       return set_flash_strobe(led,SW_STROBE, enable);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const struct led_flash_ops qcom_flash_ops = {
>>>>>>> +       .flash_brightness_set = qcom_flash_brightness_set,
>>>>>>> +       .strobe_set = qcom_flash_strobe_set,
>>>>>>> +       .strobe_get = qcom_flash_strobe_get,
>>>>>>> +       .timeout_set = qcom_flash_timeout_set,
>>>>>>> +       .fault_get = qcom_flash_fault_get,
>>>>>>> +};
>>>>>>> +
>>>>>>> +#if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
>>>>>>> +static int qcom_flash_external_strobe_set(struct
>>>>>>> v4l2_flash >
>>>>>>> *v4l2_flash, bool enable)
>>>>>>> +{
>>>>>>> +       struct led_classdev_flash *flash = v4l2_flash-
>>>>>>>> fled_cdev;
>>>>>>> +       struct qcom_flash_led *led = container_of(flash,
>>>>>>> struct
>>>>>>>>
>>>>>>> qcom_flash_led, flash);
>>>>>>> +       int rc;
>>>>>>> +
>>>>>>> +       rc = set_flash_module_en(led, enable);
>>>>>>> +       if (rc < 0)
>>>>>>> +               return rc;
>>>>>>> +
>>>>>>> +       if (enable)
>>>>>>> +               return set_flash_strobe(led, HW_STROBE,
>>>>>>> true);
>>>>>>> +       else
>>>>>>> +               return set_flash_strobe(led, SW_STROBE,
>>>>>>> false);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static enum led_brightness
>>>>>>> qcom_flash_intensity_to_led_brightness(
>>>>>>> +               struct v4l2_flash *v4l2_flash, s32
>>>>>>> intensity)
>>>>>>> +{
>>>>>>> +       struct led_classdev_flash *flash = v4l2_flash-
>>>>>>>> fled_cdev;
>>>>>>> +       struct qcom_flash_led *led = container_of(flash,
>>>>>>> struct
>>>>>>>>
>>>>>>> qcom_flash_led, flash);
>>>>>>> +       u32 current_ma = intensity/ 1000;
>>>>>>> +
>>>>>>> +       current_ma = min_t(u32, current_ma, > led-
>>>>>>>> max_torch_current_ma);
>>>>>>> +       if (!current_ma)
>>>>>>> +               return LED_OFF;
>>>>>>> +
>>>>>>> +       return current_ma * LED_FULL/ led-
>>>>>>>> max_torch_current_ma;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static s32 qcom_flash_brightness_to_led_intensity(struct
>>>>>>> v4l2_flash > *v4l2_flash,
>>>>>>> +                                       enum led_brightness
>>>>>>>>
>>>>>>> brightness)
>>>>>>> +{
>>>>>>> +       struct led_classdev_flash *flash = v4l2_flash-
>>>>>>>> fled_cdev;
>>>>>>> +       struct qcom_flash_led *led = container_of(flash,
>>>>>>> struct
>>>>>>>>
>>>>>>> qcom_flash_led, flash);
>>>>>>> +
>>>>>>> +       return (brightness * led->max_torch_current_ma *
>>>>>>> 1000)
>>>>>>> / >
>>>>>>> LED_FULL;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const struct v4l2_flash_ops qcom_v4l2_flash_ops = {
>>>>>>> +       .external_strobe_set =
>>>>>>> qcom_flash_external_strobe_set,
>>>>>>> +       .intensity_to_led_brightness= >
>>>>>>> qcom_flash_intensity_to_led_brightness,
>>>>>>> +       .led_brightness_to_intensity= >
>>>>>>> qcom_flash_brightness_to_led_intensity,
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int qcom_flash_v4l2_init(struct qcom_flash_led
>>>>>>> *led,
>>>>>>> struct
>>>>>>>> fwnode_handle *fwnode)
>>>>>>> +{
>>>>>>> +       struct v4l2_flash_config v4l2_cfg = {0};
>>>>>>> +       struct led_flash_setting *s = &v4l2_cfg.intensity;
>>>>>>> +
>>>>>>> +       if (!(led->flash.led_cdev.flags &
>>>>>>> LED_DEV_CAP_FLASH))
>>>>>>> +               return 0;
>>>>>>> +
>>>>>>> +       s->min = s->step = TORCH_IRES_UA * led->chan_count;
>>>>>>> +       s->max = led->max_torch_current_ma * 1000;
>>>>>>> +       s->val = min_t(u32, s->max,
>>>>>>> TORCH_CURRENT_DEFAULT_UA);
>>>>>>> +
>>>>>>> +       strscpy(v4l2_cfg.dev_name, >led-
>>>>>>>> flash.led_cdev.dev-
>>>>>>>> kobj.name,
>>>>>>> +                                       sizeof(v4l2_cfg.dev
>>>>>>> _nam
>>>>>>> e));
>>>>>>> +       v4l2_cfg.has_external_strobe= 1;
>>>>>>> +       v4l2_cfg.flash_faults = LED_FAULT_INPUT_VOLTAGE | >
>>>>>>> LED_FAULT_OVER_CURRENT |
>>>>>>> +               LED_FAULT_SHORT_CIRCUIT |
>>>>>>> LED_FAULT_OVER_TEMPERATURE > | LED_FAULT_TIMEOUT;
>>>>>>> +
>>>>>>> +       led->v4l2_flash = v4l2_flash_init(led->chip->dev,
>>>>>>> fwnode, >
>>>>>>> &led->flash,
>>>>>>> +                                       &qcom_v4l2_flash_op
>>>>>>> s, >
>>>>>>> &v4l2_cfg);
>>>>>>> +       return PTR_ERR_OR_ZERO(led->v4l2_flash);
>>>>>>> +}
>>>>>>> +# else
>>>>>>> +static int qcom_flash_v4l2_init(struct qcom_flash_led
>>>>>>> *led,
>>>>>>> struct
>>>>>>>> fwnode_handle *fwnode)
>>>>>>> +{
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +static int qcom_flash_register_led_device(struct device
>>>>>>> *parent,
>>>>>>> +               struct fwnode_handle *node, struct
>>>>>>> qcom_flash_led >
>>>>>>> *led)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_chip *chip= led->chip;
>>>>>>> +       struct led_init_data init_data;
>>>>>>> +       struct led_classdev_flash *flash;
>>>>>>> +       struct led_flash_setting *s;
>>>>>>> +       u32 count, val;
>>>>>>> +       u32 channels[4];
>>>>>>> +       int i, rc;
>>>>>>> +
>>>>>>> +       flash = &led->flash;
>>>>>>> +       count = fwnode_property_count_u32(node, "led-
>>>>>>> sources");
>>>>>>> +       if (count <= 0) {
>>>>>>> +               dev_err(chip->dev, "No led-sources
>>>>>>> specified\n");
>>>>>>> +               return -ENODEV;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       if (count > chip->max_channels) {
>>>>>>> +               dev_err(chip->dev, "led-sources count %u
>>>>>>> exceeds >
>>>>>>> maximum channel count %u\n",
>>>>>>> +                               count, chip->max_channels);
>>>>>>> +               return -EINVAL;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       rc = fwnode_property_read_u32_array(node, "led-
>>>>>>> sources", >
>>>>>>> channels, count);
>>>>>>> +       if (rc < 0) {
>>>>>>> +               dev_err(chip->dev, "get led-sources failed,
>>>>>>> rc=%d\n", > rc);
>>>>>>> +               return rc;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       led->chan_count = count;
>>>>>>> +       led->chan_id = devm_kcalloc(chip->dev, count,
>>>>>>> sizeof(u8), >
>>>>>>> GFP_KERNEL);
>>>>>>> +       if (!led->chan_id)
>>>>>>> +               return -ENOMEM;
>>>>>>> +
>>>>>>> +       for (i = 0; i < count; i++) {
>>>>>>> +               if (channels[i] > chip->max_channels) {
>>>>>>> +                       dev_err(chip->dev, "led-source out
>>>>>>> of
>>>>>>> HW >
>>>>>>> support range [1-%u]\n",
>>>>>>> +                                       chip-
>>>>>>>> max_channels);
>>>>>>> +                       return-EINVAL;
>>>>>>> +               }
>>>>>>> +
>>>>>>> +               led->chan_id[i] = channels[i];
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       rc = fwnode_property_read_u32(node, "led-max-
>>>>>>> microamp",
>>>>>>>>
>>>>>>> &val);
>>>>>>> +       if (rc < 0) {
>>>>>>> +               dev_err(chip->dev, "Get led-max-microamp
>>>>>>> failed, >
>>>>>>> rc=%d\n", rc);
>>>>>>> +               return rc;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       if (!val) {
>>>>>>> +               dev_err(chip->dev, "led-max-microamp
>>>>>>> shouldn't
>>>>>>> be >
>>>>>>> 0\n");
>>>>>>> +               return -EINVAL;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       val = min_t(u32, val, TORCH_CURRENT_MAX_UA * > led-
>>>>>>>> chan_count);
>>>>>>> +       led->max_torch_current_ma = val / 1000;
>>>>>>> +
>>>>>>> +       if (fwnode_property_present(node, "flash-max-
>>>>>>> microamp")) {
>>>>>>> +               flash->led_cdev.flags |= LED_DEV_CAP_FLASH;
>>>>>>> +               rc = fwnode_property_read_u32(node, >
>>>>>>> "flash-
>>>>>>> max-
>>>>>>> microamp", &val);
>>>>>>> +               if (rc < 0) {
>>>>>>> +                       dev_err(chip->dev, "Get flash-max-
>>>>>>> microamp
>>>>>>>> failed, rc=%d\n", rc);
>>>>>>> +                       returnrc;
>>>>>>> +               }
>>>>>>> +
>>>>>>> +               val = min_t(u32, val, FLASH_CURRENT_MAX_UA
>>>>>>> * >
>>>>>>> led-
>>>>>>>> chan_count);
>>>>>>> +               val = min_t(u32, val,
>>>>>>> FLASH_TOTAL_CURRENT_MAX_UA);
>>>>>>> +               s = &flash->brightness;
>>>>>>> +               s->min = s->step = FLASH_IRES_UA * led-
>>>>>>>> chan_count;
>>>>>>> +               s->max = val;
>>>>>>> +               s->val = min_t(u32, val,
>>>>>>> FLASH_CURRENT_DEFAULT_UA);
>>>>>>> +               led->max_flash_current_ma = val / 1000;
>>>>>>> +               led->flash_current_ma = s->val / 1000;
>>>>>>> +
>>>>>>> +               rc = fwnode_property_read_u32(node, >
>>>>>>> "flash-
>>>>>>> max-
>>>>>>> timeout-us", &val);
>>>>>>> +               if (rc < 0) {
>>>>>>> +                       dev_err(chip->dev, "Get flash-max-
>>>>>>> timeout-
>>>>>>> us > failed, rc=%d\n", rc);
>>>>>>> +                       returnrc;
>>>>>>> +               }
>>>>>>> +
>>>>>>> +               val = min_t(u32, val,
>>>>>>> FLASH_TIMEOUT_MAX_US);
>>>>>>> +               s = &flash->timeout;
>>>>>>> +               s->min = s->step = FLASH_TIMEOUT_STEP_US;
>>>>>>> +               s->val = s->max = val;
>>>>>>> +               led->max_timeout_ms = led->flash_timeout_ms
>>>>>>> =
>>>>>>> val /
>>>>>>>> 1000;
>>>>>>> +
>>>>>>> +               flash->ops = &qcom_flash_ops;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       flash->led_cdev.brightness_set_blocking = >
>>>>>>> qcom_flash_led_brightness_set;
>>>>>>> +       init_data.fwnode = node;
>>>>>>> +       init_data.devicename = NULL;
>>>>>>> +       init_data.default_label = NULL;
>>>>>>> +       init_data.devname_mandatory = false;
>>>>>>> +       rc = devm_led_classdev_flash_register_ext(parent,
>>>>>>> flash, >
>>>>>>> &init_data);
>>>>>>> +       if (rc < 0) {
>>>>>>> +               dev_err(chip->dev, "Register flash LED
>>>>>>> classdev
>>>>>>>>
>>>>>>> failed, rc=%d\n", rc);
>>>>>>> +               return rc;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       return qcom_flash_v4l2_init(led, node);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int qcom_flash_led_probe(struct platform_device
>>>>>>> *pdev)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_chip *chip;
>>>>>>> +       struct qcom_flash_led *led;
>>>>>>> +       struct fwnode_handle *child;
>>>>>>> +       struct device *dev = &pdev->dev;
>>>>>>> +       struct regmap *map;
>>>>>>> +       struct reg_field *regs;
>>>>>>> +       int count, i, rc;
>>>>>>> +       u32 val, reg_base;
>>>>>>> +
>>>>>>> +       chip = devm_kzalloc(dev, sizeof(*chip),
>>>>>>> GFP_KERNEL);
>>>>>>> +       if (!chip)
>>>>>>> +               return -ENOMEM;
>>>>>>> +
>>>>>>> +       map = dev_get_regmap(dev->parent, NULL);
>>>>>>> +       if (!map) {
>>>>>>> +               dev_err(dev, "Failed to get parent
>>>>>>> regmap\n");
>>>>>>> +               return -EINVAL;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       rc = fwnode_property_read_u32(dev->fwnode, "reg",
>>>>>>> &reg_base);
>>>>>>> +       if (rc < 0) {
>>>>>>> +               dev_err(dev, "Failed to get register base
>>>>>>> address,
>>>>>>>> rc=%d\n", rc);
>>>>>>> +               return rc;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       rc = regmap_read(map, reg_base + FLASH_TYPE_REG,
>>>>>>> &val);
>>>>>>> +       if (rc < 0) {
>>>>>>> +               dev_err(dev, "Read flash module type
>>>>>>> failed, >
>>>>>>> rc=%d\n", rc);
>>>>>>> +               return rc;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       if (val != FLASH_TYPE_VAL){
>>>>>>> +               dev_err(dev, "type %#x is not a flash
>>>>>>> module\n", >
>>>>>>> val);
>>>>>>> +               return -ENODEV;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       rc = regmap_read(map, reg_base + FLASH_SUBTYPE_REG,
>>>>>>> &val);
>>>>>>> +       if (rc < 0) {
>>>>>>> +               dev_err(dev, "Read flash module subtype
>>>>>>> failed,
>>>>>>>>
>>>>>>> rc=%d\n", rc);
>>>>>>> +               return rc;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       if (val == FLASH_SUBTYPE_3CH_VAL) {
>>>>>>> +               chip->hw_type = QCOM_MVFLASH_3CH;
>>>>>>> +               chip->max_channels = 3;
>>>>>>> +               regs = mvflash_3ch_regs;
>>>>>>> +       } else if (val == FLASH_SUBTYPE_4CH_VAL) {
>>>>>>> +               chip->hw_type = QCOM_MVFLASH_4CH;
>>>>>>> +               chip->max_channels = 4;
>>>>>>> +               regs = mvflash_4ch_regs;
>>>>>>> +       } else {
>>>>>>> +               dev_err(dev, "flash subtype %#x is not yet
>>>>>>>>
>>>>>>> supported\n", val);
>>>>>>> +               return -ENODEV;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       for (i = 0; i < REG_MAX_COUNT; i++)
>>>>>>> +               regs[i].reg += reg_base;
>>>>>>> +
>>>>>>> +       rc = devm_regmap_field_bulk_alloc(dev, map, chip-
>>>>>>>> r_fields,
>>>>>>>> regs, REG_MAX_COUNT);
>>>>>>> +       if (rc < 0) {
>>>>>>> +               dev_err(dev, "failed to alloc regmap filed,
>>>>>>> rc=%d\n", > rc);
>>>>>>> +               return rc;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       chip->dev = dev;
>>>>>>> +       platform_set_drvdata(pdev, chip);
>>>>>>> +       mutex_init(&chip->lock);
>>>>>>> +       count = device_get_child_node_count(dev);
>>>>>>> +       if (count == 0 || count > chip->max_channels) {
>>>>>>> +               dev_err(dev, "No child or child count
>>>>>>> exceeds
>>>>>>> %d\n", > chip->max_channels);
>>>>>>> +               return -EINVAL;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       chip->leds = devm_kcalloc(dev, count, sizeof(*chip-
>>>>>>>> leds),
>>>>>>>> GFP_KERNEL);
>>>>>>> +       if (!chip->leds)
>>>>>>> +               return -ENOMEM;
>>>>>>> +
>>>>>>> +       device_for_each_child_node(dev, child) {
>>>>>>> +               led = &chip->leds[chip->leds_count];
>>>>>>> +               led->chip = chip;
>>>>>>> +               rc = qcom_flash_register_led_device(dev,
>>>>>>> child,
>>>>>>> led);
>>>>>>> +               if (rc < 0)
>>>>>>> +                       goto release;
>>>>>>> +
>>>>>>> +               chip->leds_count++;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       return 0;
>>>>>>> +release:
>>>>>>> +       while (chip->leds && chip->leds_count--)
>>>>>>> +               v4l2_flash_release(chip->leds[chip-
>>>>>>>> leds_count].v4l2_> flash);
>>>>>>> +       return rc;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int qcom_flash_led_remove(struct platform_device
>>>>>>> *pdev)
>>>>>>> +{
>>>>>>> +       struct qcom_flash_chip *chip=
>>>>>>> platform_get_drvdata(pdev);
>>>>>>> +
>>>>>>> +       while (chip->leds_count--)
>>>>>>> +               v4l2_flash_release(chip->leds[chip-
>>>>>>>> leds_count].v4l2_> flash);
>>>>>>> +
>>>>>>> +       mutex_destroy(&chip->lock);
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const struct of_device_id
>>>>>>> qcom_flash_led_match_table[]
>>>>>>> = {
>>>>>>> +       { .compatible = "qcom,spmi-flash-led" },
>>>>>>> +       { }
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct platform_driver qcom_flash_led_driver = {
>>>>>>> +       .driver = {
>>>>>>> +               .name = "leds-qcom-flash",
>>>>>>> +               .of_match_table =
>>>>>>> qcom_flash_led_match_table,
>>>>>>> +       },
>>>>>>> +       .probe = qcom_flash_led_probe,
>>>>>>> +       .remove = qcom_flash_led_remove,
>>>>>>> +};
>>>>>>> +
>>>>>>> +module_platform_driver(qcom_flash_led_driver);
>>>>>>> +
>>>>>>> +MODULE_DESCRIPTION("QCOM Flash LED driver");
>>>>>>> +MODULE_LICENSE("GPL");
>>>>>
>>>>> Kind regards,
>>>>> Dylan Van Assche
>>>
>>> Kind regards,
>>> Dylan Van Assche
>>>
> 
> Kind regards,
> Dylan Van Assche
> 
