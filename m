Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC473FF73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjF0PPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjF0PPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:15:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A0270C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:15:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so3080300e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687878916; x=1690470916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EQuyVr7JHKg0+/1h2GBy4g/huTlSZlh5DOVx9XkYto=;
        b=OrdMtENPoBnvA/SviTV3GZG1R36+mKwF7oUyYSEcFmv3zXtOCejJJNQMHv1ET4B8m7
         SyLVEUmHgcEPSBtBdz6QYXaG7+KSwtRczH/gFJbcKHnY399QpM12eBP6xy5HNDnoTt4q
         5gVk4TP8iRGkHerJuGCJx1X5y8iNBv2PdDVHY35bZ/xodU7+xKpU8naho1bhOK8WSOQ2
         /UJWQBxClvNnMepzvZv/hbU18ZWdBCI7iYs3gtJhrOan73aG09Vedxf+B/lRa1sctg9R
         GzVTI+TrZwdnOaJ5bbJpN9mD5OlLBoS8Qd1qA8lzkihQNEhlfFeFGPygef0UUZAJPDiv
         NTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878916; x=1690470916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EQuyVr7JHKg0+/1h2GBy4g/huTlSZlh5DOVx9XkYto=;
        b=jmBI041IRLwywGpSuStWiin53JODPYb+uglZlnmA+EUyGaxulwZ4VSlOwuXEFlJvDm
         enCDjOnBBUKcuYUyU1qJvyenH/h1NinSZ/spOzenSzDHZfgvp2LNUM7yehsvoxiZaVzE
         MDjxlgKYPEHXeEMWUrgMDZaW0I3arasXXTOo/emtGtXacdc8I1xAqhKi2pF6DKrf0BeA
         g0QOuHKi6Lm8k2mFX1hMd6K4LLiQpWVc0PoYtimqxcXvJIREOv2uTAodUvR9RnWY3Jca
         FzfH6faOsCjXtZ3j8VFg3vZT8driiM9WP2Yz11y/Pp149ANG0IZBRYRma87igE9xVH13
         tZxw==
X-Gm-Message-State: AC+VfDzHdUOhyj9p0SyvYt1cWaJ8GtsXkgpb9OZSWikcYlB2LR5nQnkZ
        pAFgD9i6v4dTb/Fwclksw8y5BJuzidNj7O89d6zX0w==
X-Google-Smtp-Source: ACHHUZ52fzXrBv0CBQuudYgePTbv9h72sFJOP/S+PLzzwTofgYHEqU+9ntIIx0uloa9FUXk7t4qszeCLK/7Haje1jJc=
X-Received: by 2002:a05:6512:3ba8:b0:4fb:822d:83ab with SMTP id
 g40-20020a0565123ba800b004fb822d83abmr2261151lfv.20.1687878915827; Tue, 27
 Jun 2023 08:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230626165736.65927-1-bjorn@kernel.org>
In-Reply-To: <20230626165736.65927-1-bjorn@kernel.org>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Tue, 27 Jun 2023 23:15:01 +0800
Message-ID: <CABgGipWUO6bXQQzMCXxpkv4MYTpH3MUtPHUVe-=VhsZk3HPNMg@mail.gmail.com>
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

On Tue, Jun 27, 2023 at 12:57=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The RISC-V vector specification states:
>   Executing a system call causes all caller-saved vector registers
>   (v0-v31, vl, vtype) and vstart to become unspecified.
>
> The vector registers are set to all 1s, vill is set (invalid), and the
> vector status is set to Initial.
>
> That way we can prevent userspace from accidentally relying on the
> stated save.
>
> R=C3=A9mi pointed out [1] that writing to the registers might be
> superfluous, and setting vill is sufficient.
>
> Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.reml=
ab.net/ # [1]
> Suggested-by: Darius Rad <darius@bluespec.com>
> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
> Suggested-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
> v1->v2:
>   Proper register restore for initial state (Andy)
>   Set registers to 1s, and not 0s (Darius)
> ---
>  arch/riscv/include/asm/vector.h | 42 ++++++++++++++++++++++++++++++---
>  arch/riscv/kernel/traps.c       |  2 ++
>  2 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 04c0b07bf6cd..93d702d9988c 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -139,14 +139,49 @@ static inline void riscv_v_vstate_save(struct task_=
struct *task,
>         }
>  }
>
> +static inline void __riscv_v_vstate_discard(void)
> +{
> +       unsigned long vl, vtype_inval =3D 1UL << (BITS_PER_LONG - 1);
> +
> +       riscv_v_enable();
> +       asm volatile (
> +               ".option push\n\t"
> +               ".option arch, +v\n\t"
> +               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
> +               "vmv.v.i        v0, -1\n\t"
> +               "vmv.v.i        v8, -1\n\t"
> +               "vmv.v.i        v16, -1\n\t"
> +               "vmv.v.i        v24, -1\n\t"
> +               "vsetvl         %0, x0, %1\n\t"
> +               ".option pop\n\t"
> +               : "=3D&r" (vl) : "r" (vtype_inval) : "memory");
> +       riscv_v_disable();
> +}
> +
> +static inline void riscv_v_vstate_discard(struct pt_regs *regs)
> +{
> +       if (!riscv_v_vstate_query(regs))
> +               return;
> +
> +       __riscv_v_vstate_discard();
> +       riscv_v_vstate_on(regs);
> +}
> +
>  static inline void riscv_v_vstate_restore(struct task_struct *task,
>                                           struct pt_regs *regs)
>  {
> -       if ((regs->status & SR_VS) !=3D SR_VS_OFF) {
> -               struct __riscv_v_ext_state *vstate =3D &task->thread.vsta=
te;
> -
> +       struct __riscv_v_ext_state *vstate =3D &task->thread.vstate;
> +       unsigned long status =3D regs->status & SR_VS;
> +
> +       switch (status) {
> +       case SR_VS_INITIAL:
> +               __riscv_v_vstate_discard();
> +               break;
> +       case SR_VS_CLEAN:
> +       case SR_VS_DIRTY:
>                 __riscv_v_vstate_restore(vstate, vstate->datap);
>                 __riscv_v_vstate_clean(regs);
> +               break;
>         }
>  }
>
> @@ -178,6 +213,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(v=
oid) { return false; }
>  #define __switch_to_vector(__prev, __next)     do {} while (0)
>  #define riscv_v_vstate_off(regs)               do {} while (0)
>  #define riscv_v_vstate_on(regs)                        do {} while (0)
> +#define riscv_v_vstate_discard(regs)           do {} while (0)
>
>  #endif /* CONFIG_RISCV_ISA_V */
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 5158961ea977..5ff63a784a6d 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -296,6 +296,8 @@ asmlinkage __visible __trap_section void do_trap_ecal=
l_u(struct pt_regs *regs)
>                 regs->epc +=3D 4;
>                 regs->orig_a0 =3D regs->a0;
>
> +               riscv_v_vstate_discard(regs);
> +
>                 syscall =3D syscall_enter_from_user_mode(regs, syscall);
>
>                 if (syscall < NR_syscalls)
>
> base-commit: 488833ccdcac118da16701f4ee0673b20ba47fe3
> --
> 2.39.2
>

Hi, the above part looks good to me. In the context of kernel-mode
vector, it would also be good to just discard V-context at the syscall
entry. So the kernel can freely use Vector if needed. I will rebase my
work on top of yours.

Another part that just came into my mind is the one for ptrace. Do we
need to disallow, or immediately return all -1 if the tracee process
is in the syscall path? It seems that we are likely to get stale
values on datap if a tracee is being traced during a syscall.

Thanks,
Andy
