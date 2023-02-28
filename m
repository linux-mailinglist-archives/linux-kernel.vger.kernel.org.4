Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462C66A50E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjB1CHB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Feb 2023 21:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1CG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:06:59 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27243252BA;
        Mon, 27 Feb 2023 18:06:52 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id ECB2A24E30E;
        Tue, 28 Feb 2023 10:06:50 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 10:06:50 +0800
Received: from [192.168.125.128] (113.72.145.171) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 10:06:48 +0800
Message-ID: <704dea02-6b9d-b977-1354-a390a489a7fb@starfivetech.com>
Date:   Tue, 28 Feb 2023 10:07:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com>
 <20230223182341.GA200380@roeck-us.net>
 <8ba002ea-299c-2eaf-b1a7-d7d38a540152@starfivetech.com>
 <ae998eb6-54ce-05c4-2961-bdb2393eac64@roeck-us.net>
 <58cab864-2a59-b82c-bdfe-2e805a04fd7a@starfivetech.com>
 <547a469d-eeaa-750c-4fe5-cc82d92493a6@roeck-us.net>
 <2b79e1ac-3399-075d-1d1d-e6d7f88351fc@starfivetech.com>
 <a7ffe026-a48b-9ffd-20d3-7d25caba120d@roeck-us.net>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <a7ffe026-a48b-9ffd-20d3-7d25caba120d@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/27 22:50, Guenter Roeck wrote:
> On 2/26/23 22:45, Xingyu Wu wrote:
>> On 2023/2/27 14:36, Guenter Roeck wrote:
>>> On 2/26/23 22:26, Xingyu Wu wrote:
>>>> On 2023/2/24 23:18, Guenter Roeck wrote:
>>>>> On 2/23/23 23:42, Xingyu Wu wrote:
>>>>>> On 2023/2/24 2:23, Guenter Roeck wrote:
>>>>>>> On Mon, Feb 20, 2023 at 04:19:26PM +0800, Xingyu Wu wrote:
>>>>>>>> [...]
>>>>>>>> +
>>>>>>>> +    wdt->wdt_device.min_timeout = 1;
>>>>>>>> +    wdt->wdt_device.max_timeout = starfive_wdt_max_timeout(wdt);
>>>>>>>
>>>>>>>       wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>>>>>>>
>>>>>>> should be set here. Otherwise the warning below would always be seen
>>>>>>> if the module parameter is not set.
>>>>>>>
>>>>>>>> +
>>>>>>>> +    watchdog_set_drvdata(&wdt->wdt_device, wdt);
>>>>>>>> +
>>>>>>>> +    /*
>>>>>>>> +     * see if we can actually set the requested heartbeat,
>>>>>>>> +     * and if not, try the default value.
>>>>>>>> +     */
>>>>>>>> +    watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
>>>>>>>> +    if (wdt->wdt_device.timeout == 0 ||
>>>>>>>
>>>>>>> If wdt->wdt_device.timeout is pre-initialized, it will never be 0 here.
>>>>>>>
>>>>>>>> +        wdt->wdt_device.timeout > wdt->wdt_device.max_timeout) {
>>>>>>>
>>>>>>> That won't happen because watchdog_init_timeout() validates it and does
>>>>>>> not update the value if it is out of range.
>>>>>>>
>>>>>>>> +        dev_warn(dev, "heartbeat value out of range, default %d used\n",
>>>>>>>> +             STARFIVE_WDT_DEFAULT_TIME);
>>>>>>>> +        wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>>>>>>>
>>>>>>> And this is then unnecessary. wdt->wdt_device.timeout will always be
>>>>>>> valid if it was pre-initialized.
>>>>>>
>>>>>> It is changed to be this at beginning of the driver:
>>>>>>
>>>>>> static int heartbeat = STARFIVE_WDT_DEFAULT_TIME;
>>>>>>
>>>>>
>>>>> No, this is wrong. The static variable should be set to 0 to indicate
>>>>> "use default".
>>>>>
>>>>>> and it is changed to be this here:
>>>>>>
>>>>>> ret = watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
>>>>>> if (ret)
>>>>>>       return ret;
>>>>>>
>>>>>> Would that be better?
>>>>>>
>>>>>
>>>>> No, it is worse, because it would not instantiate the watchdog at all
>>>>> if a bad heartbeat is provided.
>>>>>
>>>>
>>>> So instantiate the watchdog with hearbeat first. And if this wrong, use default timeout.
>>>> :
>>>> if (watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev))
>>>>      wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>>>>
>>>
>>> I am kind of lost why you have to make it that complicated.
>>> Just pre-initialize wdt->wdt_device.timeout like all the other drivers do,
>>> and as I had suggested earlier.
>>>
>>
>> So you mean just use :
>> wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>> to initialize watchdog directly?
>>
> 
> Yes, as I had suggested before, before calling watchdog_init_timeout().
> 

OK, thanks.
Best regard,
Xingyu Wu

