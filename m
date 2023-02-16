Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4969953D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBPNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBPNKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:10:11 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564741B7D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:10:07 -0800 (PST)
X-QQ-mid: bizesmtp72t1676552978ty5olj5d
Received: from localhost.localdomain ( [116.30.131.224])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 16 Feb 2023 21:09:37 +0800 (CST)
X-QQ-SSF: 01200000006000C0T000B00A0000000
X-QQ-FEAT: QityeSR92A1egmDK/srb02Zj/HLMIkUCoVBroipi3lqkgUo1nemMdgssHjlSK
        QRCnrEnaXI7Dmj5vD07aoDU/TV9ARV9J8Lf7r6dz4+JJX35eRjhzeJj8M6ySUcukchltfXt
        5hhmcy+kPK6rIXsO3WlHZBMiv9z0um4feqo/tUs2r6jHaodolU5na+GzTjSySjAbxMX4jaN
        SIdO+5zV8eERcRVlSkLSXC22IN8SGtukFiqat1tbp4/19EgEOuOhYiz6/UhkCK3AUdDZDwM
        08XcH5cfqGcOkOI1YhBIycORyqiTccCZUUPC7AtzOr+qD+xwATw1ZcUa8UTLFPEg/OHRwec
        x/0VKyb5NC/N/lsuKPwUPFarDb2jQ4X3rJRTOZg
X-QQ-GoodBg: 0
From:   Zhangjin Wu <falcon@tinylab.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        nicolas.pitre@linaro.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Paul Burton <paulburton@kernel.org>
Subject: Re: Re: Kernel-only deployments?
Date:   Thu, 16 Feb 2023 21:09:35 +0800
Message-Id: <20230216130935.37976-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y+yqRwNERjb0/dSd@1wt.eu>
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

Hi, Willy

> On Wed, 15 Feb 2023 10:47:51 +0100, Willy Tarreau wrote:
> 
> Hi Wu,
> 
> On Wed, Feb 15, 2023 at 10:35:57AM +0800, Zhangjin Wu wrote:
> > Hi, Willy & Paul
> > 
> > Thanks very much for your work on nolibc, based on the nolibc feature
> > and the gc-sections feature from Paul Burton, I have tried to 'gc' the
> > dead system calls not used in the nolibc applications.
> > 
> > Tests shows, the gc-sections shrinks a minimal config of RISC-V 64 by
> > ~10% and the gc-sections for syscalls shrinks another ~4.6% (~200k).
> > 
> > Since nolibc has been added into tools/include/nolibc, it may be
> > possible to auto 'gc' the dead syscalls automatically while building the
> > nolibc based initrd, but it requires to auto update the architecture
> > specific system call table after building the nolibc application:
> > 
> > 1. Eliminate the unused functions and syscalls of the nolibc application
> > 
> >    add -ffunction-sections -fdata-sections and -Wl,--gc-sections to
> >    compile the nolibc application
> > 
> > 2. Dump the used syscalls with the help of objdump
> > 
> >    This is architecture dependent, a RISC-V 64 example:
> > 
> >    riscv64-linux-gnu-objdump -d $nolibc_bin | \
> >        egrep "li[[:space:]]*a7|ecall" | \
> >        egrep -B1 ecall | \
> >        egrep "li[[:space:]]*a7" | \
> >        rev | cut -d ' ' -f1 | rev | cut -d ',' -f2 | \
> >        sort -u -g
> > 
> >    Use a simple hello.c with reboot() at the end as an example, the
> >    dumped syscall numbers are:
> > 
> >        64
> >        93
> >        142
> > 
> > 3. Update architecture specific system call table
> > 
> >    Use RISC-V 64 as an example, arch/riscv/kernel/syscall_table.c:
> > 
> >     diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
> >     index 44b1420a2270..3b48a94c0ae8 100644
> >     --- a/arch/riscv/kernel/syscall_table.c
> >     +++ b/arch/riscv/kernel/syscall_table.c
> >     @@ -14,5 +14,10 @@
> > 
> >      void * const sys_call_table[__NR_syscalls] = {
> >             [0 ... __NR_syscalls - 1] = sys_ni_syscall,
> >     -#include <asm/unistd.h>
> >     +// AUTO INSERT START
> >     +       [64] = sys_write,
> >     +       [93] = sys_exit,
> >     +       [142] = sys_reboot,
> >     +// AUTO INSERT END
> >     +// #include <asm/unistd.h>
> >      };
> > 
> > 4. Build kernel with gc-sections, the unused syscalls will be eliminated
> > 
> > It is not that complicated, but to mainline such a feature and let it
> > support more architectures, it is not that easy. I have written more
> > about this here:
> > https://lore.kernel.org/linux-riscv/20230214084229.42623-1-falcon@tinylab.org/
> 
> Yeah I noticed your message (though didn't yet have time to respond). If
> find it interesting from an academic perspective at least.
>

Thanks very much for your kindly reply and suggestion ;-)

