Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FCD697A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBOKxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjBOKxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:53:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0462322A16;
        Wed, 15 Feb 2023 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676458401; x=1707994401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Dz7qTQziXwrfsDUDgdkso8uA0wQrPUvUfUJ8wN7mJoA=;
  b=Rn6abKYyrNr3vVq4alF/gS2dJSXDeqqsz8HPFGAK9DJxfa1w2CqoeI7o
   XtOABfnVsPSeZnpV8kMD0we9mqhl+Nor3JER/NTAZuT02LI0lhFNoIL1O
   96c3muaUM22T29mSwCWS7C3kLOtJYGS2FM+h254g+77GVmmBNfGBMNlvX
   d+Flh9hbbxJrgeDHr8lpxXQKjNCp8EX3jPTswCYPBREjqZ3PlPqtH1zRm
   vvYPEcNvtvoFAFzr5xbeg9cBtFxqGiPi/LNpi+juQDXrN6UJ5oZtktiL0
   EU6b0fDV4BEVmVW+mY4xH9naLLkULQKBTbIUKJURFkUDMy6gvwpkBh2F7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358820665"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="358820665"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 02:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="647123548"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="647123548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2023 02:53:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pSFPZ-007DcJ-28;
        Wed, 15 Feb 2023 12:53:17 +0200
Date:   Wed, 15 Feb 2023 12:53:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
Message-ID: <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
References: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
 <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr>
 <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
 <36d8e761-58e2-2515-fd1a-65a11731d1b1@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36d8e761-58e2-2515-fd1a-65a11731d1b1@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 07:19:16PM +0100, Mirsad Goran Todorovac wrote:
