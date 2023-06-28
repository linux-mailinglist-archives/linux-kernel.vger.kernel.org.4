Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947B3740EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjF1Khy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjF1Kft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C3619B9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27CA3612A0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056E8C433C0;
        Wed, 28 Jun 2023 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687948546;
        bh=mKJBV3CVTPbAXUsQVPYh09KVE3ZPO51JzSPCMXpKhMY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VHMQXtcYcCaXbO5HfYJFyDD2y/RQ0RYL1ijps/EWpebQwg1uQXYySNTgEKL+xHQWv
         813Xb6WKWUx9wAL3KIQFDYhpNKRcRV4kTAy1EQxjs3CA1U7VJN5RBfvUzzDhVWS4wr
         uBU3tB/I5/3YfQ+lgERlipK2bSudX9wmNIAUJzAYUZIONPY72NUMV7qd3QwDbKYbIl
         pvrC3WcMWdpH0Q4PtblT2vv6z6AMyzB4eIJk2k8elxFasJj5BkTmr6F0mgR104VnL1
         sz67oI9tbr9s7rjm5ADqc++qYeA7sOfrAOBHmAK5YUxtqHuWUL1CMV15ZHhEzNc3aX
         o4T8EjCHmTtRA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Andy Chiu <andy.chiu@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?utf-8?Q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>,
        Darius Rad <darius@bluespec.com>
Subject: Re: [PATCH v2] riscv: Discard vector state on syscalls
In-Reply-To: <CABgGipWUO6bXQQzMCXxpkv4MYTpH3MUtPHUVe-=VhsZk3HPNMg@mail.gmail.com>
References: <20230626165736.65927-1-bjorn@kernel.org>
 <CABgGipWUO6bXQQzMCXxpkv4MYTpH3MUtPHUVe-=VhsZk3HPNMg@mail.gmail.com>
Date:   Wed, 28 Jun 2023 12:35:43 +0200
Message-ID: <87tturnabk.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Chiu <andy.chiu@sifive.com> writes:

> On Tue, Jun 27, 2023 at 12:57=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> The RISC-V vector specification states:
>>   Executing a system call causes all caller-saved vector registers
>>   (v0-v31, vl, vtype) and vstart to become unspecified.
>>
>> The vector registers are set to all 1s, vill is set (invalid), and the
>> vector status is set to Initial.
>>
>> That way we can prevent userspace from accidentally relying on the
>> stated save.
>>
>> R=C3=A9mi pointed out [1] that writing to the registers might be
>> superfluous, and setting vill is sufficient.
>>
>> Link: https://lore.kernel.org/linux-riscv/12784326.9UPPK3MAeB@basile.rem=
lab.net/ # [1]
>> Suggested-by: Darius Rad <darius@bluespec.com>
>> Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Suggested-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>> v1->v2:
>>   Proper register restore for initial state (Andy)
>>   Set registers to 1s, and not 0s (Darius)
>> ---
>>  arch/riscv/include/asm/vector.h | 42 ++++++++++++++++++++++++++++++---
>>  arch/riscv/kernel/traps.c       |  2 ++
>>  2 files changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/ve=
ctor.h
>> index 04c0b07bf6cd..93d702d9988c 100644
>> --- a/arch/riscv/include/asm/vector.h
>> +++ b/arch/riscv/include/asm/vector.h
>> @@ -139,14 +139,49 @@ static inline void riscv_v_vstate_save(struct task=
_struct *task,
>>         }
>>  }
>>
>> +static inline void __riscv_v_vstate_discard(void)
>> +{
>> +       unsigned long vl, vtype_inval =3D 1UL << (BITS_PER_LONG - 1);
>> +
>> +       riscv_v_enable();
>> +       asm volatile (
>> +               ".option push\n\t"
>> +               ".option arch, +v\n\t"
>> +               "vsetvli        %0, x0, e8, m8, ta, ma\n\t"
>> +               "vmv.v.i        v0, -1\n\t"
>> +               "vmv.v.i        v8, -1\n\t"
>> +               "vmv.v.i        v16, -1\n\t"
>> +               "vmv.v.i        v24, -1\n\t"
>> +               "vsetvl         %0, x0, %1\n\t"
>> +               ".option pop\n\t"
>> +               : "=3D&r" (vl) : "r" (vtype_inval) : "memory");
>> +       riscv_v_disable();
>> +}
>> +
>> +static inline void riscv_v_vstate_discard(struct pt_regs *regs)
>> +{
>> +       if (!riscv_v_vstate_query(regs))
>> +               return;
>> +
>> +       __riscv_v_vstate_discard();
>> +       riscv_v_vstate_on(regs);
>> +}
>> +
>>  static inline void riscv_v_vstate_restore(struct task_struct *task,
>>                                           struct pt_regs *regs)
>>  {
>> -       if ((regs->status & SR_VS) !=3D SR_VS_OFF) {
>> -               struct __riscv_v_ext_state *vstate =3D &task->thread.vst=
ate;
>> -
>> +       struct __riscv_v_ext_state *vstate =3D &task->thread.vstate;
>> +       unsigned long status =3D regs->status & SR_VS;
>> +
>> +       switch (status) {
>> +       case SR_VS_INITIAL:
>> +               __riscv_v_vstate_discard();
>> +               break;
>> +       case SR_VS_CLEAN:
>> +       case SR_VS_DIRTY:
>>                 __riscv_v_vstate_restore(vstate, vstate->datap);
>>                 __riscv_v_vstate_clean(regs);
>> +               break;
>>         }
>>  }
>>
>> @@ -178,6 +213,7 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(=
void) { return false; }
>>  #define __switch_to_vector(__prev, __next)     do {} while (0)
>>  #define riscv_v_vstate_off(regs)               do {} while (0)
>>  #define riscv_v_vstate_on(regs)                        do {} while (0)
>> +#define riscv_v_vstate_discard(regs)           do {} while (0)
>>
>>  #endif /* CONFIG_RISCV_ISA_V */
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 5158961ea977..5ff63a784a6d 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -296,6 +296,8 @@ asmlinkage __visible __trap_section void do_trap_eca=
ll_u(struct pt_regs *regs)
>>                 regs->epc +=3D 4;
>>                 regs->orig_a0 =3D regs->a0;
>>
>> +               riscv_v_vstate_discard(regs);
>> +
>>                 syscall =3D syscall_enter_from_user_mode(regs, syscall);
>>
>>                 if (syscall < NR_syscalls)
>>
>> base-commit: 488833ccdcac118da16701f4ee0673b20ba47fe3
>> --
>> 2.39.2
>>
>
> Hi, the above part looks good to me. In the context of kernel-mode
> vector, it would also be good to just discard V-context at the syscall
> entry. So the kernel can freely use Vector if needed. I will rebase my
> work on top of yours.

Ok!

> Another part that just came into my mind is the one for ptrace. Do we
> need to disallow, or immediately return all -1 if the tracee process
> is in the syscall path? It seems that we are likely to get stale
> values on datap if a tracee is being traced during a syscall.

Hmm, could you elaborate a bit on when the tracer would get stale regs?
