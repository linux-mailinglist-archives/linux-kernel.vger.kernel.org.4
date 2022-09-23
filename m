Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2525E8149
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIWSBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIWSBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67112107DCC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:01:40 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id v1so554315ilq.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ZxODueSVu993iow9+IRQcd2cAR/7QHC2F7QagYpj6s4=;
        b=m4Jy84bkMkp1f80KdFX1gy5kqyuYf0YbWTNXm8FznunQJOxjahB98L5/Mu+YpRCnBp
         gWZHoB+mApVmB5qjXWidWFK8SNouHWtPsjP6S4OdGg746JUsvDz478bljPq3EgeTc298
         nbXwyZchisKccQFcr81kdgnoqY5COc/Vj6ZV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZxODueSVu993iow9+IRQcd2cAR/7QHC2F7QagYpj6s4=;
        b=IfTOuvR7iuFJQpgFJQ2U31YaSQu1EKW9rO54DU3mUYcS5pHljlgl/Ze0MyJ1zHDce7
         FaaNgzQMbruVexu4QjCkaeMiDXFeV+ofUydO7GfxsEOhCqpSQe1+53C3TmfDOsBVjhD6
         vtu1foc+2gs05dETckVQY+cyFUPHRWA2Zu7Zg+0TrMkdS7DFRGEE9ehgxOBchZlHlH73
         jK3Tiy1B+GYMRir7MH9b6I40SDGkIR5coKgZrg3+4rWCC/0K4QZMvKuAyAdo2qUNxete
         pjzQS1kbPHJWjTuyN490ZIlCrPo5floo8ShW+XXNrCFOXS61nMBtoolO7o0n8xXmDyhM
         cQcg==
X-Gm-Message-State: ACrzQf1JTThRNDwNUOvBGYDLvT3/knc8nSv3fD4zZVz0UEGBYzM5ltSp
        zVHBZjjmJxywroqsJcbsgSQ6GWtoja3QwUfou9kfEQESlA==
X-Google-Smtp-Source: AMsMyM6yjDcia2g5yXnczkwVN4Voayn7ioPUZPoAnEqys66bbomYiVrEe+ViYZAOo8BHJNy/16+HMt0zRmIU9/QK2Mc=
X-Received: by 2002:a92:cb91:0:b0:2f6:240a:9887 with SMTP id
 z17-20020a92cb91000000b002f6240a9887mr4905573ilo.203.1663956099602; Fri, 23
 Sep 2022 11:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220922060958.44203-1-samuel@sholland.org> <2546376.ElGaqSPkdT@phil>
 <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com> <13396584.uLZWGnKmhe@phil>
