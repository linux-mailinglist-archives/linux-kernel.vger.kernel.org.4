Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14B969E232
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjBUOVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjBUOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:21:09 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91FC2B638;
        Tue, 21 Feb 2023 06:20:46 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 59241604EA;
        Tue, 21 Feb 2023 15:20:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676989245; bh=clxP60L1+OIEoYFohn5RZNOjOraRP9gmFMcOQWqrREI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=DtEKoY703G2bxn/iZ5zA0cMF9DRBrxE8NczSwFe4Eu3fIQyLmHou7iQ/MMBaDKPeI
         wdHJNVW/NsVV5pdavjy2nNQNuQssy8OHaKbdglG4gYwNiv8+KNo6nGRQmoFX+pZ9xX
         d37kNpx2cd0ogX677JZvf5uMA1zPMeEoiCC86sJZ1H7sni6nPo0EulcevNUi5zsiyV
         NyurI/rtEY14J4F7J6gxuM+BnCr6UW3z20mipK4qVQqau4RqS2bTA0J0KxQ1kJecru
         sZf4nHY3Wh5++xkcEmJmNnS+4X20zBWHvozplIF2V4G6Ui6b6CQV822jmqyZw8BHci
         zXBUBo6e+dtaA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d4PeUR4Z1clD; Tue, 21 Feb 2023 15:20:42 +0100 (CET)
Received: from [10.0.1.16] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id D6911604ED;
        Tue, 21 Feb 2023 15:20:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676989242; bh=clxP60L1+OIEoYFohn5RZNOjOraRP9gmFMcOQWqrREI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=f9O9nwoL0KIV99Q+DA9vVawQMv7i8QZR/dYpkmUtiY3XJC+8VizU8c2qdz0gOA+LC
         +U04KBAWz8Pju32OkGQm0ZvZbmXDG46nGDpZJvRbHYOF4dWpIeFWNfmz1MArpEiEoD
         NbSbE4BbnhNV/NfEZxBl/q434LrM0+Nuj7MPn90iyYc2mzWrFm79KhCMxid5Kj01YA
         vfwxRuyKsnlvd/6zAtLEp4FmbkAC/BCvG/20klNL/JXWpz9MdtKOYgEy5zmv1FqhP5
         hTcEojKqN6qVjb15fdHJ0+idOkfi+17KDk2dQSQKS77yP+Olz1p9vGhJ1X583ekUrH
         vcxGqOLn15HqQ==
Message-ID: <1e559ca6-4f77-8b48-e53e-12a8b498920d@alu.unizg.hr>
Date:   Tue, 21 Feb 2023 15:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
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
In-Reply-To: <d7762f6f-5b58-cf71-3400-557799de43c0@alu.unizg.hr>
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

On 21.2.2023. 14:52, Mirsad Goran Todorovac wrote:
> On 20. 02. 2023. 14:43, Andy Shevchenko wrote:
>> On Mon, Feb 20, 2023 at 02:10:00PM +0100, Mirsad Todorovac wrote:
>>> On 2/16/23 15:16, Bartosz Golaszewski wrote:
>>
>> ...
>>
>>> As Mr. McKenney once said, a bunch of monkeys with keyboard could
>>> have done it in a considerable number of trials and errors ;-)
>>>
>>> But here I have something that could potentially leak as well. I could not devise a
>>> reproducer due to the leak being lightly triggered only in extreme memory contention.
>>>
>>> See it for yourself:
>>>
>>> drivers/gpio/gpio-sim.c:
>>>  301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>>>  302 {
>>>  303         struct device_attribute *val_dev_attr, *pull_dev_attr;
>>>  304         struct gpio_sim_attribute *val_attr, *pull_attr;
>>>  305         unsigned int num_lines = chip->gc.ngpio;
>>>  306         struct device *dev = chip->gc.parent;
>>>  307         struct attribute_group *attr_group;
>>>  308         struct attribute **attrs;
>>>  309         int i, ret;
>>>  310
>>>  311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
>>>  312                                          num_lines + 1, GFP_KERNEL);
>>>  313         if (!chip->attr_groups)
>>>  314                 return -ENOMEM;
>>>  315
>>>  316         for (i = 0; i < num_lines; i++) {
>>>  317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
>>>  318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
>>>  319                                      GFP_KERNEL);
>>>  320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
>>>  321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
>>>  322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
>>>  323                         return -ENOMEM;
>>>  324
>>>  325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
>>>  326 "sim_gpio%u", i);
>>>  327                 if (!attr_group->name)
>>>  328                         return -ENOMEM;
>>>
>>> Apparently, if the memory allocation only partially succeeds, in the theoretical case
>>> that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
>>> free the partially succeeded allocs, would it?
>>>
>>> To explain it better, I tried a version that is not yet full doing "all or nothing"
>>> memory allocation for the gpio-sim driver, because I am not that familiar with the
>>> driver internals.
>>
>> devm_*() mean that the resource allocation is made in a managed manner, so when
>> it's done, it will be freed automatically.
>
> Didn't see that one coming ... :-/ "buzzing though the bush ..."
>
>> The question is: is the lifetime of the attr_groups should be lesser or the
>> same as chip->gc.parent? Maybe it's incorrect to call devm_*() in the first place?
>
> Bona fide said, I hope that automatic deallocation does things in the right order.
> I've realised that devm_kzalloc() calls devm_kmalloc() that registers allocations on
> a per driver list. But I am not sure how chip->gc was allocated?
>
> Here is said it is allocated in drivers/gpio/gpio-sim.c:386 in gpio_sim_add_bank(), as a part of
> struct gpio_sim_chip *chip;
>     struct gpio_chip *gc;
>
>     gc = &chip->gc;
>
> and gc->parent is set to
>
>     gc->parent = dev;
>
> in line 420, which appears called before gpio_sim_setup_sysfs() and the lines above.

