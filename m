Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844BE5EEC71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiI2D0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiI2D0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:26:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5309E7C30C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:26:13 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z191so11662732iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Ne3sDvSeT8T6lMIITrfZjeG7rkyUrTjPzLdvXstuzwM=;
        b=UgIV8/qkpJBS0CkPpj/hxfcY1hOzmButi4RjRE/PR/PYEa6YicQOVZACjYI7FoTLJo
         sBjcDqlDvEkphA5sfPmaCrI2ICC+BQUT+a47HjurLoRbU3y6S1rnOV6tTRJNrcR/zXt4
         bc4s4U7AlqulJ180bheWKC0z15AAqiWkeOTWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ne3sDvSeT8T6lMIITrfZjeG7rkyUrTjPzLdvXstuzwM=;
        b=QcMqJOi7Tk9RnEHWKUojiDFL/vL/gMagkhjbT6Di9O0Rf6+LicVzl+5TG7cpfi+Y8q
         KULU5d6kHY7DYoq5s3h5Za78qOOOUr2mvKngQaVvuSreZ3C3v/yc/CBvlAkbOXRzVBrO
         y9BAtOVsGF8uRio/4+7bxFs1JLi5WB3IlIP5dl60nVwLRKU8ObT6AE1RkS41eMAC5v8T
         14rT2WrVJRdXq7PXR3njM5CRANkrL1AeKlb1xDnvEhADXJgscqJxynaZcHamzb10RYNY
         DPy/uVQIk44E76Zfs4KkGudMoJy98AHetPeV6Wi/gXBA/EQt013Jn3VETQ3b2AN+wG9m
         Ls3Q==
X-Gm-Message-State: ACrzQf1jCB6qA6d/HbhIjSotGCknyVUBwCe+ziokiIp/ujOPy+HUIGby
        2Ex9izr+FA/p0Afwgtx+OzoZxMdElVg+80DpMPOG
X-Google-Smtp-Source: AMsMyM7QOPJZdGG8EehoY4nxzckz9poShCyfQCbiTWPufxEOUahaboW/kMlGCowMNjPFKatTl37bmbKNilBm3MWoOZs=
X-Received: by 2002:a05:6638:25cb:b0:35b:b1cd:c411 with SMTP id
 u11-20020a05663825cb00b0035bb1cdc411mr706166jat.308.1664421972588; Wed, 28
 Sep 2022 20:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220922060958.44203-1-samuel@sholland.org> <2546376.ElGaqSPkdT@phil>
 <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com> <13396584.uLZWGnKmhe@phil>
 <CAOnJCUKdBpbj=KDz5oibB_N_SjOiMrkWcttczuGbisi_nMWaVA@mail.gmail.com>
 <Yy+Plxzj4bckXrhy@spud> <CAOnJCU+fA-pxLPRviqW2d7q-E__qJYkZKkCdiNHXhJBjWCRPaA@mail.gmail.com>
 <YzS5kT2CCBPxqLg+@spud>
In-Reply-To: <YzS5kT2CCBPxqLg+@spud>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 28 Sep 2022 20:26:01 -0700
Message-ID: <CAOnJCUKn-rNwyw5BK7=hNM-vnJ=VROjipCiDtB4BL=LZ3kKAAg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
To:     Conor Dooley <conor@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
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

