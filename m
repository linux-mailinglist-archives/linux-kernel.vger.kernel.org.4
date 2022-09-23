Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE9F5E7ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiIWM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiIWM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:26:42 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0A83135046
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:22:45 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 28NCIU7x016687;
        Fri, 23 Sep 2022 07:18:30 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 28NCITHi016686;
        Fri, 23 Sep 2022 07:18:29 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 23 Sep 2022 07:18:29 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/irq: Modernise inline assembly in irq_soft_mask_{set,return}
Message-ID: <20220923121829.GL25951@gate.crashing.org>
References: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu> <CN3LB8F3D9LM.3W1RQRVS64UXU@bobo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CN3LB8F3D9LM.3W1RQRVS64UXU@bobo>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:08:13PM +1000, Nicholas Piggin wrote:
> On Tue Sep 20, 2022 at 4:41 PM AEST, Christophe Leroy wrote:
> > local_paca is declared as global register asm("r13"), it is therefore
> > garantied to always ever be r13.
> >
> > It is therefore not required to opencode r13 in the assembly, use
> > a reference to local_paca->irq_soft_mask instead.

> The code matches the changelog AFAIKS. But I don't know where it is
> guaranteed it will always be r13 in GCC and Clang. I still don't know
> where in the specification or documentation suggests this.

"Global Register Variables" in the GCC manual.

> There was some assertion it would always be r13, but that can't be a
> *general* rule. e.g., the following code:
> 
> struct foo {
> #ifdef BIGDISP
>         int array[1024*1024];
> #endif
>         char bar;
> };
> 
> register struct foo *foo asm("r13");
> 
> static void setval(char val)
> {
>         asm("stb%X0 %1,%0" : "=m" (foo->bar) : "r" (val));
> }
> 
> int main(void)
> {
>         setval(10);
> }

Just use r13 directly in the asm, if that is what you want!

> With -O0 this generates stb 9,0(10) for me for GCC 12, and with -O2
> -DBIGDISP it generates stb 10,0(9). So that makes me nervious. GCC
> does not have some kind of correctness guarantee here, so it must not
> have this in its regression tests etc., and who knows about clang.

GCC has all kinds of correctness guarantees, here and elsewhere, that is
90% of a compiler's job.  But you don't *tell* it what you consider
"correct" here.

You wrote "foo->bar", and this expression was translated to something
that derived from r13.  If you made the asm something like
	asm("stb%X0 %1,0(%0)" : : "r" (foo), "r" (val) : "memory");
it would work fine.  It would also work fine if you wrote 13 in the
template directly.  These things follow the rules, so are guaranteed.

The most important pieces of doc here may be
   * Accesses to the variable may be optimized as usual and the register
     remains available for allocation and use in any computations,
     provided that observable values of the variable are not affected.
   * If the variable is referenced in inline assembly, the type of
     access must be provided to the compiler via constraints (*note
     Constraints::).  Accesses from basic asms are not supported.
but read the whole "Global Register Variables" chapter?

> If it is true for some particular subset of cases that we can guarantee,
> e.g., using -O2 and irq_soft_mask offset within range of stb offset and
> we can point to specification such that both GCC and Clang will follow
> it, then okay. Otherwise I still think it's more trouble than it is
> worth.

-O2 makes it much more likely some inline assembler things work as
intended, but it guarantees nothing.  Sorry.


Segher