> > So, is such a feature really useful? does anyone in the deep embedded
> > space already do this? welcome your suggestion.
> 
> The thing is that you will clearly not be able to compile realistic
> applications with nolibc. Its goal is just to support test programs
> or ultra-basic shells or init programs for which a libc is either
> annoying (e.g. for kernel development you prefer to use the -nolibc
> toolchains) or overkill (you don't always want to inflate your embedded
> initramfs by hundreds of kB for a 300 bytes program, especially when
> your kernel size approaches the maximum size of your flash device like
> I recently had).
> 
> But for real applications you will definitely need to have a real libc
> such as klibc or musl.
>

Yeah, that is exactly the cause why I use nolibc as the base to think about
dead system call elimination, currently, not for real applications, not for
real products, only for possibility estimation, it is part of my long-term
community tinylinux work: https://tinylab.org/tinylinux

With nolibc, especially after its integration into the kernel source
code tree, the kernel+user becomes a monolithic software, it can simply
tell us what system calls (and of course may use some other kernel
interfaces, such as /dev, /tmp, /proc, /sys, here we focus on syscalls)
it uses and then we can put the 'C' lib part aside and focus on the
kernel part.

With a real bigger libc, even only with a small initramfs, the work to dig out
the used system calls is very hard and time-cost, although it is possible,
kernel+nolibc is such a good simplified 'model' for such a type of kernel
development.

> However the value I'm seeing in your work is to be able to show the
> cost of families of syscalls and features. Instead of automatically
> trimming them depending on what the application uses, I think it could
> be useful to spot groups that dominate the size of these 200kB savings,
> and possibly add build options to allow to remove them. In this case it
> becomes easy to add tests for them (including using nolibc) that are
> representative to what a some application would need and quickly verify
> if a given kernel config has chances to work with this or that application.
> 

This is really a right direction, and I have tried to add many config
options for different syscalls:
https://github.com/tinyclub/tinylinux/tree/2.6.35/dev/syscall-cfg

And under this kernel menu:

    General setup  --->
        Configure standard kernel features (expert users)  --->

There have been more than 10+ syscall options, but this direction has at
least two potential issues:

- The manual splitting of a new system call option is very hard and the
  upstream to mainline is hard too. If x 451 (__NR_syscalls in generic
  unistd.h), the work will be huge.

  But we still need to split some syscalls manually, for example, vdso
  syscalls in some architectures (e.g. MIPS) are not configurable. some
  other syscalls may be just 'referenced' directly in kernel space, but
  not really 'used'. such ones should be found out.

- The configure of the options is not that easy, the kernel engineers
  should co-operate with the application engineers cheek by jowl and
  then test them carefully, may fail, re-build, fail, re-build.

With 'dead system call elimination', application engineers can care about their
own functions development, kernel engineers can simply enable the 'dead system
call elimination', the left parts could be submitted to a script to dump out
all of the system calls used by the kernel+user monolithic software (the same
to a real system, but need to do more).

I have prepared several RFC patches to implement a draft support of 'dead
system call elimination', will send them out later and welcome your review. 

> This approach is even better because it won't force you to limit your
> analysis to syscalls, but it can also cover other optional areas and
> help application developers estimate the rough amount of savings they
> can make by removing some parts if it's estimated that the application
> will not use them.

Yes, syscall elimination is only of the options to tinylinux, here are
some others we tried: https://github.com/tinyclub/tinylinux/branches

Thanks,
- Zhangjin Wu

> 
> Just my two cents,
> Willy
