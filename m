Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6660869CBA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjBTNKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjBTNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:10:15 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1091BACE;
        Mon, 20 Feb 2023 05:10:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 93333604EF;
        Mon, 20 Feb 2023 14:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676898607; bh=FyfE4tC8igUAfJ1WM6T/uJcadwtKyIM2Fa8rlhGlW7I=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=FLefrpxYIM2tKQpynJjVT/hXJdjA+3lyXSl7PQcBQuU5EaE+rqZHtgIqExoeI/Iop
         bYexzKfrZ4SnBCO+sQRzk7kabMq+d+xVJQAYR0Wp2/giR/wdmwjNuSFO9tkjXGZuWS
         Lz81C2gnRm/uu1SLrD+r17NWluX41/UcheXnQ5PMpwnOctP1YP/IHBYk6DhWwcv3YB
         uonnm3aMC6FVhe/PN8OeWvCtAGw3Y817YQOelFU/qIbPlxgGkO/60FeBaYjkK2Zcvd
         Q4I8ItyP81VT3P4zG2blwSRAM9rAh/uJ9rHJc5OaMTZ2a5FUZ2O291b3y1dYQpkMs2
         0O1S8E3eveCNQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lar5yJAwrTsd; Mon, 20 Feb 2023 14:10:05 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 5CF39604ED;
        Mon, 20 Feb 2023 14:10:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676898605; bh=FyfE4tC8igUAfJ1WM6T/uJcadwtKyIM2Fa8rlhGlW7I=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=OS40+tMxcrx2gvmZ6zDlRkWQ206Trl+AjMK/K14nYCd+vsQ7RTefzVelXJ16m3l2N
         8eHs+htfFIH0iORelg3KqCrVrOaCbcJHg5kOpnbYPVTlWvc9VQLatdR5870e8tbG5V
         K/QhK9w5rhO7t7Ax3k6ZtwMf936QGwoW6ei049nvCGDxzlNRCSUUdiKHAoTzcss6r4
         NYrony976GdQ+nyq7dwP406w1Cb/S3M7YqgELgG0KqMo7etShx8tkMllZI2LValrN5
         igeJFV5xzbMIDQFU7JKTZAsB20VUNEPw5EuRmU8LiC9vdh17vDR/kz02rskvuhOdMN
         k9qGCVRTr/CNQ==
Message-ID: <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr>
Date:   Mon, 20 Feb 2023 14:10:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-gpio@vger.kernel.org,
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
Content-Language: en-US, hr
In-Reply-To: <CAMRc=Mcx=Ko5H_c1YGzA5Jfu3KJqx1pfL3RZuMrV6oTObnUrhQ@mail.gmail.com>
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

