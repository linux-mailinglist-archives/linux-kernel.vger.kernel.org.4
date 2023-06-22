Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45F973A76E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFVRkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjFVRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:39:53 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFA92118
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:39:46 -0700 (PDT)
Received: from i53875bdf.versanet.de ([83.135.91.223] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qCOHN-0001Ae-3y; Thu, 22 Jun 2023 19:39:33 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     palmer@dabbelt.com, Stefan O'Rear <sorear@fastmail.com>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] RISC-V: add T-Head vector errata handling
Date:   Thu, 22 Jun 2023 19:39:32 +0200
Message-ID: <1941316.PYKUYFuaPT@diego>
In-Reply-To: <75071be8-272d-45e7-989f-5d717f313fe2@app.fastmail.com>
References: <20230228215435.3366914-1-heiko@sntech.de>
 <20230228215435.3366914-3-heiko@sntech.de>
 <75071be8-272d-45e7-989f-5d717f313fe2@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Am Dienstag, 13. Juni 2023, 08:35:53 CEST schrieb Stefan O'Rear:
> On Tue, Feb 28, 2023, at 4:54 PM, Heiko Stuebner wrote:
> > @@ -29,6 +78,7 @@ static __always_inline bool has_vector(void)
> >  static inline void __vstate_clean(struct pt_regs *regs)
> >  {
> >  	regs->status = (regs->status & ~(SR_VS)) | SR_VS_CLEAN;
> > +
> >  }
> > 
> >  static inline void vstate_off(struct pt_regs *regs)
> > @@ -58,30 +108,75 @@ static __always_inline void rvv_disable(void)
> > 
> >  static __always_inline void __vstate_csr_save(struct __riscv_v_state *dest)
> >  {
> > -	asm volatile (
> > +	register u32 t1 asm("t1") = (SR_FS);
> > +
> > +	/*
> > +	 * CSR_VCSR is defined as
> > +	 * [2:1] - vxrm[1:0]
> > +	 * [0] - vxsat
> > +	 * The earlier vector spec implemented by T-Head uses separate
> > +	 * registers for the same bit-elements, so just combine those
> > +	 * into the existing output field.
> > +	 *
> > +	 * Additionally T-Head cores need FS to be enabled when accessing
> > +	 * the VXRM and VXSAT CSRs, otherwise ending in illegal instructions.
> > +	 */
> > +	asm volatile (ALTERNATIVE(
> >  		"csrr	%0, " CSR_STR(CSR_VSTART) "\n\t"
> >  		"csrr	%1, " CSR_STR(CSR_VTYPE) "\n\t"
> >  		"csrr	%2, " CSR_STR(CSR_VL) "\n\t"
> >  		"csrr	%3, " CSR_STR(CSR_VCSR) "\n\t"
> > +		__nops(5),
> > +		"csrs	sstatus, t1\n\t"
> > +		"csrr	%0, " CSR_STR(CSR_VSTART) "\n\t"
> > +		"csrr	%1, " CSR_STR(CSR_VTYPE) "\n\t"
> > +		"csrr	%2, " CSR_STR(CSR_VL) "\n\t"
> > +		"csrr	%3, " CSR_STR(THEAD_C9XX_CSR_VXRM) "\n\t"
> > +		"slliw	%3, %3, " CSR_STR(VCSR_VXRM_SHIFT) "\n\t"
> > +		"csrr	t4, " CSR_STR(THEAD_C9XX_CSR_VXSAT) "\n\t"
> > +		"or	%3, %3, t4\n\t"
> > +		"csrc	sstatus, t1\n\t",
> > +		THEAD_VENDOR_ID,
> > +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
> >  		: "=r" (dest->vstart), "=r" (dest->vtype), "=r" (dest->vl),
> > -		  "=r" (dest->vcsr) : :);
> > +		  "=r" (dest->vcsr) : "r"(t1) : "t4");
> >  }
> > 
> >  static __always_inline void __vstate_csr_restore(struct __riscv_v_state *src)
> >  {
> > -	asm volatile (
> > +	register u32 t1 asm("t1") = (SR_FS);
> > +
> > +	/*
> > +	 * Similar to __vstate_csr_save above, restore values for the
> > +	 * separate VXRM and VXSAT CSRs from the vcsr variable.
> > +	 */
> > +	asm volatile (ALTERNATIVE(
> >  		"vsetvl	 x0, %2, %1\n\t"
> >  		"csrw	" CSR_STR(CSR_VSTART) ", %0\n\t"
> >  		"csrw	" CSR_STR(CSR_VCSR) ", %3\n\t"
> > +		__nops(6),
> > +		"csrs	sstatus, t1\n\t"
> > +		"vsetvl	 x0, %2, %1\n\t"
> > +		"csrw	" CSR_STR(CSR_VSTART) ", %0\n\t"
> > +		"srliw	t4, %3, " CSR_STR(VCSR_VXRM_SHIFT) "\n\t"
> > +		"andi	t4, t4, " CSR_STR(VCSR_VXRM_MASK) "\n\t"
> > +		"csrw	" CSR_STR(THEAD_C9XX_CSR_VXRM) ", t4\n\t"
> > +		"andi	%3, %3, " CSR_STR(VCSR_VXSAT_MASK) "\n\t"
> > +		"csrw	" CSR_STR(THEAD_C9XX_CSR_VXSAT) ", %3\n\t"
> > +		"csrc	sstatus, t1\n\t",
> > +		THEAD_VENDOR_ID,
> > +		ERRATA_THEAD_VECTOR, CONFIG_ERRATA_THEAD_VECTOR)
> >  		: : "r" (src->vstart), "r" (src->vtype), "r" (src->vl),
> > -		    "r" (src->vcsr) :);
> > +		    "r" (src->vcsr), "r"(t1): "t4");
> >  }
> 
> vxrm and vxsat are part of fcsr in 0.7.1, so they should already have been
> handled by __fstate_save and __fstate_restore, and this code is likely to
> misbehave (saving the new process's vxrm/vxsat in the old process's save area
> because float state is swapped before vector state in __switch_to).

I'm not sure I follow your description but may be overlooking or have
misunderstood something.

Somehow I way to often have trouble resolving CSR addresses, but according
to openSBI, FCSR has the location of 0x3
(#define CSR_FCSR 0x003 in include/sbi/riscv_encoding.h)

where CSR_VXSAT and CSR_VXRM are at 0x9 and 0xa respectively.
(#define CSR_VXSAT 0x9 and  #define CSR_VXRM 0xa)


And looking at __fstate_save + __fstate_restore the only CSRs accessed seem
to be CSR_STATUS and FCSR itself.

I definitly won't claim to be right, but don't see the issue yet.


Thanks for a hint
Heiko


