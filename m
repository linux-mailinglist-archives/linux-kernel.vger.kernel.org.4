Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734A55F4851
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJDRYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:24:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B431117
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:24:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w18so13644941wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=FsWpPxF9YKjDUJA9DRbfEkloek4OZoMHaYL5frLPEpw=;
        b=V1t4PQGDHckpbZeVwT+7JUsi6iKwEpjsenWyWAfF0TvXm/rf7hH44VgmZ+Mu3bmqCd
         Dv0JA76s5LwEEkYEUzlkVV39SmgTtqcHhKZq4WfSMO4yWjA+q5FJSFlWwTGudke4vj+N
         p0Ohf14wq28dKx5Meag7YaDoBi1ExFH/DOzEsr5N+Pw+HmX1zeOiRLvuT24UmLoAocn7
         6RBBt9pX5SDqyKOwbXb60GFDjulxB+QcIjEF2RDEBUyN/M8whuLL/nFZYKfJDzV5KjCf
         ch1ywmQFmmYI5usG+wTFz5IqwYrWGack9ORVUalTIGkTwzRMoCxM/lQuOJZ689jD6rqK
         u1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FsWpPxF9YKjDUJA9DRbfEkloek4OZoMHaYL5frLPEpw=;
        b=KZ2LmNi7ykwD7lkMq5QSer4PKYVOyY87o6xY+9sbW7GYVgtGt3cktg7+uJ4V9dB7CA
         d8G/Jl0Dpv3mUDdMSK/lGWZnkWgxUjRrltofCKcaGPgfJ2qA/3EWU46TXn0kfsg/clQ4
         bdPTzdwxeFyzPaCZ3/qkD4C1udqYKY9yhIMqAAKMMfmypleoud7eD/vqWTmJoc/mSYk0
         8FauevtmlLwGyl1bogfVbzUVbNx3ScI+XLZjdnPzwsRggEQYVWYFi0xgSDRsgHv7HjhU
         DQVfnvOyV82W4XGgc+JVGKsyrXmyC6bX8hgmUosRFZe+eOOLx4MJTr7j//0XnG7pSPGa
         CzSA==
X-Gm-Message-State: ACrzQf3nV1NI+fX2e8MdmScNm+65ZEyn8tiE717CNfpdX0KBqjg9Xso7
        t9INQHVY7MsCP+8b3/ME6W0udA==
X-Google-Smtp-Source: AMsMyM6EIZcRWndBOUFVsDXZjzZkj8fLhUkrT+xM2wVDitU0+dBw57LsZELozvaUc63EookBIH98cw==
X-Received: by 2002:a5d:59a3:0:b0:22e:4b62:7ceb with SMTP id p3-20020a5d59a3000000b0022e4b627cebmr3370989wrr.90.1664904275966;
        Tue, 04 Oct 2022 10:24:35 -0700 (PDT)
