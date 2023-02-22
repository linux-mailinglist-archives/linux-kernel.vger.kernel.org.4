Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D124369FDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjBVV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjBVV14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:27:56 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4943912;
        Wed, 22 Feb 2023 13:27:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 45480604EF;
        Wed, 22 Feb 2023 22:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1677101261; bh=ahZ1slHOb/8gAMmJ4VVpuoDWePKyQ27d271cNlRW/XA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rR3q6kRXu4lbWTi68IQWyDollQtKdbMdeeU5HqSv7ipSTkomlBcYkwBvZ4JtGVEgo
         8OPAlVgneH2yLely0OHEBpG5KOHarIgOKwdkQt1CuuSjXZOousdUhYM4Ar6ajUivCt
         PD54iM1+OUxRjJ+J3FVxpkdaz03r0f0iTDDgwP8a9gKfYgp8GsRGBkVJoTxWGffrpN
         qHzt9yLzSe+WkKaiofshGlnO8fBl1CKO7ZvTm4IVamo3dmm4ZsmtYyAJFmdI3PRVzC
         1bwHspgQVNW84jB+zBaO/7gKFwR+5WVpTDqW12iTmyVz3mQSGvX7YXJIBJqRp8xoNI
         /M/80mXM+f4GQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DJHbE3B-zNsc; Wed, 22 Feb 2023 22:27:38 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id D39C1604F0;
        Wed, 22 Feb 2023 22:27:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1677101258; bh=ahZ1slHOb/8gAMmJ4VVpuoDWePKyQ27d271cNlRW/XA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T/9PiI4wNdLB4Es+Vd8VEmCsDEDux5LOJLzXk8j6ZCnwIxQK/6RZqjy2cFcQkuZ1S
         rARoSCrc6Xq4wS2VYKDOn1vRKEb+IyWAREfRtHWzNiYJ0UebQNW94jZAz3xE70aTud
         0395VMwRbBhs7TyK2hNsAuQnkbHgdPPq7yxw8VezExgaotrL1TEz6DBwoNKRVTTJSh
         GunINUA7+Ge80BmsQ7vfjfxazO3g+WRmjORBi6zRKaSH6QURW49vHWkMg6LXANGryq
         p0Faalg6d0gntoqdKOwXDPLTq3YIqr1WvSPChNgqPhYk2zGXq/SnDwDPmSyML8lIhd
         9CsOaOx2TvLJg==
Message-ID: <c86237a2-dc7b-f2db-cfec-c5a345141237@alu.unizg.hr>
Date:   Wed, 22 Feb 2023 22:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
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
 <CAMRc=MeFGMtjoq4fwfJ17pBPAstOAjBi3fcQQrjJJnawzx7W5A@mail.gmail.com>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAMRc=MeFGMtjoq4fwfJ17pBPAstOAjBi3fcQQrjJJnawzx7W5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 2023. 11:53, Bartosz Golaszewski wrote:
