Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF071694628
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBMMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBMMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:45:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E7B81969D;
        Mon, 13 Feb 2023 04:45:46 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Dx3tr5MOpjxhYAAA--.459S3;
        Mon, 13 Feb 2023 20:45:45 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB732MOpj9EYyAA--.28122S3;
        Mon, 13 Feb 2023 20:45:42 +0800 (CST)
Subject: Re: [PATCH v12 1/2] thermal: loongson-2: add thermal management
 support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, lvjianmin@loongson.cn,
        wanghongliang@loongson.cn, zhuyinbo@loongson.cn
References: <20221114024709.7975-1-zhuyinbo@loongson.cn>
 <20230206135921.GA15176@linaro.org>
 <64d9782c-cafd-cdc3-3602-719c386d98cc@loongson.cn>
 <20230208104919.GA120053@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <5abe22ee-77d4-4349-1d88-43e4324177f0@loongson.cn>
Date:   Mon, 13 Feb 2023 20:45:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230208104919.GA120053@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxB732MOpj9EYyAA--.28122S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAw17tw1Dur1xZFy8uw4xtFb_yoWrKFWfpr
        W8Ga1UtFZ8tr18W3W0gw18Zr9Iyry3t343Wws3GFyrArZ8tryagFyFqFWF9Fs7CrW0kFWj
        vF15twsruFn8X3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20x
        vY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x
        07jjpBfUUUUU=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/8 下午6:49, Daniel Lezcano 写道:
> On Wed, Feb 08, 2023 at 11:13:33AM +0800, zhuyinbo wrote:
>
> [ ... ]
>
>>>> +struct loongson2_thermal_data {
>>>> +	struct thermal_zone_device *tzd;
>>> 'tzd' won't be needed after taking into account the comments
>> The 'tzd' element is needed,  because the thermal_zone_device_update need
>> pass a data->tzd element.
>>
>> static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
>> {
>>          struct loongson2_thermal_data *data = dev;
>>
>>          thermal_zone_device_update(data->tzd,
>>                                     THERMAL_EVENT_UNSPECIFIED);
>>          enable_irq(data->irq);
>>
>>          return IRQ_HANDLED;
>> }
> After taking into account all the comments, enabled_irq() won't be
> called, so 'data' won't be needed. 'tzd' will be passed to
> devm_request_threaded_irq() instead of 'data'.
>
> As loongson2_thermal_irq_thread() is the only place where 'tzd' is
> needed and 'tzd' being local to the call site of
> thermal_zone_device_register() and devm_request_threaded_irq(), there
> is no need to store the pointer in the 'data' structure.

okay, I got it. I will remove tzd element in data struct.

>
>>>> +	int irq;
>>> 'irq' won't be needed after taking into account the comments
>> I will drop it.
>>>> +	int id;
>>>> +	void __iomem *regs;
>>>> +	struct platform_device *pdev;
>>> 'pdev' is not needed
>> I will drop it.
>>>> +	u16 ctrl_low_val;
>>>> +	u16 ctrl_hi_val;
>>> Those fields won't be needed after taking into account the comments
>> I will drop it.
>>>> +};
>>>> +
>>>> +static int loongson2_thermal_set(struct loongson2_thermal_data *data,
>>>> +					int low, int high, bool enable)
>>>> +{
>>>> +	u64 reg_ctrl = 0;
>>>> +	int reg_off = data->id * 2;
>>>> +
>>>> +	if (low > high)
>>>> +		return -EINVAL;
>>>> +
>>>> +	low = max(low, -100);
>>>> +	high = min(high, 155);
> Documentation says -40, 125
My previous calculation is to consider that the range of 8bit 
representation is 0 to 255,
and node (cpu) temp=Thens0_ out -100, So the temperature range is 0-100 
~ 255-100, and this
range includes -40~125.  In fact, the range described in the manual is - 
40~125, I will
adop it.
>
>>>> +	low += 100;
>>>> +	high += 100;
>>> Why are those values added to the low and high ? Did you mean low += 0x100 ?
>>>
>>> Mind to describe a bit the register layout?
>> node(cpu) temp = Thens0_out -100,
>>
>> low and high is record node temp, so low and high need add '100' as
>> Thens0_out.
> If I refer to the documentation it is a raw value converted from
> centigrade. The function has degree.
>
> So it should be:
>
> temp_deci = temp_milli / 10
>
> raw = temp_to_raw(temp_deci);
>
> -> temp_to_raw to be determined from temp = (raw * 731) / 0x4000 - 273
>
> [ ... ]
I have review the 3a5000 datasheet,  what you said is right about 
3a5000, but in 2k1000 datasheet,

the calculation of temperature is follows:

Temperature = Thens0_out - 100
  
get_temp return value is (Temperature * 1000) and set_trips is (value /1000) in 2k1000.
I don't find a caculate about "temp_deci = temp_milli / 10" . Are you talking about "
temp_deci = temp_milli / 1000" in set_trips?

>
>>>> +static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>>>> +{
>>>> +	u32 reg_val;
>>>> +	struct loongson2_thermal_data *data = tz->devdata;
>>>> +
>>>> +	reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
>>>> +	*temp = ((reg_val & 0xff) - 100) * 1000;
>>> Why '-100' ?
>>>
>>> Is the unit returned 'degrees' ?
>> node(cpu) temp = Thens0_out -100,
>>
>> Here we need to get a node temp.
> If I refer to the Loongson-3A5000 manual and assuming it is the right
> one, the documentation says:
>
> Temperature = Thens0_out * 731 / 0x4000 - 273
>
> The unit is centigrade.
>
> [ ... ]

Yes, 3a5000 is what you said, but 2k1000 is calculated as follows:

Temperature = Thens0_out - 100
>
>>>> +	writeb(0xff, data->regs + LOONGSON2_TSENSOR_STATUS);
>>>> +
>>>> +	loongson2_thermal_set(data, 0, 0, false);
>>> It would be nicer to use a reset line if it is available
>> sorry, I don't get your meaning. Please describe more details about 'reset
>> line'.
> After a reset, the thermal controller should be in default state and the interrupt
> flag cleared.
>
> One example:
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/arch/arm64/boot/dts/nvidia/tegra210.dtsi#n1560
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/tegra/soctherm.c#n2169
>
> Then search in the driver for:
>       reset_control_assert(reset);
>       reset_control_deassert(reset);
>
>
> [ ... ]
>
> Thanks
>
>    -- Daniel
thanks your explicate!   but our platform doesn't support it.
>