In-Reply-To: <13396584.uLZWGnKmhe@phil>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 23 Sep 2022 11:01:28 -0700
Message-ID: <CAOnJCUKdBpbj=KDz5oibB_N_SjOiMrkWcttczuGbisi_nMWaVA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
To:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>, Dao Lu <daolu@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:18 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Donnerstag, 22. September 2022, 17:52:46 CEST schrieb Jessica Clarke:
> > On 22 Sept 2022, at 16:45, Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > Am Donnerstag, 22. September 2022, 08:09:58 CEST schrieb Samuel Holla=
nd:
> > >> commit 8eb060e10185 ("arch/riscv: add Zihintpause support") broke
> > >> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.0):
> > >>
> > >> CC arch/riscv/kernel/vdso/vgettimeofday.o
> > >> In file included from <command-line>:
> > >> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> > >> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 =
probably does not match constraints
> > >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> > >> | ^~~
> > >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of ma=
cro 'asm_volatile_goto'
> > >> 41 | asm_volatile_goto(
> > >> | ^~~~~~~~~~~~~~~~~
> > >> ././include/linux/compiler_types.h:285:33: error: impossible constra=
int in 'asm'
> > >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> > >> | ^~~
> > >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of ma=
cro 'asm_volatile_goto'
> > >> 41 | asm_volatile_goto(
> > >> | ^~~~~~~~~~~~~~~~~
> > >> make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vge=
ttimeofday.o] Error 1
> > >> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> > >>
> > >> Having a static branch in cpu_relax() is problematic because that
> > >> function is widely inlined, including in some quite complex function=
s
> > >> like in the VDSO. A quick measurement shows this static branch is
> > >> responsible by itself for around 40% of the jump table.
> > >>
> > >> Drop the static branch, which ends up being the same number of
> > >> instructions anyway. If Zihintpause is supported, we trade the nop f=
rom
> > >> the static branch for a div. If Zihintpause is unsupported, we trade=
 the
> > >> jump from the static branch for (what gets interpreted as) a nop.
> > >>
> > >> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> > >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> > >> ---
> > >>
> > >> arch/riscv/include/asm/hwcap.h | 3 ---
> > >> arch/riscv/include/asm/vdso/processor.h | 25 ++++++++++-------------=
--
> > >> 2 files changed, 10 insertions(+), 18 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm=
/hwcap.h
> > >> index 6f59ec64175e..b21d46e68386 100644
> > >> --- a/arch/riscv/include/asm/hwcap.h
> > >> +++ b/arch/riscv/include/asm/hwcap.h
> > >> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
> > >> */
> > >> enum riscv_isa_ext_key {
> > >>    RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
> > >> -  RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> > >>    RISCV_ISA_EXT_KEY_MAX,
> > >> };
> > >>
> > >> @@ -88,8 +87,6 @@ static __always_inline int riscv_isa_ext2key(int n=
um)
> > >>            return RISCV_ISA_EXT_KEY_FPU;
> > >>    case RISCV_ISA_EXT_d:
> > >>            return RISCV_ISA_EXT_KEY_FPU;
> > >> -  case RISCV_ISA_EXT_ZIHINTPAUSE:
> > >> -          return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> > >>    default:
> > >>            return -EINVAL;
> > >>    }
> > >> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/in=
clude/asm/vdso/processor.h
> > >> index 1e4f8b4aef79..789bdb8211a2 100644
> > >> --- a/arch/riscv/include/asm/vdso/processor.h
> > >> +++ b/arch/riscv/include/asm/vdso/processor.h
> > >> @@ -4,30 +4,25 @@
> > >>
> > >> #ifndef __ASSEMBLY__
> > >>
> > >> -#include <linux/jump_label.h>
> > >> #include <asm/barrier.h>
> > >> -#include <asm/hwcap.h>
> > >>
> > >> static inline void cpu_relax(void)
> > >> {
> > >> -  if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_Z=
IHINTPAUSE])) {
> > >> #ifdef __riscv_muldiv
> > >> -          int dummy;
> > >> -          /* In lieu of a halt instruction, induce a long-latency s=
tall. */
> > >> -          __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy)=
);
> > >> +  int dummy;
> > >> +  /* In lieu of a halt instruction, induce a long-latency stall. */
> > >> +  __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
> > >> #endif
> > >> -  } else {
> > >> -          /*
> > >> -           * Reduce instruction retirement.
> > >> -           * This assumes the PC changes.
> > >> -           */
> > >> +  /*
> > >> +   * Reduce instruction retirement.
> > >> +   * This assumes the PC changes.
> > >> +   */
> > >> #ifdef __riscv_zihintpause
> > >> -          __asm__ __volatile__ ("pause");
> > >> +  __asm__ __volatile__ ("pause");
> > >> #else
> > >> -          /* Encoding of the pause instruction */
> > >> -          __asm__ __volatile__ (".4byte 0x100000F");
> > >> +  /* Encoding of the pause instruction */
> > >> +  __asm__ __volatile__ (".4byte 0x100000F");
> > >> #endif
> > >
> > > hmm, though before this part of the code was only ever accessed
> > > when the zhintpause extension was really available on the running
> > > machine while now the pause instruction is called every time.
> > >
> > > So I'm just wondering, can't this run into some "illegal instruction"
> > > thingy on machines not supporting the extension?
> >
> > No. The encoding for pause was deliberately chosen to be one of the
> > =E2=80=9Cuseless=E2=80=9D encodings of fence, with the hope that existi=
ng
> > microarchitectures might take a while to execute it and thus it would
> > still function as a slow-running instruction. It=E2=80=99s somewhat
> > questionable whether the div is even needed, the worst that happens is
> > cpu_relax isn=E2=80=99t very relaxed and you spin a bit faster. Any
> > implementations where that=E2=80=99s true probably also don=E2=80=99t h=
ave fancy
> > clock/power management anyway, and div isn=E2=80=99t going to be a low-=
power
> > operation so the only real effect is likely hammering on contended
> > atomics a bit more, and who cares about that on the low core count
> > systems we have today.
>
> thanks a lot for that explanation, which made things a lot clearer.
>
> So as you said, dropping the div part might make the function even smalle=
r,
> though somehow part of me would want to add some sort of comment to
> the function for when the next developer stumbles over the unconditional
> use of pause :-) .
>

I agree. If that's what microarch will do, we can drop div altogether.
Though microarch may be treated as nop even if it is undesirable.
IIRC, the div was introduced for the rocket chip which would induce a
long latency stall with div instruction (zero as operands).

Does any other core or newer rocket chip actually induce a latency
stall with div instruction ?
If not, it is equivalent to NOP as well. We can definitely remove the div.
The only cores affected will be the older rocket core.

Tagging some folks to understand what their core does.

@Paul Walmsley @Guo Ren @Conor Dooley ?

(Please add anybody who may have an insight to execution flow on
existing Linux capable cores)

>
> Heiko
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--
Regards,
Atish