On Wed, Sep 28, 2022 at 2:16 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Wed, Sep 28, 2022 at 12:21:55AM -0700, Atish Patra wrote:
> > On Sat, Sep 24, 2022 at 4:15 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Fri, Sep 23, 2022 at 11:01:28AM -0700, Atish Patra wrote:
> > > > On Fri, Sep 23, 2022 at 12:18 AM Heiko Stuebner <heiko@sntech.de> w=
rote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Am Donnerstag, 22. September 2022, 17:52:46 CEST schrieb Jessica =
Clarke:
> > > > > > On 22 Sept 2022, at 16:45, Heiko Stuebner <heiko@sntech.de> wro=
te:
> > > > > > >
> > > > > > > Am Donnerstag, 22. September 2022, 08:09:58 CEST schrieb Samu=
el Holland:
> > > > > > >> commit 8eb060e10185 ("arch/riscv: add Zihintpause support") =
broke
> > > > > > >> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.=
0):
> > > > > > >>
> > > > > > >> CC arch/riscv/kernel/vdso/vgettimeofday.o
> > > > > > >> In file included from <command-line>:
> > > > > > >> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_rela=
x':
> > > > > > >> ././include/linux/compiler_types.h:285:33: warning: 'asm' op=
erand 0 probably does not match constraints
> > > > > > >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> > > > > > >> | ^~~
> > > > > > >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansi=
on of macro 'asm_volatile_goto'
> > > > > > >> 41 | asm_volatile_goto(
> > > > > > >> | ^~~~~~~~~~~~~~~~~
> > > > > > >> ././include/linux/compiler_types.h:285:33: error: impossible=
 constraint in 'asm'
> > > > > > >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> > > > > > >> | ^~~
> > > > > > >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansi=
on of macro 'asm_volatile_goto'
> > > > > > >> 41 | asm_volatile_goto(
> > > > > > >> | ^~~~~~~~~~~~~~~~~
> > > > > > >> make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel/=
vdso/vgettimeofday.o] Error 1
> > > > > > >> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> > > > > > >>
> > > > > > >> Having a static branch in cpu_relax() is problematic because=
 that
> > > > > > >> function is widely inlined, including in some quite complex =
functions
> > > > > > >> like in the VDSO. A quick measurement shows this static bran=
ch is
> > > > > > >> responsible by itself for around 40% of the jump table.
> > > > > > >>
> > > > > > >> Drop the static branch, which ends up being the same number =
of
> > > > > > >> instructions anyway. If Zihintpause is supported, we trade t=
he nop from
> > > > > > >> the static branch for a div. If Zihintpause is unsupported, =
we trade the
> > > > > > >> jump from the static branch for (what gets interpreted as) a=
 nop.
> > > > > > >>
> > > > > > >> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> > > > > > >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> > > > > > >> ---
> > > > > > >>
> > > > > > >> arch/riscv/include/asm/hwcap.h | 3 ---
> > > > > > >> arch/riscv/include/asm/vdso/processor.h | 25 ++++++++++-----=
----------
> > > > > > >> 2 files changed, 10 insertions(+), 18 deletions(-)
> > > > > > >>
> > > > > > >> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/inc=
lude/asm/hwcap.h
> > > > > > >> index 6f59ec64175e..b21d46e68386 100644
> > > > > > >> --- a/arch/riscv/include/asm/hwcap.h
> > > > > > >> +++ b/arch/riscv/include/asm/hwcap.h
> > > > > > >> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
> > > > > > >> */
> > > > > > >> enum riscv_isa_ext_key {
> > > > > > >>    RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
> > > > > > >> -  RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> > > > > > >>    RISCV_ISA_EXT_KEY_MAX,
> > > > > > >> };
> > > > > > >>
> > > > > > >> @@ -88,8 +87,6 @@ static __always_inline int riscv_isa_ext2k=
ey(int num)
> > > > > > >>            return RISCV_ISA_EXT_KEY_FPU;
> > > > > > >>    case RISCV_ISA_EXT_d:
> > > > > > >>            return RISCV_ISA_EXT_KEY_FPU;
> > > > > > >> -  case RISCV_ISA_EXT_ZIHINTPAUSE:
> > > > > > >> -          return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> > > > > > >>    default:
> > > > > > >>            return -EINVAL;
> > > > > > >>    }
> > > > > > >> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/=
riscv/include/asm/vdso/processor.h
> > > > > > >> index 1e4f8b4aef79..789bdb8211a2 100644
> > > > > > >> --- a/arch/riscv/include/asm/vdso/processor.h
> > > > > > >> +++ b/arch/riscv/include/asm/vdso/processor.h
> > > > > > >> @@ -4,30 +4,25 @@
> > > > > > >>
> > > > > > >> #ifndef __ASSEMBLY__
> > > > > > >>
> > > > > > >> -#include <linux/jump_label.h>
> > > > > > >> #include <asm/barrier.h>
> > > > > > >> -#include <asm/hwcap.h>
> > > > > > >>
> > > > > > >> static inline void cpu_relax(void)
> > > > > > >> {
> > > > > > >> -  if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_E=
XT_KEY_ZIHINTPAUSE])) {
> > > > > > >> #ifdef __riscv_muldiv
> > > > > > >> -          int dummy;
> > > > > > >> -          /* In lieu of a halt instruction, induce a long-l=
atency stall. */
> > > > > > >> -          __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr"=
 (dummy));
