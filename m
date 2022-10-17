Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0449860112A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJQObn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJQObl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:31:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F185925C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:31:40 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b145so13530045yba.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh12UWjdjMMugaBN7TG2En01IfaGopWII1TN7vU8KRE=;
        b=hizRtERUVOppD+XCfJNb6iDmIVgY+Gm+PRIcuIdsJ9lxBdy2A0n8B8UIuLJW/nTUnb
         MUN+7V+vVUjjomupFxWJ6EhSqzg8oDnlygh6cU5TYST5cwAh6U/O6FD8PwGrDqblvpYG
         0lVBjJQ613s34SWoieDLGh5ynLCNUbDO/7taVnV9vG/og/ugMgLHZBx/v27eTgyWgf3e
         wse2S0VT9XMj5GtRr9zjEsqrt/uaOf3o3GvfdD31TSYyh9XYpLYNyMNUD4W4laUU0IiL
         iPvg5Ocr6i/qpifl9mdI+LZqlJc7GxKd7AyX/1AqUepMdkDalkhU/5f/u7snssJOrl1n
         SmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yh12UWjdjMMugaBN7TG2En01IfaGopWII1TN7vU8KRE=;
        b=fYgoESDB7EztjQjsUy439Csy8F1sNDxP8hZ60CDHwQpEWtmwci/6+biFPoMWjT2GZr
         FfxZ/dymmJrkKaDpVejqrn3EBlEaGhV12gCHVdpAeO1owzNNE9aFDdTo+feptNef32L8
         HTWj2FAjcOp1Clde7igPBfFborZBPYiDNRyIJNNpyz3sL6hrjTysu0SKBYshkijKW+mX
         gZHld5E44uvnzdedZEQgENYmAv7ZCZmaCUn4hrOQp8g07WPmIasP5QfgyEKbeQrwasNL
         ljsUrWvRsEqxJhvS8s57J3S52O115tWK0haXgeDpmUU3K0Mi0aVncWDhiJYHLskJpYQD
         c67w==
X-Gm-Message-State: ACrzQf3qsqhahobZ/7Mv4V8eqe/PVBSrU2IKMO5hdRoVFtnj97OC9lpb
        3QKHa2jRH9mwmeFAkDav6xiU2Ucf/JZ07xpHWMM=
X-Google-Smtp-Source: AMsMyM7K07rHVPBeST/AFWZuNS1Yu7RFT9UeFM2vY2Fs1SHRaEpyFFJ9QcmTZSDbhgMm0Oc6gjxsDlGZz1tTivwA4yI=
X-Received: by 2002:a25:6ac2:0:b0:6c0:efe6:462 with SMTP id
 f185-20020a256ac2000000b006c0efe60462mr9663667ybc.9.1666017099150; Mon, 17
 Oct 2022 07:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220930081357.651914-1-l3b2w1@gmail.com> <Yzm+z+mv/VSA+5hg@spud>
In-Reply-To: <Yzm+z+mv/VSA+5hg@spud>
From:   binglei wang <l3b2w1@gmail.com>
Date:   Mon, 17 Oct 2022 22:31:28 +0800
Message-ID: <CAJ3C4KzyAR7dKYFBKHzFEXr-dzr-JMGRFVx+dybMhRPy0uHUgA@mail.gmail.com>
Subject: Re: [PATCH v8] rethook: add riscv rethook implementation
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,
could you please help me to push forward merging process of this patch
into the 6.1 ?  Thank you!

Binglei Wang
Best wishes.


