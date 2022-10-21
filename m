Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9E607434
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJUJht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJUJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:37:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE0D24D88A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:37:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F07BEED1;
        Fri, 21 Oct 2022 02:37:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.6.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A28583F67D;
        Fri, 21 Oct 2022 02:37:43 -0700 (PDT)
Date:   Fri, 21 Oct 2022 10:37:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     syzbot <syzbot+96e659d35b9d6b541152@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, jiebin.sun@intel.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 percpu_counter_add_batch
Message-ID: <Y1JoXzLByvQPdbH4@FVFF77S0Q05N>
References: <000000000000e528a905eb822440@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e528a905eb822440@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 20, 2022 at 07:24:40PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    aae703b02f92 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1686e478880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=883de36878e6d869
> dashboard link: https://syzkaller.appspot.com/bug?extid=96e659d35b9d6b541152
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
> 
> Unfortunately, I don't have any reproducer for this issue yet.

I'm hitting what I believe is the same issue on my local arm64 Syzkaller
instance, which came up with a reproducer (which I can confirm with syz-repro)

Full Syzkaller report below. I'm testing v6.1-rc1 with a couple of fixes atop,
building with the kernel.org crosstool GCC 12.1.0 binaries.

Thanks,
Mark.

--------
Syzkaller hit 'BUG: unable to handle kernel paging request in percpu_counter_add_batch' bug.

Unable to handle kernel paging request at virtual address ffff70000b396400
KASAN: maybe wild-memory-access in range [0xffff800059cb2000-0xffff800059cb2007]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000048633000
[ffff70000b396400] pgd=00000000bfc0d003, p4d=00000000bfc0d003, pud=00000000bfc0c003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
CPU: 1 PID: 152 Comm: kworker/1:2 Not tainted 6.1.0-rc1-00005-g24c8a1f0fa1e #1
Hardware name: linux,dummy-virt (DT)
Workqueue: events free_ipc
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : percpu_counter_add_batch+0x74/0x2e4
lr : percpu_counter_add_batch+0x4c/0x2e4
sp : ffff8000155d7a50
x29: ffff8000155d7a50 x28: 0000000000000000 x27: 0000000000000000
x26: ffff00001635d400 x25: 1fffe0000220f4f3 x24: dfff800000000000
x23: ffff00001635d500 x22: 000000007fffffff x21: 0000000000000000
x20: ffff00001107a740 x19: ffff00001107a798 x18: 0000000000000010
x17: ffff8000093bd524 x16: ffff8000093bdf24 x15: ffff8000081e8528
x14: ffff8000081e9308 x13: ffff80000802aa0c x12: ff80800009632064
x11: 0000000000000000 x10: 0000000000000003 x9 : 1ffff0000b396400
x8 : ffff800059cb2000 x7 : ffff800008948af0 x6 : ffff800008945e20
x5 : ffff000016de8518 x4 : ffff8000093e64f0 x3 : ffff8000082d9058
x2 : 000000007fffffff x1 : ffff80000e6ea340 x0 : 0000000000000001
Call trace:
 percpu_counter_add_batch+0x74/0x2e4
 freeque+0x25c/0x334
 free_ipcs+0x12c/0x194
 msg_exit_ns+0x48/0x68
 free_ipc+0xac/0x230
 process_one_work+0x830/0x166c
 worker_thread+0x8f0/0xff8
 kthread+0x25c/0x2e0
 ret_from_fork+0x10/0x20
Code: f9400268 d538d089 8b080128 d343fd09 (38f86929) 
---[ end trace 0000000000000000 ]---
note: kworker/1:2[152] exited with preempt_count 1
----------------
Code disassembly (best guess):
   0:	f9400268 	ldr	x8, [x19]
   4:	d538d089 	mrs	x9, tpidr_el1
   8:	8b080128 	add	x8, x9, x8
   c:	d343fd09 	lsr	x9, x8, #3