> > > > > > >> +  int dummy;
> > > > > > >> +  /* In lieu of a halt instruction, induce a long-latency s=
tall. */
> > > > > > >> +  __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy)=
);
> > > > > > >> #endif
> > > > > > >> -  } else {
> > > > > > >> -          /*
> > > > > > >> -           * Reduce instruction retirement.
> > > > > > >> -           * This assumes the PC changes.
> > > > > > >> -           */
> > > > > > >> +  /*
> > > > > > >> +   * Reduce instruction retirement.
> > > > > > >> +   * This assumes the PC changes.
> > > > > > >> +   */
> > > > > > >> #ifdef __riscv_zihintpause
> > > > > > >> -          __asm__ __volatile__ ("pause");
> > > > > > >> +  __asm__ __volatile__ ("pause");
> > > > > > >> #else
> > > > > > >> -          /* Encoding of the pause instruction */
> > > > > > >> -          __asm__ __volatile__ (".4byte 0x100000F");
> > > > > > >> +  /* Encoding of the pause instruction */
> > > > > > >> +  __asm__ __volatile__ (".4byte 0x100000F");
> > > > > > >> #endif
> > > > > > >
> > > > > > > hmm, though before this part of the code was only ever access=
ed
> > > > > > > when the zhintpause extension was really available on the run=
ning
> > > > > > > machine while now the pause instruction is called every time.
> > > > > > >
> > > > > > > So I'm just wondering, can't this run into some "illegal inst=
ruction"
> > > > > > > thingy on machines not supporting the extension?
> > > > > >
> > > > > > No. The encoding for pause was deliberately chosen to be one of=
 the
> > > > > > =E2=80=9Cuseless=E2=80=9D encodings of fence, with the hope tha=
t existing
> > > > > > microarchitectures might take a while to execute it and thus it=
 would
> > > > > > still function as a slow-running instruction. It=E2=80=99s some=
what
> > > > > > questionable whether the div is even needed, the worst that hap=
pens is
> > > > > > cpu_relax isn=E2=80=99t very relaxed and you spin a bit faster.=
 Any
> > > > > > implementations where that=E2=80=99s true probably also don=E2=
=80=99t have fancy
> > > > > > clock/power management anyway, and div isn=E2=80=99t going to b=
e a low-power
> > > > > > operation so the only real effect is likely hammering on conten=
ded
> > > > > > atomics a bit more, and who cares about that on the low core co=
unt
> > > > > > systems we have today.
> > > > >
> > > > > thanks a lot for that explanation, which made things a lot cleare=
r.
> > > > >
> > > > > So as you said, dropping the div part might make the function eve=
n smaller,
> > > > > though somehow part of me would want to add some sort of comment =
to
> > > > > the function for when the next developer stumbles over the uncond=
itional
> > > > > use of pause :-) .
> > > > >
> > > >
> > > > I agree. If that's what microarch will do, we can drop div altogeth=
er.
> > > > Though microarch may be treated as nop even if it is undesirable.
> > > > IIRC, the div was introduced for the rocket chip which would induce=
 a
> > > > long latency stall with div instruction (zero as operands).
> > > >
> > > > Does any other core or newer rocket chip actually induce a latency
> > > > stall with div instruction ?
> > > > If not, it is equivalent to NOP as well. We can definitely remove t=
he div.
> > > > The only cores affected will be the older rocket core.
> > > >
> > > > Tagging some folks to understand what their core does.
> > > >
> > > > @Paul Walmsley @Guo Ren @Conor Dooley ?
> > >
> > > I am no microarch expert by _any_ stretch of the imagination, but
> > > from a quick experiment it looks like the u54s on PolarFire SoC behav=
e
> > > in the same way, and div w/ zero operands does in fact take significa=
ntly
> > > longer than regular division (looks to be about 3x).
> > >
> >
> > Thanks. Do you have any data on how much the "pause" instruction takes.
>
> So these numbers you may consider as being pulled out of a magic hat
> as all I am doing is reading the counters from userspace and there is
> some variance etc. Plus the fact that I just started hacking at some
> existing code I had lying around as I'm pretty snowed under at the
> moment.
>
> Doing the following takes about 70 cycles on both a PolarFire SoC and an
> unmatched:
>         long divisor =3D 2, dividend =3D 100000, dest;
>         asm("div %0, zero, zero" : "=3Dr" (dest));
> and equates to:
>         sd      a5,-48(s0)
>         div     a5,zero,zero
>
> Clocking in at about 40 cycles is some actual divisions, I just did the
> following a dozen times, doing a trivial computation:
>         long divisor =3D 2, dividend =3D 100000, dest;
>         asm("div %0, %1, %2" : "=3Dr" (dividend) : "r" (dividend), "r" (d=
ivisor))
>
> ie, a load of the following:
>         sd      a5,-48(s0)
>         ld      a5,-48(s0)
>         ld      a4,-40(s0)
>         div     a5,a5,a4
>
> So clearly the div w/ zero args makes a difference...
>
> On PolarFire SoC, `0x100000F` takes approx 6 cycles. On my unmatched, it
> takes approx 40. Again, I just had an asm block & called the instruction
> a number times and took the average - here it was 48 times.
>
> Take the actual numbers with a fist full of salt, but at least the
> relative numbers should be of some use to you.
>
> Hope that's somewhat helpful, maybe next week I can do something a
> little more useful for you...
>

Thanks. It would be good to understand what happens when "pause" is
executed on these boards ?

> Conor.
>
> > I understand that it is not available in these cores. Just wanted to
> > understand if microarchitecture
> > actually takes a while executing the useless encoding as pointed out by=
 Jessica.
> >
> > If that's the case, we can remove the div instruction altogether.
> > Otherwise, this patch will cause some performance regression
> > for existing SoC (HiFive unleashed has the same core. Not sure about
> > unmatched though).
> > This needs to be documented at least.
> >
> > > Hope that's helpful,
> > > Conor.
> > >
> > > (I just did a quick check of what pretty much amounted to a bunch of
> > > div a5,zero,zero in a row versus div a5,a5,a5)
> > >
> > > >
> > > > (Please add anybody who may have an insight to execution flow on
> > > > existing Linux capable cores)
> > > >
> > > > >
> > > > > Heiko
> > > > >
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >
> > > >
> > > >
> > > > --
> > > > Regards,
> > > > Atish
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
