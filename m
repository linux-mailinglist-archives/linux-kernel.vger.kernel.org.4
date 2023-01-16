Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F866BD39
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjAPLw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAPLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:52:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA2166E1;
        Mon, 16 Jan 2023 03:52:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C89226602AA1;
        Mon, 16 Jan 2023 11:52:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673869940;
        bh=CVZUIWVKnY0LRLjyYUd0hBINwGyBzN+d2Zrqq8AHqUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UQWJSHvX85u3RfN9x2VAONawiZVE1qh4JJmpwsnrzOZ9jD6mW3CjnelBaiYu8qk+/
         /heNq5WTwQFdIpfXBZxSKLeGkITrK5ineflMnW4aPTN941LdZrRzNQs1C7/4md8Sqr
         hfbi8GK8RJvijnQ3GpVQvb8OwnE7XeM38495vfpgPw0oWZBZIVeC1AzF2/tzJkqICu
         dx8yhxRyeXSy63qJbMolp0+pqNxc2uEskkqjQ7ImoaMQXDdepe5jzpmXmILYSgtxyX
         jFokrDIioKcoCTW8wQSwkJrpm6dzmBUut9g7DGTcksP3WX95mGiBiS2VvbF6rBxlrD
         AJ4KGzN8T9ROg==
Message-ID: <d640f848-3f28-3089-7703-ee6cb9db32ed@collabora.com>
Date:   Mon, 16 Jan 2023 12:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v10 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, bchihi@baylibre.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-5-bchihi@baylibre.com>
 <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
 <1ee1152b-b83b-ed7b-6368-26601ece37e8@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1ee1152b-b83b-ed7b-6368-26601ece37e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/01/23 12:08, Daniel Lezcano ha scritto:
> On 16/01/2023 11:50, AngeloGioacchino Del Regno wrote:
>> Il 12/01/23 16:28, bchihi@baylibre.com ha scritto:
>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>
>>> The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
>>> controllers contained in a thermal domain.
>>>
>>> A thermal domains can be the MCU or the AP.
>>>
>>> Each thermal domains contain up to seven controllers, each thermal
>>> controller handle up to four thermal sensors.
>>>
>>> The LVTS has two Finite State Machines (FSM), one to handle the
>>> functionin temperatures range like hot or cold temperature and another
>>> one to handle monitoring trip point. The FSM notifies via interrupts
>>> when a trip point is crossed.
>>>
>>> The interrupt is managed at the thermal controller level, so when an
>>> interrupt occurs, the driver has to find out which sensor triggered
>>> such an interrupt.
>>>
>>> The sampling of the thermal can be filtered or immediate. For the
>>> former, the LVTS measures several points and applies a low pass
>>> filter.
>>>
>>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>>> ---
>>>   drivers/thermal/mediatek/Kconfig            |   15 +
>>>   drivers/thermal/mediatek/Makefile           |    1 +
>>>   drivers/thermal/mediatek/lvts_thermal.c     | 1244 +++++++++++++++++++
>>>   include/dt-bindings/thermal/mediatek-lvts.h |   19 +
>>>   4 files changed, 1279 insertions(+)
>>>   create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
>>>   create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h
>>>
>>
>> ..snip..
>>
>>> +
>>> +static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
>>> +{
>>> +    struct lvts_sensor *lvts_sensor = tz->devdata;
>>> +    void __iomem *base = lvts_sensor->base;
>>> +    u32 raw_low = lvts_temp_to_raw(low);
>>> +    u32 raw_high = lvts_temp_to_raw(high);
>>> +
>>> +    /*
>>> +     * Hot to normal temperature threshold
>>> +     *
>>> +     * LVTS_H2NTHRE
>>> +     *
>>> +     * Bits:
>>> +     *
>>> +     * 14-0 : Raw temperature for threshold
>>> +     */
>>> +    if (low != -INT_MAX) {
>>> +        dev_dbg(&tz->device, "Setting low limit temperature interrupt: %d\n", 
>>> low);
>>> +        writel(raw_low, LVTS_H2NTHRE(base));
>>> +    }
>>> +
>>> +    /*
>>> +     * Hot temperature threshold
>>> +     *
>>> +     * LVTS_HTHRE
>>> +     *
>>> +     * Bits:
>>> +     *
>>> +     * 14-0 : Raw temperature for threshold
>>> +     */
>>> +    dev_dbg(&tz->device, "Setting high limit temperature interrupt: %d\n", high);
>>> +    writel(raw_high, LVTS_HTHRE(base));
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
>>> +{
>>> +    irqreturn_t iret = IRQ_NONE;
>>> +    u32 value, masks[] = { 0x0009001F, 0X000881F0, 0x00247C00, 0x1FC00000 };
>>
>> Please, no magic numbers around.
>>
>>> +    int i;
>>> +
>>> +    /*
>>> +     * Interrupt monitoring status
>>> +     *
>>> +     * LVTS_MONINTST
>>> +     *
>>> +     * Bits:
>>
>> You're describing the register with nice words, but there's another way to do
>> the same that will be even more effective.
>>
>> /*
>>   * LVTS MONINT: Interrupt Monitoring register
>>   * Each bit describes the enable status of per-sensor interrupts.
>>   */
>> #define LVTS_MONINT_THRES_COLD    BIT(0)    /* Cold threshold */
>> #define LVTS_MONINT_THRES_HOT    BIT(1)    /* Hot threshold */
>> #define LVTS_MONINT_OFFST_LOW    BIT(2)    /* Low offset */
>> #define LVTS_MONINT_OFFST_HIGH    BIT(3)    /* High offset */
>> #define LVTS_MONINT_OFFST_NTH    BIT(4)    /* Normal To Hot */
>> #define EVERYTHING_ELSE ........................
> 
> I don't see how this is more effective than describing the register layout. If 
> someone wants to hack the driver, it is much better to have the layout than this 
> long list of defines for every bits of every registers.
> 

This also describes the register layout, with the difference that we can use those
definitions with bitfield macros to avoid writing magic numbers around.

Anyway, I'm not against the long comment that is describing the layout with nice
words - my suggestion was just only about one of the ways to replace the magic
numbers with actual definitions.

Regards,
Angelo

