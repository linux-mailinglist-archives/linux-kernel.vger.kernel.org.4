Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3A1696EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBNUyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:54:28 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41799298CC;
        Tue, 14 Feb 2023 12:54:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 43115604F3;
        Tue, 14 Feb 2023 21:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676408063; bh=RT4I/OIHeNiAba1aSITMpBbq2CDX3h+SC/sKOSd/9Ik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YlJG5cT2jLM/HdM/BEIywNTY5pocxGpkIc933y4t0nLCH+ISrPcMoE4346wHTHOHA
         SkEO3w11ux3Z247Ab1Qrrxy/jUB6/yp8RYwhwQslw1UoqsKYG6L4IuGxskHxl/JrAn
         aEEOqFpOeQnocQ0+6k+/OrBcin3QvS/Ck4KEjYU/XSxh9H7Gj6mp87JbMxfK7n3OvL
         zyKbDqCNonb1Z+kQYiXzO1JcEA4eZqtxzYw1RjNCw2musENiUqWKMPDBkABBT3H+/Y
         klYr/nZP0g7itlsUSR81ss4yJF77En3Lfx2oMRI5uRA7Gyo6WbVDR2LoEqC/WHBJdc
         YSrw9XfWWeMxA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OpyqtGM7-WDS; Tue, 14 Feb 2023 21:54:12 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 2630F604ED;
        Tue, 14 Feb 2023 21:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1676408052; bh=RT4I/OIHeNiAba1aSITMpBbq2CDX3h+SC/sKOSd/9Ik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bIJgZmsH4n45WJ1PnwIDlyOpDxEVi6AApkh/Mi7H/P1nXYQOauOeyTNZe8K8g8te1
         2+fwsDq0BOu+wqwX0/x1ZF3AZXFclAwrq0jDHncHFHrqY6IyNJEY5LvG+RMnXXa6ie
         6MkEv4P6Ni9j8/orHjRRT64XoeYLtdtqhvxnAGvE1sC85DNlUTmLtcIzx7FYRG30tZ
         5c1rlfpzYRK0S5xJNCN19A/jByYanU22y9jrgOGC2wt7P7wuokWC220BnHAZpKV2Be
         1YGAmbLiY7WGm4pWvk8mXNzRwWcbKpb+6LsmKETWG6TdhOkX2ARCMvxoeUc6Pb2JOS
         /z78pCDNab8tQ==
Message-ID: <f796c459-cfa0-7643-acd5-ae5638e213dc@alu.unizg.hr>
Date:   Tue, 14 Feb 2023 21:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: INFO: BISECTED: memory leak in gpio device in 6.2-rc6
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
 <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr>
 <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 2023. 15:19, Andy Shevchenko wrote:
