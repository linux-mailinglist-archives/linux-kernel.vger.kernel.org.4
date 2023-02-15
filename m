Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6238C697EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBOOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjBOOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:45:54 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD23314EAC;
        Wed, 15 Feb 2023 06:45:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id CABE3604F5;
        Wed, 15 Feb 2023 15:45:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676472346; bh=DVTzGNrkCiQTwMT5Ysz+09n835Tr5m9EboGbMHnHOvY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tMsnCiuVbaY3iOoJ3+oCoo3M3OpYsVKQ48Wlx6kVqhFP6xoQAYKkubtGVksTQFOnP
         n+a7bVnoEHvae18t8iOQNKPiyFWUGQqEVBEHB7rUnPCbpBSmT8CCl4sc0s+ii2RvDY
         mKSKORD5j2LwdAS9LsP6iTskHueqeVpZHeINLclF16nE43Ta/UMByg/9UH7vuWgH5l
         4IRMV0QGpDRdxQo38/bvedbjJ11n4WcXyDtU9GLWF36CJSr2Jd8gIR6k1ciGS+H47Y
         8u2g6tDxeBUAyi0zqKq3pVsquGL6/V/8SSgJFvYnnLJiT+BJVzd5A5fPzgsulqXLMW
         qEyhzd2siKtZA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wb8CD2ZVEB72; Wed, 15 Feb 2023 15:45:44 +0100 (CET)
Received: from [10.0.1.227] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id A9E48604E9;
        Wed, 15 Feb 2023 15:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676472344; bh=DVTzGNrkCiQTwMT5Ysz+09n835Tr5m9EboGbMHnHOvY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0sSL435qM3egCBXLSvab3v4TQK1Lodiw3J4zlWzJ+yalhnN3Isj/QxVTeo/nnd0bL
         UnJzkhyFbH6wr5WjTjiybU4G7Qe1xFjI6Hva2xNLGHrbVb1NlBEO1ChMLT27lqHgtp
         LzRMFblajbpC+7qtxZKKw2lmjD0cKaP85XQLy7xyaqiId/O9xRNjLJcc5VaDYnBYs/
         c6E6dUFTV1NEchRo7qrMyOVDGUzuREnz49atIbkrZOn+sXHH5c1fO0vaggoi5/ZZYU
         dc8WDiOdrChdE3RU2CCVCgKkdaZ8yRtMRl9U7/CMQ7tAvZNSSlv73ogMsDNRwdqTAW
         2f+oI/0X93kKQ==
Message-ID: <3d96e50b-ed17-9bf5-149b-8a50c7b4cca2@alu.unizg.hr>
Date:   Wed, 15 Feb 2023 15:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
 <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr>
 <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
 <36d8e761-58e2-2515-fd1a-65a11731d1b1@alu.unizg.hr>
 <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.2.2023. 11:53, Andy Shevchenko wrote:
> On Tue, Feb 14, 2023 at 07:19:16PM +0100, Mirsad Goran Todorovac wrote:
>> On 12. 02. 2023. 15:19, Andy Shevchenko wrote:
>>> On Wed, Feb 08, 2023 at 08:55:24PM +0100, Mirsad Goran Todorovac wrote:
>>>> On 31. 01. 2023. 10:36, Mirsad Goran Todorovac wrote:
>>>>> I came across this memory leak apparently in the GPIO device driver.
>>>>> It is still present in 6.2-rc6 release candidate kernel (just ran kselftest).
>>>>>
>>>>> This is a vanilla Torvalds tree kernel with MGLRU and KMEMLEAK (obviously)
>>>>> enabled.
>>>>>
>>>>> If you think this bug is significant, I can attempt the bug bisect in the
>>>>> environment that triggered it (Lenovo LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
>>>>> with BIOS M22KT49A from 11/10/2022 and AlmaLinux 8.7.
>>>>>
>>>>> Here is the /sys/kernel/debug/kmemleak output:
>>>>>
>>>>> unreferenced object 0xffff9e67ad71f160 (size 32):
>>>>>    comm "gpio-sim.sh", pid 208926, jiffies 4372229685 (age 2101.564s)
>>>>>    hex dump (first 32 bytes):
>>>>>      67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>>    backtrace:
>>>>>      [<0000000098bf3d1b>] slab_post_alloc_hook+0x91/0x320
>>>>>      [<00000000da3205c5>] __kmem_cache_alloc_node+0x1bf/0x2b0
>>>>>      [<00000000aa51a58a>] __kmalloc_node_track_caller+0x55/0x140
>>>>>      [<00000000bd682ecc>] kvasprintf+0x6b/0xd0
>>>>>      [<00000000a3431d55>] kasprintf+0x4e/0x70
>>>>>      [<00000000f52d2629>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>>>>>      [<00000000673fc6df>] configfs_write_iter+0xcc/0x130
>>>>>      [<000000001d5d0829>] vfs_write+0x2b4/0x3d0
>>>>>      [<00000000d2336251>] ksys_write+0x61/0xe0
>>>>>      [<00000000f7015bb1>] __x64_sys_write+0x1a/0x20
>>>>>      [<000000008ac743d2>] do_syscall_64+0x58/0x80
>>>>>      [<000000004d7b7d50>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
>> Sorry, but unfortunately this patch didn't fix the memleak. Please see the result:
> 
> Thank you for give a try!

No sweat. It was worth the effort.

> Yeah, that's why I put that I'm skeptical, because while patch is correct per
> se it wouldn't prevent the initial leakage (it seems it happens due to other
> circumstances).

I must admit that is looks like hieroglyphs to me. My learning curve had not
yet reached that point of debugging memory leaks in the kernel drivers ...

>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# echo clear > /sys/kernel/debug/kmemleak
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# time ./gpio-sim.sh
>> trap: SIGTERM: bad trap
>> 1. chip_name and dev_name attributes
>> 1.1. Chip name is communicated to user
>> 1.2. chip_name returns 'none' if the chip is still pending
>> 1.3. Device name is communicated to user
>> 2. Creating and configuring simulated chips
>> 2.1. Default number of lines is 1
>> 2.2. Number of lines can be specified
>> 2.3. Label can be set
>> 2.4. Label can be left empty
>> 2.5. Line names can be configured
>> 2.6. Line config can remain unused if offset is greater than number of lines
>> 2.7. Line configfs directory names are sanitized
>> 2.8. Multiple chips can be created
>> 2.9. Can't modify settings when chip is live
>> 2.10. Can't create line items when chip is live
>> 2.11. Probe errors are propagated to user-space
>> 2.12. Cannot enable a chip without any GPIO banks
>> 2.13. Duplicate chip labels are not allowed
>> 2.14. Lines can be hogged
>> 3. Controlling simulated chips
>> 3.1. Pull can be set over sysfs
>> 3.2. Pull can be read from sysfs
>> 3.3. Incorrect input in sysfs is rejected
>> 3.4. Can't write to value
>> 4. Simulated GPIO chips are functional
>> 4.1. Values can be read from sysfs
>> 4.2. Bias settings work correctly
>> GPIO gpio-sim test PASS
>>
>> real	0m1.120s
>> user	0m0.283s
>> sys	0m0.842s
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# echo scan > /sys/kernel/debug/kmemleak
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# cat /sys/kernel/debug/kmemleak
>> unreferenced object 0xffff91f019219660 (size 32):
>>    comm "gpio-sim.sh", pid 11223, jiffies 4295028142 (age 87.304s)
>>    hex dump (first 32 bytes):
>>      67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<ffffffff86fcd408>] __kmem_cache_alloc_node+0x1d8/0x330
>>      [<ffffffff86f4c271>] __kmalloc_node_track_caller+0x51/0xd0
>>      [<ffffffff872fb359>] kvasprintf+0x69/0xd0
>>      [<ffffffff872fb4ce>] kasprintf+0x4e/0x70
>>      [<ffffffffc1864553>] gpio_sim_device_config_live_store+0x483/0x6b5 [gpio_sim]
>>      [<ffffffff870dde9c>] configfs_write_iter+0xcc/0x130
>>      [<ffffffff87016869>] vfs_write+0x1f9/0x3b0
>>      [<ffffffff87016dab>] ksys_write+0x6b/0xf0
>>      [<ffffffff87016e59>] __x64_sys_write+0x19/0x20
>>      [<ffffffff87b91188>] do_syscall_64+0x58/0x80
>>      [<ffffffff87c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# uname -rms
>> Linux 6.2.0-rc8-lru-km-andy-00015-gf6feea56f66d-dirty x86_64
>> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio#
>>
>> I can verify that I build the right patch:
>>
>> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds$ git diff
>> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
>> index 60514bc5454f..7f79e49b23d7 100644
>> --- a/drivers/gpio/gpio-sim.c
>> +++ b/drivers/gpio/gpio-sim.c
>> @@ -954,9 +954,9 @@ static void gpio_sim_device_deactivate_unlocked(struct gpio_sim_device *dev)
>>   
>>          swnode = dev_fwnode(&dev->pdev->dev);
>>          platform_device_unregister(dev->pdev);
>> +       gpio_sim_remove_hogs(dev);
>>          gpio_sim_remove_swnode_recursive(swnode);
>>          dev->pdev = NULL;
>> -       gpio_sim_remove_hogs(dev);
>>   }
>>   
>>   static ssize_t
>> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds$
>>
>> Alternatively, I could try to bisect if you think it's prudent to try that.
>> But first I need a stroll after this kernel build :-)
>>
>> Do you think that knowing when the bug was introduced might help find the culprit?
> 

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