> On Tue, Feb 21, 2023 at 4:41 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>>
>> On Tue, Feb 21, 2023 at 02:52:38PM +0100, Mirsad Goran Todorovac wrote:
>>> On 20. 02. 2023. 14:43, Andy Shevchenko wrote:
>>>> On Mon, Feb 20, 2023 at 02:10:00PM +0100, Mirsad Todorovac wrote:
>>>>> On 2/16/23 15:16, Bartosz Golaszewski wrote:
>>
>> ...
>>
>>>>> As Mr. McKenney once said, a bunch of monkeys with keyboard could
>>>>> have done it in a considerable number of trials and errors ;-)
>>>>>
>>>>> But here I have something that could potentially leak as well. I could not devise a
>>>>> reproducer due to the leak being lightly triggered only in extreme memory contention.
>>>>>
>>>>> See it for yourself:
>>>>>
>>>>> drivers/gpio/gpio-sim.c:
>>>>>  301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>>>>>  302 {
>>>>>  303         struct device_attribute *val_dev_attr, *pull_dev_attr;
>>>>>  304         struct gpio_sim_attribute *val_attr, *pull_attr;
>>>>>  305         unsigned int num_lines = chip->gc.ngpio;
>>>>>  306         struct device *dev = chip->gc.parent;
>>>>>  307         struct attribute_group *attr_group;
>>>>>  308         struct attribute **attrs;
>>>>>  309         int i, ret;
>>>>>  310
>>>>>  311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
>>>>>  312                                          num_lines + 1, GFP_KERNEL);
>>>>>  313         if (!chip->attr_groups)
>>>>>  314                 return -ENOMEM;
>>>>>  315
>>>>>  316         for (i = 0; i < num_lines; i++) {
>>>>>  317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
>>>>>  318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
>>>>>  319                                      GFP_KERNEL);
>>>>>  320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
>>>>>  321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
>>>>>  322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
>>>>>  323                         return -ENOMEM;
>>>>>  324
>>>>>  325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
>>>>>  326                                                   "sim_gpio%u", i);
>>>>>  327                 if (!attr_group->name)
>>>>>  328                         return -ENOMEM;
>>>>>
>>>>> Apparently, if the memory allocation only partially succeeds, in the theoretical case
>>>>> that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
>>>>> free the partially succeeded allocs, would it?
>>>>>
>>>>> To explain it better, I tried a version that is not yet full doing "all or nothing"
>>>>> memory allocation for the gpio-sim driver, because I am not that familiar with the
>>>>> driver internals.
>>>>
>>>> devm_*() mean that the resource allocation is made in a managed manner, so when
>>>> it's done, it will be freed automatically.
>>>
>>> Didn't see that one coming ... :-/ "buzzing though the bush ..."
>>>
>>>> The question is: is the lifetime of the attr_groups should be lesser or the
>>>> same as chip->gc.parent? Maybe it's incorrect to call devm_*() in the first place?
>>>
>>> Bona fide said, I hope that automatic deallocation does things in the right order.
>>> I've realised that devm_kzalloc() calls devm_kmalloc() that registers allocations on
>>> a per driver list. But I am not sure how chip->gc was allocated?
>>>
>>> Here is said it is allocated in drivers/gpio/gpio-sim.c:386 in gpio_sim_add_bank(),
>>> as a part of
>>>
>>>       struct gpio_sim_chip *chip;
>>>       struct gpio_chip *gc;
>>>
>>>       gc = &chip->gc;
>>>
>>> and gc->parent is set to
>>>
>>>       gc->parent = dev;
>>>
>>> in line 420, which appears called before gpio_sim_setup_sysfs() and the lines above.
>>>
>>> If I understood well, automatic deallocation on unloading the driver goes
>>> in the reverse order, so lifetime of chip appears to be longer than attr_groups,
>>> but I am really not that good at this ...
>>
>> So, the device is instantiated by platform_device_register_full().
>>
>> It should gone with the platform_device_unregister().
>>
>> In case of CONFIG_DEBUG_KOBJECT_RELEASE=y the ->release() can be called
>> asynchronously.
>>
>> So, there are following questions:
>> - is the put_device() is actually called?
>> - is the above mentioned option is set to Y?
>> - if it's in Y, does kmemleak take it into account?
>> - if no, do you get anything new in `dmesg` when enable it?
>>
>>>> Or maybe the chip->gc.parent should be changed to something else (actual GPIO
>>>> device, but then it's unclear how to provide the attributes in non-racy way
>>> Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
>>>
>>> I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
>>> device expert nor would be appropriate to try the craft not earned ;-)
>>
>> --
>> With Best Regards,
>> Andy Shevchenko

> Mirsad,
> 
> I think you fear that the memory allocated for sysfs attributes could
> be accessed after the driver is detached from the simulated GPIO
> device? This is not possible as sysfs handles that gracefully (by
> removing all sysfs attributes with driver_sysfs_remove()) before
> freeing devres resources. You can test that yourself by instantiating
> a gpio-sim device, opening and holding a file descriptor to one of the
> sysfs attributes, disabling the device and then trying to read from
> said fd - it will return -ENODEV.
> 
> Let me know if you actually mean something else?

Hi Bartosz,

I have to repeat that I am not an expert in the Linux kernel
drivers, but have only found the leak using the DEBUG_KMEMLEAK
kernel tweak.

After (in gpio/gpio-sim.sh):

SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
echo "4.1b Disabling gpio-sim device $DEVNAME $CHIPNAME $SYSFS_PATH"
tail -f "$SYSFS_PATH" &
sleep 3
echo 0 > /sys/kernel/config/gpio-sim/chip/live

I get "No such file or directory" when trying to read from sysfs parameters:

Failed to open /dev/none: No such file or directory

Actually, this apparently comes from the tail command unexpectedly using
inotify()
to monitor changes on the .../sim_gpio0/value, and reopening the file.

This sounds like a good idea for a gpio-sim test, as it might be impractical
to change the gpio-sim.sh source for a newbie kernel tester and they may obviously
lack your insight.

However, at my level I am content that the leak is patched at its core
source. It is human to make such omission, and may I remind you that one time
a satellite was lost due to an error traced down to a single wrong character
or digit.

Finding a bug only reminds me of my own bugs in much less complicated
situations with fewer gotchas ... I wonder if such cases could be discovered
by static analysis, but from the given loop, I simply do not see how a robot
could have guessed the intent of the test ...

Let's stay positive, a leak is fixed, and this was a great experience with
a great team.

Further hardening of the driver might be a good thing, but I suppose the way is
in what Andy proposed, but I am still doing a homework on that one.

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

