Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8265AAD2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjAARwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjAARwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:52:40 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62412619
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:52:38 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id C2VfpT5rJ8ao3C2Vfp6RdP; Sun, 01 Jan 2023 18:52:36 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Jan 2023 18:52:36 +0100
X-ME-IP: 86.243.100.34
Message-ID: <401d3328-8da0-056b-8b32-d890bd5508b4@wanadoo.fr>
Date:   Sun, 1 Jan 2023 18:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] watchdog: ixp4xx: Use devm_clk_get_enabled() helper
Content-Language: fr, en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
 <20221231231451.GD2706156@roeck-us.net>
 <40718555-3c2e-f6b5-889a-0a1817ad39a0@wanadoo.fr>
 <20230101150758.GA2736217@roeck-us.net>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230101150758.GA2736217@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,WEIRD_PORT autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/01/2023 à 16:07, Guenter Roeck a écrit :
> On Sun, Jan 01, 2023 at 10:35:59AM +0100, Christophe JAILLET wrote:
>> Le 01/01/2023 à 00:14, Guenter Roeck a écrit :
>>> On Sat, Dec 31, 2022 at 12:07:27PM +0100, Christophe JAILLET wrote:
>>>> The devm_clk_get_enabled() helper:
>>>>      - calls devm_clk_get()
>>>>      - calls clk_prepare_enable() and registers what is needed in order to
>>>>        call clk_disable_unprepare() when needed, as a managed resource.
>>>>
>>>> This simplifies the code and avoids the need of a dedicated function used
>>>> with devm_add_action_or_reset().
>>>>
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
>>>> ---
>>>> Note that I get a compilation error because read_cpuid_id() is not defined
>>>> on my system (x86_64).
>>>> So I think that a "depends on ARM<something>" in missing in a KConfig file.
>>>
>>> It has
>>>
>>> 	depends on ARCH_IXP4XX
>>>
>>> and CONFIG_IXP4XX_WATCHDOG is not set for me after "make allmodconfig".
>>
>> Here is what  do.
>>
>> make allmodconfig
>> make -j8 drivers/watchdog/ixp4xx_wdt.o
>>
>> And I get:
>>    DESCEND objtool
>>    CALL    scripts/checksyscalls.sh
>>    CC      drivers/watchdog/ixp4xx_wdt.o
>> drivers/watchdog/ixp4xx_wdt.c: In function ‘ixp4xx_wdt_probe’:
>> drivers/watchdog/ixp4xx_wdt.c:122:15: error: implicit declaration of
>> function ‘read_cpuid_id’ [-Werror=implicit-function-declaration]
>>    122 |         if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
>>        |               ^~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make[3]: *** [scripts/Makefile.build:252 : drivers/watchdog/ixp4xx_wdt.o]
>> Erreur 1
>> make[2]: *** [scripts/Makefile.build:504 : drivers/watchdog] Erreur 2
>> make[1]: *** [scripts/Makefile.build:504 : drivers] Erreur 2
>> make: *** [Makefile:2011 : .] Erreur 2
>>
>>
>> I do agree with you that:
>>
>>     - Kconfig looks fine
>> config IXP4XX_WATCHDOG
>> 	tristate "IXP4xx Watchdog"
>> 	depends on ARCH_IXP4XX
>>
>>    - Makefile looks fine
>> obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
>>
>>    - .config looks fine
>> IXP4XX_WATCHDOG is NOT defined
>>
>>    - make drivers/watchdog/ looks fine
>> No error and ixp4xx_wdt.o is NOT built.
>>
>>
>> However, in the past (if I recollect correctly :) ), a "make <something_that
>> depends_on_a_config_variable_that_is_not_defined>" returned an error stating
>> that no rule existed to build the specified target.
>>
> 
> This is not correct. It only applies if the target directory Makefile is
> excluded by the make flags, or possibly if the target file is a complex
> one build from various source files.
> 
>> I sometimes needed to tweak the Kconfig files to force some compilation when
>> I didn't have the right tool chain or configuration.
>> It was maybe not the best practice, but it worked most of the time.
>>
>>
>> Now, with the example above, such a compilation attempt is possible. It is
>> maybe normal (because of a change somewhere in the way the kernel is built,
>> because of an updated toolchain on my machine, ...)
>> This is just fine for me, but looked really surprising.
>>
>> That is why I first thought that something was missing in a Kconfig file.
>>
>>
>> So my comments are just a surprise to me to something that seems not to
>> behave the same as before.
>>
> I don't think anything changed. It always worked like that for me.
> I would suggest to go back to an older kernel and try it there.
> You'll see exactly the same error. Maybe you just never encountered
> a file like that.

git reset --hard next-20210111			(randomly chosen date)
make allmodconfig
make clean
make -j7 drivers/watchdog/ixp4xx_wdt.o		(too build most of the needed 
stuff to build a kernel)
touch drivers/watchdog/ixp4xx_wdt.c
make -j7 drivers/watchdog/ixp4xx_wdt.o		(too build this file only)

   DESCEND  objtool
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
make[3]: *** Aucune règle pour fabriquer la cible « 
drivers/watchdog/ixp4xx_wdt.o ». Arrêt.
make[2]: *** [scripts/Makefile.build:471 : __build] Erreur 2
make[1]: *** [scripts/Makefile.build:496 : drivers/watchdog] Erreur 2
make: *** [Makefile:1805 : drivers] Erreur 2


This is what I had in mind.
(Aucune règle pour fabriquer la cible... = no rule to build...)


So something changed somewhere. Maybe in the way Makefile are now 
included or not in the build process, as you suggest above.

> 
> So, in other words, what you should have said is "not compile tested".
> Alternatively, you could install cross compilers and compile test the
> patches with those.
>

No. The patches HAVE been cross compiled after my initial attempt with 
my default x86_64 failing built.


This one was successfully built using:
   make ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- allmodconfig
   make ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- -j7 
drivers/watchdog/ixp4xx_wdt.o


The other one was successfully built using:
   make ARCH=mips CROSS_COMPILE=mips64-linux-gnuabi64- allmodconfig
   Changing CONFIG_MACH_LOONGSON32 to y, instead of 
CONFIG_MIPS_GENERIC_KERNEL
   make ARCH=mips CROSS_COMPILE=mips64-linux-gnuabi64- -j7 
drivers/watchdog/loongson1_wdt.o

I've long been reluctant to use cross-compiler because of low disk space 
on my system. But I've changed my mind recently and now I do cross 
compile. (see [1] if needed as example also with ARCH=arm)


My comments below the --- in the patches should not be taken as "I've 
not managed to build with the patch", but "I've been surprised to get an 
issue with x86_64, then cross-compiled with the relevant toolchain. 
Then, I reported what looked like a potential issue when building with 
x86_64."

CJ

[1]: 
https://lore.kernel.org/all/dc5a2157-19c8-4498-6288-d7513ad3dde2@wanadoo.fr/

> 
> Thanks,
> Guenter
> 

