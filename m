Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CEE730D62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjFOC5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjFOC5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:57:10 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 208B0122;
        Wed, 14 Jun 2023 19:57:07 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxnOoCfopkVGQFAA--.11424S3;
        Thu, 15 Jun 2023 10:57:06 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPMr_fYpkxVobAA--.3349S3;
        Thu, 15 Jun 2023 10:57:06 +0800 (CST)
Subject: Re: [PATCH v14 1/2] thermal: loongson-2: add thermal management
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>, zhuyinbo@loongson.cn
References: <20230426062018.19755-1-zhuyinbo@loongson.cn>
 <af4d1e00-76d6-b71a-2ed1-562e6405306b@linaro.org>
 <ac5b3982-a658-e05b-1b5c-3aeeda1585ed@loongson.cn>
 <d652acef-ab25-7d5e-6af0-584dacfbbd8d@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <8ca44091-35fd-cc24-9896-0317772c5620@loongson.cn>
Date:   Thu, 15 Jun 2023 10:57:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d652acef-ab25-7d5e-6af0-584dacfbbd8d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPMr_fYpkxVobAA--.3349S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Daniel,

在 2023/6/14 下午6:59, Daniel Lezcano 写道:
> 
> Hi Yinbo,
> 
> 
> On 14/06/2023 10:03, zhuyinbo wrote:
>>
>> Hi Daniel,
>>
>> Thank you very much for your feedback and suggestions. Below, I have
>> some comments, please review.
> 
> [ ... ]
> 
>>>> +
>>>> +    low += 100;
>>>> +    high += 100;
> 
> Literals -> macros


okay, I got it.

> 
>>>> +    reg_ctrl = low;
>>>> +    reg_ctrl |= enable ? 0x100 : 0;
>>>> +    writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + 
>>>> reg_off);
>>>> +
>>>> +    reg_ctrl = high;
>>>> +    reg_ctrl |= enable ? 0x100 : 0;
>>>> +    writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_HI + 
>>>> reg_off);
>>>
>>> Is the 'enable' boolean really useful?
>>
>>
>> Yes, this 'enable' was to enable thermal irq.
>>
>>>
>>> Wouldn't be the sensor trip points disabled by default at reset time?
>>>
>>
>>
>> Only here will thermal irq be enabled throughout the entire driver, and
>> actual testing has shown that interrupts are valid, so this is
>> meaningful.
> 
> Ok.
> 
>>> If it is the case then we can get ride of this variable and make the 
>>> routine simpler
>>>
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int loongson2_thermal_get_temp(struct thermal_zone_device 
>>>> *tz, int *temp)
>>>> +{
>>>> +    u32 reg_val;
>>>> +    struct loongson2_thermal_data *data = tz->devdata;
>>>> +
>>>> +    reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
>>>
>>> Seems like there is no offset for the sensor id here ?
>>
>>
>> There is no need for a sensor ID here.
>>
>> There are some things that I didn't describe clearly, which made you
>> misunderstand. Actually, the temperature sensor of 2K1000 is like this:
>>
>> There are 4 sets of temperature interrupt controllers, only one set of
>> temperature sampling registers. a sets of temperature interrupt
>> controllers was considered a sensor, which sensor include 3 register as
>> follows, where "SEL" represents which sensor is referenced, In 2k1000
>> datasheet, which "SEL" must be 0.
> 
> I'm not sure to understand. Let me rephrase it and know what is wrong.
> 
> 1. The thermal controller has 4 sensors. The interrupt can be set for 
> these 4 sensors.


You can think it's actually a sensor, but the thermal sensor include a
set of status register and four sets of control register in loongson-2k
series (2k1000 /2k2000), but the control register only select a group
register by set "SEL".

> 
> 2. When reading a temperature, we have to select the sensor via the 
> 'SEL' register.


The 'SEL' was to select thermal control register set, that reading a
tempearure was to thermal status register set. thermal status register
set only one and no no other choice. The function of 'SEL' is actually
to select which temperature sensor collects the temperature as input.

> 
> 3. The 2k1000 has one sensor with an id = 0.


Yes, the future 2k series product may still be a sensor, but the ID may
not be 0, it may be 1 or 2 or 3.

> 
> 4. In the future, more Loongson platform can be submitted with more than 
> one sensor


 From the current situation of the 2k series (2k1000/2k2000), it seems
that there will always be only one sensor, but 'SEL' can be used to
select which sensor. (0th, 1th, 2th, 3th).  If there are really special
circumstances in the future, add appropriate modifications at that time.

> 
> If this is correct, then my comments are about the inconsistency of the 
> proposed changes. Guessing in the future Loongson board there will be 
> more than one sensor, the existing code mixes support for one and 
> multiple sensors as well as assuming id is 0.
> 
> So if you add in the of_loongson2_thermal_match table a new platform 
> with several sensors, the current code will be broken because:
> 
>   - the initialization loop does exit when the first thermal zone 
> registration succeed
> 
>   - the interrupt handler does not figure out which sensor crossed the 
> low/high limit
> 
>   - the get_temp is not selecting the right sensor


Yes,  but currently this code does not support the requirement for 
multiple sensors.

> 
> 
> That is my point:
> 
>   - write the code to support one sensor with id=0 only
> 
>     *or*
> 
>   - write the code to support multiple sensors
> 
> If I'm not wrong the code is closer to support multiple sensors ;)


In fact, my code is more inclined to support one sensor, but it can
determine which sensor to use based on the ID. (id = 0, 1, 2, 3)

> 
> Let me know if these deductions are correct
> 
>    -- Daniel
> 
> ps : is there an English translation for the 2k1000 datasheet ?


Sorry, there seems to be no English version available at the moment.


Thanks,
Yinbo.

