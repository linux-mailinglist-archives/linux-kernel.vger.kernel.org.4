Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EDE6A49E8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjB0SiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0SiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:38:22 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85561B471;
        Mon, 27 Feb 2023 10:38:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7CAB8604F2;
        Mon, 27 Feb 2023 19:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1677523092; bh=PJhKwDdWjFoRN7rFBIZioHeVSP+BHkQSvDNbwORZOWs=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=SpUO6yuwRiSfHeYlchrky1EVuo7dJh7pri9vF73KESJsUCQ0uw4prK7zMEvW03+Qh
         7Cy3iZrthHvmKefMxr4vy4i7rxTXlz6GvEfkxMunI728OGCqOWo54UVKjC4V3g0CxK
         J2rTf/4PJ78cP/I1+KfXRTkFcNEh94km/m5uejukB5B98f3N7moDH5f6/OUOApYT6m
         QU6JmJ/sG67sOgmCpbibe8vhXktC1Prg71zEvbEETazU/N4H68bwA5rTFiUETFhbIH
         wiTmZXM7HP4mMrfnT5uyzg5Jp0bsWAWd2/KOBaxT8ctodL/WCNV2V+fWwx5lMQC6nw
         AQFICU7dLl2bA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2JBeE0bQT2QN; Mon, 27 Feb 2023 19:38:05 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 6DF14604E9;
        Mon, 27 Feb 2023 19:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1677523085; bh=PJhKwDdWjFoRN7rFBIZioHeVSP+BHkQSvDNbwORZOWs=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=kSf2lWzlk7F6kWv7FoJoSvZRHLjP61ZpYY/TYHHPFX6oDZMCiVpFSIqBS1SyPU0o1
         ez//CNGnrEmRw7hF9uyt4r7J+Bf5byudlU3YgyHKfqShJvYYXi03o9ZIDP+XJI6dg+
         zk8XgTlGdh6weI1EAyQGausOvCtmy1vwFbK+G0yB9dA6mRSqlneFTQAxoQvcnIBKnj
         2rSORNOUAx36XQ8paqvPSEnrpALReKYZch2w5bkxMT0htRLLKRgw3ZFnXs1Ssr+2KU
         aY4QDXrjMsG8KGIdgXEIucIbfHuEDnHvIVyqxcbveAmstnsRrYf+JnGcW4+2bXjnae
         mn2++9n14KAvw==
Message-ID: <2373a9ab-1c38-35fd-e961-9a172f8ce622@alu.unizg.hr>
Date:   Mon, 27 Feb 2023 19:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
 <36d8e761-58e2-2515-fd1a-65a11731d1b1@alu.unizg.hr>
 <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
 <3d96e50b-ed17-9bf5-149b-8a50c7b4cca2@alu.unizg.hr>
 <CAMRc=Mcx=Ko5H_c1YGzA5Jfu3KJqx1pfL3RZuMrV6oTObnUrhQ@mail.gmail.com>
 <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr>
 <Y/N5Dt6G397rkfBd@smile.fi.intel.com>
 <d7762f6f-5b58-cf71-3400-557799de43c0@alu.unizg.hr>
 <Y/Tlq9aY3btfoVUN@smile.fi.intel.com>
 <7856e5a8-d84e-4f41-721b-80b6fc413919@alu.unizg.hr>
 <Y/j2ikfd/wvrDdws@smile.fi.intel.com>
Content-Language: en-US, hr
In-Reply-To: <Y/j2ikfd/wvrDdws@smile.fi.intel.com>
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

On 2/24/23 18:40, Andy Shevchenko wrote:
> On Fri, Feb 24, 2023 at 04:12:31PM +0100, Mirsad Todorovac wrote:
>> On 2/21/23 16:39, Andy Shevchenko wrote:
>>> On Tue, Feb 21, 2023 at 02:52:38PM +0100, Mirsad Goran Todorovac wrote:
>>>> On 20. 02. 2023. 14:43, Andy Shevchenko wrote:
>>>>> On Mon, Feb 20, 2023 at 02:10:00PM +0100, Mirsad Todorovac wrote:
>>>>>> On 2/16/23 15:16, Bartosz Golaszewski wrote:
> 
> ...
> 
>>>>>> As Mr. McKenney once said, a bunch of monkeys with keyboard could
>>>>>> have done it in a considerable number of trials and errors ;-)
>>>>>>
>>>>>> But here I have something that could potentially leak as well. I could not devise a
>>>>>> reproducer due to the leak being lightly triggered only in extreme memory contention.
>>>>>>
>>>>>> See it for yourself:
>>>>>>
>>>>>> drivers/gpio/gpio-sim.c:
>>>>>>    301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>>>>>>    302 {
>>>>>>    303         struct device_attribute *val_dev_attr, *pull_dev_attr;
>>>>>>    304         struct gpio_sim_attribute *val_attr, *pull_attr;
>>>>>>    305         unsigned int num_lines = chip->gc.ngpio;
>>>>>>    306         struct device *dev = chip->gc.parent;
>>>>>>    307         struct attribute_group *attr_group;
>>>>>>    308         struct attribute **attrs;
>>>>>>    309         int i, ret;
>>>>>>    310
>>>>>>    311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
>>>>>>    312                                          num_lines + 1, GFP_KERNEL);
>>>>>>    313         if (!chip->attr_groups)
>>>>>>    314                 return -ENOMEM;
>>>>>>    315
>>>>>>    316         for (i = 0; i < num_lines; i++) {
>>>>>>    317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
>>>>>>    318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
>>>>>>    319                                      GFP_KERNEL);
>>>>>>    320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
>>>>>>    321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
>>>>>>    322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
>>>>>>    323                         return -ENOMEM;
>>>>>>    324
>>>>>>    325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
>>>>>>    326                                                   "sim_gpio%u", i);
>>>>>>    327                 if (!attr_group->name)
>>>>>>    328                         return -ENOMEM;
>>>>>>
>>>>>> Apparently, if the memory allocation only partially succeeds, in the theoretical case
>>>>>> that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
>>>>>> free the partially succeeded allocs, would it?
>>>>>>
>>>>>> To explain it better, I tried a version that is not yet full doing "all or nothing"
>>>>>> memory allocation for the gpio-sim driver, because I am not that familiar with the
>>>>>> driver internals.
>>>>>
>>>>> devm_*() mean that the resource allocation is made in a managed manner, so when
>>>>> it's done, it will be freed automatically.
>>>>
>>>> Didn't see that one coming ... :-/ "buzzing though the bush ..."
>>>>
>>>>> The question is: is the lifetime of the attr_groups should be lesser or the
>>>>> same as chip->gc.parent? Maybe it's incorrect to call devm_*() in the first place?
>>>>
>>>> Bona fide said, I hope that automatic deallocation does things in the right order.
>>>> I've realised that devm_kzalloc() calls devm_kmalloc() that registers allocations on
>>>> a per driver list. But I am not sure how chip->gc was allocated?
>>>>
>>>> Here is said it is allocated in drivers/gpio/gpio-sim.c:386 in gpio_sim_add_bank(),
>>>> as a part of
>>>>
>>>> 	struct gpio_sim_chip *chip;
>>>> 	struct gpio_chip *gc;
>>>>
>>>> 	gc = &chip->gc;
>>>>
>>>> and gc->parent is set to
>>>>
>>>> 	gc->parent = dev;
>>>>
>>>> in line 420, which appears called before gpio_sim_setup_sysfs() and the lines above.
>>>>
>>>> If I understood well, automatic deallocation on unloading the driver goes
>>>> in the reverse order, so lifetime of chip appears to be longer than attr_groups,
>>>> but I am really not that good at this ...
>>>
>>> So, the device is instantiated by platform_device_register_full().
>>>
>>> It should gone with the platform_device_unregister().
>>>
>>> In case of CONFIG_DEBUG_KOBJECT_RELEASE=y the ->release() can be called
>>> asynchronously.
>>>
>>> So, there are following questions:
>>> - is the put_device() is actually called?
>>> - is the above mentioned option is set to Y?
>>> - if it's in Y, does kmemleak take it into account?
>>> - if no, do you get anything new in `dmesg` when enable it?
>>
>> Hi, Andy,
>>
>> Having set CONFIG_DEBUG_KOBJECT=y.
>> CONFIG_DEBUG_KOBJECT_RELEASE=y and CONFIG_DEBUG_OBJECTS_TIMERS=y disappear after "make olddefconfig"
>>
>> So, I cannot tell about whether release() was called asynchronously, all I get is (after driver unload):
>>
>> [  810.989742] kobject: 'gpio-sim' (00000000251afa19): kobject_cleanup, parent 00000000447da7a7
>> [  810.990216] kobject: 'gpio-sim' (00000000251afa19): auto cleanup kobject_del
>> [  810.990674] kobject: 'gpio-sim' (00000000251afa19): auto cleanup 'remove' event
>> [  810.991175] kobject: 'gpio-sim' (00000000251afa19): kobject_uevent_env
>> [  810.991674] kobject: 'gpio-sim' (00000000251afa19): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
>> [  810.992154] kobject: 'gpio-sim' (00000000251afa19): calling ktype release
>> [  810.992644] kobject: 'gpio-sim': free name
>>
>> I am still trying to convince "make olddefconfig" to accept the above values he did not like :-/
> 
> Btw, since devm_*() is in use, you may enable trace events (I have added them a
> few releases back) and see how objects allocated with devm are getting
> released.
> 
> Before that there is a possibility to enable debug for devm.
> CONFIG_DEBUG_DEVRES for that (you may see how it's used in the
> drivers/base/devres.c).

The loga are extensive if you are willing to skim over them, but I believe the interesting
part is this:

[ 4830.764748] kobject: 'gpio-sim' (000000005b8d0726): kobject_release, parent 000000007425b13f (delayed 750)
[ 4833.908238] kobject: 'gpio-sim' (000000005b8d0726): kobject_cleanup, parent 000000007425b13f
[ 4833.908244] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup kobject_del
[ 4833.908245] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup 'remove' event
[ 4833.908247] kobject: 'gpio-sim' (000000005b8d0726): kobject_uevent_env
[ 4833.908273] kobject: 'gpio-sim' (000000005b8d0726): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
[ 4833.908311] kobject: 'gpio-sim' (000000005b8d0726): calling ktype release
[ 4833.908315] kobject: 'gpio-sim': free name
[ 4834.932303] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_release, parent 0000000093357d30 (delayed 250)
[ 4835.952388] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_cleanup, parent 0000000093357d30
[ 4835.952413] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup kobject_del
[ 4835.952415] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup 'remove' event
[ 4835.952416] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_uevent_env
[ 4835.952424] kobject: 'gpio_sim' (0000000096ea0bb1): fill_kobj_path: path = '/module/gpio_sim'
[ 4835.952445] kobject: 'gpio_sim' (0000000096ea0bb1): calling ktype release
[ 4835.952448] kobject: 'gpio_sim': free name

Or, with CONFIG_DEBUG_DEVRES=y, it looks like this:

[  180.472131] kobject: 'gpio-sim' (00000000e72df678): kobject_release, parent 0000000053a50b05 (delayed 250)
[  180.472270] kobject: 'drivers' (00000000a3c60031): kobject_release, parent 00000000363d6076 (delayed 250)
[  180.472274] kobject: 'holders' (000000006bd5c478): kobject_release, parent 00000000363d6076 (delayed 250)
[  180.472281] kobject: 'notes' (00000000c85ae91b): kobject_release, parent 00000000363d6076 (delayed 1000)
[  181.495687] kobject: 'holders' (000000006bd5c478): kobject_cleanup, parent 00000000363d6076
[  181.495693] kobject: 'holders' (000000006bd5c478): auto cleanup kobject_del
[  181.495696] kobject: 'holders' (000000006bd5c478): calling ktype release
[  181.495697] kobject: (000000006bd5c478): dynamic_kobj_release
[  181.495703] kobject: 'holders': free name
[  181.495717] kobject: 'drivers' (00000000a3c60031): kobject_cleanup, parent 00000000363d6076
[  181.495719] kobject: 'drivers' (00000000a3c60031): auto cleanup kobject_del
[  181.495723] kobject: 'drivers' (00000000a3c60031): calling ktype release
[  181.495724] kobject: (00000000a3c60031): dynamic_kobj_release
[  181.495727] kobject: 'drivers': free name
[  181.495728] kobject: 'gpio-sim' (00000000e72df678): kobject_cleanup, parent 0000000053a50b05
[  181.495730] kobject: 'gpio-sim' (00000000e72df678): auto cleanup kobject_del
[  181.495731] kobject: 'gpio-sim' (00000000e72df678): auto cleanup 'remove' event
[  181.495733] kobject: 'gpio-sim' (00000000e72df678): kobject_uevent_env
[  181.495742] kobject: 'gpio-sim' (00000000e72df678): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
[  181.495764] kobject: 'gpio-sim' (00000000e72df678): calling ktype release
[  181.495768] kobject: 'gpio-sim': free name
[  184.663810] kobject: 'notes' (00000000c85ae91b): kobject_cleanup, parent 00000000363d6076
[  184.663816] kobject: 'notes' (00000000c85ae91b): auto cleanup kobject_del
[  184.663824] kobject: 'notes' (00000000c85ae91b): calling ktype release
[  184.663838] kobject: (00000000c85ae91b): dynamic_kobj_release
[  184.663841] kobject: 'notes': free name
[  184.663843] kobject: 'gpio_sim' (00000000363d6076): kobject_release, parent 00000000dfc73d50 (delayed 500)
[  186.679811] kobject: 'gpio_sim' (00000000363d6076): kobject_cleanup, parent 00000000dfc73d50
[  186.679817] kobject: 'gpio_sim' (00000000363d6076): auto cleanup kobject_del
[  186.679819] kobject: 'gpio_sim' (00000000363d6076): auto cleanup 'remove' event
[  186.679820] kobject: 'gpio_sim' (00000000363d6076): kobject_uevent_env
[  186.679832] kobject: 'gpio_sim' (00000000363d6076): fill_kobj_path: path = '/module/gpio_sim'
[  186.679855] kobject: 'gpio_sim' (00000000363d6076): calling ktype release
[  186.679859] kobject: 'gpio_sim': free name

