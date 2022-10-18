Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF4B602E51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiJROW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiJROWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:22:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C3AD7E01
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666102953; x=1697638953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r8hfM9vlb4HsYk2fm6pCiYv38TSz52CmPPsPliY0T8I=;
  b=lITEvrOZdTagXwRn8aHS8MyJdoYQ+3Ev8V4GFrcP61KX7pf7yGh07pyY
   +QXG2y2j4eoLiS+pXMrwz0H7Er3IC+MN1rAilnzeS/pnCgm2t+3JqVhk8
   HM3N0W3EICe7GQ2BBhZhQyEyZBdiDseS9D/RPtK3sP6Gv0d/v9lX2L+G5
   yjXtGKMrpaaH0C4dsCtUt2zq3kYODysMwP7JzvSeSYBZiNc/xYgXHWkB5
   dVJpOINO+g1R/9uV8NFowi1/hHJxOhPQ8V79nSvT0cq1S39M9SGQXX7sZ
   XS0weAWYV6uPwQUl3lmH0eudYiMdXbPwxwk7zNKtMIRga0o92Za8dwTnH
   w==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="182745264"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2022 07:22:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 18 Oct 2022 07:22:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 18 Oct 2022 07:22:29 -0700
Date:   Tue, 18 Oct 2022 15:22:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     binglei wang <l3b2w1@gmail.com>
CC:     Conor Dooley <conor@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] rethook: add riscv rethook implementation
Message-ID: <Y062jiPZbWEAVjpO@wendy>
References: <20220930081357.651914-1-l3b2w1@gmail.com>
 <Yzm+z+mv/VSA+5hg@spud>
 <CAJ3C4KzyAR7dKYFBKHzFEXr-dzr-JMGRFVx+dybMhRPy0uHUgA@mail.gmail.com>
 <Y01tdcRRFBdOmaYc@spud>
 <CAJ3C4Kwj0yYS5JCPw=g0X9qiQhw04iKy_cTjc0x8iWdy0ay7bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ3C4Kwj0yYS5JCPw=g0X9qiQhw04iKy_cTjc0x8iWdy0ay7bg@mail.gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:08:55PM +0800, binglei wang wrote:
> Hi Conor:
> Thank you for your help to check the merging process for this patch.
> 
> > Thread overview: 3+ messages (download: mbox.gz / follow: Atom feed)
> > -- links below jump to the message on this page --
> >      [not found] <20220930081357.651914-1-l3b2w1@gmail.com>
> I have no idea what this means, I guess maybe the way i sended the
> patch was not right.
> 
> I found the patch on the lore in this url, is this helpful ?
> https://lore.kernel.org/lkml/20221002181035.490ad0155d741e39faa29716@kernel.org/

Hmm, looks like your patch made it to lkml itself but got rejected by
linux-riscv which is hosted by infradead. It's missing here:
https://lore.kernel.org/linux-riscv/CAJ3C4Kwj0yYS5JCPw=g0X9qiQhw04iKy_cTjc0x8iWdy0ay7bg@mail.gmail.com/T/#t

> 
> > I'm not really sure what's happened there.. I can only see your v1 and
> > your v4 on lore/patchwork.
> I find all my commits from v1 to v8 in this addr
> https://lore.kernel.org/lkml/?q=l3b2w1
> 
> Should I resend the patch as a last resort ?

Eh, I guess you could try (and CC patches@lists.linux.dev). I'm not sure
if that'll help at all though.. At worst, if that doesn't work I could
possibly send the patches for you. Or if you think you may end up doing
more upstream work you could always apply for an @linux.dev account?
See https://korg.docs.kernel.org/linuxdev.html for more information on
that.

