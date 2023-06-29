Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAF2742DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjF2TnB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjF2Tm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:42:59 -0400
X-Greylist: delayed 10803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 12:42:56 PDT
Received: from 1.mo582.mail-out.ovh.net (1.mo582.mail-out.ovh.net [46.105.56.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8975210E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:42:56 -0700 (PDT)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.146.86])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 1B22F27328
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:06:06 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-jjccx (unknown [10.110.115.101])
        by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5CA781FD81;
        Thu, 29 Jun 2023 16:06:05 +0000 (UTC)
Received: from courmont.net ([37.59.142.102])
        by ghost-submission-6684bf9d7b-jjccx with ESMTPSA
        id 6K0SEu2rnWRLegEAx5K4IQ
        (envelope-from <remi@remlab.net>); Thu, 29 Jun 2023 16:06:05 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R00462b49bf9-edcf-4eeb-9952-1c40042ce9f5,
                    F84C1CB5A676BA8784C093282B10E490F1B88DE6) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] RISC-V: add T-Head vector errata handling
Date:   Thu, 29 Jun 2023 19:06:04 +0300
Message-ID: <3235072.aeNJFYEL58@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230622231305.631331-4-heiko@sntech.de>
References: <20230622231305.631331-1-heiko@sntech.de>
 <20230622231305.631331-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 12388839627150727643
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeffgedthfegveefhffhffehvddtvdetgfelveeuueekkeetvefgtdfgffdvhfegveenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Le perjantaina 23. kesäkuuta 2023, 2.13.05 EEST Heiko Stuebner a écrit :
> diff --git a/arch/riscv/include/asm/errata_list.h
> b/arch/riscv/include/asm/errata_list.h index fb1a810f3d8c..ab21fadbe9c6
> 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -154,6 +155,48 @@ asm volatile(ALTERNATIVE(				
		\
> 
>  	: "=r" (__ovl) :						
\
>  	: "memory")
> 
> +#ifdef CONFIG_ERRATA_THEAD_VECTOR
> +
> +#define THEAD_C9XX_CSR_VXSAT			0x9
> +#define THEAD_C9XX_CSR_VXRM			0xa
> +
> +/*
> + * Vector 0.7.1 as used for example on T-Head Xuantie cores, uses an older
> + * encoding for vsetvli (ta, ma vs. d1), so provide an instruction for
> + * vsetvli	t4, x0, e8, m8, d1
> + */
> +#define THEAD_VSETVLI_T4X0E8M8D1	".long	0x00307ed7\n\t"

That is equivalent to, and (IMHO) much less legible than:
".insn   i OP_V, 7, t4, x0, 3"
Or even if you don't mind second-guessing RVV 1.0 assemblers:
"vsetvli t4, zero, e8, m8, tu, mu"

Either way, you don't need to hard-code X-register operands in assembler 
macros (though you do unfortunately need to hard-code V register operands if 
you use .insn).

> +
> +/*
> + * While in theory, the vector-0.7.1 vsb.v and vlb.v result in the same
> + * encoding as the standard vse8.v and vle8.v,

Not only in theory. vse8.v and vle8.v have only one possible encoding each 
(for given operands).

> compilers seem to optimize

Nit: By "compilers", do you mean "assemblers"? That's a bit misleading to me.

> + * the call resulting in a different encoding and then using a value for
> + * the "mop" field that is not part of vector-0.7.1

Uh, no? They use mew = 0b0 and mop = 0b00, which corresponds to mop = 0b000.

> + * So encode specific variants for vstate_save and _restore.
> + */
> +#define THEAD_VSB_V_V0T0		".long	0x02028027\n\t"

That's "vse8.v v0, (t0)", at least as assembled with binutils 2.40.50.20230625 
(from Debian unstable). I don't understand the rationale for hard-coding from 
the above comment. Maybe that's just me being an idiot, but if so, then the 
comment ought to be clarified.

(I do realise that vse8.v and vsb.v are not exactly equivalent in behaviour, 
but here, the concern should be the assembler, not the processor.)

> +#define THEAD_VSB_V_V8T0		".long	0x02028427\n\t"
> +#define THEAD_VSB_V_V16T0		".long	0x02028827\n\t"
> +#define THEAD_VSB_V_V24T0		".long	0x02028c27\n\t"
> +#define THEAD_VLB_V_V0T0		".long	0x012028007\n\t"

This has one nibble too many for a 32-bit value.

And why use sign-extended loads? Zero-extended loads would have the exact same 
encoding as vle8.v, and not need this dark magic, AFAICT.

> +#define THEAD_VLB_V_V8T0		".long	0x012028407\n\t"
> +#define THEAD_VLB_V_V16T0		".long	0x012028807\n\t"
> +#define THEAD_VLB_V_V24T0		".long	0x012028c07\n\t"
> +
> +#define ALT_SR_VS_VECTOR_1_0_SHIFT	9
> +#define ALT_SR_VS_THEAD_SHIFT		23
> +
> +#define ALT_SR_VS(_val, prot)					
	\
> +asm(ALTERNATIVE("li %0, %1\t\nslli %0,%0,%3",				
\
> +		"li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,		
\
> +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)	\
> +		: "=r"(_val)					
	\
> +		: "I"(prot##_1_0 >> ALT_SR_VS_VECTOR_1_0_SHIFT),	\
> +		  "I"(prot##_THEAD >> ALT_SR_VS_THEAD_SHIFT),		
\
> +		  "I"(ALT_SR_VS_VECTOR_1_0_SHIFT),			
\
> +		  "I"(ALT_SR_VS_THEAD_SHIFT))
> +#endif /* CONFIG_ERRATA_THEAD_VECTOR */
> +
>  #endif /* __ASSEMBLY__ */
> 
>  #endif

-- 
レミ・デニ-クールモン
http://www.remlab.net/