> On 12. 02. 2023. 15:19, Andy Shevchenko wrote:
> > On Wed, Feb 08, 2023 at 08:55:24PM +0100, Mirsad Goran Todorovac wrote:
> >> On 31. 01. 2023. 10:36, Mirsad Goran Todorovac wrote:
> >>> I came across this memory leak apparently in the GPIO device driver.
> >>> It is still present in 6.2-rc6 release candidate kernel (just ran kselftest).
> >>>
> >>> This is a vanilla Torvalds tree kernel with MGLRU and KMEMLEAK (obviously)
> >>> enabled.
> >>>
> >>> If you think this bug is significant, I can attempt the bug bisect in the
> >>> environment that triggered it (Lenovo LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
> >>> with BIOS M22KT49A from 11/10/2022 and AlmaLinux 8.7.
> >>>
> >>> Here is the /sys/kernel/debug/kmemleak output:
> >>>
> >>> unreferenced object 0xffff9e67ad71f160 (size 32):
> >>>   comm "gpio-sim.sh", pid 208926, jiffies 4372229685 (age 2101.564s)
> >>>   hex dump (first 32 bytes):
> >>>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
> >>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>>   backtrace:
> >>>     [<0000000098bf3d1b>] slab_post_alloc_hook+0x91/0x320
> >>>     [<00000000da3205c5>] __kmem_cache_alloc_node+0x1bf/0x2b0
> >>>     [<00000000aa51a58a>] __kmalloc_node_track_caller+0x55/0x140
> >>>     [<00000000bd682ecc>] kvasprintf+0x6b/0xd0
> >>>     [<00000000a3431d55>] kasprintf+0x4e/0x70
> >>>     [<00000000f52d2629>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
> >>>     [<00000000673fc6df>] configfs_write_iter+0xcc/0x130
> >>>     [<000000001d5d0829>] vfs_write+0x2b4/0x3d0
> >>>     [<00000000d2336251>] ksys_write+0x61/0xe0
> >>>     [<00000000f7015bb1>] __x64_sys_write+0x1a/0x20
> >>>     [<000000008ac743d2>] do_syscall_64+0x58/0x80
> >>>     [<000000004d7b7d50>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

> Sorry, but unfortunately this patch didn't fix the memleak. Please see the result:

Thank you for give a try!

Yeah, that's why I put that I'm skeptical, because while patch is correct per
se it wouldn't prevent the initial leakage (it seems it happens due to other
circumstances).

> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# echo clear > /sys/kernel/debug/kmemleak
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# time ./gpio-sim.sh
> trap: SIGTERM: bad trap
> 1. chip_name and dev_name attributes
> 1.1. Chip name is communicated to user
> 1.2. chip_name returns 'none' if the chip is still pending
> 1.3. Device name is communicated to user
> 2. Creating and configuring simulated chips
> 2.1. Default number of lines is 1
> 2.2. Number of lines can be specified
> 2.3. Label can be set
> 2.4. Label can be left empty
> 2.5. Line names can be configured
> 2.6. Line config can remain unused if offset is greater than number of lines
> 2.7. Line configfs directory names are sanitized
> 2.8. Multiple chips can be created
> 2.9. Can't modify settings when chip is live
> 2.10. Can't create line items when chip is live
> 2.11. Probe errors are propagated to user-space
> 2.12. Cannot enable a chip without any GPIO banks
> 2.13. Duplicate chip labels are not allowed
> 2.14. Lines can be hogged
> 3. Controlling simulated chips
> 3.1. Pull can be set over sysfs
> 3.2. Pull can be read from sysfs
> 3.3. Incorrect input in sysfs is rejected
> 3.4. Can't write to value
> 4. Simulated GPIO chips are functional
> 4.1. Values can be read from sysfs
> 4.2. Bias settings work correctly
> GPIO gpio-sim test PASS
> 
> real	0m1.120s
> user	0m0.283s
> sys	0m0.842s
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# echo scan > /sys/kernel/debug/kmemleak
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# cat /sys/kernel/debug/kmemleak 
> unreferenced object 0xffff91f019219660 (size 32):
>   comm "gpio-sim.sh", pid 11223, jiffies 4295028142 (age 87.304s)
>   hex dump (first 32 bytes):
>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff86fcd408>] __kmem_cache_alloc_node+0x1d8/0x330
>     [<ffffffff86f4c271>] __kmalloc_node_track_caller+0x51/0xd0
>     [<ffffffff872fb359>] kvasprintf+0x69/0xd0
>     [<ffffffff872fb4ce>] kasprintf+0x4e/0x70
>     [<ffffffffc1864553>] gpio_sim_device_config_live_store+0x483/0x6b5 [gpio_sim]
>     [<ffffffff870dde9c>] configfs_write_iter+0xcc/0x130
>     [<ffffffff87016869>] vfs_write+0x1f9/0x3b0
>     [<ffffffff87016dab>] ksys_write+0x6b/0xf0
>     [<ffffffff87016e59>] __x64_sys_write+0x19/0x20
>     [<ffffffff87b91188>] do_syscall_64+0x58/0x80
>     [<ffffffff87c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# uname -rms
> Linux 6.2.0-rc8-lru-km-andy-00015-gf6feea56f66d-dirty x86_64
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio# 
> 
> I can verify that I build the right patch:
> 
> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds$ git diff
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 60514bc5454f..7f79e49b23d7 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -954,9 +954,9 @@ static void gpio_sim_device_deactivate_unlocked(struct gpio_sim_device *dev)
>  
>         swnode = dev_fwnode(&dev->pdev->dev);
>         platform_device_unregister(dev->pdev);
> +       gpio_sim_remove_hogs(dev);
>         gpio_sim_remove_swnode_recursive(swnode);
>         dev->pdev = NULL;
> -       gpio_sim_remove_hogs(dev);
>  }
>  
>  static ssize_t
> marvin@marvin-IdeaPad-3-15ITL6:~/linux/kernel/linux_torvalds$ 
> 
> Alternatively, I could try to bisect if you think it's prudent to try that.
> But first I need a stroll after this kernel build :-)
> 
> Do you think that knowing when the bug was introduced might help find the culprit?

-- 
With Best Regards,
Andy Shevchenko


