Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0F700657
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbjELLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbjELLIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:08:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6E4C1F;
        Fri, 12 May 2023 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683889717; x=1715425717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uai1hQcJ04WE6LNiNpqID72DdEL2bn7lrxMJNGYLlwQ=;
  b=mSvJ5081B9uPKBhBTDgF06A4foFzwQgO5ItgBjpy3ibbzfVAA6YLH9G3
   +hJxDCiMiZK5lsfKldgCNAQpjI/WUbsJ4GHBb+oq7WnKAG2VpLwuB/GhQ
   i0OH9OQkKB09NyceM1uTIhyQ047qyYU1rP3jTPT6Ub85QmYT1voQq+IYB
   xfLNnRzY3uUr5Vd7vij7Q1yHhQD2q+ybYKYuNnqLeCQIajKMWeChaeoZI
   SSL6xGRaNqacY6qP99gKml88uefUnZiH89cBaL4tLI88KWcCXEYMeSj4T
   l13Rta0sIqaeSgfVTiE/KyjyKysKZPwdIyH1xqfHtE6V+46FWfshwNr9P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="330383586"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="330383586"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 04:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="874359436"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="874359436"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2023 04:08:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pxQdC-0004aY-1Q;
        Fri, 12 May 2023 14:08:14 +0300
Date:   Fri, 12 May 2023 14:08:14 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     zhangqiumiao <zhangqiumiao1@huawei.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: Re: KASAN: soft lockup in paste_selection
Message-ID: <ZF4eHqgvA4NJk1ow@smile.fi.intel.com>
References: <16846f8e017948dcba9bf32b75a770f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16846f8e017948dcba9bf32b75a770f0@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Ilpo (not sure if you can do anything about that, so JFYI)

On Fri, May 12, 2023 at 08:28:26AM +0000, zhangqiumiao wrote:
> Hello,
> 
> We found the following issue using syzkaller on Linux v5.10.0.
> A similar issue was found in function `paste_selection` before and
> I believe they are the same.
> (https://lore.kernel.org/all/000000000000fe769905d315a1b7@google.com/)
> 
> Unfortunately, no one seems to be paying attention to this issue.
> 
> The brief report is below:
> ========================================================
> kasan
> 
> RBP: 00007fcdf2facd75 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff5a65520f R14: 00007fff5a6553b0 R15: 00007fcdf14acd80
> watchdog: BUG: soft lockup - CPU#1 stuck for 123s! [syz-executor.3:23295]
> Modules linked in:
> 
> Sample time: 21774237378 ns(HZ: 1000)
> Sample stat:
> curr: user: 39128997021, nice: 0, sys: 466294657699, idle: 246835945000, iowait: 5392968000, irq: 19049308342, softirq: 7849858971, st: 1336816062
> deta: user: 0, nice: 0, sys: 21408617598, idle: 0, iowait: 0, irq: 588225776, softirq: 0, st: 255856
> Sample softirq:
> Sample irqstat:
>     irq   15: delta         22, curr:       1301, ata_piix
> CPU: 1 PID: 23295 Comm: syz-executor.3 Not tainted 5.10.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
> RIP: 0010:__sanitizer_cov_trace_pc+0x14/0x60 kernel/kcov.c:197
> Code: 80 ee 02 00 48 8b 80 68 14 00 00 c3 cc cc cc cc 66 0f 1f 44 00 00 48 8b 34 24 65 48 8b 04 25 80 ee 02 00 65 8b 15 8c 69 8c 7e <f7> c2 00 01 ff 00 74 0f 80 e6 01 74 35 8b 90 74 14 00 00 85 d2 74
> RSP: 0018:ffff88812919fa90 EFLAGS: 00000286
> 
> RAX: ffff888084ced100 RBX: ffff888084ced100 RCX: ffffc90008523000
> RDX: 0000000000000000 RSI: ffffffff83696570 RDI: ffff888112c729e8
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102258e538
> R10: ffff888112c729bf R11: ffffed102258e537 R12: ffff888112c72800
> R13: ffffed101099da20 R14: dffffc0000000000 R15: ffff888103922ec0
> FS:  00007fcdf14ad700(0000) GS:ffff888134c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 0000000100af4000 CR4: 0000000000150ee0
> Call Trace:
> paste_selection+0x170/0x3e0 drivers/tty/vt/selection.c:401
> tioclinux+0x3c3/0x480 drivers/tty/vt/vt.c:3208
> vt_ioctl+0x114d/0x1b90 drivers/tty/vt/vt_ioctl.c:762
> tty_ioctl+0x6d2/0x14a0 drivers/tty/tty_io.c:2757
> vfs_ioctl fs/ioctl.c:48 [inline]
> __do_sys_ioctl fs/ioctl.c:753 [inline]
> __se_sys_ioctl+0x112/0x150 fs/ioctl.c:739
> do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
> entry_SYSCALL_64_after_hwframe+0x61/0xc6
> RIP: 0033:0x7fcdf2f3f6cd
> Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fcdf14acbf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fcdf307af80 RCX: 00007fcdf2f3f6cd
> RDX: 0000000020000100 RSI: 000000000000541c RDI: 0000000000000004
> RBP: 00007fcdf2facd75 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff5a65520f R14: 00007fff5a6553b0 R15: 00007fcdf14acd80
> Sending NMI from CPU 1 to CPUs 0,2-3:
> NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
> NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
> NMI backtrace for cpu 0 skipped: idling at default_idle+0x13/0x20 arch/x86/kernel/process.c:713
> NMI backtrace for cpu 2 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
> NMI backtrace for cpu 2 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
> NMI backtrace for cpu 2 skipped: idling at default_idle+0x13/0x20 arch/x86/kernel/process.c:713
> NMI backtrace for cpu 3 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
> NMI backtrace for cpu 3 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
> NMI backtrace for cpu 3 skipped: idling at default_idle+0x13/0x20 arch/x86/kernel/process.c:713
> 
> ========================================================

-- 
With Best Regards,
Andy Shevchenko


