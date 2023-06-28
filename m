Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C57416EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjF1RDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjF1RDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:03:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA8B1BD5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:03:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso1166361e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687971811; x=1690563811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fGniKrnRVqiskki+vMFs5QmWoxWcrUy88Xnd4dtv6E=;
        b=UVR8HYdK9gFstICmY4hAkepr0QKxMKfOXwIhsNDGim9/jjneMNoGUKuh3t5n7laOBp
         98wea9zROg8nb/7ZIrwfNifWqxofTMNzvvd0NQDsxf5rGU3Iz0FwyQ8THq3cLB79bRmt
         jIeRJhjwn8Yn9BwkKcX6v9sKJ1ggN+WO/SEh4oDq/2ZleU+of05aCoazBHAgI0nCPOVb
         fyiAAjRcdMdX46BfAWosXPvHaLIDJz1wbqO5Ye5W9vwoU9KUXjQXm0qT9JQGWe5d3lpE
         6lTH94fx+GY7QDRXBFFs6agFadAmy1GMr/OueUfknMBIY6659OlXC7eF9w3SlP16RU70
         rXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687971811; x=1690563811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fGniKrnRVqiskki+vMFs5QmWoxWcrUy88Xnd4dtv6E=;
        b=f/4epvipzlADJ6Uj97kQ3IEPfNYNYI2WBOi7fVDRTIgZZaek9PyKVIm1HtKPmly7fe
         yLESLu0ugvC0nvQNX7dWfy4ckPXldeAoaq4Q/9agV4ElI10spF+VQimb1BMuwmqvLmIH
         Ec6w1tgMGV/XAXcsRau3Khg4nklZoVbg4QLmUcZe5YjStx3vOqcowB5sXV47dbyySvVt
         HXJX0MTDWaKYEx7yoZZ1ksvG95A/uRtfQzVdEKxc8UljQEgokppqVdqnqLNhe/oB8nEq
         gK5Zj7yMrKLdKfQp2E2220BCA53cH9/O3zHyFYoDnEjlWV6R8fkAc4gwVXfyOtALu289
         BiKQ==
X-Gm-Message-State: AC+VfDzQo7v9gRwPXh+rvNgyXrfH8ABLSkGE5b1YGokCbH51Khd4p7aI
        UXxdYc877cB1305RXik2QU+btz5Qjfp5Poq8wxRKnAy5w75JU4+BzWc71w==
X-Google-Smtp-Source: ACHHUZ5J1P85vLM25PblVSGE1F5G9PmOIFlymdbV93aCEGjSE0olGYNnab2Irx0SdIHbinxXdEqWJZdBltfet/iGYLo=
X-Received: by 2002:a05:6512:3ec:b0:4fa:fc12:2bdd with SMTP id
 n12-20020a05651203ec00b004fafc122bddmr6092614lfq.40.1687971811374; Wed, 28
 Jun 2023 10:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230626165736.65927-1-bjorn@kernel.org> <CABgGipWUO6bXQQzMCXxpkv4MYTpH3MUtPHUVe-=VhsZk3HPNMg@mail.gmail.com>
 <87tturnabk.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87tturnabk.fsf@all.your.base.are.belong.to.us>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Thu, 29 Jun 2023 01:03:19 +0800
Message-ID: <CABgGipUFPv0TOWdz_3LofARZ0DH6H2sSzxBD0t=h2-YhmzC2OQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Discard vector state on syscalls
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>,
        Darius Rad <darius@bluespec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 6:35=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Andy Chiu <andy.chiu@sifive.com> writes:
