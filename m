Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBB3694720
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBMNd5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Feb 2023 08:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBMNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:33:55 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB567468F;
        Mon, 13 Feb 2023 05:33:44 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A2E5124E289;
        Mon, 13 Feb 2023 21:33:32 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 21:33:32 +0800
Received: from [192.168.125.128] (183.27.97.168) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 21:33:31 +0800
Message-ID: <d5ff24d3-317e-0cb1-24e7-5aac20d81305@starfivetech.com>
Date:   Mon, 13 Feb 2023 21:29:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/3] drivers: watchdog: Add StarFive Watchdog driver
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
        <linux-kernel@vger.kernel.org>
References: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
 <20221219094233.179153-3-xingyu.wu@starfivetech.com>
 <20230201224619.GA3194283@roeck-us.net>
 <8feda5d9-8510-acbf-1ec2-3a0e67df0adc@starfivetech.com>
 <690da4a4-b4df-f316-e948-38c857237095@roeck-us.net>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <690da4a4-b4df-f316-e948-38c857237095@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/10 23:28, Guenter Roeck wrote:
> On 2/9/23 23:01, Xingyu Wu wrote:
>> On 2023/2/2 6:46, Guenter Roeck wrote:
>>> On Mon, Dec 19, 2022 at 05:42:32PM +0800, Xingyu Wu wrote:
>>>> Add watchdog driver for the StarFive JH7110 SoC.
>>>>
>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>
>
>[...]
>
>>>
>>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>>>> +         __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>>>> +MODULE_PARM_DESC(soft_noboot,
>>>> +         "Watchdog action, set to 1 to ignore reboots, 0 to reboot (default 0)");
>>>
>>> I do not understand what this module parameter is supposed to be used for,
>>> and what the "soft_' prefix is supposed to mean.
>>
>> This 'soft_noboot' means watchdog reset enabled status. If 'soft_noboot' is set to 1,
>> it means reset is disabled and do not reboot.Or 'reboot_disbled' instead?
>>
> 
> That means it does nothing ? Why load the watchdog in the first place then ?
> 

This feature is used for debugging, so user can check the counter repeatedly
without rebooting the system.

