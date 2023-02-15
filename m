Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2EE69794B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjBOJsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjBOJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:48:30 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1356367D0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:48:24 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31F9lqPP003803;
        Wed, 15 Feb 2023 10:47:52 +0100
Date:   Wed, 15 Feb 2023 10:47:51 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        nicolas.pitre@linaro.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Paul Burton <paulburton@kernel.org>
Subject: Re: Re: Kernel-only deployments?
Message-ID: <Y+yqRwNERjb0/dSd@1wt.eu>
References: <20180823190657.GA12057@1wt.eu>
 <20230215023557.7241-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215023557.7241-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wu,

On Wed, Feb 15, 2023 at 10:35:57AM +0800, Zhangjin Wu wrote:
> Hi, Willy & Paul
> 
> Thanks very much for your work on nolibc, based on the nolibc feature
> and the gc-sections feature from Paul Burton, I have tried to 'gc' the
> dead system calls not used in the nolibc applications.
> 
> Tests shows, the gc-sections shrinks a minimal config of RISC-V 64 by
> ~10% and the gc-sections for syscalls shrinks another ~4.6% (~200k).
> 
> Since nolibc has been added into tools/include/nolibc, it may be
> possible to auto 'gc' the dead syscalls automatically while building the
> nolibc based initrd, but it requires to auto update the architecture
> specific system call table after building the nolibc application:
> 
> 1. Eliminate the unused functions and syscalls of the nolibc application
> 
>    add -ffunction-sections -fdata-sections and -Wl,--gc-sections to
>    compile the nolibc application
> 
> 2. Dump the used syscalls with the help of objdump
> 
>    This is architecture dependent, a RISC-V 64 example:
> 
>    riscv64-linux-gnu-objdump -d $nolibc_bin | \
>        egrep "li[[:space:]]*a7|ecall" | \
>        egrep -B1 ecall | \
>        egrep "li[[:space:]]*a7" | \
>        rev | cut -d ' ' -f1 | rev | cut -d ',' -f2 | \
>        sort -u -g
> 
>    Use a simple hello.c with reboot() at the end as an example, the
>    dumped syscall numbers are:
> 
>        64
>        93
>        142
> 
> 3. Update architecture specific system call table
> 
>    Use RISC-V 64 as an example, arch/riscv/kernel/syscall_table.c:
> 
>     diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
>     index 44b1420a2270..3b48a94c0ae8 100644
>     --- a/arch/riscv/kernel/syscall_table.c
>     +++ b/arch/riscv/kernel/syscall_table.c
>     @@ -14,5 +14,10 @@
> 
>      void * const sys_call_table[__NR_syscalls] = {
>             [0 ... __NR_syscalls - 1] = sys_ni_syscall,
>     -#include <asm/unistd.h>
>     +// AUTO INSERT START
>     +       [64] = sys_write,
>     +       [93] = sys_exit,
>     +       [142] = sys_reboot,
>     +// AUTO INSERT END
>     +// #include <asm/unistd.h>
>      };
> 
> 4. Build kernel with gc-sections, the unused syscalls will be eliminated
> 
> It is not that complicated, but to mainline such a feature and let it
> support more architectures, it is not that easy. I have written more
> about this here:
> https://lore.kernel.org/linux-riscv/20230214084229.42623-1-falcon@tinylab.org/

Yeah I noticed your message (though didn't yet have time to respond). If
find it interesting from an academic perspective at least.

> So, is such a feature really useful? does anyone in the deep embedded
> space already do this? welcome your suggestion.

The thing is that you will clearly not be able to compile realistic
applications with nolibc. Its goal is just to support test programs
or ultra-basic shells or init programs for which a libc is either
annoying (e.g. for kernel development you prefer to use the -nolibc
toolchains) or overkill (you don't always want to inflate your embedded
initramfs by hundreds of kB for a 300 bytes program, especially when
your kernel size approaches the maximum size of your flash device like
I recently had).

But for real applications you will definitely need to have a real libc
such as klibc or musl.

However the value I'm seeing in your work is to be able to show the
cost of families of syscalls and features. Instead of automatically
trimming them depending on what the application uses, I think it could
be useful to spot groups that dominate the size of these 200kB savings,
and possibly add build options to allow to remove them. In this case it
becomes easy to add tests for them (including using nolibc) that are
representative to what a some application would need and quickly verify
if a given kernel config has chances to work with this or that application.

This approach is even better because it won't force you to limit your
analysis to syscalls, but it can also cover other optional areas and
help application developers estimate the rough amount of savings they
can make by removing some parts if it's estimated that the application
will not use them.

Just my two cents,
Willy
