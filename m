Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17A769D7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjBUA54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBUA5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:57:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C830FC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 16:57:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 900E6CE1264
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC23BC433A0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676941069;
        bh=2U77emMxZCJK0muP9uqiLxYApzuUYnFt3FC/cM2Sl8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YDowIFslhLW0nRS6jEESOcLRwT+2N6NWKamVze3XH6HcbZAsRMSgugxjQboiqdcqW
         FPNz/mvIgQf7zsf+Jra23ITa8hETU5YtO9gvyt51PPAfrdJIUEYHxsX44arcbp4ksK
         RdrMrORIvFjNF4deRn96ZvyO7X6PuD+D4YaMj84f4U8z921jUDqGeCMNDCkMgvBHNa
         +SKg9pNe1US16yDpaSzLqfCKeUmEDPouP+/F0Ba43wyiOiLm642JBqG0jHwffzWV5H
         6Q51FOg+Uyq+Dkep+Wfk7f1zEzQwGr+tDqWyvFEtYgwei2xUr9c6U7GKPtWMxgw2k1
         V89DXXCGJpRNQ==
Received: by mail-ed1-f47.google.com with SMTP id ck15so12181753edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 16:57:49 -0800 (PST)
X-Gm-Message-State: AO0yUKULZ5Hf1NfjcwbKZuYj6zQu81Oblbui1wcOfcRkvKf0ZE15y7Gj
        9EGsY177ThcIcq9ubRq47Omsfr6uEho6NY4IPck=
X-Google-Smtp-Source: AK7set812L7nRs5euDJ3PT/OYLOJgSnYAJL71so7Vxh/1YKPDgaRO8nbLFoOBH8i087dkguT4GDDIds8RpU7/Iwv5xc=
X-Received: by 2002:a17:906:4550:b0:8b1:7aec:c8e7 with SMTP id
 s16-20020a170906455000b008b17aecc8e7mr6705351ejq.8.1676941067986; Mon, 20 Feb
 2023 16:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <20230217004234.dbf3159e821e6581a62374b1@kernel.org>
In-Reply-To: <20230217004234.dbf3159e821e6581a62374b1@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Feb 2023 08:57:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTdojp+GohNv7BcdPGiEc=JCfi1SWjzfv6qKTF1JY+KCw@mail.gmail.com>
Message-ID: <CAJF2gTTdojp+GohNv7BcdPGiEc=JCfi1SWjzfv6qKTF1JY+KCw@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:42 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 26 Jan 2023 11:15:59 -0500
> guoren@kernel.org wrote:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The previous implementation was based on the stop_matchine mechanism,
> > which reduced the speed of arm/disarm_kprobe. Using minimum ebreak
> > instruction would get accurate atomicity.
> >
> > This patch removes the patch_text of riscv, which is based on
> > stop_machine. Then riscv only reserved patch_text_nosync, and developers
> > need to be more careful in dealing with patch_text atomicity.
> >
> > When CONFIG_RISCV_ISA_C=n, the ebreak could replace the whole
> > instruction. When CONFIG_RISCV_ISA_C=y, the patch uses 16-bit length
> > c.ebreak instruction, which may occupy the first part of the 32-bit
> > instruction and leave half the rest of the broken instruction. Because
> > ebreak could detour the flow to skip it, leaving it in the kernel text
> > memory is okay.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
>
> I'm not sure how the RISCV specification ensures this type of self
> code modification. But if you think calling the stop_machine() for
> *each* probe arm/disarm is slow, there may be another way to avoid
> ot by introducing a batch arming interface too. (reserve-commit way)
Could you give out "reserve-commit way" link? I'm not making sense of
that, thank you.

>
> BTW, for the BPF usecase which is usually only for function
> entry/exit, we will use Fprobes. Since that will use ftrace batch
> text patching, I think we already avoid such slowdown.
>
> FYI, for ftrace dynamic event usecase, there is another reason to slow
> down the enable/disable dynamic event itself (to sync up the event
> enabled status to ensure all event handler has been done, it waits
> for rcu-sync for each operation.)
If it's done, the ftrace common code will guarantee all events are
done. Do you know if anyone has started this work? - "sync up the
event enabled status to ensure all event handler has been done".

