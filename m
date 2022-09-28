Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD05ED5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiI1HW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiI1HWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:22:12 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A438D4DD3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:08 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n192so8321500iod.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Y0w5aTDlCIxMGUyYZBQP/pb/4Wc6jJ5tbp9g0ljwATc=;
        b=NCINj3BzduwH1SOWoDVQPCCa1U2jmStsl3ktabQ40MpHpLGf1L3O0VinXGdAWlsbfw
         HtzPzZxf9axGpYElP4RuBzo4GoQo8IOaO9Z7O/lk63ReXLwTy5kKihTSPTDWXge7Mj5V
         CyQgUwu1hzkvshW7enpwKjb1QADnIfF7ZP548=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y0w5aTDlCIxMGUyYZBQP/pb/4Wc6jJ5tbp9g0ljwATc=;
        b=IAp813TlIzo6AhH1nYmEkENNEpBdVxl4P9RCexmz6kTIDmwPQS2TT1AqCoBue7wYDJ
         woQs7uTwho9aBDwT1rUbBwHg3uwN7qTjOJbZ5Dx/vr/jp0b4N4kabblWKZpU+4PkTOoU
         gu052z/6bRtQr3u0aPz5m6f/a8WzStKwxhpf12TYI9aE4+JyRYozZDFhLxA2sDq/HGC2
         mo35LJFYMa+3UUo+l++vsRc/7Rc25fajd7L+bZ9i/NSaSUWlshJTDeZjCZXeTit3Eg94
         Q2RsQQrP7UNADFtMgMre2t0N+LEHnbF/akTnBI19ZWk5wA9S6d+jxmvbNRzSWmE7x9Ic
         bHgg==
X-Gm-Message-State: ACrzQf2PZTdAxuncJDNO8atMSP3qhxpHFM12Q70/C9yFVORee7L+FYHC
        nbEGTZhBD96Vfp5p8TxYW1rTEy7UsI4oKuNJ8+Cx
X-Google-Smtp-Source: AMsMyM6OFqIFbu7CXVs0kMU8h0C6v/wAax4ZlbN9UNA4g78iQLxZgopumjLbY1AQHn5XFPduMMWzAn8hNEy9UdqRtB0=
X-Received: by 2002:a6b:5d0c:0:b0:6a4:c2f:2d4d with SMTP id
 r12-20020a6b5d0c000000b006a40c2f2d4dmr12736862iob.136.1664349727717; Wed, 28
 Sep 2022 00:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220922060958.44203-1-samuel@sholland.org> <2546376.ElGaqSPkdT@phil>
 <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com> <13396584.uLZWGnKmhe@phil>
 <CAOnJCUKdBpbj=KDz5oibB_N_SjOiMrkWcttczuGbisi_nMWaVA@mail.gmail.com> <Yy+Plxzj4bckXrhy@spud>
In-Reply-To: <Yy+Plxzj4bckXrhy@spud>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 28 Sep 2022 00:21:55 -0700
Message-ID: <CAOnJCU+fA-pxLPRviqW2d7q-E__qJYkZKkCdiNHXhJBjWCRPaA@mail.gmail.com>
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