>
> > On Tue, Jun 27, 2023 at 12:57=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
> >>
> >> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >>
> >> The RISC-V vector specification states:
> >>   Executing a system call causes all caller-saved vector registers
> >>   (v0-v31, vl, vtype) and vstart to become unspecified.
> >>
> >> The vector registers are set to all 1s, vill is set (invalid), and the
> >> vector status is set to Initial.
> >>
> >> That way we can prevent userspace from accidentally relying on the
> >> stated save.
> >>
> >> R=C3=A9mi pointed out [1] that writing to the registers might be
> >> superfluous, and setting vill is sufficient.
> >>
> >> Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.r=
emlab.net/ # [1]
> >> Suggested-by: Darius Rad <darius@bluespec.com>
> >> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> Suggested-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>
> >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> ---
> >> v1->v2:
> >>   Proper register restore for initial state (Andy)
> >>   Set registers to 1s, and not 0s (Darius)
> >> ---
> >>  arch/riscv/include/asm/vector.h | 42 ++++++++++++++++++++++++++++++--=
-
> >>  arch/riscv/kernel/traps.c       |  2 ++
> >>  2 files changed, 41 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/=
vector.h
> >> index 04c0b07bf6cd..93d702d9988c 100644
> >> --- a/arch/riscv/include/asm/vector.h
> >> +++ b/arch/riscv/include/asm/vector.h
> >> @@ -139,14 +139,49 @@ static inline void riscv_v_vstate_save(struct ta=
sk_struct *task,
> >>         }
> >>  }
> >>
> >> +static inline void __riscv_v_vstate_discard(void)
> >> +{
> >> +       unsigned long vl, vtype_inval =3D 1UL << (BITS_PER_LONG - 1);
> >> +
> >> +       riscv_v_enable();
> >> +       asm volatile (
> >> +               ".option push\n\t"
> >> +               ".option arch, +v\n\t"
> >> +               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> >> +               "vmv.v.i        v0, -1\n\t"
> >> +               "vmv.v.i        v8, -1\n\t"
> >> +               "vmv.v.i        v16, -1\n\t"
> >> +               "vmv.v.i        v24, -1\n\t"
> >> +               "vsetvl         %0, x0, %1\n\t"
> >> +               ".option pop\n\t"
> >> +               : "=3D&r" (vl) : "r" (vtype_inval) : "memory");
> >> +       riscv_v_disable();
> >> +}
> >> +
> >> +static inline void riscv_v_vstate_discard(struct pt_regs *regs)
> >> +{
> >> +       if (!riscv_v_vstate_query(regs))
> >> +               return;
> >> +
> >> +       __riscv_v_vstate_discard();
> >> +       riscv_v_vstate_on(regs);
> >> +}
> >> +
> >>  static inline void riscv_v_vstate_restore(struct task_struct *task,
> >>                                           struct pt_regs *regs)
> >>  {
> >> -       if ((regs->status & SR_VS) !=3D SR_VS_OFF) {
> >> -               struct __riscv_v_ext_state *vstate =3D &task->thread.v=
state;
> >> -
> >> +       struct __riscv_v_ext_state *vstate =3D &task->thread.vstate;
> >> +       unsigned long status =3D regs->status & SR_VS;
> >> +
> >> +       switch (status) {
> >> +       case SR_VS_INITIAL:
> >> +               __riscv_v_vstate_discard();
> >> +               break;
> >> +       case SR_VS_CLEAN:
> >> +       case SR_VS_DIRTY:
> >>                 __riscv_v_vstate_restore(vstate, vstate->datap);
> >>                 __riscv_v_vstate_clean(regs);
> >> +               break;
> >>         }
> >>  }
> >>
> >> @@ -178,6 +213,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowe=
d(void) { return false; }
> >>  #define __switch_to_vector(__prev, __next)     do {} while (0)
> >>  #define riscv_v_vstate_off(regs)               do {} while (0)
> >>  #define riscv_v_vstate_on(regs)                        do {} while (0=
)
> >> +#define riscv_v_vstate_discard(regs)           do {} while (0)
> >>
> >>  #endif /* CONFIG_RISCV_ISA_V */
> >>
> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >> index 5158961ea977..5ff63a784a6d 100644
> >> --- a/arch/riscv/kernel/traps.c
> >> +++ b/arch/riscv/kernel/traps.c
> >> @@ -296,6 +296,8 @@ asmlinkage __visible __trap_section void do_trap_e=
call_u(struct pt_regs *regs)
> >>                 regs->epc +=3D 4;
> >>                 regs->orig_a0 =3D regs->a0;
> >>
> >> +               riscv_v_vstate_discard(regs);
> >> +
> >>                 syscall =3D syscall_enter_from_user_mode(regs, syscall=
);
> >>
> >>                 if (syscall < NR_syscalls)
> >>
> >> base-commit: 488833ccdcac118da16701f4ee0673b20ba47fe3
> >> --
> >> 2.39.2
> >>
> >
> > Hi, the above part looks good to me. In the context of kernel-mode
> > vector, it would also be good to just discard V-context at the syscall
> > entry. So the kernel can freely use Vector if needed. I will rebase my
> > work on top of yours.
>
> Ok!
>
> > Another part that just came into my mind is the one for ptrace. Do we
> > need to disallow, or immediately return all -1 if the tracee process
> > is in the syscall path? It seems that we are likely to get stale
> > values on datap if a tracee is being traced during a syscall.
>
> Hmm, could you elaborate a bit on when the tracer would get stale regs?

Yep, consider that our tracer process attaches to a tracee with
PTRACE_SYSCALL. Then, the tracee will let the tracer to inspect it
whenever it makes a syscall. The tracer wants to inspect V-registers
at these PTRACE_SYSCALL stops. Assume the tracee context switches out
before being inspected (Sadly I didn't find this part in the code, so
maybe I was wrong). Now, we set all V-regs to -1 and VS to 'On'
entering a syscall. However, -1 will not be saved into datap, which
the tracer copies from, because riscv_v_vstate_save() only saves
whenever VS is 'Dirty'. We intentionally want this because it saves
unnecessary context saves. As a result, what we will get with REGSET_V
will not reflect the latest one, and what we set will get lost since
VS=3D'ON' restores V to -1.

Since we are planning to discard V registers on syscall, does it make
sense to also make ptrace aware of this? Or, just leave it as-it
because reading/writing V register at syscall is not meaningful
already.

Thanks,
Andy