Received: from smtpclient.apple (global-5-142.n-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c2cb200b003b51a4c61aasm20768784wmc.40.2022.10.04.10.24.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 10:24:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAOnJCUKtoiXKaS81BZyvpybFDkh-undHLqE5ZxoNmf9AtAtvfw@mail.gmail.com>
Date:   Tue, 4 Oct 2022 18:24:34 +0100
Cc:     Conor Dooley <conor@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5A6B840-A306-48E8-A60F-1D852B0639D6@jrtc27.com>
References: <20220922060958.44203-1-samuel@sholland.org>
 <2546376.ElGaqSPkdT@phil> <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com>
 <13396584.uLZWGnKmhe@phil>
 <CAOnJCUKdBpbj=KDz5oibB_N_SjOiMrkWcttczuGbisi_nMWaVA@mail.gmail.com>
 <Yy+Plxzj4bckXrhy@spud>
 <CAOnJCU+fA-pxLPRviqW2d7q-E__qJYkZKkCdiNHXhJBjWCRPaA@mail.gmail.com>
 <YzS5kT2CCBPxqLg+@spud>
 <CAOnJCUKn-rNwyw5BK7=hNM-vnJ=VROjipCiDtB4BL=LZ3kKAAg@mail.gmail.com>
 <YzifTW5Y7O191gCo@spud>
 <CAOnJCUKtoiXKaS81BZyvpybFDkh-undHLqE5ZxoNmf9AtAtvfw@mail.gmail.com>
To:     Atish Patra <atishp@atishpatra.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Oct 2022, at 17:52, Atish Patra <atishp@atishpatra.org> wrote:
>=20
> On Sat, Oct 1, 2022 at 1:13 PM Conor Dooley <conor@kernel.org> wrote:
>>=20
>> On Wed, Sep 28, 2022 at 08:26:01PM -0700, Atish Patra wrote:
>>> On Wed, Sep 28, 2022 at 2:16 PM Conor Dooley <conor@kernel.org> =
wrote:
>>>>=20
>>>> On Wed, Sep 28, 2022 at 12:21:55AM -0700, Atish Patra wrote:
>>>>> On Sat, Sep 24, 2022 at 4:15 PM Conor Dooley <conor@kernel.org> =
wrote:
>>>>>>=20
>>>>>> On Fri, Sep 23, 2022 at 11:01:28AM -0700, Atish Patra wrote:
>>>>>>> On Fri, Sep 23, 2022 at 12:18 AM Heiko Stuebner =
<heiko@sntech.de> wrote:
>>>>>>>>=20
>>>>>>>> Hi,
>>>>>>>>=20
>>>>>>>> Am Donnerstag, 22. September 2022, 17:52:46 CEST schrieb =
Jessica Clarke:
>>>>>>>>> On 22 Sept 2022, at 16:45, Heiko Stuebner <heiko@sntech.de> =
wrote:
>>>>>>>>>>=20
>>>>>>>>>> Am Donnerstag, 22. September 2022, 08:09:58 CEST schrieb =
Samuel Holland:
>>>>>>>>>>> commit 8eb060e10185 ("arch/riscv: add Zihintpause support") =
broke
>>>>>>>>>>> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc =
11.1.0):
>>>>>>>>>>>=20
>>>>>>>>>>> CC arch/riscv/kernel/vdso/vgettimeofday.o
>>>>>>>>>>> In file included from <command-line>:
>>>>>>>>>>> ./arch/riscv/include/asm/jump_label.h: In function =
'cpu_relax':
>>>>>>>>>>> ././include/linux/compiler_types.h:285:33: warning: 'asm' =
operand 0 probably does not match constraints
>>>>>>>>>>> 285 | #define asm_volatile_goto(x...) asm goto(x)
>>>>>>>>>>> | ^~~
>>>>>>>>>>> ./arch/riscv/include/asm/jump_label.h:41:9: note: in =
expansion of macro 'asm_volatile_goto'
>>>>>>>>>>> 41 | asm_volatile_goto(
>>>>>>>>>>> | ^~~~~~~~~~~~~~~~~
>>>>>>>>>>> ././include/linux/compiler_types.h:285:33: error: impossible =
constraint in 'asm'
>>>>>>>>>>> 285 | #define asm_volatile_goto(x...) asm goto(x)
>>>>>>>>>>> | ^~~
>>>>>>>>>>> ./arch/riscv/include/asm/jump_label.h:41:9: note: in =
expansion of macro 'asm_volatile_goto'
>>>>>>>>>>> 41 | asm_volatile_goto(
>>>>>>>>>>> | ^~~~~~~~~~~~~~~~~
>>>>>>>>>>> make[1]: *** [scripts/Makefile.build:249: =
arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
>>>>>>>>>>> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
>>>>>>>>>>>=20
>>>>>>>>>>> Having a static branch in cpu_relax() is problematic because =
that
>>>>>>>>>>> function is widely inlined, including in some quite complex =
functions
>>>>>>>>>>> like in the VDSO. A quick measurement shows this static =
branch is
>>>>>>>>>>> responsible by itself for around 40% of the jump table.
>>>>>>>>>>>=20
>>>>>>>>>>> Drop the static branch, which ends up being the same number =
of
>>>>>>>>>>> instructions anyway. If Zihintpause is supported, we trade =
the nop from
>>>>>>>>>>> the static branch for a div. If Zihintpause is unsupported, =
we trade the
>>>>>>>>>>> jump from the static branch for (what gets interpreted as) a =
nop.
>>>>>>>>>>>=20
>>>>>>>>>>> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
>>>>>>>>>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>>>>>>>>>> ---
>>>>>>>>>>>=20
>>>>>>>>>>> arch/riscv/include/asm/hwcap.h | 3 ---
>>>>>>>>>>> arch/riscv/include/asm/vdso/processor.h | 25 =
++++++++++---------------
>>>>>>>>>>> 2 files changed, 10 insertions(+), 18 deletions(-)
>>>>>>>>>>>=20
>>>>>>>>>>> diff --git a/arch/riscv/include/asm/hwcap.h =
b/arch/riscv/include/asm/hwcap.h
>>>>>>>>>>> index 6f59ec64175e..b21d46e68386 100644
>>>>>>>>>>> --- a/arch/riscv/include/asm/hwcap.h
>>>>>>>>>>> +++ b/arch/riscv/include/asm/hwcap.h
>>>>>>>>>>> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
>>>>>>>>>>> */
>>>>>>>>>>> enum riscv_isa_ext_key {
>>>>>>>>>>> RISCV_ISA_EXT_KEY_FPU, /* For 'F' and 'D' */
>>>>>>>>>>> - RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>>>>>>>>>>> RISCV_ISA_EXT_KEY_MAX,
>>>>>>>>>>> };
>>>>>>>>>>>=20
>>>>>>>>>>> @@ -88,8 +87,6 @@ static __always_inline int =
riscv_isa_ext2key(int num)
>>>>>>>>>>> return RISCV_ISA_EXT_KEY_FPU;
>>>>>>>>>>> case RISCV_ISA_EXT_d:
>>>>>>>>>>> return RISCV_ISA_EXT_KEY_FPU;
>>>>>>>>>>> - case RISCV_ISA_EXT_ZIHINTPAUSE:
>>>>>>>>>>> - return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>>>>>>>>>>> default:
>>>>>>>>>>> return -EINVAL;
>>>>>>>>>>> }
>>>>>>>>>>> diff --git a/arch/riscv/include/asm/vdso/processor.h =
b/arch/riscv/include/asm/vdso/processor.h
>>>>>>>>>>> index 1e4f8b4aef79..789bdb8211a2 100644
>>>>>>>>>>> --- a/arch/riscv/include/asm/vdso/processor.h
>>>>>>>>>>> +++ b/arch/riscv/include/asm/vdso/processor.h
>>>>>>>>>>> @@ -4,30 +4,25 @@
>>>>>>>>>>>=20
>>>>>>>>>>> #ifndef __ASSEMBLY__
>>>>>>>>>>>=20
>>>>>>>>>>> -#include <linux/jump_label.h>
>>>>>>>>>>> #include <asm/barrier.h>
>>>>>>>>>>> -#include <asm/hwcap.h>
>>>>>>>>>>>=20
>>>>>>>>>>> static inline void cpu_relax(void)
>>>>>>>>>>> {
>>>>>>>>>>> - if =
(!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])=
) {
>>>>>>>>>>> #ifdef __riscv_muldiv
>>>>>>>>>>> - int dummy;
>>>>>>>>>>> - /* In lieu of a halt instruction, induce a long-latency =
stall. */
>>>>>>>>>>> - __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" =
(dummy));
>>>>>>>>>>> + int dummy;
>>>>>>>>>>> + /* In lieu of a halt instruction, induce a long-latency =
stall. */
>>>>>>>>>>> + __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" =
(dummy));
>>>>>>>>>>> #endif
>>>>>>>>>>> - } else {
>>>>>>>>>>> - /*
>>>>>>>>>>> - * Reduce instruction retirement.
>>>>>>>>>>> - * This assumes the PC changes.
>>>>>>>>>>> - */
>>>>>>>>>>> + /*
>>>>>>>>>>> + * Reduce instruction retirement.
>>>>>>>>>>> + * This assumes the PC changes.
>>>>>>>>>>> + */
>>>>>>>>>>> #ifdef __riscv_zihintpause
>>>>>>>>>>> - __asm__ __volatile__ ("pause");
>>>>>>>>>>> + __asm__ __volatile__ ("pause");
>>>>>>>>>>> #else
>>>>>>>>>>> - /* Encoding of the pause instruction */
>>>>>>>>>>> - __asm__ __volatile__ (".4byte 0x100000F");
>>>>>>>>>>> + /* Encoding of the pause instruction */
>>>>>>>>>>> + __asm__ __volatile__ (".4byte 0x100000F");
>>>>>>>>>>> #endif
>>>>>>>>>>=20
>>>>>>>>>> hmm, though before this part of the code was only ever =
accessed
>>>>>>>>>> when the zhintpause extension was really available on the =
running
>>>>>>>>>> machine while now the pause instruction is called every time.
>>>>>>>>>>=20
>>>>>>>>>> So I'm just wondering, can't this run into some "illegal =
instruction"
>>>>>>>>>> thingy on machines not supporting the extension?
>>>>>>>>>=20
>>>>>>>>> No. The encoding for pause was deliberately chosen to be one =
of the
>>>>>>>>> =E2=80=9Cuseless=E2=80=9D encodings of fence, with the hope =
that existing
>>>>>>>>> microarchitectures might take a while to execute it and thus =
it would
>>>>>>>>> still function as a slow-running instruction. It=E2=80=99s =
somewhat
>>>>>>>>> questionable whether the div is even needed, the worst that =
happens is
>>>>>>>>> cpu_relax isn=E2=80=99t very relaxed and you spin a bit =
faster. Any
>>>>>>>>> implementations where that=E2=80=99s true probably also =
don=E2=80=99t have fancy
>>>>>>>>> clock/power management anyway, and div isn=E2=80=99t going to =
be a low-power
>>>>>>>>> operation so the only real effect is likely hammering on =
contended
>>>>>>>>> atomics a bit more, and who cares about that on the low core =
count
>>>>>>>>> systems we have today.
>>>>>>>>=20
>>>>>>>> thanks a lot for that explanation, which made things a lot =
clearer.
>>>>>>>>=20
>>>>>>>> So as you said, dropping the div part might make the function =
even smaller,
>>>>>>>> though somehow part of me would want to add some sort of =
comment to
>>>>>>>> the function for when the next developer stumbles over the =
unconditional
>>>>>>>> use of pause :-) .
>>>>>>>>=20
>>>>>>>=20
>>>>>>> I agree. If that's what microarch will do, we can drop div =
altogether.
>>>>>>> Though microarch may be treated as nop even if it is =
undesirable.
>>>>>>> IIRC, the div was introduced for the rocket chip which would =
induce a
>>>>>>> long latency stall with div instruction (zero as operands).
>>>>>>>=20
>>>>>>> Does any other core or newer rocket chip actually induce a =
latency
>>>>>>> stall with div instruction ?
>>>>>>> If not, it is equivalent to NOP as well. We can definitely =
remove the div.
>>>>>>> The only cores affected will be the older rocket core.
>>>>>>>=20
>>>>>>> Tagging some folks to understand what their core does.
>>>>>>>=20
>>>>>>> @Paul Walmsley @Guo Ren @Conor Dooley ?
>>>>>>=20
>>>>>> I am no microarch expert by _any_ stretch of the imagination, but
>>>>>> from a quick experiment it looks like the u54s on PolarFire SoC =
behave
>>>>>> in the same way, and div w/ zero operands does in fact take =
significantly
>>>>>> longer than regular division (looks to be about 3x).
>>>>>>=20
>>>>>=20
>>>>> Thanks. Do you have any data on how much the "pause" instruction =
takes.
>>>>=20
>>>> So these numbers you may consider as being pulled out of a magic =
hat
>>>> as all I am doing is reading the counters from userspace and there =
is
>>>> some variance etc. Plus the fact that I just started hacking at =
some
>>>> existing code I had lying around as I'm pretty snowed under at the
>>>> moment.
>>>>=20
>>>> Doing the following takes about 70 cycles on both a PolarFire SoC =
and an
>>>> unmatched:
>>>> long divisor =3D 2, dividend =3D 100000, dest;
>>>> asm("div %0, zero, zero" : "=3Dr" (dest));
>>>> and equates to:
>>>> sd a5,-48(s0)
>>>> div a5,zero,zero
>>>>=20
>>>> Clocking in at about 40 cycles is some actual divisions, I just did =
the
>>>> following a dozen times, doing a trivial computation:
>>>> long divisor =3D 2, dividend =3D 100000, dest;
>>>> asm("div %0, %1, %2" : "=3Dr" (dividend) : "r" (dividend), "r" =
(divisor))
>>>>=20
>>>> ie, a load of the following:
>>>> sd a5,-48(s0)
>>>> ld a5,-48(s0)
>>>> ld a4,-40(s0)
>>>> div a5,a5,a4
>>>>=20
>>>> So clearly the div w/ zero args makes a difference...
>>>>=20
>>>> On PolarFire SoC, `0x100000F` takes approx 6 cycles. On my =
unmatched, it
>>>> takes approx 40. Again, I just had an asm block & called the =
instruction
>>>> a number times and took the average - here it was 48 times.
>>>>=20
>>>> Take the actual numbers with a fist full of salt, but at least the
>>>> relative numbers should be of some use to you.
>>>>=20
>>>> Hope that's somewhat helpful, maybe next week I can do something a
>>>> little more useful for you...
>>>>=20
>>>=20
>>> Thanks. It would be good to understand what happens when "pause" is
>>> executed on these boards ?
>>=20
>> The actual pause instruction? uhh, so with the usual "I don't know =
what
>> I am doing" disclaimer, I ran each of the .insn and pause instruction =
48
>> times in a row and checked the time elapsed via rdcycle & then ran =
that
>> c program 1000 times in a bash loop. Got the below, the insns were =
run
>> first and then the pauses.
>> insn pause
>> min 2.3 3.2
>> max 9.5 10.6
>> avg 27.0 29.1
>> 5% 2.9 4.2
>> 95% 18.1 19.1
>>=20
>> Swapping the pause & insn order around made a minor difference, but =
not
>> enough to report on. I'd be very wary of drawing any real conclusions
>> from this data, but at least both are roughly similar (and certainly =
not
>> even close to doing the div w/ zero args.
>>=20
>=20
> Yeah. That's what I was expecting. So we can't drop the div for now. =
Otherwise,
> the existing hardware(don't support Zhintpause) suffers by spinning =
faster.

But does that actually matter in practice? If it doesn=E2=80=99t =
noticeable
affect performance then you don=E2=80=99t need to keep the div. There =
are a lot
of architectures that even just define cpu_relax() as barrier().

Jess

> Thanks for running the experiments.
>=20
>> Again, hope that is helpful?
>> Conor.
>>=20
>>>=20
>>>> Conor.
>>>>=20
>>>>> I understand that it is not available in these cores. Just wanted =
to
>>>>> understand if microarchitecture
>>>>> actually takes a while executing the useless encoding as pointed =
out by Jessica.
>>>>>=20
>>>>> If that's the case, we can remove the div instruction altogether.
>>>>> Otherwise, this patch will cause some performance regression
>>>>> for existing SoC (HiFive unleashed has the same core. Not sure =
about
>>>>> unmatched though).
>>>>> This needs to be documented at least.
>>>>>=20
>>>>>> Hope that's helpful,
>>>>>> Conor.
>>>>>>=20
>>>>>> (I just did a quick check of what pretty much amounted to a bunch =
of
>>>>>> div a5,zero,zero in a row versus div a5,a5,a5)
>>>>>>=20
>>>>>>>=20
>>>>>>> (Please add anybody who may have an insight to execution flow on
>>>>>>> existing Linux capable cores)
>>>>>>>=20
>>=20
>=20
>=20
> --=20
> Regards,
> Atish

