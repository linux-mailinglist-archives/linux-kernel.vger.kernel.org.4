Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1D697462
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjBOChd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjBOChc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:37:32 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F89F31E14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:37:27 -0800 (PST)
X-QQ-mid: bizesmtp90t1676428611tg2aeyqf
Received: from localhost.localdomain ( [116.30.131.224])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 15 Feb 2023 10:36:50 +0800 (CST)
X-QQ-SSF: 01200000000000C0S000000A0000000
X-QQ-FEAT: 5q30pvLz2id9OWHmZBHyel5Z+VxupIKX8tOxdUvJ2Sm6Ur1eW4eOqxmdiDkP7
        0u4dxNhC02Uy4qQ3nA0pC/pXD+mrRi9omPGwtK7z8STNWm55MKr3JcdRy/dWr+HC7sclqNo
        PC5Rl+2jSvmgYkc1xaWX7ZoNvObbdFn5Am6UNKfUfufdCk6+7vm0BSeKRJxqlxDDJqkaywv
        74Pm/NKm2OFplkWphNzS0vjjuy7oo6aJcWUAASTVLmy6A5DyZ6xzSV7yYNYxl/NbjrIwM0U
        A6d84LukKidn2n+/37SVdmFRUBmJ126P4iR0iZMRSyRKxdwH5OUU3gmpEQv3nv/eloD+4gu
        YrySkNpOEzYts7/9HunA8MEne/FTn95BXYQn33o
X-QQ-GoodBg: 0
From:   Zhangjin Wu <falcon@tinylab.org>
To:     Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Zhangjin Wu <falcon@tinylab.org>, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        Adam Borowski <kilobyte@angband.pl>,
        Paul Burton <paulburton@kernel.org>
Subject: Re: Re: Kernel-only deployments?
Date:   Wed, 15 Feb 2023 10:35:57 +0800
Message-Id: <20230215023557.7241-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20180823190657.GA12057@1wt.eu>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Willy & Paul

Thanks very much for your work on nolibc, based on the nolibc feature
and the gc-sections feature from Paul Burton, I have tried to 'gc' the
dead system calls not used in the nolibc applications.

Tests shows, the gc-sections shrinks a minimal config of RISC-V 64 by
~10% and the gc-sections for syscalls shrinks another ~4.6% (~200k).

Since nolibc has been added into tools/include/nolibc, it may be
possible to auto 'gc' the dead syscalls automatically while building the
nolibc based initrd, but it requires to auto update the architecture
specific system call table after building the nolibc application:

1. Eliminate the unused functions and syscalls of the nolibc application

   add -ffunction-sections -fdata-sections and -Wl,--gc-sections to
   compile the nolibc application

2. Dump the used syscalls with the help of objdump

   This is architecture dependent, a RISC-V 64 example:

   riscv64-linux-gnu-objdump -d $nolibc_bin | \
       egrep "li[[:space:]]*a7|ecall" | \
       egrep -B1 ecall | \
       egrep "li[[:space:]]*a7" | \
       rev | cut -d ' ' -f1 | rev | cut -d ',' -f2 | \
       sort -u -g

   Use a simple hello.c with reboot() at the end as an example, the
   dumped syscall numbers are:

       64
       93
       142

3. Update architecture specific system call table

   Use RISC-V 64 as an example, arch/riscv/kernel/syscall_table.c:

    diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
    index 44b1420a2270..3b48a94c0ae8 100644
    --- a/arch/riscv/kernel/syscall_table.c
    +++ b/arch/riscv/kernel/syscall_table.c
    @@ -14,5 +14,10 @@

     void * const sys_call_table[__NR_syscalls] = {
            [0 ... __NR_syscalls - 1] = sys_ni_syscall,
    -#include <asm/unistd.h>
    +// AUTO INSERT START
    +       [64] = sys_write,
    +       [93] = sys_exit,
    +       [142] = sys_reboot,
    +// AUTO INSERT END
    +// #include <asm/unistd.h>
     };

4. Build kernel with gc-sections, the unused syscalls will be eliminated

It is not that complicated, but to mainline such a feature and let it
support more architectures, it is not that easy. I have written more
about this here:
https://lore.kernel.org/linux-riscv/20230214084229.42623-1-falcon@tinylab.org/

So, is such a feature really useful? does anyone in the deep embedded
space already do this? welcome your suggestion.

Thanks
- Zhangjin Wu

On Thu, 23 Aug 2018 18:38:12 -0400, Willy Tarreau wrote:
> 
> On Thu, Aug 23, 2018 at 08:54:17PM +0200, Adam Borowski wrote:
> > .globl _start
> > .data
> > req:    .8byte 999999999, 999999999
> > .text
> > _start:
> >         mov     $35, %rax       # syscall: nanosleep
> >         mov     $req, %rdi
> >         xor     %rsi, %rsi
> >         syscall
> >         jmp     _start
> > 
> > 
> > as sl.s -o sl.o
> > ld sl.o -o init
> > 
> > 'Ere you go, no libc needed.  If your arch is not amd64, just say so.
> > 
> > If you want to do anything more complex, though -- you really want musl
> > or another lightweight libc instead.  Glibc is utterly unfit for static
> > linking.
> 
> Since there seems to be some interest about this, I'll repost this
> here. I've developed a "nolibc" include file which implements most
> common syscalls and string functions (those I use in early boot)
> as static inlines so the resulting executable only contains the
> code you really use :
> 
>     http://git.formilux.org/?p=people/willy/nolibc.git;a=tree
> 
> Example :
> 
>   $ echo "int main() { return sleep(3);}" | gcc -Os -nostdlib -include ../nolibc/nolibc.h -s -fno-exceptions -fno-asynchronous-unwind-tables -fno-unwind-tables  -lgcc -o sleep -xc -
>   $ ls -l sleep
>   -rwxr-xr-x 1 willy users 664 Aug 23 20:37 sleep
> 
> It's actually used by my pre-init loader that is embedded into the
> initramfs of all my kernels, to untar the modules and switch to the
> initrd or rootfs. This way all my modules are contained into the
> kernel image and I can easily use many different kernels with rootfs
> without having to install modules.
> 
> Just in case someone curious would want to know more about it, the
> (old and horrible) preinit is here :
> 
>   http://git.formilux.org/?p=dist/src/flxutils.git;a=tree;f=init;h=9dc8fbae6383d9b4d56d34cc6c3d59585318bef8;hb=HEAD
> 
> And the (old and ugly) build script is here :
> 
>   http://git.formilux.org/?p=dist/techno.git;a=tree;f=scripts/kernel;hb=HEAD
> 
> Yes it's aging a lot now but it's still very convenient ;-)
> 
> Willy
