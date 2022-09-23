Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A80B5E74B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIWHSL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Sep 2022 03:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiIWHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:18:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF8E12B487
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:17:52 -0700 (PDT)
Received: from p508fdb48.dip0.t-ipconnect.de ([80.143.219.72] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1obcwQ-0004Yg-Mr; Fri, 23 Sep 2022 09:17:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jessica Clarke <jrtc27@jrtc27.com>
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
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
Date:   Fri, 23 Sep 2022 09:17:41 +0200
Message-ID: <13396584.uLZWGnKmhe@phil>
In-Reply-To: <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com>
References: <20220922060958.44203-1-samuel@sholland.org> <2546376.ElGaqSPkdT@phil> <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 22. September 2022, 17:52:46 CEST schrieb Jessica Clarke:
> On 22 Sept 2022, at 16:45, Heiko Stuebner <heiko@sntech.de> wrote:
> > 
> > Am Donnerstag, 22. September 2022, 08:09:58 CEST schrieb Samuel Holland:
> >> commit 8eb060e10185 ("arch/riscv: add Zihintpause support") broke
> >> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.0):
> >> 
> >> CC arch/riscv/kernel/vdso/vgettimeofday.o
> >> In file included from <command-line>:
> >> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> >> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 probably does not match constraints
> >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> >> | ^~~
> >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
> >> 41 | asm_volatile_goto(
> >> | ^~~~~~~~~~~~~~~~~
> >> ././include/linux/compiler_types.h:285:33: error: impossible constraint in 'asm'
> >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> >> | ^~~
> >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
> >> 41 | asm_volatile_goto(
> >> | ^~~~~~~~~~~~~~~~~
> >> make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> >> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> >> 
> >> Having a static branch in cpu_relax() is problematic because that
> >> function is widely inlined, including in some quite complex functions
> >> like in the VDSO. A quick measurement shows this static branch is
> >> responsible by itself for around 40% of the jump table.
> >> 
> >> Drop the static branch, which ends up being the same number of
> >> instructions anyway. If Zihintpause is supported, we trade the nop from
> >> the static branch for a div. If Zihintpause is unsupported, we trade the
> >> jump from the static branch for (what gets interpreted as) a nop.
> >> 
> >> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >> 
> >> arch/riscv/include/asm/hwcap.h | 3 ---
> >> arch/riscv/include/asm/vdso/processor.h | 25 ++++++++++---------------
> >> 2 files changed, 10 insertions(+), 18 deletions(-)
> >> 
> >> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> >> index 6f59ec64175e..b21d46e68386 100644
> >> --- a/arch/riscv/include/asm/hwcap.h
> >> +++ b/arch/riscv/include/asm/hwcap.h
> >> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
> >> */
> >> enum riscv_isa_ext_key {
> >> 	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
> >> -	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> >> 	RISCV_ISA_EXT_KEY_MAX,
> >> };
> >> 
> >> @@ -88,8 +87,6 @@ static __always_inline int riscv_isa_ext2key(int num)
> >> 		return RISCV_ISA_EXT_KEY_FPU;
> >> 	case RISCV_ISA_EXT_d:
> >> 		return RISCV_ISA_EXT_KEY_FPU;
> >> -	case RISCV_ISA_EXT_ZIHINTPAUSE:
> >> -		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> >> 	default:
> >> 		return -EINVAL;
> >> 	}
> >> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> >> index 1e4f8b4aef79..789bdb8211a2 100644
> >> --- a/arch/riscv/include/asm/vdso/processor.h
> >> +++ b/arch/riscv/include/asm/vdso/processor.h
> >> @@ -4,30 +4,25 @@
> >> 
> >> #ifndef __ASSEMBLY__
> >> 
> >> -#include <linux/jump_label.h>
> >> #include <asm/barrier.h>
> >> -#include <asm/hwcap.h>
> >> 
> >> static inline void cpu_relax(void)
> >> {
> >> -	if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
> >> #ifdef __riscv_muldiv
> >> -		int dummy;
> >> -		/* In lieu of a halt instruction, induce a long-latency stall. */
> >> -		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> >> +	int dummy;
> >> +	/* In lieu of a halt instruction, induce a long-latency stall. */
> >> +	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> >> #endif
> >> -	} else {
> >> -		/*
> >> -		 * Reduce instruction retirement.
> >> -		 * This assumes the PC changes.
> >> -		 */
> >> +	/*
> >> +	 * Reduce instruction retirement.
> >> +	 * This assumes the PC changes.
> >> +	 */
> >> #ifdef __riscv_zihintpause
> >> -		__asm__ __volatile__ ("pause");
> >> +	__asm__ __volatile__ ("pause");
> >> #else
> >> -		/* Encoding of the pause instruction */
> >> -		__asm__ __volatile__ (".4byte 0x100000F");
> >> +	/* Encoding of the pause instruction */
> >> +	__asm__ __volatile__ (".4byte 0x100000F");
> >> #endif
> > 
> > hmm, though before this part of the code was only ever accessed
> > when the zhintpause extension was really available on the running
> > machine while now the pause instruction is called every time.
> > 
> > So I'm just wondering, can't this run into some "illegal instruction"
> > thingy on machines not supporting the extension?
> 
> No. The encoding for pause was deliberately chosen to be one of the
> “useless” encodings of fence, with the hope that existing
> microarchitectures might take a while to execute it and thus it would
> still function as a slow-running instruction. It’s somewhat
> questionable whether the div is even needed, the worst that happens is
> cpu_relax isn’t very relaxed and you spin a bit faster. Any
> implementations where that’s true probably also don’t have fancy
> clock/power management anyway, and div isn’t going to be a low-power
> operation so the only real effect is likely hammering on contended
> atomics a bit more, and who cares about that on the low core count
> systems we have today.

thanks a lot for that explanation, which made things a lot clearer.

So as you said, dropping the div part might make the function even smaller,
though somehow part of me would want to add some sort of comment to
the function for when the next developer stumbles over the unconditional
use of pause :-) .


Heiko


