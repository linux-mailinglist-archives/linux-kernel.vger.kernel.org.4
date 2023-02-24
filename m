Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3C6A1E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBXPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjBXPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:14:42 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B963E0AC;
        Fri, 24 Feb 2023 07:14:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7B15E604FC;
        Fri, 24 Feb 2023 16:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1677251558; bh=PixN/IP5wX+lo2rFTBLL6THjWsIy2gpNeb0DU7O+Ufc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BfSRCG1mFDGffK7qed0cQkZvA0vVv3GhON7FzNiTfo0KrTOxUKQGDUzjQaQskkH08
         3oww/LfL5n6oCo05tui7aXkjtC4/FoH9zsv9RXn+bHMncOOKJnffDTHvdk9HTHf3zQ
         bUIo93SpkGw+I70nWRnNOA0DH/WsnCaaR2mmJUnybAQyj4RrRQAGyCqiM/Xuto0ajI
         9scJiljccurQvj4j5vxM5m7BOA3YXgN9AHSCx5MfH7VUEtbcPd75GCih2YsCQl8ZFz
         1ugRgXeCJZpugtN4GsiI7LQQdj7oWA6Hs2DbKRNI0uNWPJCwY6lD+GCNGpwOCozgFh
         5sYX4dQAinI+w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vmZKoOtxAAER; Fri, 24 Feb 2023 16:12:36 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 8CC0A604F9;
        Fri, 24 Feb 2023 16:12:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1677251556; bh=PixN/IP5wX+lo2rFTBLL6THjWsIy2gpNeb0DU7O+Ufc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M6xZ8qFrUg6MP8Hib0iGS4mU9Ra/1EWlPDz93e/9s6INR1EVNlP3sCA7i3uE15NRh
         WPHk8pQIaB+wov3q0mRszn79avLI4amSHVZ2AHan114HKjjmpW6nPuWboqtBFkxuXq
         mO0+nhoSVcbvT/Bet358sGpmauMECbuOY1MzTeJBNTV4byz9uc6zNCpFm7pQsJ+o6G
         JZ2ilRb0S1iQhzE6D+IC2uMcecN8Ki6KqCPJax+gHRe4lOv9blPzI8M0Mm1Qb+0BWo
         nigdYLdfGdVTr2ugWC3KwdL3YdC9uNUkLKAcJq73W/N0mdc2yuGkPblyn91Re/95+2
         d8moreRKuJcUw==
Message-ID: <7856e5a8-d84e-4f41-721b-80b6fc413919@alu.unizg.hr>
Date:   Fri, 24 Feb 2023 16:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
 <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr>
 <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
 <36d8e761-58e2-2515-fd1a-65a11731d1b1@alu.unizg.hr>
 <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
 <3d96e50b-ed17-9bf5-149b-8a50c7b4cca2@alu.unizg.hr>
 <CAMRc=Mcx=Ko5H_c1YGzA5Jfu3KJqx1pfL3RZuMrV6oTObnUrhQ@mail.gmail.com>
 <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr>
 <Y/N5Dt6G397rkfBd@smile.fi.intel.com>
 <d7762f6f-5b58-cf71-3400-557799de43c0@alu.unizg.hr>
 <Y/Tlq9aY3btfoVUN@smile.fi.intel.com>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y/Tlq9aY3btfoVUN@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/23 16:39, Andy Shevchenko wrote:
