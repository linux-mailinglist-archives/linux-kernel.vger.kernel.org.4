Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8F5E679A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIVPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIVPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:52:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E9CA599E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:52:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so1627535wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=81X8Dd61stsBs4BxsLd4i6egkBiEzGQWkV5nRmL6aD8=;
        b=J1jMlGs02XMXXN++Af35IPh72qo3crm12S1Uz+vGYHxUUFN4wqYAmqzrFbWuYzplwq
         dXZ2Yc+GJNUHzbSpr3QXPNeRSS2m0K0wEJsXAczbh+PWwH6Jt2kIXm9TirvIRPypURmK
         88c0MAMhYg3UacE1W/7Irmhso3CjG+CXglCWObzAKZUdp5wtJo+AbYzQG7Bn+BHMzKmA
         Zf5EB8iqwKOqiWWSnrfDk8G27fgpVCU52hGZM7chRVI+pAcD3C3R98N+ZivD3xBZHXT5
         4IhlnWVD2yxB3eyyC8pWK7VrPlU6R7MQwyzJUSFP/cfo3Kvwg8b9ch8CgNMiRjJPMnhi
         ogeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=81X8Dd61stsBs4BxsLd4i6egkBiEzGQWkV5nRmL6aD8=;
        b=QSww0X9ifAkTgn4X8VJHLzfCoQrjHwIOGokWZBVFzBRioXW64ZwV+CdYUjJqdMoTPH
         lwb0YU3rbs7ecVKDSM83Zd79uwx602jEdiuhIVPewusfgAiK2+wDKLrvBqx6s4ndDBv/
         kwmM4vO8tqkJHCZV+3sXtk29sAkTUNM/0CVN6c7SDsx/lpdLmuiMsBRW/+c5V5UKWY7W
         S7G6kfGpXvhJkGS2K1eQWqjHisTZsbokoquImBETdxaR4r/2WGBo0o14EmD/RTliJsbu
         Ges2EH/I2kM5mpyqSwKxyzZNeTODwhFavuJBMfo62BdnY4rXqcnPcljGJ9yOoOZQDWNX
         FmPw==
X-Gm-Message-State: ACrzQf1E+fuF4WXlTNfnxplNHE/HbTuo5fG0W7aFcwIEc2t8a1aBjB+/
        y4p9QGOO7jlHMn583j9H6/26+w==
X-Google-Smtp-Source: AMsMyM4SASX+I+EOTOW+Fvp4ltwX7zDrGCp8JVHMtcMBNGTpJEfkc94AmvASPBzUQjFU5A31PsDd/Q==
X-Received: by 2002:a05:600c:4f01:b0:3b4:a8c8:2523 with SMTP id l1-20020a05600c4f0100b003b4a8c82523mr9746746wmq.199.1663861968312;
        Thu, 22 Sep 2022 08:52:48 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id m188-20020a1c26c5000000b003b47e75b401sm6148925wmm.37.2022.09.22.08.52.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:52:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <2546376.ElGaqSPkdT@phil>
Date:   Thu, 22 Sep 2022 16:52:46 +0100
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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
Message-Id: <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com>
References: <20220922060958.44203-1-samuel@sholland.org>
 <2546376.ElGaqSPkdT@phil>
