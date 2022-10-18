Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227C4603158
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJRRHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRRHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:07:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CA94EEAB7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:07:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37BC3113E;
        Tue, 18 Oct 2022 10:07:21 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22D483F7D8;
        Tue, 18 Oct 2022 10:07:14 -0700 (PDT)
Date:   Tue, 18 Oct 2022 18:07:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org,
        Liam Howlett <liam.howlettatoracle.com@lakrids>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org
Subject: Re: Possible Syzkaller / mmap() issues with commit abdba2dda0c477ca
Message-ID: <Y07dPJOYqshoX4f+@lakrids>
References: <Y06yk66SKxlrwwfb@lakrids>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y06yk66SKxlrwwfb@lakrids>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:05:07PM +0100, Mark Rutland wrote:
> Hi,
> 
> I'm seeing an issue with arm64 Syzkaller since commit:
> 
>   abdba2dda0c477ca ("mm: use maple tree operations for find_vma_intersection()")
> 
> ... where testing guest kernels with that commit causes syz-manager to
> scream, apparently with mmap() failing unexpectedly with error 11
> (EAGAIN):

It turned out the reported error was a red herring; Liam and I managed
to track this down to map() with MAP_FIXED returning a different
address, which which syz-executor handled as a failure.

I believe that Liam will send a patch in a bit.

Thanks,
Mark.