> On Tue, Feb 21, 2023 at 02:52:38PM +0100, Mirsad Goran Todorovac wrote:
>> On 20. 02. 2023. 14:43, Andy Shevchenko wrote:
>>> On Mon, Feb 20, 2023 at 02:10:00PM +0100, Mirsad Todorovac wrote:
>>>> On 2/16/23 15:16, Bartosz Golaszewski wrote:
> 
> ...
> 
>>>> As Mr. McKenney once said, a bunch of monkeys with keyboard could
>>>> have done it in a considerable number of trials and errors ;-)
>>>>
>>>> But here I have something that could potentially leak as well. I could not devise a
>>>> reproducer due to the leak being lightly triggered only in extreme memory contention.
>>>>
>>>> See it for yourself:
>>>>
>>>> drivers/gpio/gpio-sim.c:
>>>>   301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>>>>   302 {
>>>>   303         struct device_attribute *val_dev_attr, *pull_dev_attr;
>>>>   304         struct gpio_sim_attribute *val_attr, *pull_attr;
>>>>   305         unsigned int num_lines = chip->gc.ngpio;
>>>>   306         struct device *dev = chip->gc.parent;
>>>>   307         struct attribute_group *attr_group;
>>>>   308         struct attribute **attrs;
>>>>   309         int i, ret;
>>>>   310
>>>>   311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
>>>>   312                                          num_lines + 1, GFP_KERNEL);
>>>>   313         if (!chip->attr_groups)
>>>>   314                 return -ENOMEM;
>>>>   315
>>>>   316         for (i = 0; i < num_lines; i++) {
>>>>   317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
>>>>   318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
>>>>   319                                      GFP_KERNEL);
>>>>   320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
>>>>   321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
>>>>   322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
>>>>   323                         return -ENOMEM;
>>>>   324
>>>>   325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
>>>>   326                                                   "sim_gpio%u", i);
>>>>   327                 if (!attr_group->name)
>>>>   328                         return -ENOMEM;
>>>>
>>>> Apparently, if the memory allocation only partially succeeds, in the theoretical case
>>>> that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
>>>> free the partially succeeded allocs, would it?
>>>>
>>>> To explain it better, I tried a version that is not yet full doing "all or nothing"
>>>> memory allocation for the gpio-sim driver, because I am not that familiar with the
>>>> driver internals.
>>>
>>> devm_*() mean that the resource allocation is made in a managed manner, so when
>>> it's done, it will be freed automatically.
>>
>> Didn't see that one coming ... :-/ "buzzing though the bush ..."
>>
>>> The question is: is the lifetime of the attr_groups should be lesser or the
>>> same as chip->gc.parent? Maybe it's incorrect to call devm_*() in the first place?
>>
>> Bona fide said, I hope that automatic deallocation does things in the right order.
>> I've realised that devm_kzalloc() calls devm_kmalloc() that registers allocations on
>> a per driver list. But I am not sure how chip->gc was allocated?
>>
>> Here is said it is allocated in drivers/gpio/gpio-sim.c:386 in gpio_sim_add_bank(),
>> as a part of
>>
>> 	struct gpio_sim_chip *chip;
>> 	struct gpio_chip *gc;
>>
>> 	gc = &chip->gc;
>>
>> and gc->parent is set to
>>
>> 	gc->parent = dev;
>>
>> in line 420, which appears called before gpio_sim_setup_sysfs() and the lines above.
>>
>> If I understood well, automatic deallocation on unloading the driver goes
>> in the reverse order, so lifetime of chip appears to be longer than attr_groups,
>> but I am really not that good at this ...
> 
> So, the device is instantiated by platform_device_register_full().
> 
> It should gone with the platform_device_unregister().
> 
> In case of CONFIG_DEBUG_KOBJECT_RELEASE=y the ->release() can be called
> asynchronously.
> 
> So, there are following questions:
> - is the put_device() is actually called?
> - is the above mentioned option is set to Y?
> - if it's in Y, does kmemleak take it into account?
> - if no, do you get anything new in `dmesg` when enable it?

Hi, Andy,

Having set CONFIG_DEBUG_KOBJECT=y.
CONFIG_DEBUG_KOBJECT_RELEASE=y and CONFIG_DEBUG_OBJECTS_TIMERS=y disappear after "make olddefconfig"

So, I cannot tell about whether release() was called asynchronously, all I get is (after driver unload):

[  810.989742] kobject: 'gpio-sim' (00000000251afa19): kobject_cleanup, parent 00000000447da7a7
[  810.990216] kobject: 'gpio-sim' (00000000251afa19): auto cleanup kobject_del
[  810.990674] kobject: 'gpio-sim' (00000000251afa19): auto cleanup 'remove' event
[  810.991175] kobject: 'gpio-sim' (00000000251afa19): kobject_uevent_env
[  810.991674] kobject: 'gpio-sim' (00000000251afa19): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
[  810.992154] kobject: 'gpio-sim' (00000000251afa19): calling ktype release
[  810.992644] kobject: 'gpio-sim': free name

I am still trying to convince "make olddefconfig" to accept the above values he did not like :-/

Regards,
Mirsad

>>> Or maybe the chip->gc.parent should be changed to something else (actual GPIO
>>> device, but then it's unclear how to provide the attributes in non-racy way
>> Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
>>
>> I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
>> device expert nor would be appropriate to try the craft not earned ;-)
> 

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