To:     Heiko Stuebner <heiko@sntech.de>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Sept 2022, at 16:45, Heiko Stuebner <heiko@sntech.de> wrote:
>=20
> Am Donnerstag, 22. September 2022, 08:09:58 CEST schrieb Samuel =
Holland:
>> commit 8eb060e10185 ("arch/riscv: add Zihintpause support") broke
>> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.0):
>>=20
>> CC arch/riscv/kernel/vdso/vgettimeofday.o
>> In file included from <command-line>:
>> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
>> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 =
probably does not match constraints
>> 285 | #define asm_volatile_goto(x...) asm goto(x)
>> | ^~~
>> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of =
macro 'asm_volatile_goto'
>> 41 | asm_volatile_goto(
>> | ^~~~~~~~~~~~~~~~~
>> ././include/linux/compiler_types.h:285:33: error: impossible =
constraint in 'asm'
>> 285 | #define asm_volatile_goto(x...) asm goto(x)
>> | ^~~
>> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of =
macro 'asm_volatile_goto'
>> 41 | asm_volatile_goto(
>> | ^~~~~~~~~~~~~~~~~
>> make[1]: *** [scripts/Makefile.build:249: =
arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
>> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
>>=20
>> Having a static branch in cpu_relax() is problematic because that
>> function is widely inlined, including in some quite complex functions
>> like in the VDSO. A quick measurement shows this static branch is
>> responsible by itself for around 40% of the jump table.
>>=20
>> Drop the static branch, which ends up being the same number of
>> instructions anyway. If Zihintpause is supported, we trade the nop =
from
>> the static branch for a div. If Zihintpause is unsupported, we trade =
the
>> jump from the static branch for (what gets interpreted as) a nop.
>>=20
>> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>=20
>> arch/riscv/include/asm/hwcap.h | 3 ---
>> arch/riscv/include/asm/vdso/processor.h | 25 =
++++++++++---------------
>> 2 files changed, 10 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/arch/riscv/include/asm/hwcap.h =
b/arch/riscv/include/asm/hwcap.h
>> index 6f59ec64175e..b21d46e68386 100644
>> --- a/arch/riscv/include/asm/hwcap.h
>> +++ b/arch/riscv/include/asm/hwcap.h
>> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
>> */
>> enum riscv_isa_ext_key {
>> 	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
>> -	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>> 	RISCV_ISA_EXT_KEY_MAX,
>> };
>>=20
>> @@ -88,8 +87,6 @@ static __always_inline int riscv_isa_ext2key(int =
num)
>> 		return RISCV_ISA_EXT_KEY_FPU;
>> 	case RISCV_ISA_EXT_d:
>> 		return RISCV_ISA_EXT_KEY_FPU;
>> -	case RISCV_ISA_EXT_ZIHINTPAUSE:
>> -		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>> 	default:
>> 		return -EINVAL;
>> 	}
>> diff --git a/arch/riscv/include/asm/vdso/processor.h =
b/arch/riscv/include/asm/vdso/processor.h
>> index 1e4f8b4aef79..789bdb8211a2 100644
>> --- a/arch/riscv/include/asm/vdso/processor.h
>> +++ b/arch/riscv/include/asm/vdso/processor.h
>> @@ -4,30 +4,25 @@
>>=20
>> #ifndef __ASSEMBLY__
>>=20
>> -#include <linux/jump_label.h>
>> #include <asm/barrier.h>
>> -#include <asm/hwcap.h>
>>=20
>> static inline void cpu_relax(void)
>> {
>> -	if =
(!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])=
) {
>> #ifdef __riscv_muldiv
>> -		int dummy;
>> -		/* In lieu of a halt instruction, induce a long-latency =
stall. */
>> -		__asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" =
(dummy));
>> +	int dummy;
>> +	/* In lieu of a halt instruction, induce a long-latency stall. =
*/
>> +	__asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
>> #endif
>> -	} else {
>> -		/*
>> -		 * Reduce instruction retirement.
>> -		 * This assumes the PC changes.
>> -		 */
>> +	/*
>> +	 * Reduce instruction retirement.
>> +	 * This assumes the PC changes.
>> +	 */
>> #ifdef __riscv_zihintpause
>> -		__asm__ __volatile__ ("pause");
>> +	__asm__ __volatile__ ("pause");
>> #else
>> -		/* Encoding of the pause instruction */
>> -		__asm__ __volatile__ (".4byte 0x100000F");
>> +	/* Encoding of the pause instruction */
>> +	__asm__ __volatile__ (".4byte 0x100000F");
>> #endif
>=20
> hmm, though before this part of the code was only ever accessed
> when the zhintpause extension was really available on the running
> machine while now the pause instruction is called every time.
>=20
> So I'm just wondering, can't this run into some "illegal instruction"
> thingy on machines not supporting the extension?

No. The encoding for pause was deliberately chosen to be one of the
=E2=80=9Cuseless=E2=80=9D encodings of fence, with the hope that =
existing
microarchitectures might take a while to execute it and thus it would
still function as a slow-running instruction. It=E2=80=99s somewhat
questionable whether the div is even needed, the worst that happens is
cpu_relax isn=E2=80=99t very relaxed and you spin a bit faster. Any
implementations where that=E2=80=99s true probably also don=E2=80=99t =
have fancy
clock/power management anyway, and div isn=E2=80=99t going to be a =
low-power
operation so the only real effect is likely hammering on contended
atomics a bit more, and who cares about that on the low core count
systems we have today.

Jess