On Sat, Sep 24, 2022 at 4:15 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Sep 23, 2022 at 11:01:28AM -0700, Atish Patra wrote:
> > On Fri, Sep 23, 2022 at 12:18 AM Heiko Stuebner <heiko@sntech.de> wrote=
:
> > >
> > > Hi,
> > >
> > > Am Donnerstag, 22. September 2022, 17:52:46 CEST schrieb Jessica Clar=
ke:
> > > > On 22 Sept 2022, at 16:45, Heiko Stuebner <heiko@sntech.de> wrote:
> > > > >
> > > > > Am Donnerstag, 22. September 2022, 08:09:58 CEST schrieb Samuel H=
olland:
> > > > >> commit 8eb060e10185 ("arch/riscv: add Zihintpause support") brok=
e
> > > > >> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.0):
> > > > >>
> > > > >> CC arch/riscv/kernel/vdso/vgettimeofday.o
> > > > >> In file included from <command-line>:
> > > > >> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> > > > >> ././include/linux/compiler_types.h:285:33: warning: 'asm' operan=
d 0 probably does not match constraints
> > > > >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> > > > >> | ^~~
> > > > >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion o=
f macro 'asm_volatile_goto'
> > > > >> 41 | asm_volatile_goto(
> > > > >> | ^~~~~~~~~~~~~~~~~
> > > > >> ././include/linux/compiler_types.h:285:33: error: impossible con=
straint in 'asm'
> > > > >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> > > > >> | ^~~
> > > > >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion o=
f macro 'asm_volatile_goto'
> > > > >> 41 | asm_volatile_goto(
> > > > >> | ^~~~~~~~~~~~~~~~~
> > > > >> make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso=
/vgettimeofday.o] Error 1
> > > > >> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> > > > >>
> > > > >> Having a static branch in cpu_relax() is problematic because tha=
t
> > > > >> function is widely inlined, including in some quite complex func=
tions
> > > > >> like in the VDSO. A quick measurement shows this static branch i=
s
> > > > >> responsible by itself for around 40% of the jump table.
> > > > >>
> > > > >> Drop the static branch, which ends up being the same number of
> > > > >> instructions anyway. If Zihintpause is supported, we trade the n=
op from
> > > > >> the static branch for a div. If Zihintpause is unsupported, we t=
rade the
> > > > >> jump from the static branch for (what gets interpreted as) a nop=
.
> > > > >>
> > > > >> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> > > > >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> > > > >> ---
> > > > >>
> > > > >> arch/riscv/include/asm/hwcap.h | 3 ---
> > > > >> arch/riscv/include/asm/vdso/processor.h | 25 ++++++++++---------=
------
> > > > >> 2 files changed, 10 insertions(+), 18 deletions(-)
> > > > >>
> > > > >> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include=
/asm/hwcap.h
> > > > >> index 6f59ec64175e..b21d46e68386 100644
> > > > >> --- a/arch/riscv/include/asm/hwcap.h
> > > > >> +++ b/arch/riscv/include/asm/hwcap.h
> > > > >> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
> > > > >> */
> > > > >> enum riscv_isa_ext_key {
> > > > >>    RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
> > > > >> -  RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> > > > >>    RISCV_ISA_EXT_KEY_MAX,
> > > > >> };
> > > > >>
> > > > >> @@ -88,8 +87,6 @@ static __always_inline int riscv_isa_ext2key(i=
nt num)
> > > > >>            return RISCV_ISA_EXT_KEY_FPU;
> > > > >>    case RISCV_ISA_EXT_d:
> > > > >>            return RISCV_ISA_EXT_KEY_FPU;
> > > > >> -  case RISCV_ISA_EXT_ZIHINTPAUSE:
> > > > >> -          return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> > > > >>    default:
> > > > >>            return -EINVAL;
> > > > >>    }
> > > > >> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/risc=
v/include/asm/vdso/processor.h
> > > > >> index 1e4f8b4aef79..789bdb8211a2 100644
> > > > >> --- a/arch/riscv/include/asm/vdso/processor.h
> > > > >> +++ b/arch/riscv/include/asm/vdso/processor.h
> > > > >> @@ -4,30 +4,25 @@
> > > > >>
> > > > >> #ifndef __ASSEMBLY__
> > > > >>
> > > > >> -#include <linux/jump_label.h>
> > > > >> #include <asm/barrier.h>
> > > > >> -#include <asm/hwcap.h>
> > > > >>
> > > > >> static inline void cpu_relax(void)
> > > > >> {
> > > > >> -  if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_K=
EY_ZIHINTPAUSE])) {
> > > > >> #ifdef __riscv_muldiv
> > > > >> -          int dummy;
> > > > >> -          /* In lieu of a halt instruction, induce a long-laten=
cy stall. */
> > > > >> -          __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (du=
mmy));
> > > > >> +  int dummy;
> > > > >> +  /* In lieu of a halt instruction, induce a long-latency stall=
. */
> > > > >> +  __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
> > > > >> #endif
> > > > >> -  } else {
> > > > >> -          /*
> > > > >> -           * Reduce instruction retirement.
> > > > >> -           * This assumes the PC changes.
> > > > >> -           */
> > > > >> +  /*
> > > > >> +   * Reduce instruction retirement.
> > > > >> +   * This assumes the PC changes.
> > > > >> +   */
> > > > >> #ifdef __riscv_zihintpause
> > > > >> -          __asm__ __volatile__ ("pause");
> > > > >> +  __asm__ __volatile__ ("pause");
> > > > >> #else
> > > > >> -          /* Encoding of the pause instruction */
> > > > >> -          __asm__ __volatile__ (".4byte 0x100000F");
> > > > >> +  /* Encoding of the pause instruction */
> > > > >> +  __asm__ __volatile__ (".4byte 0x100000F");
> > > > >> #endif
> > > > >
> > > > > hmm, though before this part of the code was only ever accessed
> > > > > when the zhintpause extension was really available on the running
> > > > > machine while now the pause instruction is called every time.
> > > > >
> > > > > So I'm just wondering, can't this run into some "illegal instruct=
ion"
> > > > > thingy on machines not supporting the extension?
> > > >
> > > > No. The encoding for pause was deliberately chosen to be one of the
> > > > =E2=80=9Cuseless=E2=80=9D encodings of fence, with the hope that ex=
isting
> > > > microarchitectures might take a while to execute it and thus it wou=
ld
> > > > still function as a slow-running instruction. It=E2=80=99s somewhat
> > > > questionable whether the div is even needed, the worst that happens=
 is
> > > > cpu_relax isn=E2=80=99t very relaxed and you spin a bit faster. Any
> > > > implementations where that=E2=80=99s true probably also don=E2=80=
=99t have fancy
> > > > clock/power management anyway, and div isn=E2=80=99t going to be a =
low-power
> > > > operation so the only real effect is likely hammering on contended
> > > > atomics a bit more, and who cares about that on the low core count
> > > > systems we have today.
> > >
> > > thanks a lot for that explanation, which made things a lot clearer.
> > >
> > > So as you said, dropping the div part might make the function even sm=
aller,
> > > though somehow part of me would want to add some sort of comment to
> > > the function for when the next developer stumbles over the unconditio=
nal
> > > use of pause :-) .
> > >
> >
> > I agree. If that's what microarch will do, we can drop div altogether.
> > Though microarch may be treated as nop even if it is undesirable.
> > IIRC, the div was introduced for the rocket chip which would induce a
> > long latency stall with div instruction (zero as operands).
> >
> > Does any other core or newer rocket chip actually induce a latency
> > stall with div instruction ?
> > If not, it is equivalent to NOP as well. We can definitely remove the d=
iv.
> > The only cores affected will be the older rocket core.
> >
> > Tagging some folks to understand what their core does.
> >
> > @Paul Walmsley @Guo Ren @Conor Dooley ?
>
> I am no microarch expert by _any_ stretch of the imagination, but
> from a quick experiment it looks like the u54s on PolarFire SoC behave
> in the same way, and div w/ zero operands does in fact take significantly
> longer than regular division (looks to be about 3x).
>

Thanks. Do you have any data on how much the "pause" instruction takes.
I understand that it is not available in these cores. Just wanted to
understand if microarchitecture
actually takes a while executing the useless encoding as pointed out by Jes=
sica.

If that's the case, we can remove the div instruction altogether.
Otherwise, this patch will cause some performance regression
for existing SoC (HiFive unleashed has the same core. Not sure about
unmatched though).
This needs to be documented at least.

> Hope that's helpful,
> Conor.
>
> (I just did a quick check of what pretty much amounted to a bunch of
> div a5,zero,zero in a row versus div a5,a5,a5)
>
> >
> > (Please add anybody who may have an insight to execution flow on
> > existing Linux capable cores)
> >
> > >
> > > Heiko
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
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