Here are the /var/log/messages and `dmesg | grep gpio` output:

Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (0000000065b01c31): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip512' (000000008b9638a5): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000e7ddc5ce): kobject_release, parent 000000007063b679 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000ca4e28ab): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (0000000052bfa782): kobject_release, parent 0000000017e526f4 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (000000007e927b76): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip513' (00000000307a0461): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (000000007025cedf): kobject_release, parent 00000000c6873be9 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (000000007cf5eda9): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (000000002030b0fc): kobject_release, parent 00000000cd2bbef4 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (000000008afdcce8): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip514' (000000008e860d8b): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000dc5ac60d): kobject_release, parent 0000000034808fa5 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000401b009a): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000b0dfd44e): kobject_release, parent 000000001a955210 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (00000000a1399cd0): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip515' (000000002b851bb5): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000276535c4): kobject_release, parent 00000000f89849bd (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000b204b566): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000581391d9): kobject_release, parent 000000002a3e415e (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (00000000babdf5db): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip531' (00000000ad4538e8): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (0000000045377336): kobject_release, parent 00000000e06680f5 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000b9ef5a28): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000554e0e6d): kobject_release, parent 000000003fe8f71b (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (000000008b98f863): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip532' (00000000ac07803f): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (0000000007a45939): kobject_release, parent 000000004ef2dca6 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (0000000034300a6b): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (0000000089fb2874): kobject_release, parent 00000000f81b3244 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (00000000dedc22f2): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip533' (000000003541481f): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (000000002d7008b9): kobject_release, parent 00000000a22546a6 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000cdc367f1): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000bbace83b): kobject_release, parent 0000000050fa69b3 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (00000000e467cb12): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip549' (0000000014379c6d): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000186d3bd6): kobject_release, parent 000000006b8d9c99 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000bb358104): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000ab70f947): kobject_release, parent 000000000876b849 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (0000000016f05b5a): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip551' (00000000a55e630b): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000948e7c59): kobject_release, parent 00000000cb0b3463 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000461517ae): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000b41576d9): kobject_release, parent 0000000060e34f22 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (00000000176df109): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip552' (000000001750e50f): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (000000008026d597): kobject_release, parent 00000000bdaa0a47 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.1' (0000000018f833bf): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (000000005a55ef16): kobject_release, parent 000000008dc012bc (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (00000000886e1a77): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip553' (0000000010cfe833): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000d8b3d64b): kobject_release, parent 00000000e3becc55 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.2' (00000000bbfd5238): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (000000002e06f814): kobject_release, parent 00000000a555c1b2 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (000000002835f4a4): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip554' (00000000e0038afb): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (000000004e7dad05): kobject_release, parent 00000000b39a3c5f (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000e8c2899c): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000bfef6047): kobject_release, parent 00000000b8559267 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (00000000d962e90a): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip555' (00000000f5bbd198): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000af8b42a8): kobject_release, parent 0000000051b24fd2 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (000000008ef7f514): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (0000000041578d2d): kobject_release, parent 00000000b738a3e4 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: gpio-sim: probe of gpio-sim.0 failed with error -34
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (000000005418b2af): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (000000001f644365): kobject_release, parent 00000000515b4b1b (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: gpio-560 (?): hogged as input
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (000000006cce49d7): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip556' (00000000d2b04f32): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000843ea14e): kobject_release, parent 00000000dc27f1aa (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000cd797c7b): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (0000000030fbb9d7): kobject_release, parent 000000001576402e (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (000000007164bff6): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip564' (00000000ee87da7b): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (000000009eaeda39): kobject_release, parent 0000000092a079b6 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (000000006053a4bf): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (0000000032fe601a): kobject_release, parent 0000000063e66fd0 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (0000000012ac3b4a): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip572' (00000000178509ff): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (0000000018c19582): kobject_release, parent 00000000b0535d8d (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000c56fc456): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (0000000095747aa3): kobject_release, parent 00000000c314f13a (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (000000000333f422): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip580' (00000000f6371a1e): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (000000006dc3da55): kobject_release, parent 000000002be607c1 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (000000000471ebbe): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (000000008cc134db): kobject_release, parent 000000008af54826 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (0000000005a238f5): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip588' (0000000075b76b85): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (000000003f03127c): kobject_release, parent 000000006ee06561 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (0000000048f1330d): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (0000000023dec04e): kobject_release, parent 000000005fd3b6d2 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (0000000064e73453): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip589' (000000007e1cf13a): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000cdec14e3): kobject_release, parent 00000000a8ca1f8c (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000f462f78a): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000b5aa4b07): kobject_release, parent 00000000ea466ae7 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio' (000000001bd064f6): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpiochip597' (00000000a32f70da): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: '(null)' (00000000aab83a1c): kobject_release, parent 000000008385ae47 (delayed 1000)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'gpio-sim.0' (00000000b1d6276b): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:32 pc-mtodorov kernel: kobject: 'node0' (00000000c6c3323c): kobject_release, parent 00000000c2405972 (delayed 250)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node2' (0000000017e526f4): kobject_release, parent 00000000d00083c8 (delayed 500)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node3' (00000000cd2bbef4): kobject_release, parent 00000000d00083c8 (delayed 250)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'gpiochip3' (00000000f89849bd): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node8' (0000000050fa69b3): kobject_release, parent 00000000d00083c8 (delayed 250)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'gpiochip11' (00000000b39a3c5f): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'gpiochip12' (0000000051b24fd2): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node15' (00000000515b4b1b): kobject_release, parent 00000000d00083c8 (delayed 750)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node17' (0000000063e66fd0): kobject_release, parent 00000000d00083c8 (delayed 500)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node20' (000000005fd3b6d2): kobject_release, parent 00000000d00083c8 (delayed 1000)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node19' (000000008af54826): kobject_release, parent 00000000d00083c8 (delayed 750)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node21' (00000000ea466ae7): kobject_release, parent 00000000d00083c8 (delayed 500)
Feb 27 19:00:33 pc-mtodorov kernel: kobject: 'node22' (00000000c2405972): kobject_release, parent 00000000d00083c8 (delayed 750)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'gpiochip2' (0000000034808fa5): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'gpiochip4' (00000000e06680f5): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'node7' (00000000f81b3244): kobject_release, parent 00000000d00083c8 (delayed 500)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'gpiochip5' (000000004ef2dca6): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'gpiochip7' (000000006b8d9c99): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'gpiochip9' (00000000bdaa0a47): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'node10' (0000000060e34f22): kobject_release, parent 00000000d00083c8 (delayed 250)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'gpiochip8' (00000000cb0b3463): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'node13' (00000000b8559267): kobject_release, parent 00000000d00083c8 (delayed 1000)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'gpiochip14' (0000000092a079b6): kobject_release, parent 0000000000000000 (delayed 1000)
Feb 27 19:00:34 pc-mtodorov kernel: kobject: 'gpiochip15' (00000000b0535d8d): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'gpiochip1' (00000000c6873be9): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'node4' (000000001a955210): kobject_release, parent 00000000d00083c8 (delayed 250)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'node12' (00000000a555c1b2): kobject_release, parent 00000000d00083c8 (delayed 1000)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'node6' (000000003fe8f71b): kobject_release, parent 00000000d00083c8 (delayed 750)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'node9' (000000000876b849): kobject_release, parent 00000000d00083c8 (delayed 750)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'gpiochip17' (000000006ee06561): kobject_release, parent 0000000000000000 (delayed 750)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'node16' (000000001576402e): kobject_release, parent 00000000d00083c8 (delayed 1000)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'gpiochip13' (00000000dc27f1aa): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:35 pc-mtodorov kernel: kobject: 'node14' (00000000b738a3e4): kobject_release, parent 00000000d00083c8 (delayed 1000)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'gpiochip0' (000000007063b679): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'node5' (000000002a3e415e): kobject_release, parent 00000000d00083c8 (delayed 1000)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'gpiochip10' (00000000e3becc55): kobject_release, parent 0000000000000000 (delayed 500)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'node11' (000000008dc012bc): kobject_release, parent 00000000d00083c8 (delayed 500)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'gpiochip6' (00000000a22546a6): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'node18' (00000000c314f13a): kobject_release, parent 00000000d00083c8 (delayed 250)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'gpiochip16' (000000002be607c1): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'gpiochip18' (00000000a8ca1f8c): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:36 pc-mtodorov kernel: kobject: 'gpiochip19' (000000008385ae47): kobject_release, parent 0000000000000000 (delayed 250)
Feb 27 19:00:43 pc-mtodorov kernel: kobject: 'gpio-sim' (000000005b8d0726): kobject_release, parent 000000007425b13f (delayed 750)
Feb 27 19:00:43 pc-mtodorov kernel: kobject: 'drivers' (00000000bca28211): kobject_release, parent 0000000096ea0bb1 (delayed 500)
Feb 27 19:00:43 pc-mtodorov kernel: kobject: 'holders' (00000000ef926144): kobject_release, parent 0000000096ea0bb1 (delayed 1000)
Feb 27 19:00:43 pc-mtodorov kernel: kobject: 'notes' (000000000c2f27e4): kobject_release, parent 0000000096ea0bb1 (delayed 500)
Feb 27 19:00:47 pc-mtodorov kernel: kobject: 'gpio_sim' (0000000096ea0bb1): kobject_release, parent 0000000093357d30 (delayed 250)

dmesg is more extensive on the events:

[ 4819.240904] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_add_internal: parent: 'module', set: 'module'
[ 4819.240925] kobject: 'holders' (00000000ef926144): kobject_add_internal: parent: 'gpio_sim', set: '<NULL>'
[ 4819.241067] kobject: 'notes' (000000000c2f27e4): kobject_add_internal: parent: 'gpio_sim', set: '<NULL>'
[ 4819.241106] kobject: 'gpio-sim' (000000005b8d0726): kobject_add_internal: parent: 'drivers', set: 'drivers'
[ 4819.241134] kobject: 'drivers' (00000000bca28211): kobject_add_internal: parent: 'gpio_sim', set: '<NULL>'
[ 4819.241148] kobject: 'gpio-sim' (000000005b8d0726): kobject_uevent_env
[ 4819.241155] kobject: 'gpio-sim' (000000005b8d0726): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
[ 4819.241210] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_uevent_env
[ 4819.241215] kobject: 'gpio_sim' (0000000096ea0bb1): fill_kobj_path: path = '/module/gpio_sim'
[ 4819.257117] kobject: 'gpio-sim.0' (00000000ca4e28ab): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.257172] kobject: 'gpio-sim.0' (00000000ca4e28ab): kobject_uevent_env
[ 4819.257177] kobject: 'gpio-sim.0' (00000000ca4e28ab): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.257297] kobject: 'gpiochip0' (000000007063b679): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.257484] kobject: 'gpiochip0' (000000007063b679): kobject_uevent_env
[ 4819.257495] kobject: 'gpiochip0' (000000007063b679): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip0'
[ 4819.257533] kobject: 'gpiochip0' (000000007063b679): kobject_uevent_env
[ 4819.257545] kobject: 'gpiochip0' (000000007063b679): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip0'
[ 4819.257571] kobject: 'gpio' (0000000065b01c31): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.257577] kobject: 'gpiochip512' (000000008b9638a5): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.257629] kobject: 'gpiochip512' (000000008b9638a5): kobject_uevent_env
[ 4819.257634] kobject: 'gpiochip512' (000000008b9638a5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip512'
[ 4819.257687] kobject: 'gpio-sim.0' (00000000ca4e28ab): kobject_uevent_env
[ 4819.257693] kobject: 'gpio-sim.0' (00000000ca4e28ab): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.275191] kobject: 'gpiochip512' (000000008b9638a5): kobject_uevent_env
[ 4819.275202] kobject: 'gpiochip512' (000000008b9638a5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip512'
[ 4819.275224] kobject: 'gpio' (0000000065b01c31): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.275227] kobject: 'gpiochip512' (000000008b9638a5): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.275329] kobject: 'gpiochip0' (000000007063b679): kobject_uevent_env
[ 4819.275337] kobject: 'gpiochip0' (000000007063b679): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip0'
[ 4819.275358] kobject: 'gpiochip0' (000000007063b679): kobject_uevent_env
[ 4819.275363] kobject: 'gpiochip0' (000000007063b679): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip0'
[ 4819.275406] kobject: 'gpio-sim.0' (00000000ca4e28ab): kobject_uevent_env
[ 4819.275415] kobject: 'gpio-sim.0' (00000000ca4e28ab): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.275432] kobject: 'gpio-sim.0' (00000000ca4e28ab): kobject_uevent_env
[ 4819.275437] kobject: 'gpio-sim.0' (00000000ca4e28ab): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.275447] kobject: 'gpio-sim.0' (00000000ca4e28ab): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.303376] kobject: 'gpio-sim.0' (000000007cf5eda9): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.303430] kobject: 'gpio-sim.0' (000000007cf5eda9): kobject_uevent_env
[ 4819.303435] kobject: 'gpio-sim.0' (000000007cf5eda9): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.303541] kobject: 'gpiochip1' (00000000c6873be9): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.303679] kobject: 'gpiochip1' (00000000c6873be9): kobject_uevent_env
[ 4819.303689] kobject: 'gpiochip1' (00000000c6873be9): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip1'
[ 4819.303724] kobject: 'gpiochip1' (00000000c6873be9): kobject_uevent_env
[ 4819.303729] kobject: 'gpiochip1' (00000000c6873be9): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip1'
[ 4819.303752] kobject: 'gpio' (000000007e927b76): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.303756] kobject: 'gpiochip513' (00000000307a0461): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.303800] kobject: 'gpiochip513' (00000000307a0461): kobject_uevent_env
[ 4819.303805] kobject: 'gpiochip513' (00000000307a0461): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip513'
[ 4819.303852] kobject: 'gpio-sim.0' (000000007cf5eda9): kobject_uevent_env
[ 4819.303858] kobject: 'gpio-sim.0' (000000007cf5eda9): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.321116] kobject: 'gpiochip513' (00000000307a0461): kobject_uevent_env
[ 4819.321128] kobject: 'gpiochip513' (00000000307a0461): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip513'
[ 4819.321155] kobject: 'gpio' (000000007e927b76): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.321160] kobject: 'gpiochip513' (00000000307a0461): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.321268] kobject: 'gpiochip1' (00000000c6873be9): kobject_uevent_env
[ 4819.321278] kobject: 'gpiochip1' (00000000c6873be9): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip1'
[ 4819.321299] kobject: 'gpiochip1' (00000000c6873be9): kobject_uevent_env
[ 4819.321304] kobject: 'gpiochip1' (00000000c6873be9): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip1'
[ 4819.321335] kobject: 'gpio-sim.0' (000000007cf5eda9): kobject_uevent_env
[ 4819.321343] kobject: 'gpio-sim.0' (000000007cf5eda9): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.321362] kobject: 'gpio-sim.0' (000000007cf5eda9): kobject_uevent_env
[ 4819.321368] kobject: 'gpio-sim.0' (000000007cf5eda9): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.321378] kobject: 'gpio-sim.0' (000000007cf5eda9): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.327855] kobject: 'gpio-sim.0' (00000000401b009a): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.327906] kobject: 'gpio-sim.0' (00000000401b009a): kobject_uevent_env
[ 4819.327911] kobject: 'gpio-sim.0' (00000000401b009a): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.328025] kobject: 'gpiochip2' (0000000034808fa5): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.328130] kobject: 'gpiochip2' (0000000034808fa5): kobject_uevent_env
[ 4819.328137] kobject: 'gpiochip2' (0000000034808fa5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip2'
[ 4819.328221] kobject: 'gpiochip2' (0000000034808fa5): kobject_uevent_env
[ 4819.328228] kobject: 'gpiochip2' (0000000034808fa5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip2'
[ 4819.328250] kobject: 'gpio' (000000008afdcce8): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.328255] kobject: 'gpiochip514' (000000008e860d8b): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.328303] kobject: 'gpiochip514' (000000008e860d8b): kobject_uevent_env
[ 4819.328309] kobject: 'gpiochip514' (000000008e860d8b): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip514'
[ 4819.328354] kobject: 'gpio-sim.0' (00000000401b009a): kobject_uevent_env
[ 4819.328360] kobject: 'gpio-sim.0' (00000000401b009a): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.347557] kobject: 'gpiochip514' (000000008e860d8b): kobject_uevent_env
[ 4819.347567] kobject: 'gpiochip514' (000000008e860d8b): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip514'
[ 4819.347589] kobject: 'gpio' (000000008afdcce8): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.347593] kobject: 'gpiochip514' (000000008e860d8b): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.347703] kobject: 'gpiochip2' (0000000034808fa5): kobject_uevent_env
[ 4819.347711] kobject: 'gpiochip2' (0000000034808fa5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip2'
[ 4819.347731] kobject: 'gpiochip2' (0000000034808fa5): kobject_uevent_env
[ 4819.347736] kobject: 'gpiochip2' (0000000034808fa5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip2'
[ 4819.347774] kobject: 'gpio-sim.0' (00000000401b009a): kobject_uevent_env
[ 4819.347782] kobject: 'gpio-sim.0' (00000000401b009a): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.347800] kobject: 'gpio-sim.0' (00000000401b009a): kobject_uevent_env
[ 4819.347806] kobject: 'gpio-sim.0' (00000000401b009a): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.347816] kobject: 'gpio-sim.0' (00000000401b009a): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.355214] kobject: 'gpio-sim.0' (00000000b204b566): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.355265] kobject: 'gpio-sim.0' (00000000b204b566): kobject_uevent_env
[ 4819.355270] kobject: 'gpio-sim.0' (00000000b204b566): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.355364] kobject: 'gpiochip3' (00000000f89849bd): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.355495] kobject: 'gpiochip3' (00000000f89849bd): kobject_uevent_env
[ 4819.355505] kobject: 'gpiochip3' (00000000f89849bd): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip3'
[ 4819.355537] kobject: 'gpiochip3' (00000000f89849bd): kobject_uevent_env
[ 4819.355543] kobject: 'gpiochip3' (00000000f89849bd): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip3'
[ 4819.355564] kobject: 'gpio' (00000000a1399cd0): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.355568] kobject: 'gpiochip515' (000000002b851bb5): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.355608] kobject: 'gpiochip515' (000000002b851bb5): kobject_uevent_env
[ 4819.355614] kobject: 'gpiochip515' (000000002b851bb5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip515'
[ 4819.355954] kobject: 'gpio-sim.0' (00000000b204b566): kobject_uevent_env
[ 4819.355961] kobject: 'gpio-sim.0' (00000000b204b566): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.375898] kobject: 'gpiochip515' (000000002b851bb5): kobject_uevent_env
[ 4819.375908] kobject: 'gpiochip515' (000000002b851bb5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip515'
[ 4819.375930] kobject: 'gpio' (00000000a1399cd0): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.375932] kobject: 'gpiochip515' (000000002b851bb5): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.375998] kobject: 'gpiochip3' (00000000f89849bd): kobject_uevent_env
[ 4819.376004] kobject: 'gpiochip3' (00000000f89849bd): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip3'
[ 4819.376018] kobject: 'gpiochip3' (00000000f89849bd): kobject_uevent_env
[ 4819.376022] kobject: 'gpiochip3' (00000000f89849bd): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip3'
[ 4819.376048] kobject: 'gpio-sim.0' (00000000b204b566): kobject_uevent_env
[ 4819.376055] kobject: 'gpio-sim.0' (00000000b204b566): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.376069] kobject: 'gpio-sim.0' (00000000b204b566): kobject_uevent_env
[ 4819.376074] kobject: 'gpio-sim.0' (00000000b204b566): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.376083] kobject: 'gpio-sim.0' (00000000b204b566): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.382519] kobject: 'gpio-sim.0' (00000000b9ef5a28): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.382577] kobject: 'gpio-sim.0' (00000000b9ef5a28): kobject_uevent_env
[ 4819.382584] kobject: 'gpio-sim.0' (00000000b9ef5a28): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.382684] kobject: 'gpiochip4' (00000000e06680f5): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.382826] kobject: 'gpiochip4' (00000000e06680f5): kobject_uevent_env
[ 4819.382838] kobject: 'gpiochip4' (00000000e06680f5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip4'
[ 4819.382874] kobject: 'gpiochip4' (00000000e06680f5): kobject_uevent_env
[ 4819.382880] kobject: 'gpiochip4' (00000000e06680f5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip4'
[ 4819.382904] kobject: 'gpio' (00000000babdf5db): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.382909] kobject: 'gpiochip531' (00000000ad4538e8): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.382952] kobject: 'gpiochip531' (00000000ad4538e8): kobject_uevent_env
[ 4819.382958] kobject: 'gpiochip531' (00000000ad4538e8): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip531'
[ 4819.383005] kobject: 'gpio-sim.0' (00000000b9ef5a28): kobject_uevent_env
[ 4819.383010] kobject: 'gpio-sim.0' (00000000b9ef5a28): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.403312] kobject: 'gpiochip531' (00000000ad4538e8): kobject_uevent_env
[ 4819.403323] kobject: 'gpiochip531' (00000000ad4538e8): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip531'
[ 4819.403343] kobject: 'gpio' (00000000babdf5db): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.403346] kobject: 'gpiochip531' (00000000ad4538e8): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.403445] kobject: 'gpiochip4' (00000000e06680f5): kobject_uevent_env
[ 4819.403454] kobject: 'gpiochip4' (00000000e06680f5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip4'
[ 4819.403473] kobject: 'gpiochip4' (00000000e06680f5): kobject_uevent_env
[ 4819.403477] kobject: 'gpiochip4' (00000000e06680f5): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip4'
[ 4819.403514] kobject: 'gpio-sim.0' (00000000b9ef5a28): kobject_uevent_env
[ 4819.403521] kobject: 'gpio-sim.0' (00000000b9ef5a28): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.403537] kobject: 'gpio-sim.0' (00000000b9ef5a28): kobject_uevent_env
[ 4819.403543] kobject: 'gpio-sim.0' (00000000b9ef5a28): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.403553] kobject: 'gpio-sim.0' (00000000b9ef5a28): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.409746] kobject: 'gpio-sim.0' (0000000034300a6b): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.409799] kobject: 'gpio-sim.0' (0000000034300a6b): kobject_uevent_env
[ 4819.409804] kobject: 'gpio-sim.0' (0000000034300a6b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.409899] kobject: 'gpiochip5' (000000004ef2dca6): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.410038] kobject: 'gpiochip5' (000000004ef2dca6): kobject_uevent_env
[ 4819.410048] kobject: 'gpiochip5' (000000004ef2dca6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip5'
[ 4819.410081] kobject: 'gpiochip5' (000000004ef2dca6): kobject_uevent_env
[ 4819.410087] kobject: 'gpiochip5' (000000004ef2dca6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip5'
[ 4819.410110] kobject: 'gpio' (000000008b98f863): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.410114] kobject: 'gpiochip532' (00000000ac07803f): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.410154] kobject: 'gpiochip532' (00000000ac07803f): kobject_uevent_env
[ 4819.410159] kobject: 'gpiochip532' (00000000ac07803f): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip532'
[ 4819.410202] kobject: 'gpio-sim.0' (0000000034300a6b): kobject_uevent_env
[ 4819.410207] kobject: 'gpio-sim.0' (0000000034300a6b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.427858] kobject: 'gpiochip532' (00000000ac07803f): kobject_uevent_env
[ 4819.427870] kobject: 'gpiochip532' (00000000ac07803f): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip532'
[ 4819.427891] kobject: 'gpio' (000000008b98f863): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.427895] kobject: 'gpiochip532' (00000000ac07803f): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.427970] kobject: 'gpiochip5' (000000004ef2dca6): kobject_uevent_env
[ 4819.427976] kobject: 'gpiochip5' (000000004ef2dca6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip5'
[ 4819.427994] kobject: 'gpiochip5' (000000004ef2dca6): kobject_uevent_env
[ 4819.427999] kobject: 'gpiochip5' (000000004ef2dca6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip5'
[ 4819.428044] kobject: 'gpio-sim.0' (0000000034300a6b): kobject_uevent_env
[ 4819.428053] kobject: 'gpio-sim.0' (0000000034300a6b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.428071] kobject: 'gpio-sim.0' (0000000034300a6b): kobject_uevent_env
[ 4819.428077] kobject: 'gpio-sim.0' (0000000034300a6b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.428088] kobject: 'gpio-sim.0' (0000000034300a6b): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.440540] kobject: 'gpio-sim.0' (00000000cdc367f1): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.440596] kobject: 'gpio-sim.0' (00000000cdc367f1): kobject_uevent_env
[ 4819.440601] kobject: 'gpio-sim.0' (00000000cdc367f1): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.440694] kobject: 'gpiochip6' (00000000a22546a6): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.440824] kobject: 'gpiochip6' (00000000a22546a6): kobject_uevent_env
[ 4819.440834] kobject: 'gpiochip6' (00000000a22546a6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip6'
[ 4819.440869] kobject: 'gpiochip6' (00000000a22546a6): kobject_uevent_env
[ 4819.440875] kobject: 'gpiochip6' (00000000a22546a6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip6'
[ 4819.440898] kobject: 'gpio' (00000000dedc22f2): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.440903] kobject: 'gpiochip533' (000000003541481f): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.440943] kobject: 'gpiochip533' (000000003541481f): kobject_uevent_env
[ 4819.440948] kobject: 'gpiochip533' (000000003541481f): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip533'
[ 4819.441305] kobject: 'gpio-sim.0' (00000000cdc367f1): kobject_uevent_env
[ 4819.441311] kobject: 'gpio-sim.0' (00000000cdc367f1): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.470191] kobject: 'gpiochip533' (000000003541481f): kobject_uevent_env
[ 4819.470202] kobject: 'gpiochip533' (000000003541481f): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip533'
[ 4819.470226] kobject: 'gpio' (00000000dedc22f2): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.470230] kobject: 'gpiochip533' (000000003541481f): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.470337] kobject: 'gpiochip6' (00000000a22546a6): kobject_uevent_env
[ 4819.470345] kobject: 'gpiochip6' (00000000a22546a6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip6'
[ 4819.470364] kobject: 'gpiochip6' (00000000a22546a6): kobject_uevent_env
[ 4819.470369] kobject: 'gpiochip6' (00000000a22546a6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip6'
[ 4819.470401] kobject: 'gpio-sim.0' (00000000cdc367f1): kobject_uevent_env
[ 4819.470408] kobject: 'gpio-sim.0' (00000000cdc367f1): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.470425] kobject: 'gpio-sim.0' (00000000cdc367f1): kobject_uevent_env
[ 4819.470431] kobject: 'gpio-sim.0' (00000000cdc367f1): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.470441] kobject: 'gpio-sim.0' (00000000cdc367f1): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.479607] kobject: 'gpio-sim.0' (00000000bb358104): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.479661] kobject: 'gpio-sim.0' (00000000bb358104): kobject_uevent_env
[ 4819.479667] kobject: 'gpio-sim.0' (00000000bb358104): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.479757] kobject: 'gpiochip7' (000000006b8d9c99): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.479878] kobject: 'gpiochip7' (000000006b8d9c99): kobject_uevent_env
[ 4819.479885] kobject: 'gpiochip7' (000000006b8d9c99): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip7'
[ 4819.479914] kobject: 'gpiochip7' (000000006b8d9c99): kobject_uevent_env
[ 4819.479919] kobject: 'gpiochip7' (000000006b8d9c99): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip7'
[ 4819.479939] kobject: 'gpio' (00000000e467cb12): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.479943] kobject: 'gpiochip549' (0000000014379c6d): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.479990] kobject: 'gpiochip549' (0000000014379c6d): kobject_uevent_env
[ 4819.479995] kobject: 'gpiochip549' (0000000014379c6d): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip549'
[ 4819.480055] kobject: 'gpio-sim.0' (00000000bb358104): kobject_uevent_env
[ 4819.480060] kobject: 'gpio-sim.0' (00000000bb358104): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.506928] kobject: 'gpiochip549' (0000000014379c6d): kobject_uevent_env
[ 4819.506940] kobject: 'gpiochip549' (0000000014379c6d): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip549'
[ 4819.506961] kobject: 'gpio' (00000000e467cb12): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.506965] kobject: 'gpiochip549' (0000000014379c6d): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.507073] kobject: 'gpiochip7' (000000006b8d9c99): kobject_uevent_env
[ 4819.507083] kobject: 'gpiochip7' (000000006b8d9c99): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip7'
[ 4819.507104] kobject: 'gpiochip7' (000000006b8d9c99): kobject_uevent_env
[ 4819.507109] kobject: 'gpiochip7' (000000006b8d9c99): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip7'
[ 4819.507137] kobject: 'gpio-sim.0' (00000000bb358104): kobject_uevent_env
[ 4819.507145] kobject: 'gpio-sim.0' (00000000bb358104): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.507162] kobject: 'gpio-sim.0' (00000000bb358104): kobject_uevent_env
[ 4819.507167] kobject: 'gpio-sim.0' (00000000bb358104): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.507178] kobject: 'gpio-sim.0' (00000000bb358104): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.538632] kobject: 'gpio-sim.0' (00000000461517ae): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.538690] kobject: 'gpio-sim.0' (00000000461517ae): kobject_uevent_env
[ 4819.538695] kobject: 'gpio-sim.0' (00000000461517ae): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.538804] kobject: 'gpiochip8' (00000000cb0b3463): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.538943] kobject: 'gpiochip8' (00000000cb0b3463): kobject_uevent_env
[ 4819.538953] kobject: 'gpiochip8' (00000000cb0b3463): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip8'
[ 4819.538990] kobject: 'gpiochip8' (00000000cb0b3463): kobject_uevent_env
[ 4819.538996] kobject: 'gpiochip8' (00000000cb0b3463): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip8'
[ 4819.539020] kobject: 'gpio' (0000000016f05b5a): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.539025] kobject: 'gpiochip551' (00000000a55e630b): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.539066] kobject: 'gpiochip551' (00000000a55e630b): kobject_uevent_env
[ 4819.539072] kobject: 'gpiochip551' (00000000a55e630b): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip551'
[ 4819.539118] kobject: 'gpio-sim.0' (00000000461517ae): kobject_uevent_env
[ 4819.539124] kobject: 'gpio-sim.0' (00000000461517ae): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.545644] kobject: 'gpio-sim.1' (0000000018f833bf): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.545706] kobject: 'gpio-sim.1' (0000000018f833bf): kobject_uevent_env
[ 4819.545712] kobject: 'gpio-sim.1' (0000000018f833bf): fill_kobj_path: path = '/devices/platform/gpio-sim.1'
[ 4819.545808] kobject: 'gpiochip9' (00000000bdaa0a47): kobject_add_internal: parent: 'gpio-sim.1', set: 'devices'
[ 4819.545937] kobject: 'gpiochip9' (00000000bdaa0a47): kobject_uevent_env
[ 4819.545948] kobject: 'gpiochip9' (00000000bdaa0a47): fill_kobj_path: path = '/devices/platform/gpio-sim.1/gpiochip9'
[ 4819.545981] kobject: 'gpiochip9' (00000000bdaa0a47): kobject_uevent_env
[ 4819.545986] kobject: 'gpiochip9' (00000000bdaa0a47): fill_kobj_path: path = '/devices/platform/gpio-sim.1/gpiochip9'
[ 4819.546010] kobject: 'gpio' (00000000176df109): kobject_add_internal: parent: 'gpio-sim.1', set: '(null)'
[ 4819.546014] kobject: 'gpiochip552' (000000001750e50f): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.546056] kobject: 'gpiochip552' (000000001750e50f): kobject_uevent_env
[ 4819.546061] kobject: 'gpiochip552' (000000001750e50f): fill_kobj_path: path = '/devices/platform/gpio-sim.1/gpio/gpiochip552'
[ 4819.546105] kobject: 'gpio-sim.1' (0000000018f833bf): kobject_uevent_env
[ 4819.546112] kobject: 'gpio-sim.1' (0000000018f833bf): fill_kobj_path: path = '/devices/platform/gpio-sim.1'
[ 4819.553126] kobject: 'gpio-sim.2' (00000000bbfd5238): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.553181] kobject: 'gpio-sim.2' (00000000bbfd5238): kobject_uevent_env
[ 4819.553188] kobject: 'gpio-sim.2' (00000000bbfd5238): fill_kobj_path: path = '/devices/platform/gpio-sim.2'
[ 4819.553297] kobject: 'gpiochip10' (00000000e3becc55): kobject_add_internal: parent: 'gpio-sim.2', set: 'devices'
[ 4819.553398] kobject: 'gpiochip10' (00000000e3becc55): kobject_uevent_env
[ 4819.553404] kobject: 'gpiochip10' (00000000e3becc55): fill_kobj_path: path = '/devices/platform/gpio-sim.2/gpiochip10'
[ 4819.553432] kobject: 'gpiochip10' (00000000e3becc55): kobject_uevent_env
[ 4819.553437] kobject: 'gpiochip10' (00000000e3becc55): fill_kobj_path: path = '/devices/platform/gpio-sim.2/gpiochip10'
[ 4819.553458] kobject: 'gpio' (00000000886e1a77): kobject_add_internal: parent: 'gpio-sim.2', set: '(null)'
[ 4819.553463] kobject: 'gpiochip553' (0000000010cfe833): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.553504] kobject: 'gpiochip553' (0000000010cfe833): kobject_uevent_env
[ 4819.553512] kobject: 'gpiochip553' (0000000010cfe833): fill_kobj_path: path = '/devices/platform/gpio-sim.2/gpio/gpiochip553'
[ 4819.553561] kobject: 'gpio-sim.2' (00000000bbfd5238): kobject_uevent_env
[ 4819.553569] kobject: 'gpio-sim.2' (00000000bbfd5238): fill_kobj_path: path = '/devices/platform/gpio-sim.2'
[ 4819.568521] kobject: 'gpiochip551' (00000000a55e630b): kobject_uevent_env
[ 4819.568536] kobject: 'gpiochip551' (00000000a55e630b): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip551'
[ 4819.568570] kobject: 'gpio' (0000000016f05b5a): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.568574] kobject: 'gpiochip551' (00000000a55e630b): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.568864] kobject: 'gpiochip8' (00000000cb0b3463): kobject_uevent_env
[ 4819.568871] kobject: 'gpiochip8' (00000000cb0b3463): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip8'
[ 4819.568890] kobject: 'gpiochip8' (00000000cb0b3463): kobject_uevent_env
[ 4819.568895] kobject: 'gpiochip8' (00000000cb0b3463): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip8'
[ 4819.568932] kobject: 'gpio-sim.0' (00000000461517ae): kobject_uevent_env
[ 4819.568939] kobject: 'gpio-sim.0' (00000000461517ae): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.568954] kobject: 'gpio-sim.0' (00000000461517ae): kobject_uevent_env
[ 4819.568960] kobject: 'gpio-sim.0' (00000000461517ae): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.568970] kobject: 'gpio-sim.0' (00000000461517ae): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.583881] kobject: 'gpiochip552' (000000001750e50f): kobject_uevent_env
[ 4819.583892] kobject: 'gpiochip552' (000000001750e50f): fill_kobj_path: path = '/devices/platform/gpio-sim.1/gpio/gpiochip552'
[ 4819.583914] kobject: 'gpio' (00000000176df109): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.583918] kobject: 'gpiochip552' (000000001750e50f): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.583988] kobject: 'gpiochip9' (00000000bdaa0a47): kobject_uevent_env
[ 4819.583994] kobject: 'gpiochip9' (00000000bdaa0a47): fill_kobj_path: path = '/devices/platform/gpio-sim.1/gpiochip9'
[ 4819.584007] kobject: 'gpiochip9' (00000000bdaa0a47): kobject_uevent_env
[ 4819.584013] kobject: 'gpiochip9' (00000000bdaa0a47): fill_kobj_path: path = '/devices/platform/gpio-sim.1/gpiochip9'
[ 4819.584048] kobject: 'gpio-sim.1' (0000000018f833bf): kobject_uevent_env
[ 4819.584056] kobject: 'gpio-sim.1' (0000000018f833bf): fill_kobj_path: path = '/devices/platform/gpio-sim.1'
[ 4819.584072] kobject: 'gpio-sim.1' (0000000018f833bf): kobject_uevent_env
[ 4819.584077] kobject: 'gpio-sim.1' (0000000018f833bf): fill_kobj_path: path = '/devices/platform/gpio-sim.1'
[ 4819.584087] kobject: 'gpio-sim.1' (0000000018f833bf): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.599281] kobject: 'gpiochip553' (0000000010cfe833): kobject_uevent_env
[ 4819.599292] kobject: 'gpiochip553' (0000000010cfe833): fill_kobj_path: path = '/devices/platform/gpio-sim.2/gpio/gpiochip553'
[ 4819.599316] kobject: 'gpio' (00000000886e1a77): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.599319] kobject: 'gpiochip553' (0000000010cfe833): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.599418] kobject: 'gpiochip10' (00000000e3becc55): kobject_uevent_env
[ 4819.599426] kobject: 'gpiochip10' (00000000e3becc55): fill_kobj_path: path = '/devices/platform/gpio-sim.2/gpiochip10'
[ 4819.599441] kobject: 'gpiochip10' (00000000e3becc55): kobject_uevent_env
[ 4819.599446] kobject: 'gpiochip10' (00000000e3becc55): fill_kobj_path: path = '/devices/platform/gpio-sim.2/gpiochip10'
[ 4819.599479] kobject: 'gpio-sim.2' (00000000bbfd5238): kobject_uevent_env
[ 4819.599488] kobject: 'gpio-sim.2' (00000000bbfd5238): fill_kobj_path: path = '/devices/platform/gpio-sim.2'
[ 4819.599504] kobject: 'gpio-sim.2' (00000000bbfd5238): kobject_uevent_env
[ 4819.599509] kobject: 'gpio-sim.2' (00000000bbfd5238): fill_kobj_path: path = '/devices/platform/gpio-sim.2'
[ 4819.599521] kobject: 'gpio-sim.2' (00000000bbfd5238): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.606440] kobject: 'gpio-sim.0' (00000000e8c2899c): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.606495] kobject: 'gpio-sim.0' (00000000e8c2899c): kobject_uevent_env
[ 4819.606501] kobject: 'gpio-sim.0' (00000000e8c2899c): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.606609] kobject: 'gpiochip11' (00000000b39a3c5f): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.606742] kobject: 'gpiochip11' (00000000b39a3c5f): kobject_uevent_env
[ 4819.606753] kobject: 'gpiochip11' (00000000b39a3c5f): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip11'
[ 4819.606789] kobject: 'gpiochip11' (00000000b39a3c5f): kobject_uevent_env
[ 4819.606795] kobject: 'gpiochip11' (00000000b39a3c5f): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip11'
[ 4819.606817] kobject: 'gpio' (000000002835f4a4): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.606821] kobject: 'gpiochip554' (00000000e0038afb): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.606864] kobject: 'gpiochip554' (00000000e0038afb): kobject_uevent_env
[ 4819.606869] kobject: 'gpiochip554' (00000000e0038afb): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip554'
[ 4819.606914] kobject: 'gpio-sim.0' (00000000e8c2899c): kobject_uevent_env
[ 4819.606919] kobject: 'gpio-sim.0' (00000000e8c2899c): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.622045] kobject: 'gpiochip554' (00000000e0038afb): kobject_uevent_env
[ 4819.622055] kobject: 'gpiochip554' (00000000e0038afb): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip554'
[ 4819.622076] kobject: 'gpio' (000000002835f4a4): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.622079] kobject: 'gpiochip554' (00000000e0038afb): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.622179] kobject: 'gpiochip11' (00000000b39a3c5f): kobject_uevent_env
[ 4819.622187] kobject: 'gpiochip11' (00000000b39a3c5f): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip11'
[ 4819.622205] kobject: 'gpiochip11' (00000000b39a3c5f): kobject_uevent_env
[ 4819.622210] kobject: 'gpiochip11' (00000000b39a3c5f): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip11'
[ 4819.622243] kobject: 'gpio-sim.0' (00000000e8c2899c): kobject_uevent_env
[ 4819.622252] kobject: 'gpio-sim.0' (00000000e8c2899c): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.622268] kobject: 'gpio-sim.0' (00000000e8c2899c): kobject_uevent_env
[ 4819.622274] kobject: 'gpio-sim.0' (00000000e8c2899c): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.622283] kobject: 'gpio-sim.0' (00000000e8c2899c): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.628405] kobject: 'gpio-sim.0' (000000008ef7f514): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.628464] kobject: 'gpio-sim.0' (000000008ef7f514): kobject_uevent_env
[ 4819.628471] kobject: 'gpio-sim.0' (000000008ef7f514): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.628588] kobject: 'gpiochip12' (0000000051b24fd2): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.628727] kobject: 'gpiochip12' (0000000051b24fd2): kobject_uevent_env
[ 4819.628737] kobject: 'gpiochip12' (0000000051b24fd2): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip12'
[ 4819.628772] kobject: 'gpiochip12' (0000000051b24fd2): kobject_uevent_env
[ 4819.628777] kobject: 'gpiochip12' (0000000051b24fd2): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip12'
[ 4819.628799] kobject: 'gpio' (00000000d962e90a): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.628804] kobject: 'gpiochip555' (00000000f5bbd198): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.628845] kobject: 'gpiochip555' (00000000f5bbd198): kobject_uevent_env
[ 4819.628850] kobject: 'gpiochip555' (00000000f5bbd198): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip555'
[ 4819.628893] kobject: 'gpio-sim.0' (000000008ef7f514): kobject_uevent_env
[ 4819.628899] kobject: 'gpio-sim.0' (000000008ef7f514): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.646727] kobject: 'gpiochip555' (00000000f5bbd198): kobject_uevent_env
[ 4819.646740] kobject: 'gpiochip555' (00000000f5bbd198): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip555'
[ 4819.646764] kobject: 'gpio' (00000000d962e90a): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.646768] kobject: 'gpiochip555' (00000000f5bbd198): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.646880] kobject: 'gpiochip12' (0000000051b24fd2): kobject_uevent_env
[ 4819.646889] kobject: 'gpiochip12' (0000000051b24fd2): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip12'
[ 4819.646912] kobject: 'gpiochip12' (0000000051b24fd2): kobject_uevent_env
[ 4819.646918] kobject: 'gpiochip12' (0000000051b24fd2): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip12'
[ 4819.646962] kobject: 'gpio-sim.0' (000000008ef7f514): kobject_uevent_env
[ 4819.646971] kobject: 'gpio-sim.0' (000000008ef7f514): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.646991] kobject: 'gpio-sim.0' (000000008ef7f514): kobject_uevent_env
[ 4819.646997] kobject: 'gpio-sim.0' (000000008ef7f514): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.647009] kobject: 'gpio-sim.0' (000000008ef7f514): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.654427] kobject: 'gpio-sim.0' (000000005418b2af): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.654482] kobject: 'gpio-sim.0' (000000005418b2af): kobject_uevent_env
[ 4819.654488] kobject: 'gpio-sim.0' (000000005418b2af): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.654536] gpio-sim: probe of gpio-sim.0 failed with error -34
[ 4819.654556] kobject: 'gpio-sim.0' (000000005418b2af): kobject_uevent_env
[ 4819.654562] kobject: 'gpio-sim.0' (000000005418b2af): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.654576] kobject: 'gpio-sim.0' (000000005418b2af): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.717310] kobject: 'gpio-sim.0' (00000000cd797c7b): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.717365] kobject: 'gpio-sim.0' (00000000cd797c7b): kobject_uevent_env
[ 4819.717371] kobject: 'gpio-sim.0' (00000000cd797c7b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.717473] gpio-560 (?): hogged as input
[ 4819.717479] kobject: 'gpiochip13' (00000000dc27f1aa): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.717621] kobject: 'gpiochip13' (00000000dc27f1aa): kobject_uevent_env
[ 4819.717630] kobject: 'gpiochip13' (00000000dc27f1aa): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip13'
[ 4819.717669] kobject: 'gpiochip13' (00000000dc27f1aa): kobject_uevent_env
[ 4819.717676] kobject: 'gpiochip13' (00000000dc27f1aa): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip13'
[ 4819.717698] kobject: 'gpio' (000000006cce49d7): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.717703] kobject: 'gpiochip556' (00000000d2b04f32): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.717753] kobject: 'gpiochip556' (00000000d2b04f32): kobject_uevent_env
[ 4819.717760] kobject: 'gpiochip556' (00000000d2b04f32): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip556'
[ 4819.717948] kobject: 'gpio-sim.0' (00000000cd797c7b): kobject_uevent_env
[ 4819.717954] kobject: 'gpio-sim.0' (00000000cd797c7b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.740722] kobject: 'gpiochip556' (00000000d2b04f32): kobject_uevent_env
[ 4819.740733] kobject: 'gpiochip556' (00000000d2b04f32): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip556'
[ 4819.740753] kobject: 'gpio' (000000006cce49d7): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.740757] kobject: 'gpiochip556' (00000000d2b04f32): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.740863] kobject: 'gpiochip13' (00000000dc27f1aa): kobject_uevent_env
[ 4819.740871] kobject: 'gpiochip13' (00000000dc27f1aa): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip13'
[ 4819.740890] kobject: 'gpiochip13' (00000000dc27f1aa): kobject_uevent_env
[ 4819.740896] kobject: 'gpiochip13' (00000000dc27f1aa): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip13'
[ 4819.740928] kobject: 'gpio-sim.0' (00000000cd797c7b): kobject_uevent_env
[ 4819.740936] kobject: 'gpio-sim.0' (00000000cd797c7b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.740951] kobject: 'gpio-sim.0' (00000000cd797c7b): kobject_uevent_env
[ 4819.740958] kobject: 'gpio-sim.0' (00000000cd797c7b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.740970] kobject: 'gpio-sim.0' (00000000cd797c7b): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.747033] kobject: 'gpio-sim.0' (000000006053a4bf): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.747082] kobject: 'gpio-sim.0' (000000006053a4bf): kobject_uevent_env
[ 4819.747087] kobject: 'gpio-sim.0' (000000006053a4bf): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.747182] kobject: 'gpiochip14' (0000000092a079b6): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.747311] kobject: 'gpiochip14' (0000000092a079b6): kobject_uevent_env
[ 4819.747321] kobject: 'gpiochip14' (0000000092a079b6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip14'
[ 4819.747354] kobject: 'gpiochip14' (0000000092a079b6): kobject_uevent_env
[ 4819.747359] kobject: 'gpiochip14' (0000000092a079b6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip14'
[ 4819.747381] kobject: 'gpio' (000000007164bff6): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.747386] kobject: 'gpiochip564' (00000000ee87da7b): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.747426] kobject: 'gpiochip564' (00000000ee87da7b): kobject_uevent_env
[ 4819.747431] kobject: 'gpiochip564' (00000000ee87da7b): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip564'
[ 4819.747622] kobject: 'gpio-sim.0' (000000006053a4bf): kobject_uevent_env
[ 4819.747629] kobject: 'gpio-sim.0' (000000006053a4bf): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.782537] kobject: 'gpiochip564' (00000000ee87da7b): kobject_uevent_env
[ 4819.782547] kobject: 'gpiochip564' (00000000ee87da7b): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip564'
[ 4819.782567] kobject: 'gpio' (000000007164bff6): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.782571] kobject: 'gpiochip564' (00000000ee87da7b): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.782653] kobject: 'gpiochip14' (0000000092a079b6): kobject_uevent_env
[ 4819.782662] kobject: 'gpiochip14' (0000000092a079b6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip14'
[ 4819.782680] kobject: 'gpiochip14' (0000000092a079b6): kobject_uevent_env
[ 4819.782685] kobject: 'gpiochip14' (0000000092a079b6): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip14'
[ 4819.782719] kobject: 'gpio-sim.0' (000000006053a4bf): kobject_uevent_env
[ 4819.782729] kobject: 'gpio-sim.0' (000000006053a4bf): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.782745] kobject: 'gpio-sim.0' (000000006053a4bf): kobject_uevent_env
[ 4819.782750] kobject: 'gpio-sim.0' (000000006053a4bf): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.782760] kobject: 'gpio-sim.0' (000000006053a4bf): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.789540] kobject: 'gpio-sim.0' (00000000c56fc456): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.789591] kobject: 'gpio-sim.0' (00000000c56fc456): kobject_uevent_env
[ 4819.789597] kobject: 'gpio-sim.0' (00000000c56fc456): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.789698] kobject: 'gpiochip15' (00000000b0535d8d): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.789829] kobject: 'gpiochip15' (00000000b0535d8d): kobject_uevent_env
[ 4819.789839] kobject: 'gpiochip15' (00000000b0535d8d): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip15'
[ 4819.789873] kobject: 'gpiochip15' (00000000b0535d8d): kobject_uevent_env
[ 4819.789880] kobject: 'gpiochip15' (00000000b0535d8d): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip15'
[ 4819.789902] kobject: 'gpio' (0000000012ac3b4a): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.789907] kobject: 'gpiochip572' (00000000178509ff): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.789957] kobject: 'gpiochip572' (00000000178509ff): kobject_uevent_env
[ 4819.789963] kobject: 'gpiochip572' (00000000178509ff): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip572'
[ 4819.790172] kobject: 'gpio-sim.0' (00000000c56fc456): kobject_uevent_env
[ 4819.790179] kobject: 'gpio-sim.0' (00000000c56fc456): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.820474] kobject: 'gpiochip572' (00000000178509ff): kobject_uevent_env
[ 4819.820489] kobject: 'gpiochip572' (00000000178509ff): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip572'
[ 4819.820515] kobject: 'gpio' (0000000012ac3b4a): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.820519] kobject: 'gpiochip572' (00000000178509ff): kobject_release, parent 0000000000000000 (delayed 750)
[ 4819.820629] kobject: 'gpiochip15' (00000000b0535d8d): kobject_uevent_env
[ 4819.820640] kobject: 'gpiochip15' (00000000b0535d8d): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip15'
[ 4819.820664] kobject: 'gpiochip15' (00000000b0535d8d): kobject_uevent_env
[ 4819.820669] kobject: 'gpiochip15' (00000000b0535d8d): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip15'
[ 4819.820715] kobject: 'gpio-sim.0' (00000000c56fc456): kobject_uevent_env
[ 4819.820724] kobject: 'gpio-sim.0' (00000000c56fc456): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.820745] kobject: 'gpio-sim.0' (00000000c56fc456): kobject_uevent_env
[ 4819.820751] kobject: 'gpio-sim.0' (00000000c56fc456): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.820761] kobject: 'gpio-sim.0' (00000000c56fc456): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.827333] kobject: 'gpio-sim.0' (000000000471ebbe): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.827384] kobject: 'gpio-sim.0' (000000000471ebbe): kobject_uevent_env
[ 4819.827390] kobject: 'gpio-sim.0' (000000000471ebbe): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.827489] kobject: 'gpiochip16' (000000002be607c1): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.827596] kobject: 'gpiochip16' (000000002be607c1): kobject_uevent_env
[ 4819.827606] kobject: 'gpiochip16' (000000002be607c1): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip16'
[ 4819.827647] kobject: 'gpiochip16' (000000002be607c1): kobject_uevent_env
[ 4819.827652] kobject: 'gpiochip16' (000000002be607c1): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip16'
[ 4819.827675] kobject: 'gpio' (000000000333f422): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.827679] kobject: 'gpiochip580' (00000000f6371a1e): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.827719] kobject: 'gpiochip580' (00000000f6371a1e): kobject_uevent_env
[ 4819.827724] kobject: 'gpiochip580' (00000000f6371a1e): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip580'
[ 4819.827920] kobject: 'gpio-sim.0' (000000000471ebbe): kobject_uevent_env
[ 4819.827927] kobject: 'gpio-sim.0' (000000000471ebbe): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.849122] kobject: 'gpiochip580' (00000000f6371a1e): kobject_uevent_env
[ 4819.849136] kobject: 'gpiochip580' (00000000f6371a1e): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip580'
[ 4819.849160] kobject: 'gpio' (000000000333f422): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.849163] kobject: 'gpiochip580' (00000000f6371a1e): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.849279] kobject: 'gpiochip16' (000000002be607c1): kobject_uevent_env
[ 4819.849293] kobject: 'gpiochip16' (000000002be607c1): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip16'
[ 4819.849317] kobject: 'gpiochip16' (000000002be607c1): kobject_uevent_env
[ 4819.849323] kobject: 'gpiochip16' (000000002be607c1): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip16'
[ 4819.849381] kobject: 'gpio-sim.0' (000000000471ebbe): kobject_uevent_env
[ 4819.849391] kobject: 'gpio-sim.0' (000000000471ebbe): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.849421] kobject: 'gpio-sim.0' (000000000471ebbe): kobject_uevent_env
[ 4819.849428] kobject: 'gpio-sim.0' (000000000471ebbe): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.849442] kobject: 'gpio-sim.0' (000000000471ebbe): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.856384] kobject: 'gpio-sim.0' (0000000048f1330d): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.856438] kobject: 'gpio-sim.0' (0000000048f1330d): kobject_uevent_env
[ 4819.856445] kobject: 'gpio-sim.0' (0000000048f1330d): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.856563] kobject: 'gpiochip17' (000000006ee06561): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.856712] kobject: 'gpiochip17' (000000006ee06561): kobject_uevent_env
[ 4819.856724] kobject: 'gpiochip17' (000000006ee06561): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip17'
[ 4819.856786] kobject: 'gpiochip17' (000000006ee06561): kobject_uevent_env
[ 4819.856794] kobject: 'gpiochip17' (000000006ee06561): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip17'
[ 4819.856821] kobject: 'gpio' (0000000005a238f5): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.856825] kobject: 'gpiochip588' (0000000075b76b85): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.856868] kobject: 'gpiochip588' (0000000075b76b85): kobject_uevent_env
[ 4819.856874] kobject: 'gpiochip588' (0000000075b76b85): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip588'
[ 4819.856922] kobject: 'gpio-sim.0' (0000000048f1330d): kobject_uevent_env
[ 4819.856928] kobject: 'gpio-sim.0' (0000000048f1330d): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.878720] kobject: 'gpiochip588' (0000000075b76b85): kobject_uevent_env
[ 4819.878731] kobject: 'gpiochip588' (0000000075b76b85): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip588'
[ 4819.878750] kobject: 'gpio' (0000000005a238f5): kobject_release, parent 0000000000000000 (delayed 500)
[ 4819.878755] kobject: 'gpiochip588' (0000000075b76b85): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4819.878864] kobject: 'gpiochip17' (000000006ee06561): kobject_uevent_env
[ 4819.878872] kobject: 'gpiochip17' (000000006ee06561): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip17'
[ 4819.878890] kobject: 'gpiochip17' (000000006ee06561): kobject_uevent_env
[ 4819.878896] kobject: 'gpiochip17' (000000006ee06561): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip17'
[ 4819.878928] kobject: 'gpio-sim.0' (0000000048f1330d): kobject_uevent_env
[ 4819.878936] kobject: 'gpio-sim.0' (0000000048f1330d): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.878950] kobject: 'gpio-sim.0' (0000000048f1330d): kobject_uevent_env
[ 4819.878954] kobject: 'gpio-sim.0' (0000000048f1330d): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.878964] kobject: 'gpio-sim.0' (0000000048f1330d): kobject_release, parent 0000000000000000 (delayed 250)
[ 4819.885904] kobject: 'gpio-sim.0' (00000000f462f78a): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4819.885967] kobject: 'gpio-sim.0' (00000000f462f78a): kobject_uevent_env
[ 4819.885973] kobject: 'gpio-sim.0' (00000000f462f78a): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4819.886080] kobject: 'gpiochip18' (00000000a8ca1f8c): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4819.886214] kobject: 'gpiochip18' (00000000a8ca1f8c): kobject_uevent_env
[ 4819.886224] kobject: 'gpiochip18' (00000000a8ca1f8c): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip18'
[ 4819.886257] kobject: 'gpiochip18' (00000000a8ca1f8c): kobject_uevent_env
[ 4819.886264] kobject: 'gpiochip18' (00000000a8ca1f8c): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip18'
[ 4819.886289] kobject: 'gpio' (0000000064e73453): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4819.886293] kobject: 'gpiochip589' (000000007e1cf13a): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4819.886340] kobject: 'gpiochip589' (000000007e1cf13a): kobject_uevent_env
[ 4819.886345] kobject: 'gpiochip589' (000000007e1cf13a): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip589'
[ 4819.886554] kobject: 'gpio-sim.0' (00000000f462f78a): kobject_uevent_env
[ 4819.886560] kobject: 'gpio-sim.0' (00000000f462f78a): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4820.013863] kobject: 'gpiochip589' (000000007e1cf13a): kobject_uevent_env
[ 4820.013872] kobject: 'gpiochip589' (000000007e1cf13a): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip589'
[ 4820.013894] kobject: 'gpio' (0000000064e73453): kobject_release, parent 0000000000000000 (delayed 750)
[ 4820.013897] kobject: 'gpiochip589' (000000007e1cf13a): kobject_release, parent 0000000000000000 (delayed 500)
[ 4820.013994] kobject: 'gpiochip18' (00000000a8ca1f8c): kobject_uevent_env
[ 4820.014004] kobject: 'gpiochip18' (00000000a8ca1f8c): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip18'
[ 4820.014022] kobject: 'gpiochip18' (00000000a8ca1f8c): kobject_uevent_env
[ 4820.014027] kobject: 'gpiochip18' (00000000a8ca1f8c): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip18'
[ 4820.014059] kobject: 'gpio-sim.0' (00000000f462f78a): kobject_uevent_env
[ 4820.014065] kobject: 'gpio-sim.0' (00000000f462f78a): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4820.014082] kobject: 'gpio-sim.0' (00000000f462f78a): kobject_uevent_env
[ 4820.014087] kobject: 'gpio-sim.0' (00000000f462f78a): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4820.014098] kobject: 'gpio-sim.0' (00000000f462f78a): kobject_release, parent 0000000000000000 (delayed 500)
[ 4820.020299] kobject: 'gpio-sim.0' (00000000b1d6276b): kobject_add_internal: parent: 'platform', set: 'devices'
[ 4820.020347] kobject: 'gpio-sim.0' (00000000b1d6276b): kobject_uevent_env
[ 4820.020352] kobject: 'gpio-sim.0' (00000000b1d6276b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4820.020447] kobject: 'gpiochip19' (000000008385ae47): kobject_add_internal: parent: 'gpio-sim.0', set: 'devices'
[ 4820.020581] kobject: 'gpiochip19' (000000008385ae47): kobject_uevent_env
[ 4820.020590] kobject: 'gpiochip19' (000000008385ae47): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip19'
[ 4820.020622] kobject: 'gpiochip19' (000000008385ae47): kobject_uevent_env
[ 4820.020627] kobject: 'gpiochip19' (000000008385ae47): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip19'
[ 4820.020651] kobject: 'gpio' (000000001bd064f6): kobject_add_internal: parent: 'gpio-sim.0', set: '(null)'
[ 4820.020655] kobject: 'gpiochip597' (00000000a32f70da): kobject_add_internal: parent: 'gpio', set: 'devices'
[ 4820.020701] kobject: 'gpiochip597' (00000000a32f70da): kobject_uevent_env
[ 4820.020707] kobject: 'gpiochip597' (00000000a32f70da): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip597'
[ 4820.020890] kobject: 'gpio-sim.0' (00000000b1d6276b): kobject_uevent_env
[ 4820.020896] kobject: 'gpio-sim.0' (00000000b1d6276b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4820.048138] kobject: 'gpiochip597' (00000000a32f70da): kobject_uevent_env
[ 4820.048148] kobject: 'gpiochip597' (00000000a32f70da): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpio/gpiochip597'
[ 4820.048175] kobject: 'gpio' (000000001bd064f6): kobject_release, parent 0000000000000000 (delayed 750)
[ 4820.048179] kobject: 'gpiochip597' (00000000a32f70da): kobject_release, parent 0000000000000000 (delayed 500)
[ 4820.048273] kobject: 'gpiochip19' (000000008385ae47): kobject_uevent_env
[ 4820.048282] kobject: 'gpiochip19' (000000008385ae47): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip19'
[ 4820.048307] kobject: 'gpiochip19' (000000008385ae47): kobject_uevent_env
[ 4820.048313] kobject: 'gpiochip19' (000000008385ae47): fill_kobj_path: path = '/devices/platform/gpio-sim.0/gpiochip19'
[ 4820.048356] kobject: 'gpio-sim.0' (00000000b1d6276b): kobject_uevent_env
[ 4820.048364] kobject: 'gpio-sim.0' (00000000b1d6276b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4820.048385] kobject: 'gpio-sim.0' (00000000b1d6276b): kobject_uevent_env
[ 4820.048391] kobject: 'gpio-sim.0' (00000000b1d6276b): fill_kobj_path: path = '/devices/platform/gpio-sim.0'
[ 4820.048407] kobject: 'gpio-sim.0' (00000000b1d6276b): kobject_release, parent 0000000000000000 (delayed 250)
[ 4820.304376] kobject: 'gpiochip512' (000000008b9638a5): kobject_cleanup, parent 0000000000000000
[ 4820.304378] kobject: 'gpiochip512' (000000008b9638a5): calling ktype release
[ 4820.304384] kobject: 'gpiochip512': free name
[ 4820.304387] kobject: 'gpio' (0000000065b01c31): kobject_cleanup, parent 0000000000000000
[ 4820.304388] kobject: 'gpio' (0000000065b01c31): calling ktype release
[ 4820.304391] kobject: 'gpio': free name
[ 4820.400182] kobject: 'gpiochip3' (00000000f89849bd): kobject_release, parent 0000000000000000 (delayed 500)
[ 4820.436325] kobject: 'gpio' (00000000babdf5db): kobject_cleanup, parent 0000000000000000
[ 4820.436331] kobject: 'gpio' (00000000babdf5db): calling ktype release
[ 4820.436335] kobject: 'gpio': free name
[ 4820.436344] kobject: 'gpio-sim.0' (0000000034300a6b): kobject_cleanup, parent 0000000000000000
[ 4820.436348] kobject: 'gpio-sim.0' (0000000034300a6b): calling ktype release
[ 4820.436355] kobject: 'gpio-sim.0': free name
[ 4820.436357] kobject: 'gpio' (000000008b98f863): kobject_cleanup, parent 0000000000000000
[ 4820.436359] kobject: 'gpio' (000000008b98f863): calling ktype release
[ 4820.436363] kobject: 'gpio': free name
[ 4820.496304] kobject: 'gpio-sim.0' (00000000cdc367f1): kobject_cleanup, parent 0000000000000000
[ 4820.496306] kobject: 'gpio-sim.0' (00000000cdc367f1): calling ktype release
[ 4820.496312] kobject: 'gpio-sim.0': free name
[ 4820.528235] kobject: 'gpiochip549' (0000000014379c6d): kobject_cleanup, parent 0000000000000000
[ 4820.528242] kobject: 'gpiochip549' (0000000014379c6d): calling ktype release
[ 4820.528248] kobject: 'gpiochip549': free name
[ 4820.596327] kobject: 'gpiochip551' (00000000a55e630b): kobject_cleanup, parent 0000000000000000
[ 4820.596333] kobject: 'gpiochip551' (00000000a55e630b): calling ktype release
[ 4820.596341] kobject: 'gpiochip551': free name
[ 4820.624451] kobject: 'gpiochip11' (00000000b39a3c5f): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4820.624455] kobject: 'gpio' (000000002835f4a4): kobject_cleanup, parent 0000000000000000
[ 4820.624456] kobject: 'gpio' (000000002835f4a4): calling ktype release
[ 4820.624461] kobject: 'gpio': free name
[ 4820.656309] kobject: 'gpiochip12' (0000000051b24fd2): kobject_release, parent 0000000000000000 (delayed 250)
[ 4820.656313] kobject: 'gpiochip555' (00000000f5bbd198): kobject_cleanup, parent 0000000000000000
[ 4820.656315] kobject: 'gpiochip555' (00000000f5bbd198): calling ktype release
[ 4820.656321] kobject: 'gpiochip555': free name
[ 4820.656324] kobject: 'gpio' (00000000d962e90a): kobject_cleanup, parent 0000000000000000
[ 4820.656326] kobject: 'gpio' (00000000d962e90a): calling ktype release
[ 4820.656329] kobject: 'gpio': free name
[ 4820.752233] kobject: 'gpiochip556' (00000000d2b04f32): kobject_cleanup, parent 0000000000000000
[ 4820.752240] kobject: 'gpiochip556' (00000000d2b04f32): calling ktype release
[ 4820.752246] kobject: 'gpiochip556': free name
[ 4820.788358] kobject: 'gpio-sim.0' (000000006053a4bf): kobject_cleanup, parent 0000000000000000
[ 4820.788360] kobject: 'gpio-sim.0' (000000006053a4bf): calling ktype release
[ 4820.788365] kobject: 'gpio-sim.0': free name
[ 4820.788367] kobject: 'gpio' (000000007164bff6): kobject_cleanup, parent 0000000000000000
[ 4820.788369] kobject: 'gpio' (000000007164bff6): calling ktype release
[ 4820.788373] kobject: 'gpio': free name
[ 4820.848443] kobject: 'gpio-sim.0' (00000000c56fc456): kobject_cleanup, parent 0000000000000000
[ 4820.848449] kobject: 'gpio-sim.0' (00000000c56fc456): calling ktype release
[ 4820.848457] kobject: 'gpio-sim.0': free name
[ 4820.852177] kobject: 'gpio' (0000000012ac3b4a): kobject_cleanup, parent 0000000000000000
[ 4820.852183] kobject: 'gpio' (0000000012ac3b4a): calling ktype release
[ 4820.852187] kobject: 'gpio': free name
[ 4820.880305] kobject: 'gpio' (000000000333f422): kobject_cleanup, parent 0000000000000000
[ 4820.880326] kobject: 'gpio' (000000000333f422): calling ktype release
[ 4820.880332] kobject: 'gpio': free name
[ 4820.884286] kobject: 'gpio-sim.0' (0000000048f1330d): kobject_cleanup, parent 0000000000000000
[ 4820.884288] kobject: 'gpio-sim.0' (0000000048f1330d): calling ktype release
[ 4820.884293] kobject: 'gpio-sim.0': free name
[ 4820.884296] kobject: 'gpio-sim.0' (000000000471ebbe): kobject_cleanup, parent 0000000000000000
[ 4820.884298] kobject: 'gpio-sim.0' (000000000471ebbe): calling ktype release
[ 4820.884304] kobject: 'gpio-sim.0': free name
[ 4821.076363] kobject: 'gpio-sim.0' (00000000b1d6276b): kobject_cleanup, parent 0000000000000000
[ 4821.076365] kobject: 'gpio-sim.0' (00000000b1d6276b): calling ktype release
[ 4821.076370] kobject: 'gpio-sim.0': free name
[ 4821.328246] kobject: 'gpio' (000000007e927b76): kobject_cleanup, parent 0000000000000000
[ 4821.328252] kobject: 'gpio' (000000007e927b76): calling ktype release
[ 4821.328258] kobject: 'gpio': free name
[ 4821.360465] kobject: 'gpiochip2' (0000000034808fa5): kobject_release, parent 0000000000000000 (delayed 250)
[ 4821.360468] kobject: 'gpio' (000000008afdcce8): kobject_cleanup, parent 0000000000000000
[ 4821.360470] kobject: 'gpio' (000000008afdcce8): calling ktype release
[ 4821.360475] kobject: 'gpio': free name
[ 4821.392179] kobject: 'gpio-sim.0' (00000000b204b566): kobject_cleanup, parent 0000000000000000
[ 4821.392186] kobject: 'gpio-sim.0' (00000000b204b566): calling ktype release
[ 4821.392193] kobject: 'gpio-sim.0': free name
[ 4821.392196] kobject: 'gpiochip515' (000000002b851bb5): kobject_cleanup, parent 0000000000000000
[ 4821.392221] kobject: 'gpiochip515' (000000002b851bb5): calling ktype release
[ 4821.392226] kobject: 'gpiochip515': free name
[ 4821.428255] kobject: 'gpio-sim.0' (00000000b9ef5a28): kobject_cleanup, parent 0000000000000000
[ 4821.428262] kobject: 'gpio-sim.0' (00000000b9ef5a28): calling ktype release
[ 4821.428283] kobject: 'gpio-sim.0': free name
[ 4821.428291] kobject: 'gpiochip4' (00000000e06680f5): kobject_release, parent 0000000000000000 (delayed 250)
[ 4821.460377] kobject: 'gpiochip5' (000000004ef2dca6): kobject_release, parent 0000000000000000 (delayed 750)
[ 4821.460380] kobject: 'gpiochip532' (00000000ac07803f): kobject_cleanup, parent 0000000000000000
[ 4821.460382] kobject: 'gpiochip532' (00000000ac07803f): calling ktype release
[ 4821.460386] kobject: 'gpiochip532': free name
[ 4821.488407] kobject: 'gpio' (00000000dedc22f2): kobject_cleanup, parent 0000000000000000
[ 4821.488426] kobject: 'gpio' (00000000dedc22f2): calling ktype release
[ 4821.488432] kobject: 'gpio': free name
[ 4821.524217] kobject: 'gpiochip7' (000000006b8d9c99): kobject_release, parent 0000000000000000 (delayed 250)
[ 4821.588303] kobject: 'gpiochip9' (00000000bdaa0a47): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4821.588372] kobject: 'gpiochip8' (00000000cb0b3463): kobject_release, parent 0000000000000000 (delayed 250)
[ 4821.588375] kobject: 'gpio' (0000000016f05b5a): kobject_cleanup, parent 0000000000000000
[ 4821.588377] kobject: 'gpio' (0000000016f05b5a): calling ktype release
[ 4821.588380] kobject: 'gpio': free name
[ 4821.616206] kobject: 'gpiochip553' (0000000010cfe833): kobject_cleanup, parent 0000000000000000
[ 4821.616213] kobject: 'gpiochip553' (0000000010cfe833): calling ktype release
[ 4821.616224] kobject: 'gpiochip553': free name
[ 4821.616228] kobject: 'gpio' (00000000886e1a77): kobject_cleanup, parent 0000000000000000
[ 4821.616230] kobject: 'gpio' (00000000886e1a77): calling ktype release
[ 4821.616234] kobject: 'gpio': free name
[ 4821.652317] kobject: 'gpio-sim.0' (000000008ef7f514): kobject_cleanup, parent 0000000000000000
[ 4821.652323] kobject: 'gpio-sim.0' (000000008ef7f514): calling ktype release
[ 4821.652348] kobject: 'gpio-sim.0': free name
[ 4821.684240] kobject: 'gpiochip12' (0000000051b24fd2): kobject_cleanup, parent 0000000000000000
[ 4821.684246] kobject: 'gpiochip12' (0000000051b24fd2): calling ktype release
[ 4821.684275] kobject: 'gpiochip12': free name
[ 4821.748311] kobject: 'gpio-sim.0' (00000000cd797c7b): kobject_cleanup, parent 0000000000000000
[ 4821.748317] kobject: 'gpio-sim.0' (00000000cd797c7b): calling ktype release
[ 4821.748325] kobject: 'gpio-sim.0': free name
[ 4821.748328] kobject: 'gpio' (000000006cce49d7): kobject_cleanup, parent 0000000000000000
[ 4821.748330] kobject: 'gpio' (000000006cce49d7): calling ktype release
[ 4821.748333] kobject: 'gpio': free name
[ 4821.812244] kobject: 'gpiochip14' (0000000092a079b6): kobject_release, parent 0000000000000000 (delayed 1000)
[ 4821.840208] kobject: 'gpiochip15' (00000000b0535d8d): kobject_release, parent 0000000000000000 (delayed 750)
[ 4821.872262] kobject: 'gpiochip580' (00000000f6371a1e): kobject_cleanup, parent 0000000000000000
[ 4821.872269] kobject: 'gpiochip580' (00000000f6371a1e): calling ktype release
[ 4821.872277] kobject: 'gpiochip580': free name
[ 4821.904224] kobject: 'gpio' (0000000005a238f5): kobject_cleanup, parent 0000000000000000
[ 4821.904230] kobject: 'gpio' (0000000005a238f5): calling ktype release
[ 4821.904235] kobject: 'gpio': free name
[ 4822.036185] kobject: 'gpio-sim.0' (00000000f462f78a): kobject_cleanup, parent 0000000000000000
[ 4822.036192] kobject: 'gpio-sim.0' (00000000f462f78a): calling ktype release
[ 4822.036198] kobject: 'gpio-sim.0': free name
[ 4822.036202] kobject: 'gpiochip589' (000000007e1cf13a): kobject_cleanup, parent 0000000000000000
[ 4822.036204] kobject: 'gpiochip589' (000000007e1cf13a): calling ktype release
[ 4822.036206] kobject: 'gpiochip589': free name
[ 4822.068252] kobject: 'gpiochip597' (00000000a32f70da): kobject_cleanup, parent 0000000000000000
[ 4822.068258] kobject: 'gpiochip597' (00000000a32f70da): calling ktype release
[ 4822.068265] kobject: 'gpiochip597': free name
[ 4822.384245] kobject: 'gpiochip1' (00000000c6873be9): kobject_release, parent 0000000000000000 (delayed 500)
[ 4822.384248] kobject: 'gpiochip513' (00000000307a0461): kobject_cleanup, parent 0000000000000000
[ 4822.384250] kobject: 'gpiochip513' (00000000307a0461): calling ktype release
[ 4822.384271] kobject: 'gpiochip513': free name
[ 4822.384286] kobject: 'gpio-sim.0' (00000000401b009a): kobject_cleanup, parent 0000000000000000
[ 4822.384288] kobject: 'gpio-sim.0' (00000000401b009a): calling ktype release
[ 4822.384294] kobject: 'gpio-sim.0': free name
[ 4822.384297] kobject: 'gpiochip514' (000000008e860d8b): kobject_cleanup, parent 0000000000000000
[ 4822.384298] kobject: 'gpiochip514' (000000008e860d8b): calling ktype release
[ 4822.384302] kobject: 'gpiochip514': free name
[ 4822.384304] kobject: 'gpiochip2' (0000000034808fa5): kobject_cleanup, parent 0000000000000000
[ 4822.384305] kobject: 'gpiochip2' (0000000034808fa5): calling ktype release
[ 4822.384312] kobject: 'gpiochip2': free name
[ 4822.416325] kobject: 'gpiochip3' (00000000f89849bd): kobject_cleanup, parent 0000000000000000
[ 4822.416331] kobject: 'gpiochip3' (00000000f89849bd): calling ktype release
[ 4822.416344] kobject: 'gpiochip3': free name
[ 4822.452250] kobject: 'gpiochip4' (00000000e06680f5): kobject_cleanup, parent 0000000000000000
[ 4822.452256] kobject: 'gpiochip4' (00000000e06680f5): calling ktype release
[ 4822.452265] kobject: 'gpiochip4': free name
[ 4822.548316] kobject: 'gpiochip7' (000000006b8d9c99): kobject_cleanup, parent 0000000000000000
[ 4822.548322] kobject: 'gpiochip7' (000000006b8d9c99): calling ktype release
[ 4822.548350] kobject: 'gpiochip7': free name
[ 4822.608239] kobject: 'gpiochip8' (00000000cb0b3463): kobject_cleanup, parent 0000000000000000
[ 4822.608260] kobject: 'gpiochip8' (00000000cb0b3463): calling ktype release
[ 4822.608275] kobject: 'gpiochip8': free name
[ 4822.640315] kobject: 'gpiochip554' (00000000e0038afb): kobject_cleanup, parent 0000000000000000
[ 4822.640339] kobject: 'gpiochip554' (00000000e0038afb): calling ktype release
[ 4822.640343] kobject: 'gpio' (00000000e467cb12): kobject_cleanup, parent 0000000000000000
[ 4822.640346] kobject: 'gpiochip554': free name
[ 4822.640348] kobject: 'gpio' (00000000e467cb12): calling ktype release
[ 4822.640349] kobject: 'gpio-sim.1' (0000000018f833bf): kobject_cleanup, parent 0000000000000000
[ 4822.640351] kobject: 'gpio-sim.1' (0000000018f833bf): calling ktype release
[ 4822.640354] kobject: 'gpio': free name
[ 4822.640360] kobject: 'gpio-sim.1': free name
[ 4822.640408] kobject: 'gpio-sim.2' (00000000bbfd5238): kobject_cleanup, parent 0000000000000000
[ 4822.640410] kobject: 'gpio-sim.2' (00000000bbfd5238): calling ktype release
[ 4822.640416] kobject: 'gpio-sim.2': free name
[ 4822.644186] kobject: 'gpio-sim.0' (00000000461517ae): kobject_cleanup, parent 0000000000000000
[ 4822.644192] kobject: 'gpio-sim.0' (00000000461517ae): calling ktype release
[ 4822.644198] kobject: 'gpio-sim.0': free name
[ 4822.644266] kobject: 'gpio-sim.0' (00000000bb358104): kobject_cleanup, parent 0000000000000000
[ 4822.644268] kobject: 'gpio-sim.0' (00000000bb358104): calling ktype release
[ 4822.644272] kobject: 'gpio-sim.0': free name
[ 4822.896320] kobject: 'gpiochip572' (00000000178509ff): kobject_cleanup, parent 0000000000000000
[ 4822.896326] kobject: 'gpiochip572' (00000000178509ff): calling ktype release
[ 4822.896334] kobject: 'gpiochip572': free name
[ 4822.896337] kobject: 'gpio-sim.0' (000000005418b2af): kobject_cleanup, parent 0000000000000000
[ 4822.896339] kobject: 'gpio-sim.0' (000000005418b2af): calling ktype release
[ 4822.896343] kobject: 'gpio-sim.0': free name
[ 4822.900449] kobject: 'gpiochip564' (00000000ee87da7b): kobject_cleanup, parent 0000000000000000
[ 4822.900455] kobject: 'gpiochip564' (00000000ee87da7b): calling ktype release
[ 4822.900461] kobject: 'gpiochip17' (000000006ee06561): kobject_release, parent 0000000000000000 (delayed 750)
[ 4822.900463] kobject: 'gpiochip564': free name
[ 4822.900524] kobject: 'gpiochip13' (00000000dc27f1aa): kobject_release, parent 0000000000000000 (delayed 250)
[ 4823.152251] kobject: 'gpio' (0000000064e73453): kobject_cleanup, parent 0000000000000000
[ 4823.152257] kobject: 'gpio' (0000000064e73453): calling ktype release
[ 4823.152260] kobject: 'gpio': free name
[ 4823.156258] kobject: 'gpio' (000000001bd064f6): kobject_cleanup, parent 0000000000000000
[ 4823.156277] kobject: 'gpio' (000000001bd064f6): calling ktype release
[ 4823.156307] kobject: 'gpio': free name
[ 4823.408426] kobject: 'gpio-sim.0' (000000007cf5eda9): kobject_cleanup, parent 0000000000000000
[ 4823.408433] kobject: 'gpio-sim.0' (000000007cf5eda9): calling ktype release
[ 4823.408433] kobject: 'gpiochip531' (00000000ad4538e8): kobject_cleanup, parent 0000000000000000
[ 4823.408436] kobject: 'gpiochip531' (00000000ad4538e8): calling ktype release
[ 4823.408444] kobject: 'gpio-sim.0': free name
[ 4823.408452] kobject: 'gpiochip531': free name
[ 4823.408456] kobject: 'gpio-sim.0' (00000000ca4e28ab): kobject_cleanup, parent 0000000000000000
[ 4823.408459] kobject: 'gpio-sim.0' (00000000ca4e28ab): calling ktype release
[ 4823.408467] kobject: 'gpio-sim.0': free name
[ 4823.408476] kobject: 'gpiochip0' (000000007063b679): kobject_release, parent 0000000000000000 (delayed 250)
[ 4823.408523] kobject: 'gpio' (00000000a1399cd0): kobject_cleanup, parent 0000000000000000
[ 4823.408525] kobject: 'gpio' (00000000a1399cd0): calling ktype release
[ 4823.408533] kobject: 'gpio': free name
[ 4823.664421] kobject: 'gpio-sim.0' (00000000e8c2899c): kobject_cleanup, parent 0000000000000000
[ 4823.664426] kobject: 'gpio-sim.0' (00000000e8c2899c): calling ktype release
[ 4823.664450] kobject: 'gpio-sim.0': free name
[ 4823.664516] kobject: 'gpiochip10' (00000000e3becc55): kobject_release, parent 0000000000000000 (delayed 500)
[ 4823.664524] kobject: 'gpiochip552' (000000001750e50f): kobject_cleanup, parent 0000000000000000
[ 4823.664526] kobject: 'gpiochip552' (000000001750e50f): calling ktype release
[ 4823.664530] kobject: 'gpiochip552': free name
[ 4823.664533] kobject: 'gpio' (00000000176df109): kobject_cleanup, parent 0000000000000000
[ 4823.664535] kobject: 'gpio' (00000000176df109): calling ktype release
[ 4823.664538] kobject: 'gpio': free name
[ 4823.664556] kobject: 'gpiochip6' (00000000a22546a6): kobject_release, parent 0000000000000000 (delayed 250)
[ 4823.664558] kobject: 'gpiochip533' (000000003541481f): kobject_cleanup, parent 0000000000000000
[ 4823.664560] kobject: 'gpiochip533' (000000003541481f): calling ktype release
[ 4823.664564] kobject: 'gpiochip533': free name
[ 4823.924314] kobject: 'gpiochip588' (0000000075b76b85): kobject_cleanup, parent 0000000000000000
[ 4823.924334] kobject: 'gpiochip588' (0000000075b76b85): calling ktype release
[ 4823.924340] kobject: 'gpiochip588': free name
[ 4823.924344] kobject: 'gpiochip13' (00000000dc27f1aa): kobject_cleanup, parent 0000000000000000
[ 4823.924346] kobject: 'gpiochip13' (00000000dc27f1aa): calling ktype release
[ 4823.924354] kobject: 'gpiochip13': free name
[ 4823.924371] kobject: 'gpiochip16' (000000002be607c1): kobject_release, parent 0000000000000000 (delayed 250)
[ 4824.176336] kobject: 'gpiochip18' (00000000a8ca1f8c): kobject_release, parent 0000000000000000 (delayed 250)
[ 4824.176381] kobject: 'gpiochip19' (000000008385ae47): kobject_release, parent 0000000000000000 (delayed 250)
[ 4824.400258] kobject: 'gpiochip1' (00000000c6873be9): kobject_cleanup, parent 0000000000000000
[ 4824.400264] kobject: 'gpiochip1' (00000000c6873be9): calling ktype release
[ 4824.400276] kobject: 'gpiochip1': free name
[ 4824.432259] kobject: 'gpiochip0' (000000007063b679): kobject_cleanup, parent 0000000000000000
[ 4824.432266] kobject: 'gpiochip0' (000000007063b679): calling ktype release
[ 4824.432278] kobject: 'gpiochip0': free name
[ 4824.688241] kobject: 'gpiochip5' (000000004ef2dca6): kobject_cleanup, parent 0000000000000000
[ 4824.688248] kobject: 'gpiochip5' (000000004ef2dca6): calling ktype release
[ 4824.688261] kobject: 'gpiochip5': free name
[ 4824.692227] kobject: 'gpiochip11' (00000000b39a3c5f): kobject_cleanup, parent 0000000000000000
[ 4824.692246] kobject: 'gpiochip11' (00000000b39a3c5f): calling ktype release
[ 4824.692278] kobject: 'gpiochip11': free name
[ 4824.692290] kobject: 'gpiochip6' (00000000a22546a6): kobject_cleanup, parent 0000000000000000
[ 4824.692317] kobject: 'gpiochip6' (00000000a22546a6): calling ktype release
[ 4824.692338] kobject: 'gpiochip6': free name
[ 4824.948242] kobject: 'gpiochip15' (00000000b0535d8d): kobject_cleanup, parent 0000000000000000
[ 4824.948247] kobject: 'gpiochip15' (00000000b0535d8d): calling ktype release
[ 4824.948251] kobject: 'gpiochip16' (000000002be607c1): kobject_cleanup, parent 0000000000000000
[ 4824.948255] kobject: 'gpiochip16' (000000002be607c1): calling ktype release
[ 4824.948259] kobject: 'gpiochip15': free name
[ 4824.948272] kobject: 'gpiochip16': free name
[ 4825.200324] kobject: 'gpiochip18' (00000000a8ca1f8c): kobject_cleanup, parent 0000000000000000
[ 4825.200330] kobject: 'gpiochip18' (00000000a8ca1f8c): calling ktype release
[ 4825.200343] kobject: 'gpiochip18': free name
[ 4825.204318] kobject: 'gpiochip19' (000000008385ae47): kobject_cleanup, parent 0000000000000000
[ 4825.204325] kobject: 'gpiochip19' (000000008385ae47): calling ktype release
[ 4825.204340] kobject: 'gpiochip19': free name
[ 4825.680450] kobject: 'gpiochip10' (00000000e3becc55): kobject_cleanup, parent 0000000000000000
[ 4825.680470] kobject: 'gpiochip10' (00000000e3becc55): calling ktype release
[ 4825.680488] kobject: 'gpiochip10': free name
[ 4825.716394] kobject: 'gpiochip9' (00000000bdaa0a47): kobject_cleanup, parent 0000000000000000
[ 4825.716396] kobject: 'gpiochip9' (00000000bdaa0a47): calling ktype release
[ 4825.716405] kobject: 'gpiochip9': free name
[ 4825.968324] kobject: 'gpiochip17' (000000006ee06561): kobject_cleanup, parent 0000000000000000
[ 4825.968331] kobject: 'gpiochip17' (000000006ee06561): calling ktype release
[ 4825.968360] kobject: 'gpiochip17': free name
[ 4825.968363] kobject: 'gpiochip14' (0000000092a079b6): kobject_cleanup, parent 0000000000000000
[ 4825.968367] kobject: 'gpiochip14' (0000000092a079b6): calling ktype release
[ 4825.968377] kobject: 'gpiochip14': free name
[ 4830.764748] kobject: 'gpio-sim' (000000005b8d0726): kobject_release, parent 000000007425b13f (delayed 750)
[ 4833.908238] kobject: 'gpio-sim' (000000005b8d0726): kobject_cleanup, parent 000000007425b13f
[ 4833.908244] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup kobject_del
[ 4833.908245] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup 'remove' event
[ 4833.908247] kobject: 'gpio-sim' (000000005b8d0726): kobject_uevent_env
[ 4833.908273] kobject: 'gpio-sim' (000000005b8d0726): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
[ 4833.908311] kobject: 'gpio-sim' (000000005b8d0726): calling ktype release
[ 4833.908315] kobject: 'gpio-sim': free name
[ 4834.932303] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_release, parent 0000000093357d30 (delayed 250)
[ 4835.952388] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_cleanup, parent 0000000093357d30
[ 4835.952413] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup kobject_del
[ 4835.952415] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup 'remove' event
[ 4835.952416] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_uevent_env
[ 4835.952424] kobject: 'gpio_sim' (0000000096ea0bb1): fill_kobj_path: path = '/module/gpio_sim'
[ 4835.952445] kobject: 'gpio_sim' (0000000096ea0bb1): calling ktype release
[ 4835.952448] kobject: 'gpio_sim': free name


>>>>> Or maybe the chip->gc.parent should be changed to something else (actual GPIO
>>>>> device, but then it's unclear how to provide the attributes in non-racy way
>>>> Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
>>>>
>>>> I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
>>>> device expert nor would be appropriate to try the craft not earned ;-)

With all of these additional debugging, cat /sys/kernel/debug/kmemleak
showed nothing new.

I believe this is reasonably safe.

However, I was unsuccessful in seeing gpio trace, even with
echo 1 > /sys/kernel/tracing/events/gpio/enable ... :-/

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