On 2/16/23 15:16, Bartosz Golaszewski wrote:
> On Wed, Feb 15, 2023 at 3:45 PM Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> On 15.2.2023. 11:53, Andy Shevchenko wrote:
>>> On Tue, Feb 14, 2023 at 07:19:16PM +0100, Mirsad Goran Todorovac wrote:
>>>> On 12. 02. 2023. 15:19, Andy Shevchenko wrote:
>>>>> On Wed, Feb 08, 2023 at 08:55:24PM +0100, Mirsad Goran Todorovac wrote:
>>>>>> On 31. 01. 2023. 10:36, Mirsad Goran Todorovac wrote:
>>>>>>> I came across this memory leak apparently in the GPIO device driver.
>>>>>>> It is still present in 6.2-rc6 release candidate kernel (just ran kselftest).
>>>>>>>
>>>>>>> This is a vanilla Torvalds tree kernel with MGLRU and KMEMLEAK (obviously)
>>>>>>> enabled.
>>>>>>>
>>>>>>> If you think this bug is significant, I can attempt the bug bisect in the
>>>>>>> environment that triggered it (Lenovo LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
>>>>>>> with BIOS M22KT49A from 11/10/2022 and AlmaLinux 8.7.
>>>>>>>
>>>>>>> Here is the /sys/kernel/debug/kmemleak output:
>>>>>>>
>>>>>>> unreferenced object 0xffff9e67ad71f160 (size 32):
>>>>>>>     comm "gpio-sim.sh", pid 208926, jiffies 4372229685 (age 2101.564s)
>>>>>>>     hex dump (first 32 bytes):
>>>>>>>       67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>>>>>>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>>>     backtrace:
>>>>>>>       [<0000000098bf3d1b>] slab_post_alloc_hook+0x91/0x320
>>>>>>>       [<00000000da3205c5>] __kmem_cache_alloc_node+0x1bf/0x2b0
>>>>>>>       [<00000000aa51a58a>] __kmalloc_node_track_caller+0x55/0x140
>>>>>>>       [<00000000bd682ecc>] kvasprintf+0x6b/0xd0
>>>>>>>       [<00000000a3431d55>] kasprintf+0x4e/0x70
>>>>>>>       [<00000000f52d2629>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>>>>>>>       [<00000000673fc6df>] configfs_write_iter+0xcc/0x130
>>>>>>>       [<000000001d5d0829>] vfs_write+0x2b4/0x3d0
>>>>>>>       [<00000000d2336251>] ksys_write+0x61/0xe0
>>>>>>>       [<00000000f7015bb1>] __x64_sys_write+0x1a/0x20
>>>>>>>       [<000000008ac743d2>] do_syscall_64+0x58/0x80
>>>>>>>       [<000000004d7b7d50>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>>> Sorry, but unfortunately this patch didn't fix the memleak. Please see the result:
>>>
>>> Thank you for give a try!
>>
>> No sweat. It was worth the effort.
>>
>>> Yeah, that's why I put that I'm skeptical, because while patch is correct per
>>> se it wouldn't prevent the initial leakage (it seems it happens due to other
>>> circumstances).
>>
>> I must admit that is looks like hieroglyphs to me. My learning curve had not
>> yet reached that point of debugging memory leaks in the kernel drivers ...
>>
>>>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# echo clear > /sys/kernel/debug/kmemleak
>>>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# time ./gpio-sim.sh
>>>> trap: SIGTERM: bad trap
>>>> 1. chip_name and dev_name attributes
>>>> 1.1. Chip name is communicated to user
>>>> 1.2. chip_name returns 'none' if the chip is still pending
>>>> 1.3. Device name is communicated to user
>>>> 2. Creating and configuring simulated chips
>>>> 2.1. Default number of lines is 1
>>>> 2.2. Number of lines can be specified
>>>> 2.3. Label can be set
>>>> 2.4. Label can be left empty
>>>> 2.5. Line names can be configured
>>>> 2.6. Line config can remain unused if offset is greater than number of lines
>>>> 2.7. Line configfs directory names are sanitized
>>>> 2.8. Multiple chips can be created
>>>> 2.9. Can't modify settings when chip is live
>>>> 2.10. Can't create line items when chip is live
>>>> 2.11. Probe errors are propagated to user-space
>>>> 2.12. Cannot enable a chip without any GPIO banks
>>>> 2.13. Duplicate chip labels are not allowed
>>>> 2.14. Lines can be hogged
>>>> 3. Controlling simulated chips
>>>> 3.1. Pull can be set over sysfs
>>>> 3.2. Pull can be read from sysfs
>>>> 3.3. Incorrect input in sysfs is rejected
>>>> 3.4. Can't write to value
>>>> 4. Simulated GPIO chips are functional
>>>> 4.1. Values can be read from sysfs
>>>> 4.2. Bias settings work correctly
>>>> GPIO gpio-sim test PASS
>>>>
>>>> real 0m1.120s
>>>> user 0m0.283s
>>>> sys  0m0.842s
>>>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# echo scan > /sys/kernel/debug/kmemleak
>>>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# cat /sys/kernel/debug/kmemleak
>>>> unreferenced object 0xffff91f019219660 (size 32):
>>>>     comm "gpio-sim.sh", pid 11223, jiffies 4295028142 (age 87.304s)
>>>>     hex dump (first 32 bytes):
>>>>       67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>>>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>     backtrace:
>>>>       [<ffffffff86fcd408>] __kmem_cache_alloc_node+0x1d8/0x330
>>>>       [<ffffffff86f4c271>] __kmalloc_node_track_caller+0x51/0xd0
>>>>       [<ffffffff872fb359>] kvasprintf+0x69/0xd0
>>>>       [<ffffffff872fb4ce>] kasprintf+0x4e/0x70
>>>>       [<ffffffffc1864553>] gpio_sim_device_config_live_store+0x483/0x6b5 [gpio_sim]
>>>>       [<ffffffff870dde9c>] configfs_write_iter+0xcc/0x130
>>>>       [<ffffffff87016869>] vfs_write+0x1f9/0x3b0
>>>>       [<ffffffff87016dab>] ksys_write+0x6b/0xf0
>>>>       [<ffffffff87016e59>] __x64_sys_write+0x19/0x20
>>>>       [<ffffffff87b91188>] do_syscall_64+0x58/0x80
>>>>       [<ffffffff87c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# uname -rms
>>>> Linux 6.2.0-rc8-lru-km-andy-00015-gf6feea56f66d-dirty x86_64
>>>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio#
>>>>
>>>> I can verify that I build the right patch:
>>>>
>>>> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds$ git diff
>>>> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
>>>> index 60514bc5454f..7f79e49b23d7 100644
>>>> --- a/drivers/gpio/gpio-sim.c
>>>> +++ b/drivers/gpio/gpio-sim.c
>>>> @@ -954,9 +954,9 @@ static void gpio_sim_device_deactivate_unlocked(struct gpio_sim_device *dev)
>>>>
>>>>           swnode = dev_fwnode(&dev->pdev->dev);
>>>>           platform_device_unregister(dev->pdev);
>>>> +       gpio_sim_remove_hogs(dev);
>>>>           gpio_sim_remove_swnode_recursive(swnode);
>>>>           dev->pdev = NULL;
>>>> -       gpio_sim_remove_hogs(dev);
>>>>    }
>>>>
>>>>    static ssize_t
>>>> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds$
>>>>
>>>> Alternatively, I could try to bisect if you think it's prudent to try that.
>>>> But first I need a stroll after this kernel build :-)
>>>>
>>>> Do you think that knowing when the bug was introduced might help find the culprit?

> Thanks for the report Mirsad, just sent out a fix.

Hi, Bart,

It is really nothing. The reproducer shows that the leak is apparently gone.

As Mr. McKenney once said, a bunch of monkeys with keyboard could
have done it in a considerable number of trials and errors ;-)

