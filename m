Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2405069E1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjBUNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjBUNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:52:47 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA8025E3D;
        Tue, 21 Feb 2023 05:52:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id DB15A604ED;
        Tue, 21 Feb 2023 14:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676987561; bh=DU0Q/m3FTCWzaxKV8pFjKM5tQt37HfAjM4pJvKiUo2k=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=EC3RxDM+mEmohfJ3Etxcjpjlx4ADud/v5jGISZn7iTsfsFpnFGFv3ifpvC5A7YUay
         Mj6zZgx9f2KaDEpOP3Tdw0xrJO3airlZ1JKtVOPAs+l8ZdoRppcm1wWWWLSspkOYQu
         WqeZ+uPWh1k2nyTMjCKBRcskjscUqRBvAuWafunigJcg9AYliez0IUy1pBywSQ7zUV
         p/A2ixwix3qj+EYzHq6rmWOXRYEU9yBR1PyhfShYdRKBQb85Y5NhAKkmwRm+au9H/P
         blNEAMB8ytVM9G4khUt3OXkvZZkJP9nxPE/yJsO7hirm0lJB8hSxVfnMuRqnG1W7yp
         Xh4BzPfoJW/KQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iWpdHBbm2MPb; Tue, 21 Feb 2023 14:52:39 +0100 (CET)
Received: from [10.0.1.16] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 0A4C2604EA;
        Tue, 21 Feb 2023 14:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676987559; bh=DU0Q/m3FTCWzaxKV8pFjKM5tQt37HfAjM4pJvKiUo2k=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=qrPLaMlPV3GpgOgA783VpPDQ2yNPIBYzmLk83rabjzF5DKa/lS6cn9L0h24JxXqXf
         N0Tta/l5l90QTBd41BDmRVRW9ubQjewhYHEYOEYKBqyYOcYtts50dgcupbPX6y/uug
         10i0FsYFj18SjEaz94qBEK3LIjQSAfdm3u0p7Llsb6KmJVGYl+VQO8ItS7A/VjjpUY
         pTyy6p+1ALCjayeZ3evq5BhxrAJWixUmsu90Wc+sq1A0GxtbBBO8vNUHdNOFkED060
         osrixGnRd891FdDaGpad++P4qm/1RAk23LJffGqWf7Q9B77MMfJuyFVsYMU/Tdd4nG
         gWa82RiJEFshg==
Message-ID: <d7762f6f-5b58-cf71-3400-557799de43c0@alu.unizg.hr>
Date:   Tue, 21 Feb 2023 14:52:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
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
Content-Language: en-US, hr
In-Reply-To: <Y/N5Dt6G397rkfBd@smile.fi.intel.com>
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

On 20. 02. 2023. 14:43, Andy Shevchenko wrote:
> On Mon, Feb 20, 2023 at 02:10:00PM +0100, Mirsad Todorovac wrote:
>> On 2/16/23 15:16, Bartosz Golaszewski wrote:
> 
> ...
> 
>> As Mr. McKenney once said, a bunch of monkeys with keyboard could
>> have done it in a considerable number of trials and errors ;-)
>>
>> But here I have something that could potentially leak as well. I could not devise a
>> reproducer due to the leak being lightly triggered only in extreme memory contention.
>>
>> See it for yourself:
>>
>> drivers/gpio/gpio-sim.c:
>>  301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>>  302 {
>>  303         struct device_attribute *val_dev_attr, *pull_dev_attr;
>>  304         struct gpio_sim_attribute *val_attr, *pull_attr;
>>  305         unsigned int num_lines = chip->gc.ngpio;
>>  306         struct device *dev = chip->gc.parent;
>>  307         struct attribute_group *attr_group;
>>  308         struct attribute **attrs;
>>  309         int i, ret;
>>  310
>>  311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
>>  312                                          num_lines + 1, GFP_KERNEL);
>>  313         if (!chip->attr_groups)
>>  314                 return -ENOMEM;
>>  315
>>  316         for (i = 0; i < num_lines; i++) {
>>  317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
>>  318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
>>  319                                      GFP_KERNEL);
>>  320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
>>  321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
>>  322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
>>  323                         return -ENOMEM;
>>  324
>>  325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
>>  326                                                   "sim_gpio%u", i);
>>  327                 if (!attr_group->name)
>>  328                         return -ENOMEM;
>>
>> Apparently, if the memory allocation only partially succeeds, in the theoretical case
>> that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
>> free the partially succeeded allocs, would it?
>>
>> To explain it better, I tried a version that is not yet full doing "all or nothing"
>> memory allocation for the gpio-sim driver, because I am not that familiar with the
>> driver internals.
> 
> devm_*() mean that the resource allocation is made in a managed manner, so when
> it's done, it will be freed automatically.

Didn't see that one coming ... :-/ "buzzing though the bush ..."

> The question is: is the lifetime of the attr_groups should be lesser or the
> same as chip->gc.parent? Maybe it's incorrect to call devm_*() in the first place?

Bona fide said, I hope that automatic deallocation does things in the right order.
I've realised that devm_kzalloc() calls devm_kmalloc() that registers allocations on
a per driver list. But I am not sure how chip->gc was allocated?

Here is said it is allocated in drivers/gpio/gpio-sim.c:386 in gpio_sim_add_bank(),
as a part of

	struct gpio_sim_chip *chip;
	struct gpio_chip *gc;

	gc = &chip->gc;

and gc->parent is set to

	gc->parent = dev;

in line 420, which appears called before gpio_sim_setup_sysfs() and the lines above.

If I understood well, automatic deallocation on unloading the driver goes
in the reverse order, so lifetime of chip appears to be longer than attr_groups,
but I am really not that good at this ...

> Or maybe the chip->gc.parent should be changed to something else (actual GPIO
> device, but then it's unclear how to provide the attributes in non-racy way
Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.

I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
device expert nor would be appropriate to try the craft not earned ;-)

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