> On Wed, Feb 08, 2023 at 08:55:24PM +0100, Mirsad Goran Todorovac wrote:
>> On 31. 01. 2023. 10:36, Mirsad Goran Todorovac wrote:
>>> I came across this memory leak apparently in the GPIO device driver.
>>> It is still present in 6.2-rc6 release candidate kernel (just ran kselftest).
>>>
>>> This is a vanilla Torvalds tree kernel with MGLRU and KMEMLEAK (obviously)
>>> enabled.
>>>
>>> If you think this bug is significant, I can attempt the bug bisect in the
>>> environment that triggered it (Lenovo LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
>>> with BIOS M22KT49A from 11/10/2022 and AlmaLinux 8.7.
>>>
>>> Here is the /sys/kernel/debug/kmemleak output:
>>>
>>> unreferenced object 0xffff9e67ad71f160 (size 32):
>>>   comm "gpio-sim.sh", pid 208926, jiffies 4372229685 (age 2101.564s)
>>>   hex dump (first 32 bytes):
>>>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>   backtrace:
>>>     [<0000000098bf3d1b>] slab_post_alloc_hook+0x91/0x320
>>>     [<00000000da3205c5>] __kmem_cache_alloc_node+0x1bf/0x2b0
>>>     [<00000000aa51a58a>] __kmalloc_node_track_caller+0x55/0x140
>>>     [<00000000bd682ecc>] kvasprintf+0x6b/0xd0
>>>     [<00000000a3431d55>] kasprintf+0x4e/0x70
>>>     [<00000000f52d2629>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>>>     [<00000000673fc6df>] configfs_write_iter+0xcc/0x130
>>>     [<000000001d5d0829>] vfs_write+0x2b4/0x3d0
>>>     [<00000000d2336251>] ksys_write+0x61/0xe0
>>>     [<00000000f7015bb1>] __x64_sys_write+0x1a/0x20
>>>     [<000000008ac743d2>] do_syscall_64+0x58/0x80
>>>     [<000000004d7b7d50>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> [root@pc-mtodorov marvin]#
>>
>> The new development on the bug is that it probably requires some superuser privileges
>> or some capability to be exploited, for it requires access to configfs,
>> but it was reproduced on different hardware as well.
>>
>> The minimum reproducing script is attached, with its output log.
>>
>> From the testing "age" of the unreferenced object I assume that it is allocated earlier
>> in a part of script I am unable to locate or specify, but orphaned at the end of the script.
>>
>> root@/home/user/kernel_bugs/gpio-sim# time ./gpio-reproduce-min.sh
>> 2.14. Lines can be hogged
>> Scanning stage 2.14.7 ... done.
>> Sleeping 60 seconds ... done.
>> Stage 2.14.7 clean.
>> Rescanning stage 2.14.7 ... done.
>> Sleeping 60 seconds ... done.
>> unreferenced object 0xffff9593b9d16bc0 (size 32):
>>   comm "gpio-reproduce-", pid 7594, jiffies 4295865460 (age 136.184s)
>>   hex dump (first 32 bytes):
>>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
>>     [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
>>     [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
>>     [<000000000c0f91cd>] kasprintf+0x4e/0x70
>>     [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>>     [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
>>     [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
>>     [<000000008a17e041>] ksys_write+0x61/0xe0
>>     [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
>>     [<00000000e1220148>] do_syscall_64+0x58/0x80
>>     [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> real	2m16.398s
>> user	0m0.023s
>> sys	0m16.360s
>> root@/home/user/kernel_bugs/gpio-sim# 
>>
>> The effect is cummulative:
>>
>> root@marvin-IdeaPad-3-15ITL6:/home/user/kernel_bugs/gpio-sim# cat /sys/kernel/debug/kmemleak 
>> unreferenced object 0xffff9593b9d16bc0 (size 32):
>>   comm "gpio-reproduce-", pid 7594, jiffies 4295865460 (age 520.296s)
>>   hex dump (first 32 bytes):
>>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
>>     [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
>>     [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
>>     [<000000000c0f91cd>] kasprintf+0x4e/0x70
>>     [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>>     [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
>>     [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
>>     [<000000008a17e041>] ksys_write+0x61/0xe0
>>     [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
>>     [<00000000e1220148>] do_syscall_64+0x58/0x80
>>     [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> unreferenced object 0xffff95938918fb40 (size 32):
>>   comm "gpio-reproduce-", pid 7675, jiffies 4295954327 (age 164.832s)
>>   hex dump (first 32 bytes):
>>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
>>     [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
>>     [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
>>     [<000000000c0f91cd>] kasprintf+0x4e/0x70
>>     [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>>     [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
>>     [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
>>     [<000000008a17e041>] ksys_write+0x61/0xe0
>>     [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
>>     [<00000000e1220148>] do_syscall_64+0x58/0x80
>>     [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> unreferenced object 0xffff9594a3cf1820 (size 32):
>>   comm "gpio-reproduce-", pid 7721, jiffies 4295976853 (age 74.728s)
>>   hex dump (first 32 bytes):
>>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
>>     [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
>>     [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
>>     [<000000000c0f91cd>] kasprintf+0x4e/0x70
>>     [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>>     [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
>>     [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
>>     [<000000008a17e041>] ksys_write+0x61/0xe0
>>     [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
>>     [<00000000e1220148>] do_syscall_64+0x58/0x80
>>     [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> root@marvin-IdeaPad-3-15ITL6:/home/user/kernel_bugs/gpio-sim# 
>>
>> With sufficient privileges (or possibly even without them), an exploit can be devised
>> to automate allocation of orphaned objects, at a rate of a couple per second (PoC attached).
> 
> Looking into the code I found one inconsistency. It might be that that brings
> an issue, dunno. Can you try the patch below if it helps (but TBH I'm a bit
> sceptical)?
> 
>>From 499cfb52aa7de67a8bbb56ce183d9528b2376db0 Mon Sep 17 00:00:00 2001
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Sun, 12 Feb 2023 16:15:00 +0200
> Subject: [PATCH 1/1] gpio: sim: Deactivate device in reversed order
> 
> Run the steps to deactivate device in the reserved order to what
> it has been done in gpio_sim_device_activate_unlocked().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index a51b5ea38ad5..b0111d18808c 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -953,9 +953,9 @@ static void gpio_sim_device_deactivate_unlocked(struct gpio_sim_device *dev)
>  
>  	swnode = dev_fwnode(&dev->pdev->dev);
>  	platform_device_unregister(dev->pdev);
> +	gpio_sim_remove_hogs(dev);
>  	gpio_sim_remove_swnode_recursive(swnode);
>  	dev->pdev = NULL;
> -	gpio_sim_remove_hogs(dev);
>  }
>  
>  static ssize_t

P.S.

Hi, Andy,

Lucky or unlucky, bisect was rather quick: the gpio-sim module seems to appear in
the 5.17-rc1 kernel, and it seems that this first version is already "bad", that is,
leaking memory.

I have managed to automate the exploit to create cca. 330,000 leaks, but the kernel
did not crash yet, though much of the memory was used. But the leak is rather small,
32 bytes + overhead.

Here is the result of the run of tools/testing/selftests/gpio/gpio-sim.sh:

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# cat /sys/kernel/debug/kmemleak 
unreferenced object 0xffff9ed2ca929f40 (size 32):
  comm "gpio-sim.sh", pid 15074, jiffies 4294959639 (age 25.848s)
  hex dump (first 32 bytes):
    67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008ae1eb47>] slab_post_alloc_hook+0x80/0x2a0
    [<000000000d18725c>] __kmalloc_track_caller+0x118/0x290
    [<0000000031cbee97>] kvasprintf+0x66/0xd0
    [<00000000f315aa2a>] kasprintf+0x4e/0x70
    [<00000000a996121f>] gpio_sim_device_config_live_store+0x372/0x578 [gpio_sim]
    [<00000000fd890a9e>] configfs_write_iter+0xc8/0x130
    [<00000000e3ef7485>] new_sync_write+0x117/0x1b0
    [<000000006dc1f988>] vfs_write+0x1aa/0x290
    [<0000000027668ff9>] ksys_write+0x61/0xe0
    [<00000000ac7bd963>] __x64_sys_write+0x1a/0x20
    [<00000000ed9d842c>] do_syscall_64+0x58/0x80
    [<00000000c81cc832>] entry_SYSCALL_64_after_hwframe+0x44/0xae
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# uname -rms
Linux 5.17.0-rc1-mglru-kmlk-andy x86_64
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# 

Basically, this is the similar output to the one with 6.2-rc6 leak.

I hope this can help narrow down the culprit code.

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