P.S.

The exact line is:

	chip  =  devm_kzalloc <https://elixir.bootlin.com/linux/latest/C/ident/devm_kzalloc>(dev,  sizeof(*chip),  GFP_KERNEL <https://elixir.bootlin.com/linux/latest/C/ident/GFP_KERNEL>); so I guess it is reasonable to assume that chip will also 
be deallocated after attr_groups. chip->gc.parent appears to be a mere pointer to dev parameter in static  int  gpio_sim_add_bank <https://elixir.bootlin.com/linux/latest/C/ident/gpio_sim_add_bank>(struct  fwnode_handle <https://elixir.bootlin.com/linux/latest/C/ident/fwnode_handle>  *swnode <https://elixir.bootlin.com/linux/latest/C/ident/swnode>,  struct  device <https://elixir.bootlin.com/linux/latest/C/ident/device>  *dev) This is OTOH called from: static  int  gpio_sim_probe <https://elixir.bootlin.com/linux/latest/C/ident/gpio_sim_probe>(struct  platform_device <https://elixir.bootlin.com/linux/latest/C/ident/platform_device>  *pdev)
{
	struct  device <https://elixir.bootlin.com/linux/latest/C/ident/device>  *dev  =  &pdev->dev;
	struct  fwnode_handle <https://elixir.bootlin.com/linux/latest/C/ident/fwnode_handle>  *swnode <https://elixir.bootlin.com/linux/latest/C/ident/swnode>;
	int  ret;

	device_for_each_child_node <https://elixir.bootlin.com/linux/latest/C/ident/device_for_each_child_node>(dev,  swnode <https://elixir.bootlin.com/linux/latest/C/ident/swnode>)  {
		ret  =  gpio_sim_add_bank <https://elixir.bootlin.com/linux/latest/C/ident/gpio_sim_add_bank>(swnode 
<https://elixir.bootlin.com/linux/latest/C/ident/swnode>,  dev); Which means dev passed to chip->gc.parent is initialised with &pdev->dev from pdev parm of gpio_sim_probe(). This is OTOH 
referenced from the very:
static struct platform_driver <https://elixir.bootlin.com/linux/latest/C/ident/platform_driver> gpio_sim_driver 
<https://elixir.bootlin.com/linux/latest/C/ident/gpio_sim_driver> = { .driver = { .name = "gpio-sim", .of_match_table 
<https://elixir.bootlin.com/linux/latest/C/ident/of_match_table> = gpio_sim_of_match 
<https://elixir.bootlin.com/linux/latest/C/ident/gpio_sim_of_match>, }, .probe 
<https://elixir.bootlin.com/linux/latest/C/ident/probe> = gpio_sim_probe 
<https://elixir.bootlin.com/linux/latest/C/ident/gpio_sim_probe>, }; Hope this helps. There's more to this than meets the eye, but 
this is really an idiot's attempt to analyse a Linux kernel driver. :-)

> If I understood well, automatic deallocation on unloading the driver goes
> in the reverse order, so lifetime of chip appears to be longer than attr_groups,
> but I am really not that good at this ...
>
>> Or maybe the chip->gc.parent should be changed to something else (actual GPIO
>> device, but then it's unclear how to provide the attributes in non-racy way
> Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
>
> I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
> device expert nor would be appropriate to try the craft not earned ;-) 

Regards,

Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

