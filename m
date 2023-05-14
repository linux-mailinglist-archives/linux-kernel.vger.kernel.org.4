Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B085E702073
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjENW3q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 14 May 2023 18:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENW3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:29:44 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2810310F0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:29:41 -0700 (PDT)
Received: from ip5b412278.dynamic.kabel-deutschland.de ([91.65.34.120] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pyKDi-000301-3F; Mon, 15 May 2023 00:29:38 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     'Christoph Muellner' <christoph.muellner@vrull.eu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Aaron Durbin <adurbin@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH v2] riscv: Add Zawrs support for spinlocks
Date:   Mon, 15 May 2023 00:29:30 +0200
Message-ID: <2679603.mvXUDI8C0e@diego>
In-Reply-To: <f04bd42eb93b4c4dbece34236a7b994b@AcuMS.aculab.com>
References: <20220623152948.1607295-1-christoph.muellner@vrull.eu>
 <f04bd42eb93b4c4dbece34236a7b994b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Am Freitag, 24. Juni 2022, 10:52:40 CEST schrieb David Laight:
> From: Christoph Muellner
> > Sent: 23 June 2022 16:30
> > 
> > From: Christoph Müllner <christoph.muellner@vrull.eu>
> > 
> > The current RISC-V code uses the generic ticket lock implementation,
> > that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
> > Currently, RISC-V uses the generic implementation of these macros.
> > This patch introduces a RISC-V specific implementation, of these
> > macros, that peels off the first loop iteration and modifies the waiting
> > loop such, that it is possible to use the WRS.STO instruction of the Zawrs
> > ISA extension to stall the CPU.
> > 
> > The resulting implementation of smp_cond_load_*() will only work for
> > 32-bit or 64-bit types for RV64 and 32-bit types for RV32.
> > This is caused by the restrictions of the LR instruction (RISC-V only
> > has LR.W and LR.D). Compiler assertions guard this new restriction.
> > 
> > This patch uses the existing RISC-V ISA extension framework
> > to detect the presents of Zawrs at run-time.
> > If available a NOP instruction will be replaced by WRS.NTO or WRS.STO.
> > 
> > The whole mechanism is gated by Kconfig setting, which defaults to Y.
> > 
> > The Zawrs specification can be found here:
> > https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> > 
> > Note, that the Zawrs extension is not frozen or ratified yet.
> > Therefore this patch is an RFC and not intended to get merged.
> > 
> > Changes since v1:
> > * Adding "depends on !XIP_KERNEL" to RISCV_ISA_ZAWRS
> > * Fixing type checking code in __smp_load_reserved*
> > * Adjustments according to the specification change
> > 
> > Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>

I'm only addressing the point here were I don't agree with you :-)
Everything else will be in the next version.

[...]

> > +
> > +#define ___smp_load_reservedN(pfx, ptr)					\
> > +({									\
> > +	typeof(*ptr) ___p1;						\
> > +	__asm__ __volatile__ ("lr." pfx "	%[p], %[c]\n"		\
> > +			      : [p]"=&r" (___p1), [c]"+A"(*ptr));	\
> > +	___p1;								\
> > +})
> 
> Isn't that missing the memory reference?
> It either needs a extra memory parameter for 'ptr' or
> a full/partial memory clobber.

Shouldn't the "+A" for *ptr should take care of that?

From the gcc docs [0]:
	‘+’  Means that this operand is both read and written by the instruction.


Heiko

[0] https://gcc.gnu.org/onlinedocs/gcc/Modifiers.html#index-_002b-in-constraint