> 
> | 2022/10/18 14:40:00 loading corpus...
> | 2022/10/18 14:40:00 serving http on http://gravadlaks.cambridge.arm.com:56741
> | 2022/10/18 14:40:00 serving rpc on tcp://[::]:34951
> | 2022/10/18 14:40:00 booting test machines...
> | 2022/10/18 14:40:00 wait for the connection from test machine...
> | 2022/10/18 14:40:36 machine check failed: program execution failed: executor 0: exit status 67
> | SYZFAIL: mmap of output file failed
> |  (errno 11: Resource temporarily unavailable)
> | SYZFAIL: child failed
> |  (errno 0: Success)
> | loop exited with status 67
> | 
> | SYZFAIL: mmap of output file failed
> |  (errno 11: Resource temporarily unavailable)
> | SYZFAIL: child failed
> |  (errno 0: Success)
> | loop exited with status 67
> | 2022/10/18 14:40:46 machine check failed: program execution failed: executor 0: exit status 67
> | SYZFAIL: mmap of output file failed
> |  (errno 11: Resource temporarily unavailable)
> | SYZFAIL: child failed
> |  (errno 0: Success)
> | loop exited with status 67
> | 
> | SYZFAIL: mmap of output file failed
> |  (errno 11: Resource temporarily unavailable)
> | SYZFAIL: child failed
> |  (errno 0: Success)
> | loop exited with status 67
> | 2022/10/18 14:40:47 vm-0: crash: SYZFATAL: Manager.Check call failed: machine check failed: program execution failed: executor NUM: exit status NUM
> | 2022/10/18 14:40:57 machine check failed: program execution failed: executor 0: exit status 67
> | SYZFAIL: mmap of output file failed
> |  (errno 11: Resource temporarily unavailable)
> | SYZFAIL: child failed
> |  (errno 0: Success)
> | loop exited with status 67
> 
> This worked with v6.0, and didn't with v6.1-rc1; I bisected down to commit
> abdba2dda0c477c.
> 
> During bisection I saw a number of WARNs from the mm code; e.g. with the
> immediately prior commit:
> 
>   2e7ce7d354f2fae4 ("mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()")
> 
> ... I occasionally see warnings such as:
> 
> | ------------[ cut here ]------------
> | WARNING: CPU: 0 PID: 237 at mm/mmap.c:920 __vma_adjust+0x1390/0x1950
> | CPU: 0 PID: 237 Comm: syz-fuzzer Not tainted 6.0.0-rc3-00238-g2e7ce7d354f2 #3
> | Hardware name: linux,dummy-virt (DT)
> | pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> | pc : __vma_adjust+0x1390/0x1950
> | lr : __vma_adjust+0x1390/0x1950
> | sp : ffff800017997900
> | x29: ffff800017997900 x28: 0000000000000000 x27: ffff800017997a10
> | x26: 0000000000000000 x25: 0000004001800000 x24: ffff00000a0ef800
> | x23: 0000004001800000 x22: 0000ffffd9fc9000 x21: 1fffe00001480c3b
> | x20: ffff00000a4061d0 x19: 0000004001800000 x18: 1fffe00001390b37
> | x17: 1fffe00001390b37 x16: 0000000000000000 x15: ffff80000885525c
> | x14: ffff800008853474 x13: ffff8000087e62a8 x12: ffff700002675855
> | x11: 1ffff00002675854 x10: 1fffe00001390b32 x9 : ffff000009c85990
> | x8 : 00000000f3000000 x7 : ffff800014e8f000 x6 : 00000000f3f3f3f3
> | x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff000009c85040
> | x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> | Call trace:
> |  __vma_adjust+0x1390/0x1950
> |  vma_merge+0x3f4/0x880
> |  do_madvise+0x8c4/0x21e0
> |  __arm64_sys_madvise+0x98/0xf0
> |  invoke_syscall+0x8c/0x2d0
> |  el0_svc_common.constprop.0+0xf4/0x300
> |  do_el0_svc+0x70/0x200
> |  el0_svc+0x54/0x120
> |  el0t_64_sync_handler+0x120/0x154
> |  el0t_64_sync+0x18c/0x190
> | irq event stamp: 1683950
> | hardirqs last  enabled at (1683949): [<ffff8000088ce15c>] kasan_quarantine_put+0xec/0x240
> | hardirqs last disabled at (1683950): [<ffff80000e14b174>] el1_dbg+0x24/0x80
> | softirqs last  enabled at (1682788): [<ffff800008021724>] __do_softirq+0x994/0xf90
> | softirqs last disabled at (1682779): [<ffff80000817aab8>] __irq_exit_rcu+0x2b4/0x5b0
> | ---[ end trace 0000000000000000 ]---
> 
> ... so it looks as if something more fundamental is going wrong.
> 
> Booting a regular userspace seems to work fine, so I'm not sure exactly
> what's being tickled here, and I'm not entirely sure how to reproduce
> this elsewhere.
> 
> I'm using the config fragments from my branch at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=testing/6.1-rc1
> 
> ... building with:
> 
>   usekorg 12.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- defconfig testing.config syzkaller.config kasan.config
>   usekorg 12.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j50 Image
> 
> ... using the GCC 12.1.0 binaries from:
> 
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> I originally saw this with an old version of Syzkaller, but I see it
> just the same with a tip-of-tree Syzkaller built from commit:
> 
>   94744d216b270284 ("sys/fuchsia: rename objects to object (#3445)")
> 
> .... which I tested works fine with v6.0.
> 
> My syz-manager config looks like:
> 
> | {
> |         "target": "linux/arm64",
> |         "http": "gravadlaks.cambridge.arm.com:56741",
> |         "workdir": "/home/mark/syzkaller-fs/workdir",
> |         "image": "/home/mark/syzkaller-fs/rootfs-aa64.ext3",
> |         "kernel_obj": "/home/mark/src/linux/",
> |         "syzkaller": "/home/mark/syzkaller-fs",
> |         "sshkey": "/home/mark/syzkaller-fs/id_syz",
> |         "procs": 2,
> |         "type": "qemu",
> |         "vm":  {
> |                 "count": 8,
> |                 "cpu": 4,
> |                 "mem": 2048,
> |                 "qemu" : "/home/mark/.opt/apps/qemu/bin/qemu-system-aarch64",
> |                 "qemu_args" : "-machine virt,accel=kvm,gic-version=host -cpu host",
> |                 "kernel": "/home/mark/src/linux/arch/arm64/boot/Image",
> |                 "cmdline": "console=ttyAMA0 earlycon=pl011,0x9000000 root=/dev/vda rodata=full csdlock_debug=ext nokaslr transparent_hugepage=never"
> |         },
> | }
> 
> ... and my rootfs is a simple buildroot filesystem I had lying around.
> 
> Thanks,
> Mark.
> 