>
> Thank you,
>
> > ---
> >  arch/riscv/include/asm/patch.h     |  1 -
> >  arch/riscv/kernel/patch.c          | 33 ------------------------------
> >  arch/riscv/kernel/probes/kprobes.c | 29 ++++++++++++++++++--------
> >  3 files changed, 21 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
> > index 9a7d7346001e..2500782e6f5b 100644
> > --- a/arch/riscv/include/asm/patch.h
> > +++ b/arch/riscv/include/asm/patch.h
> > @@ -7,6 +7,5 @@
> >  #define _ASM_RISCV_PATCH_H
> >
> >  int patch_text_nosync(void *addr, const void *insns, size_t len);
> > -int patch_text(void *addr, u32 insn);
> >
> >  #endif /* _ASM_RISCV_PATCH_H */
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 765004b60513..8bd51ed8b806 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -98,36 +98,3 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
> >       return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_nosync);
> > -
> > -static int patch_text_cb(void *data)
> > -{
> > -     struct patch_insn *patch = data;
> > -     int ret = 0;
> > -
> > -     if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
> > -             ret =
> > -                 patch_text_nosync(patch->addr, &patch->insn,
> > -                                         GET_INSN_LENGTH(patch->insn));
> > -             atomic_inc(&patch->cpu_count);
> > -     } else {
> > -             while (atomic_read(&patch->cpu_count) <= num_online_cpus())
> > -                     cpu_relax();
> > -             smp_mb();
> > -     }
> > -
> > -     return ret;
> > -}
> > -NOKPROBE_SYMBOL(patch_text_cb);
> > -
> > -int patch_text(void *addr, u32 insn)
> > -{
> > -     struct patch_insn patch = {
> > -             .addr = addr,
> > -             .insn = insn,
> > -             .cpu_count = ATOMIC_INIT(0),
> > -     };
> > -
> > -     return stop_machine_cpuslocked(patch_text_cb,
> > -                                    &patch, cpu_online_mask);
> > -}
> > -NOKPROBE_SYMBOL(patch_text);
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> > index 475989f06d6d..27f8960c321c 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -24,12 +24,18 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
> >  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> >  {
> >       unsigned long offset = GET_INSN_LENGTH(p->opcode);
> > +#ifdef CONFIG_RISCV_ISA_C
> > +     u32 opcode = __BUG_INSN_16;
> > +#else
> > +     u32 opcode = __BUG_INSN_32;
> > +#endif
> >
> >       p->ainsn.api.restore = (unsigned long)p->addr + offset;
> >
> > -     patch_text(p->ainsn.api.insn, p->opcode);
> > -     patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> > -                __BUG_INSN_32);
> > +     patch_text_nosync(p->ainsn.api.insn, &p->opcode, offset);
> > +     patch_text_nosync((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> > +                       &opcode, GET_INSN_LENGTH(opcode));
> > +
> >  }
> >
> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
> >  /* install breakpoint in text */
> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
> >  {
> > -     if ((p->opcode & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
> > -             patch_text(p->addr, __BUG_INSN_32);
> > -     else
> > -             patch_text(p->addr, __BUG_INSN_16);
> > +#ifdef CONFIG_RISCV_ISA_C
> > +     u32 opcode = __BUG_INSN_16;
> > +#else
> > +     u32 opcode = __BUG_INSN_32;
> > +#endif
> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode));
> >  }
> >
> >  /* remove breakpoint from text */
> >  void __kprobes arch_disarm_kprobe(struct kprobe *p)
> >  {
> > -     patch_text(p->addr, p->opcode);
> > +#ifdef CONFIG_RISCV_ISA_C
> > +     u32 opcode = __BUG_INSN_16;
> > +#else
> > +     u32 opcode = __BUG_INSN_32;
> > +#endif
> > +     patch_text_nosync(p->addr, &p->opcode, GET_INSN_LENGTH(opcode));
> >  }
> >
> >  void __kprobes arch_remove_kprobe(struct kprobe *p)
> > --
> > 2.36.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



-- 
Best Regards
 Guo Ren