>[...]
>>>> +
>>>> +/* interrupt status whether has been raised from the counter */
>>>> +static bool starfive_wdt_raise_irq_status(struct starfive_wdt *wdt)
>>>> +{
>>>> +    return !!readl(wdt->base + wdt->drv_data->irq_is_raise);
>>>> +}
>>>> +
>>>> +static void starfive_wdt_int_clr(struct starfive_wdt *wdt)
>>>> +{
>>>> +    writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->drv_data->int_clr);
>>>> +}
>>>
>>> There is no explanation for this interrupt handling (or, rather,
>>> non-handling since there is no interrupt handler. What is the purpose
>>> of even having all this code ?
>>
>> Because the watchdog raise an interrupt signal on the hardware when timeout,
>> although we do not use interrupt handler on the sorfware, but the watchdog
>> initialization or reload also need to clear the hardware interrupt signal.
>>
> 
> That should be documented.
> 

I will add that in the comments.

>
>[...]
>>>> +
>>>> +    /*
>>>> +     * This watchdog takes twice timeouts to reset.
>>>> +     * In order to reduce time to reset, should set half count value.
>>>> +     */
>>>> +    count = timeout * freq / 2;
>>>> +
>>>> +    if (count > STARFIVE_WDT_MAXCNT) {
>>>
>>> count is an unsigned int, which is pretty much everywhere a 32-bit
>>> value. STARFIVE_WDT_MAXCNT is 0xffffffff. How is an unsigned integer
>>> ever supposed to be larger than 0xffffffff ?
>>>
>>>> +        dev_warn(wdt->dev, "timeout %d too big,use the MAX-timeout set.\n",
>>>> +             timeout);
>>>> +        timeout = starfive_wdt_max_timeout(wdt);
>>>> +        count = timeout * freq;
>>>
>>> This is confusing. First, the timeout range is checked by the calling code,
>>> which makes sure it is never larger than max_timeout. max_timeout is
>>> set to the value returned by starfive_wdt_max_timeout().
>>> Thus, count = timeout * freq / 2 will _never_ be larger than
>>> STARFIVE_WDT_MAXCNT. Even if it ever was, it doesn't make sense
>>> to use a count value of timeout * freq in that case, ie a value which
>>> could be twice as large as the supposed maximum value.
>>
>> Change 'count' type to 'u64'. And if 'count' is larger than STARFIVE_WDT_MAXCNT,
>> 'count' is equal to STARFIVE_WDT_MAXCNT. Does that seem OK?
>>
> 
> That would not change anything. This is not about overflows; I would
> have mentioned that. count can still never be larger than STARFIVE_WDT_MAXCNT.
> Please do the math.
> 

I get your point. It has checked the 'count' before the ops of 'set_timeout' so
I check the 'count' uselessly in this. I will remove this.

>
>[...]
>>>> +
>>>> +    if (tmr_atboot && started == 0) {
>>>> +        starfive_wdt_start(&wdt->wdt_device);
>>>> +    } else if (!tmr_atboot) {
>>>> +        /*
>>>> +         *if we're not enabling the watchdog, then ensure it is
>>>> +         * disabled if it has been left running from the bootloader
>>>> +         * or other source.
>>>> +         */
>>>> +        starfive_wdt_stop(&wdt->wdt_device);
>>>
>>> If it _is_ running from the boot loader, the watchdog core is not
>>> informed about it. If it is started here, it is not informed either.
>>> This is unusual and will need to be explained.
>>> Why ?
>>
>> Is is okay to remove the 'started'?
>>
> Yes, though of course it would be better if the watchdog is kept running
> in that situation and the watchdog core is informed about it. Also,
> the watchdog core is still not informed that the watchdog is running
> (i.e., WDOG_HW_RUNNING is not set) when it is explicitly started.
> 

Will remove the 'started'.

>>>
>>>> +    }
>>>> +
>>>> +#ifdef CONFIG_PM
>>>> +    clk_disable_unprepare(wdt->core_clk);
>>>> +    clk_disable_unprepare(wdt->apb_clk);
>>>> +#endif
>>>
>>> I do not understand the above code. Why stop the watchdog if CONFIG_PM
>>> is enabled, even if it is supposed to be running ?
>>
>> There misses a check about 'early_enable' and add 'if (!early_enable)'.
>> There means that disable clock when watchdog sleep and CONFIG_PM is enable.
>> Then enable clock when watchdog work by 'starfive_wdt_runtime_resume' function.
>>
> 
> I am quite sure that you are supposed to use pm functions for that purpose,
> such as pm_runtime_get_sync(), pm_runtime_put_sync(), and pm_runtime_enable(),
> similar to the code in omap_wdt.c.
> 

I will use pm_runtime_get_sync() and pm_runtime_put_sync() to operate clocks.

>[...]
>>>> +#ifdef CONFIG_PM_SLEEP
>>>> +static int starfive_wdt_suspend(struct device *dev)
>>>> +{
>>>> +    int ret;
>>>> +    struct starfive_wdt *wdt = dev_get_drvdata(dev);
>>>> +
>>>> +    starfive_wdt_unlock(wdt);
>>>> +
>>>> +    /* Save watchdog state, and turn it off. */
>>>> +    wdt->reload = starfive_wdt_get_count(wdt);
>>>> +
>>>> +    starfive_wdt_mask_and_disable_reset(wdt, true);
>>>> +
>>>> +    /* Note that WTCNT doesn't need to be saved. */
>>>> +    starfive_wdt_stop(&wdt->wdt_device);
>>>> +    pm_runtime_force_suspend(dev);
>>>> +
>>>> +    starfive_wdt_lock(wdt);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int starfive_wdt_resume(struct device *dev)
>>>> +{
>>>> +    int ret;
>>>> +    struct starfive_wdt *wdt = dev_get_drvdata(dev);
>>>> +
>>>> +    starfive_wdt_unlock(wdt);
>>>> +
>>>> +    pm_runtime_force_resume(dev);
>>>> +
>>>> +    /* Restore watchdog state. */
>>>> +    starfive_wdt_set_reload_count(wdt, wdt->reload);
>>>> +
>>>> +    starfive_wdt_restart(&wdt->wdt_device, 0, NULL);
>>>
>>> I do not understand this call. Per its definition it is a restart handler,
>>> supposed to restart the hardware. Why would anyone want to restart the
>>> system on resume ?
>>
>> The watchdog start counting from 'count' to 0 on everytime resume like a restart.
>> So I directly use a restart.
>>
> 
> That doesn't answer my question. The "restart" callback resets the hardware.
> starfive_wdt_restart() is registered as restart handler, and thus expected
> to reset the hardware. It it doesn't reset the hardware, it should not
> register itself as restart handler. If it does restart the hardware, calling
> it on resume would automatically reset the system on each resume.
> Something is wrong here, and will have to be fixed.
> 
> I _suspect_ that you think that the restart callback is supposed to reset
> the watchdog. That would be wrong. It resets (restarts) the hardware,
> not the watchdog. Please read Documentation/watchdog/watchdog-kernel-api.rst
> if there are questions about this callback.
> 

Thanks you for reminding me. I finally understand that the restart callback is supposed
to reset the hardware not watchdog. This watchdog doesn't reset the hardware, and I will
remove that. By the way, if I don't need restart callback, would I still use the 
'watchdog_set_restart_priority' function? Thanks.

Best regards,
Xingyu Wu
