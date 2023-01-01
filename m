Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0F65A981
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 10:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAAJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 04:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAAJgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 04:36:05 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263282727
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 01:36:02 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id Bul5pYI66Rn9tBul5pQ6t3; Sun, 01 Jan 2023 10:36:00 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Jan 2023 10:36:00 +0100
X-ME-IP: 86.243.100.34
Message-ID: <40718555-3c2e-f6b5-889a-0a1817ad39a0@wanadoo.fr>
Date:   Sun, 1 Jan 2023 10:35:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] watchdog: ixp4xx: Use devm_clk_get_enabled() helper
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
 <20221231231451.GD2706156@roeck-us.net>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221231231451.GD2706156@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/01/2023 à 00:14, Guenter Roeck a écrit :
> On Sat, Dec 31, 2022 at 12:07:27PM +0100, Christophe JAILLET wrote:
>> The devm_clk_get_enabled() helper:
>>     - calls devm_clk_get()
>>     - calls clk_prepare_enable() and registers what is needed in order to
>>       call clk_disable_unprepare() when needed, as a managed resource.
>>
>> This simplifies the code and avoids the need of a dedicated function used
>> with devm_add_action_or_reset().
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Note that I get a compilation error because read_cpuid_id() is not defined
>> on my system (x86_64).
>> So I think that a "depends on ARM<something>" in missing in a KConfig file.
> 
> It has
> 
> 	depends on ARCH_IXP4XX
> 
> and CONFIG_IXP4XX_WATCHDOG is not set for me after "make allmodconfig".

Here is what  do.

make allmodconfig
make -j8 drivers/watchdog/ixp4xx_wdt.o

And I get:
   DESCEND objtool
   CALL    scripts/checksyscalls.sh
   CC      drivers/watchdog/ixp4xx_wdt.o
drivers/watchdog/ixp4xx_wdt.c: In function ‘ixp4xx_wdt_probe’:
drivers/watchdog/ixp4xx_wdt.c:122:15: error: implicit declaration of 
function ‘read_cpuid_id’ [-Werror=implicit-function-declaration]
   122 |         if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
       |               ^~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:252 : 
drivers/watchdog/ixp4xx_wdt.o] Erreur 1
make[2]: *** [scripts/Makefile.build:504 : drivers/watchdog] Erreur 2
make[1]: *** [scripts/Makefile.build:504 : drivers] Erreur 2
make: *** [Makefile:2011 : .] Erreur 2


I do agree with you that:

    - Kconfig looks fine
config IXP4XX_WATCHDOG
	tristate "IXP4xx Watchdog"
	depends on ARCH_IXP4XX

   - Makefile looks fine
obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o

   - .config looks fine
IXP4XX_WATCHDOG is NOT defined

   - make drivers/watchdog/ looks fine
No error and ixp4xx_wdt.o is NOT built.


However, in the past (if I recollect correctly :) ), a "make 
<something_that depends_on_a_config_variable_that_is_not_defined>" 
returned an error stating that no rule existed to build the specified 
target.

I sometimes needed to tweak the Kconfig files to force some compilation 
when I didn't have the right tool chain or configuration.
It was maybe not the best practice, but it worked most of the time.


Now, with the example above, such a compilation attempt is possible. It 
is maybe normal (because of a change somewhere in the way the kernel is 
built, because of an updated toolchain on my machine, ...)
This is just fine for me, but looked really surprising.

That is why I first thought that something was missing in a Kconfig file.


So my comments are just a surprise to me to something that seems not to 
behave the same as before.

As far a just a 'make' works as expected, I won't dig further if this 
behavior is expected or not.
It should be a corner case anyway, and for my own use, I would even call 
it a feature :) (i.e. it saves me some Kconfig modification to test things)

CJ

> 
>>
>> Fixing it could help compilation farms build-bots.
> 
> Mine doesn't see a problem, and I don't recall ever being alerted about
> one. What am I missing ? Do you see a problem reported anywhere ?
> 
> Guenter
> 
>> ---
>>   drivers/watchdog/ixp4xx_wdt.c | 18 +++---------------
>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
>> index 281a48d9889f..607ce4b8df57 100644
>> --- a/drivers/watchdog/ixp4xx_wdt.c
>> +++ b/drivers/watchdog/ixp4xx_wdt.c
>> @@ -112,12 +112,6 @@ static const struct watchdog_info ixp4xx_wdt_info = {
>>   	.identity = KBUILD_MODNAME,
>>   };
>>   
>> -/* Devres-handled clock disablement */
>> -static void ixp4xx_clock_action(void *d)
>> -{
>> -	clk_disable_unprepare(d);
>> -}
>> -
>>   static int ixp4xx_wdt_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -139,16 +133,10 @@ static int ixp4xx_wdt_probe(struct platform_device *pdev)
>>   	 * Retrieve rate from a fixed clock from the device tree if
>>   	 * the parent has that, else use the default clock rate.
>>   	 */
>> -	clk = devm_clk_get(dev->parent, NULL);
>> -	if (!IS_ERR(clk)) {
>> -		ret = clk_prepare_enable(clk);
>> -		if (ret)
>> -			return ret;
>> -		ret = devm_add_action_or_reset(dev, ixp4xx_clock_action, clk);
>> -		if (ret)
>> -			return ret;
>> +	clk = devm_clk_get_enabled(dev->parent, NULL);
>> +	if (!IS_ERR(clk))
>>   		iwdt->rate = clk_get_rate(clk);
>> -	}
>> +
>>   	if (!iwdt->rate)
>>   		iwdt->rate = IXP4XX_TIMER_FREQ;
>>   
>> -- 
>> 2.34.1
>>
> 

