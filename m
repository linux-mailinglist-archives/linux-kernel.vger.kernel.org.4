Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F756937BB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBLOTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 09:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBLOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 09:19:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48865FF38;
        Sun, 12 Feb 2023 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676211578; x=1707747578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jwJ3Qkd4c5LG0elAtaBFKkHfWApWcKvA1eF+OMmsvtE=;
  b=eBkajW1+QoDFY1Cb699Q7pqD8II7yNqAGY/mfUfm38EyxE6FEeQW2wg7
   dMV5FDBUJOGsFyhX/7Zvrk6KZV/MUQ+A3Afo2rQCj1gMFFiVDnGWWnnAF
   wfP8kYuAq5nZGP4/mHswE11QY8Hg5JAWKGqpBzGYtPYuMqxDTPNrQvz2q
   prdDsATTZNCSmgrEQtSEKZaTzzKkD36JImvGbEMBi43+K+/dI/VIxhpzd
   10VpIpQ+rtN0YiKLvZoLZ1zSfJzl9baIlV1aXAoI70vDhmcikvnS+gSZ0
   oZ4T9AefUhcROLoNtgKVGYYESCLGfUI75NnHVqbbCbXYEqGZcQGeSRLIo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="329347909"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="329347909"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 06:19:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="646125900"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="646125900"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2023 06:19:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pRDCX-005tF9-33;
        Sun, 12 Feb 2023 16:19:33 +0200
Date:   Sun, 12 Feb 2023 16:19:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
Message-ID: <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
References: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
 <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:55:24PM +0100, Mirsad Goran Todorovac wrote:
> On 31. 01. 2023. 10:36, Mirsad Goran Todorovac wrote:
> > I came across this memory leak apparently in the GPIO device driver.
> > It is still present in 6.2-rc6 release candidate kernel (just ran kselftest).
> > 
> > This is a vanilla Torvalds tree kernel with MGLRU and KMEMLEAK (obviously)
> > enabled.
> > 
> > If you think this bug is significant, I can attempt the bug bisect in the
> > environment that triggered it (Lenovo LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
> > with BIOS M22KT49A from 11/10/2022 and AlmaLinux 8.7.
> > 
> > Here is the /sys/kernel/debug/kmemleak output:
> > 
> > unreferenced object 0xffff9e67ad71f160 (size 32):
> >   comm "gpio-sim.sh", pid 208926, jiffies 4372229685 (age 2101.564s)
> >   hex dump (first 32 bytes):
> >     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<0000000098bf3d1b>] slab_post_alloc_hook+0x91/0x320
> >     [<00000000da3205c5>] __kmem_cache_alloc_node+0x1bf/0x2b0
> >     [<00000000aa51a58a>] __kmalloc_node_track_caller+0x55/0x140
> >     [<00000000bd682ecc>] kvasprintf+0x6b/0xd0
> >     [<00000000a3431d55>] kasprintf+0x4e/0x70
> >     [<00000000f52d2629>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
> >     [<00000000673fc6df>] configfs_write_iter+0xcc/0x130
> >     [<000000001d5d0829>] vfs_write+0x2b4/0x3d0
> >     [<00000000d2336251>] ksys_write+0x61/0xe0
> >     [<00000000f7015bb1>] __x64_sys_write+0x1a/0x20
> >     [<000000008ac743d2>] do_syscall_64+0x58/0x80
> >     [<000000004d7b7d50>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [root@pc-mtodorov marvin]#
> 
> The new development on the bug is that it probably requires some superuser privileges
> or some capability to be exploited, for it requires access to configfs,
> but it was reproduced on different hardware as well.
> 
> The minimum reproducing script is attached, with its output log.
> 
> From the testing "age" of the unreferenced object I assume that it is allocated earlier
> in a part of script I am unable to locate or specify, but orphaned at the end of the script.
> 
> root@/home/user/kernel_bugs/gpio-sim# time ./gpio-reproduce-min.sh
> 2.14. Lines can be hogged
> Scanning stage 2.14.7 ... done.
> Sleeping 60 seconds ... done.
> Stage 2.14.7 clean.
> Rescanning stage 2.14.7 ... done.
> Sleeping 60 seconds ... done.
> unreferenced object 0xffff9593b9d16bc0 (size 32):
>   comm "gpio-reproduce-", pid 7594, jiffies 4295865460 (age 136.184s)
>   hex dump (first 32 bytes):
>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
>     [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
>     [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
>     [<000000000c0f91cd>] kasprintf+0x4e/0x70
>     [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>     [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
>     [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
>     [<000000008a17e041>] ksys_write+0x61/0xe0
>     [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
>     [<00000000e1220148>] do_syscall_64+0x58/0x80
>     [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> real	2m16.398s
> user	0m0.023s
> sys	0m16.360s
> root@/home/user/kernel_bugs/gpio-sim# 
> 
> The effect is cummulative:
> 
> root@marvin-IdeaPad-3-15ITL6:/home/user/kernel_bugs/gpio-sim# cat /sys/kernel/debug/kmemleak 
> unreferenced object 0xffff9593b9d16bc0 (size 32):
>   comm "gpio-reproduce-", pid 7594, jiffies 4295865460 (age 520.296s)
>   hex dump (first 32 bytes):
>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
>     [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
>     [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
>     [<000000000c0f91cd>] kasprintf+0x4e/0x70
>     [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>     [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
>     [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
>     [<000000008a17e041>] ksys_write+0x61/0xe0
>     [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
>     [<00000000e1220148>] do_syscall_64+0x58/0x80
>     [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> unreferenced object 0xffff95938918fb40 (size 32):
>   comm "gpio-reproduce-", pid 7675, jiffies 4295954327 (age 164.832s)
>   hex dump (first 32 bytes):
>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
>     [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
>     [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
>     [<000000000c0f91cd>] kasprintf+0x4e/0x70
>     [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>     [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
>     [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
>     [<000000008a17e041>] ksys_write+0x61/0xe0
>     [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
>     [<00000000e1220148>] do_syscall_64+0x58/0x80
>     [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> unreferenced object 0xffff9594a3cf1820 (size 32):
>   comm "gpio-reproduce-", pid 7721, jiffies 4295976853 (age 74.728s)
>   hex dump (first 32 bytes):
>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
>     [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
>     [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
>     [<000000000c0f91cd>] kasprintf+0x4e/0x70
>     [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>     [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
>     [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
>     [<000000008a17e041>] ksys_write+0x61/0xe0
>     [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
>     [<00000000e1220148>] do_syscall_64+0x58/0x80
>     [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> root@marvin-IdeaPad-3-15ITL6:/home/user/kernel_bugs/gpio-sim# 
> 
> With sufficient privileges (or possibly even without them), an exploit can be devised
> to automate allocation of orphaned objects, at a rate of a couple per second (PoC attached).

Looking into the code I found one inconsistency. It might be that that brings
an issue, dunno. Can you try the patch below if it helps (but TBH I'm a bit
sceptical)?

From 499cfb52aa7de67a8bbb56ce183d9528b2376db0 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Sun, 12 Feb 2023 16:15:00 +0200
Subject: [PATCH 1/1] gpio: sim: Deactivate device in reversed order

Run the steps to deactivate device in the reserved order to what
it has been done in gpio_sim_device_activate_unlocked().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index a51b5ea38ad5..b0111d18808c 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -953,9 +953,9 @@ static void gpio_sim_device_deactivate_unlocked(struct gpio_sim_device *dev)
 
 	swnode = dev_fwnode(&dev->pdev->dev);
 	platform_device_unregister(dev->pdev);
+	gpio_sim_remove_hogs(dev);
 	gpio_sim_remove_swnode_recursive(swnode);
 	dev->pdev = NULL;
-	gpio_sim_remove_hogs(dev);
 }
 
 static ssize_t
-- 
2.39.1


-- 
With Best Regards,
Andy Shevchenko