But here I have something that could potentially leak as well. I could not devise a
reproducer due to the leak being lightly triggered only in extreme memory contention.

See it for yourself:

drivers/gpio/gpio-sim.c:
  301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
  302 {
  303         struct device_attribute *val_dev_attr, *pull_dev_attr;
  304         struct gpio_sim_attribute *val_attr, *pull_attr;
  305         unsigned int num_lines = chip->gc.ngpio;
  306         struct device *dev = chip->gc.parent;
  307         struct attribute_group *attr_group;
  308         struct attribute **attrs;
  309         int i, ret;
  310
  311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
  312                                          num_lines + 1, GFP_KERNEL);
  313         if (!chip->attr_groups)
  314                 return -ENOMEM;
  315
  316         for (i = 0; i < num_lines; i++) {
  317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
  318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
  319                                      GFP_KERNEL);
  320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
  321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
  322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
  323                         return -ENOMEM;
  324
  325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
  326                                                   "sim_gpio%u", i);
  327                 if (!attr_group->name)
  328                         return -ENOMEM;

Apparently, if the memory allocation only partially succeeds, in the theoretical case
that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
free the partially succeeded allocs, would it?

To explain it better, I tried a version that is not yet full doing "all or nothing"
memory allocation for the gpio-sim driver, because I am not that familiar with the
driver internals.

I give this just as an illustration to what I mean to say (one line of code speaks
like thousand words):

301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
  302 {
  303         struct device_attribute *val_dev_attr, *pull_dev_attr;
  304         struct gpio_sim_attribute *val_attr, *pull_attr;
  305         unsigned int num_lines = chip->gc.ngpio;
  306         struct device *dev = chip->gc.parent;
  307         struct attribute_group *attr_group;
  308         struct attribute **attrs;
  309         int i, ret;
  310
  311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
  312                                          num_lines + 1, GFP_KERNEL);
  313         if (!chip->attr_groups)
  314                 return -ENOMEM;
  315
  316         for (i = 0; i < num_lines; i++) {
  317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
  318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
  319                                      GFP_KERNEL);
  320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
  321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
  322                 if (!attr_group || !attrs || !val_attr || !pull_attr) {
  323                         if (attr_group)
  324                                 devm_kfree(dev, attr_group);
  325                         if (attrs)
  326                                 devm_kfree(dev, attrs);
  327                         if (val_attr)
  328                                 devm_kfree(dev, val_attr);
  329                         if (pull_attr)
  330                                 devm_kfree(dev, pull_attr);
  331                         return -ENOMEM;
  332                 }
  333
  334                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
  335                                                   "sim_gpio%u", i);
  336                 if (!attr_group->name) {
  337                         devm_kfree(dev, attr_group);
  338                         devm_kfree(dev, attrs);
  339                         devm_kfree(dev, val_attr);
  340                         devm_kfree(dev, pull_attr);
  341                         return -ENOMEM;
  342                 }
  343
  344                 val_attr->offset = pull_attr->offset = i;

This is, of course, far from perfect, and it seems that the driver will still leak
memory in case of partially successful allocation because of the
for (i = 0; i < num_lines; i++) { ... } loop. :-/

I hope this makes any sense to you.

Thanks,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