* 10:	38f86929 	ldrsb	w9, [x9, x24] <-- trapping instruction


Syzkaller reproducer:
# {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:false UseTmpDir:false HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
unshare(0x48040000)
msgget(0x1, 0x2f0)


C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE 

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_mmap
#define __NR_mmap 222
#endif
#ifndef __NR_msgget
#define __NR_msgget 186
#endif
#ifndef __NR_unshare
#define __NR_unshare 97
#endif

int main(void)
{
		syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
	syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
	syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
				syscall(__NR_unshare, 0x48040000ul);
	syscall(__NR_msgget, 0x798e2634ul, 0x2f0ul);
	return 0;
}



> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+96e659d35b9d6b541152@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address ffff70000b978a00
> KASAN: maybe wild-memory-access in range [0xffff80005cbc5000-0xffff80005cbc5007]
> Mem abort info:
>   ESR = 0x0000000096000006
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x06: level 2 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000006
>   CM = 0, WnR = 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000045dfb000
> [ffff70000b978a00] pgd=00000000bfbeb003, p4d=00000000bfbeb003, pud=00000000bfbea003, pmd=0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 2820 Comm: kworker/0:3 Tainted: G        W          6.1.0-rc1-syzkaller-00025-gaae703b02f92 #0
> Hardware name: linux,dummy-virt (DT)
> Workqueue: events free_ipc
> pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : percpu_counter_add_batch+0x78/0x2f0 lib/percpu_counter.c:87
> lr : percpu_counter_add_batch+0x44/0x2f0 lib/percpu_counter.c:87
> sp : ffff8000120979c0
> x29: ffff8000120979c0 x28: ffff0000151ff800 x27: 1fffe00002a3ff24
> x26: ffff80005cbc5000 x25: ffff00000eeac7b0 x24: 1fffe00001dd58f6
> x23: 000000007fffffff x22: ffff80000cc4e800 x21: 0000000000000000
> x20: 0000000000000000 x19: ffff00000eeac758 x18: ffff00006a9cbbc0
> x17: 0000000000000000 x16: 0000000000000000 x15: ffff800008d9c830
> x14: ffff800008d78ecc x13: ffff800008d752d4 x12: ffff600002a3ff01
> x11: 1fffe00002a3ff00 x10: ffff600002a3ff00 x9 : dfff800000000000
> x8 : ffff0000151ff800 x7 : 00000000f1f1f1f1 x6 : dfff800000000000
> x5 : ffff700002412f32 x4 : 1ffff000020ef1ac x3 : 1ffff0000b978a00
> x2 : dfff800000000000 x1 : 0000000000000003 x0 : ffff80005cbc5000
> Call trace:
>  percpu_counter_add_batch+0x78/0x2f0 lib/percpu_counter.c:87
>  percpu_counter_add_local include/linux/percpu_counter.h:75 [inline]
>  percpu_counter_sub_local include/linux/percpu_counter.h:225 [inline]
>  freeque+0x20c/0x364 ipc/msg.c:292
>  free_ipcs+0xa0/0x160 ipc/namespace.c:125
>  msg_exit_ns+0x38/0x60 ipc/msg.c:1334
>  free_ipc_ns ipc/namespace.c:138 [inline]
>  free_ipc+0xd0/0x1c0 ipc/namespace.c:157
>  process_one_work+0x780/0x184c kernel/workqueue.c:2289
>  worker_thread+0x3cc/0xc40 kernel/workqueue.c:2436
>  kthread+0x23c/0x2a0 kernel/kthread.c:376
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> Code: f2fbffe2 92400801 d343fc03 11000c21 (38e26862) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	f2fbffe2 	movk	x2, #0xdfff, lsl #48
>    4:	92400801 	and	x1, x0, #0x7
>    8:	d343fc03 	lsr	x3, x0, #3
>    c:	11000c21 	add	w1, w1, #0x3
> * 10:	38e26862 	ldrsb	w2, [x3, x2] <-- trapping instruction
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