On 2022-10-03 00:39, Conor Dooley wrote:
> Hey Binglei,
> I am not qualified to give you an actual R-b on this patch, but I see
> you did get one from Masami who very much is!
>
> That said, the patch looks a lot better (and much simpler!) now. Thanks
> for sticking with it despite the initial issues with your email setup
> and the submission process.
>
> Thanks,
> Conor.
>
> On Fri, Sep 30, 2022 at 04:13:57PM +0800, Binglei Wang wrote:
>> From: Binglei Wang <l3b2w1@gmail.com>
>>
>> Implement the kretprobes on riscv arch by using rethook machenism
>> which abstracts general kretprobe info into a struct rethook_node
>> to be embedded in the struct kretprobe_instance.
>>
>> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
>> ---
>>
>> Notes:
>>      v8: Add the omitted rethook.h
>>      v7: Add the changelog.
>>      v6: Remove the kretprobes trampoline.
>>      v5: Trt to fix robot compiling error and warnings.
>>      v4: Add patch version number.
>>      v3: Trt to fix robot compiling error and warnings.
>>      v2: Add comit log to explain reasons behind changes.
>>          Use my personal email instead of work email
>>              to avoid the attachments of company informaton.
>>          Make the kprobes_trampoline.S code to be shared.
>>      v1: Add riscv rethook implementation.
>>
>>   arch/riscv/Kconfig                            |  1 +
>>   arch/riscv/include/asm/kprobes.h              |  2 --
>>   arch/riscv/kernel/probes/Makefile             |  2 +-
>>   arch/riscv/kernel/probes/kprobes.c            | 13 ---------
>>   arch/riscv/kernel/probes/rethook.c            | 27 +++++++++++++++++++
>>   arch/riscv/kernel/probes/rethook.h            |  8 ++++++
>>   ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
>>   7 files changed, 40 insertions(+), 19 deletions(-)
>>   create mode 100644 arch/riscv/kernel/probes/rethook.c
>>   create mode 100644 arch/riscv/kernel/probes/rethook.h
>>   rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (94%)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 59d18881f..bfb66cdc5 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -97,6 +97,7 @@ config RISCV
>>      select HAVE_KPROBES if !XIP_KERNEL
>>      select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>>      select HAVE_KRETPROBES if !XIP_KERNEL
>> +    select HAVE_RETHOOK if !XIP_KERNEL
>>      select HAVE_MOVE_PMD
>>      select HAVE_MOVE_PUD
>>      select HAVE_PCI
>> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
>> index 217ef89f2..e7882ccb0 100644
>> --- a/arch/riscv/include/asm/kprobes.h
>> +++ b/arch/riscv/include/asm/kprobes.h
>> @@ -40,8 +40,6 @@ void arch_remove_kprobe(struct kprobe *p);
>>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
>>   bool kprobe_breakpoint_handler(struct pt_regs *regs);
>>   bool kprobe_single_step_handler(struct pt_regs *regs);
>> -void __kretprobe_trampoline(void);
>> -void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>
>>   #endif /* CONFIG_KPROBES */
>>   #endif /* _ASM_RISCV_KPROBES_H */
>> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
>> index 7f0840dcc..c40139e9c 100644
>> --- a/arch/riscv/kernel/probes/Makefile
>> +++ b/arch/riscv/kernel/probes/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_KPROBES)              += kprobes.o decode-insn.o simulate-insn.o
>> -obj-$(CONFIG_KPROBES)               += kprobes_trampoline.o
>> +obj-$(CONFIG_RETHOOK)               += rethook.o rethook_trampoline.o
>>   obj-$(CONFIG_KPROBES_ON_FTRACE)    += ftrace.o
>>   obj-$(CONFIG_UPROBES)              += uprobes.o decode-insn.o simulate-insn.o
>>   CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
>> index e6e950b7c..f21592d20 100644
>> --- a/arch/riscv/kernel/probes/kprobes.c
>> +++ b/arch/riscv/kernel/probes/kprobes.c
>> @@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
>>      return ret;
>>   }
>>
>> -void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>> -{
>> -    return (void *)kretprobe_trampoline_handler(regs, NULL);
>> -}
>> -
>> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>> -                                  struct pt_regs *regs)
>> -{
>> -    ri->ret_addr = (kprobe_opcode_t *)regs->ra;
>> -    ri->fp = NULL;
>> -    regs->ra = (unsigned long) &__kretprobe_trampoline;
>> -}
>> -
>>   int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>>   {
>>      return 0;
>> diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
>> new file mode 100644
>> index 000000000..cbd0da059
>> --- /dev/null
>> +++ b/arch/riscv/kernel/probes/rethook.c
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Generic return hook for riscv.
>> + */
>> +
>> +#include <linux/kprobes.h>
>> +#include <linux/rethook.h>
>> +#include "rethook.h"
>> +
>> +/* This is called from arch_rethook_trampoline() */
>> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
>> +{
>> +    return rethook_trampoline_handler(regs, regs->s0);
>> +}
>> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
>> +
>> +
>> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
>> +{
>> +    rhn->ret_addr = regs->ra;
>> +    rhn->frame = regs->s0;
>> +
>> +    /* replace return addr with trampoline */
>> +    regs->ra = (unsigned long)arch_rethook_trampoline;
>> +}
>> +NOKPROBE_SYMBOL(arch_rethook_prepare);
>> +
>> diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
>> new file mode 100644
>> index 000000000..cc573d701
>> --- /dev/null
>> +++ b/arch/riscv/kernel/probes/rethook.h
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#ifndef __RISCV_RETHOOK_H
>> +#define __RISCV_RETHOOK_H
>> +
>> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
>> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
>> +
>> +#endif
>> diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
>> similarity index 94%
>> rename from arch/riscv/kernel/probes/kprobes_trampoline.S
>> rename to arch/riscv/kernel/probes/rethook_trampoline.S
>> index 7bdb09ded..21bac92a1 100644
>> --- a/arch/riscv/kernel/probes/kprobes_trampoline.S
>> +++ b/arch/riscv/kernel/probes/rethook_trampoline.S
>> @@ -75,13 +75,13 @@
>>      REG_L x31, PT_T6(sp)
>>      .endm
>>
>> -ENTRY(__kretprobe_trampoline)
>> +ENTRY(arch_rethook_trampoline)
>>      addi sp, sp, -(PT_SIZE_ON_STACK)
>>      save_all_base_regs
>>
>>      move a0, sp /* pt_regs */
>>
>> -    call trampoline_probe_handler
>> +    call arch_rethook_trampoline_callback
>>
>>      /* use the result as the return-address */
>>      move ra, a0
>> @@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
>>      addi sp, sp, PT_SIZE_ON_STACK
>>
>>      ret
>> -ENDPROC(__kretprobe_trampoline)
>> +ENDPROC(arch_rethook_trampoline)
>> --
>> 2.27.0
>>