> 
> Binglei Wang
> Best wishes.
> 
> Conor Dooley <conor@kernel.org> 于2022年10月17日周一 22:58写道：
> >
> > On Mon, Oct 17, 2022 at 10:31:28PM +0800, binglei wang wrote:
> > > Hi Conor,
> > > could you please help me to push forward merging process of this patch
> > > into the 6.1 ?  Thank you!
> >
> > Hey Binglei,
> > Unfortunately it is too late for v6.1 (the merge window closed on
> > Sunday, Palmer sent his second PR on Friday) but I don't see why this
> > should not be picked for v6.2. I tried last week & again just now to
> > check the status of this patch on patchwork but I cannot find it there.
> > Similarly, the patch does not appear on lore:
> > https://lore.kernel.org/linux-riscv/CAJ3C4KzyAR7dKYFBKHzFEXr-dzr-JMGRFVx+dybMhRPy0uHUgA@mail.gmail.com/T/#t
> > Thread overview: 3+ messages (download: mbox.gz / follow: Atom feed)
> > -- links below jump to the message on this page --
> >      [not found] <20220930081357.651914-1-l3b2w1@gmail.com>
> > 2022-10-02  9:10 ` [PATCH v8] rethook: add riscv rethook implementation Masami Hiramatsu
> > 2022-10-02 16:39 ` Conor Dooley
> > 2022-10-17 14:31   ` binglei wang
> >
> > I'm not really sure what's happened there.. I can only see your v1 and
> > your v4 on lore/patchwork. Maybe take a look if you changed anything
> > between versions & try resending as v9?
> >
> > HTH,
> > Conor.
> >
> > >
> > > Binglei Wang
> > > Best wishes.
> > >
> > >
> > > On 2022-10-03 00:39, Conor Dooley wrote:
> > > > Hey Binglei,
> > > > I am not qualified to give you an actual R-b on this patch, but I see
> > > > you did get one from Masami who very much is!
> > > >
> > > > That said, the patch looks a lot better (and much simpler!) now. Thanks
> > > > for sticking with it despite the initial issues with your email setup
> > > > and the submission process.
> > > >
> > > > Thanks,
> > > > Conor.
> > > >
> > > > On Fri, Sep 30, 2022 at 04:13:57PM +0800, Binglei Wang wrote:
> > > >> From: Binglei Wang <l3b2w1@gmail.com>
> > > >>
> > > >> Implement the kretprobes on riscv arch by using rethook machenism
> > > >> which abstracts general kretprobe info into a struct rethook_node
> > > >> to be embedded in the struct kretprobe_instance.
> > > >>
> > > >> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> > > >> ---
> > > >>
> > > >> Notes:
> > > >>      v8: Add the omitted rethook.h
> > > >>      v7: Add the changelog.
> > > >>      v6: Remove the kretprobes trampoline.
> > > >>      v5: Trt to fix robot compiling error and warnings.
> > > >>      v4: Add patch version number.
> > > >>      v3: Trt to fix robot compiling error and warnings.
> > > >>      v2: Add comit log to explain reasons behind changes.
> > > >>          Use my personal email instead of work email
> > > >>              to avoid the attachments of company informaton.
> > > >>          Make the kprobes_trampoline.S code to be shared.
> > > >>      v1: Add riscv rethook implementation.
> > > >>
> > > >>   arch/riscv/Kconfig                            |  1 +
> > > >>   arch/riscv/include/asm/kprobes.h              |  2 --
> > > >>   arch/riscv/kernel/probes/Makefile             |  2 +-
> > > >>   arch/riscv/kernel/probes/kprobes.c            | 13 ---------
> > > >>   arch/riscv/kernel/probes/rethook.c            | 27 +++++++++++++++++++
> > > >>   arch/riscv/kernel/probes/rethook.h            |  8 ++++++
> > > >>   ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
> > > >>   7 files changed, 40 insertions(+), 19 deletions(-)
> > > >>   create mode 100644 arch/riscv/kernel/probes/rethook.c
> > > >>   create mode 100644 arch/riscv/kernel/probes/rethook.h
> > > >>   rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (94%)
> > > >>
> > > >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > >> index 59d18881f..bfb66cdc5 100644
> > > >> --- a/arch/riscv/Kconfig
> > > >> +++ b/arch/riscv/Kconfig
> > > >> @@ -97,6 +97,7 @@ config RISCV
> > > >>      select HAVE_KPROBES if !XIP_KERNEL
> > > >>      select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> > > >>      select HAVE_KRETPROBES if !XIP_KERNEL
> > > >> +    select HAVE_RETHOOK if !XIP_KERNEL
> > > >>      select HAVE_MOVE_PMD
> > > >>      select HAVE_MOVE_PUD
> > > >>      select HAVE_PCI
> > > >> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
> > > >> index 217ef89f2..e7882ccb0 100644
> > > >> --- a/arch/riscv/include/asm/kprobes.h
> > > >> +++ b/arch/riscv/include/asm/kprobes.h
> > > >> @@ -40,8 +40,6 @@ void arch_remove_kprobe(struct kprobe *p);
> > > >>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
> > > >>   bool kprobe_breakpoint_handler(struct pt_regs *regs);
> > > >>   bool kprobe_single_step_handler(struct pt_regs *regs);
> > > >> -void __kretprobe_trampoline(void);
> > > >> -void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
> > > >>
> > > >>   #endif /* CONFIG_KPROBES */
> > > >>   #endif /* _ASM_RISCV_KPROBES_H */
> > > >> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> > > >> index 7f0840dcc..c40139e9c 100644
> > > >> --- a/arch/riscv/kernel/probes/Makefile
> > > >> +++ b/arch/riscv/kernel/probes/Makefile
> > > >> @@ -1,6 +1,6 @@
> > > >>   # SPDX-License-Identifier: GPL-2.0
> > > >>   obj-$(CONFIG_KPROBES)              += kprobes.o decode-insn.o simulate-insn.o
> > > >> -obj-$(CONFIG_KPROBES)               += kprobes_trampoline.o
> > > >> +obj-$(CONFIG_RETHOOK)               += rethook.o rethook_trampoline.o
> > > >>   obj-$(CONFIG_KPROBES_ON_FTRACE)    += ftrace.o
> > > >>   obj-$(CONFIG_UPROBES)              += uprobes.o decode-insn.o simulate-insn.o
> > > >>   CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
> > > >> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> > > >> index e6e950b7c..f21592d20 100644
> > > >> --- a/arch/riscv/kernel/probes/kprobes.c
> > > >> +++ b/arch/riscv/kernel/probes/kprobes.c
> > > >> @@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
> > > >>      return ret;
> > > >>   }
> > > >>
> > > >> -void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> > > >> -{
> > > >> -    return (void *)kretprobe_trampoline_handler(regs, NULL);
> > > >> -}
> > > >> -
> > > >> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> > > >> -                                  struct pt_regs *regs)
> > > >> -{
> > > >> -    ri->ret_addr = (kprobe_opcode_t *)regs->ra;
> > > >> -    ri->fp = NULL;
> > > >> -    regs->ra = (unsigned long) &__kretprobe_trampoline;
> > > >> -}
> > > >> -
> > > >>   int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> > > >>   {
> > > >>      return 0;
> > > >> diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
> > > >> new file mode 100644
> > > >> index 000000000..cbd0da059
> > > >> --- /dev/null
> > > >> +++ b/arch/riscv/kernel/probes/rethook.c
> > > >> @@ -0,0 +1,27 @@
> > > >> +// SPDX-License-Identifier: GPL-2.0-only
> > > >> +/*
> > > >> + * Generic return hook for riscv.
> > > >> + */
> > > >> +
> > > >> +#include <linux/kprobes.h>
> > > >> +#include <linux/rethook.h>
> > > >> +#include "rethook.h"
> > > >> +
> > > >> +/* This is called from arch_rethook_trampoline() */
> > > >> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
> > > >> +{
> > > >> +    return rethook_trampoline_handler(regs, regs->s0);
> > > >> +}
> > > >> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> > > >> +
> > > >> +
> > > >> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
> > > >> +{
> > > >> +    rhn->ret_addr = regs->ra;
> > > >> +    rhn->frame = regs->s0;
> > > >> +
> > > >> +    /* replace return addr with trampoline */
> > > >> +    regs->ra = (unsigned long)arch_rethook_trampoline;
> > > >> +}
> > > >> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> > > >> +
> > > >> diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
> > > >> new file mode 100644
> > > >> index 000000000..cc573d701
> > > >> --- /dev/null
> > > >> +++ b/arch/riscv/kernel/probes/rethook.h
> > > >> @@ -0,0 +1,8 @@
> > > >> +// SPDX-License-Identifier: GPL-2.0-only
> > > >> +#ifndef __RISCV_RETHOOK_H
> > > >> +#define __RISCV_RETHOOK_H
> > > >> +
> > > >> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> > > >> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
> > > >> +
> > > >> +#endif
> > > >> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
> > > >> similarity index 94%
> > > >> rename from arch/riscv/kernel/probes/kprobes_trampoline.S
> > > >> rename to arch/riscv/kernel/probes/rethook_trampoline.S
> > > >> index 7bdb09ded..21bac92a1 100644
> > > >> --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
> > > >> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
> > > >> @@ -75,13 +75,13 @@
> > > >>      REG_L x31, PT_T6(sp)
> > > >>      .endm
> > > >>
> > > >> -ENTRY(__kretprobe_trampoline)
> > > >> +ENTRY(arch_rethook_trampoline)
> > > >>      addi sp, sp, -(PT_SIZE_ON_STACK)
> > > >>      save_all_base_regs
> > > >>
> > > >>      move a0, sp /* pt_regs */
> > > >>
> > > >> -    call trampoline_probe_handler
> > > >> +    call arch_rethook_trampoline_callback
> > > >>
> > > >>      /* use the result as the return-address */
> > > >>      move ra, a0
> > > >> @@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
> > > >>      addi sp, sp, PT_SIZE_ON_STACK
> > > >>
> > > >>      ret
> > > >> -ENDPROC(__kretprobe_trampoline)
> > > >> +ENDPROC(arch_rethook_trampoline)
> > > >> --
> > > >> 2.27.0
> > > >>
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
