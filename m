Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429F5E8E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiIXQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIXQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:18:43 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8466090C51
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:18:42 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 28OGEQAB001449;
        Sat, 24 Sep 2022 11:14:26 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 28OGEOKe001448;
        Sat, 24 Sep 2022 11:14:24 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 24 Sep 2022 11:14:24 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/irq: Modernise inline assembly in irq_soft_mask_{set,return}
Message-ID: <20220924161424.GO25951@gate.crashing.org>
References: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu> <CN3LB8F3D9LM.3W1RQRVS64UXU@bobo> <20220923121829.GL25951@gate.crashing.org> <CN3X6YN1FRQ3.1Z9BVD6WYQY3M@bobo> <20220923221543.GN25951@gate.crashing.org> <CN4BYDAY75PX.33LJ1P2VQJXD9@bobo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CN4BYDAY75PX.33LJ1P2VQJXD9@bobo>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 02:00:55PM +1000, Nicholas Piggin wrote:
> On Sat Sep 24, 2022 at 8:15 AM AEST, Segher Boessenkool wrote:
> > Never it is guaranteed that all accesses through this variable will use
> > the register directly: this fundamentally cannot work on all archs, and
> > also not at -O0.  More in general it doesn't work if some basic
> > optimisations are not done, be it because of a compiler deficiency, or a
> > straight out bug, or maybe it is a conscious choice in some cases.
> 
> Right, and we know better than to rely on a spec that is not 100% air
> tight with no possibility of lawyering. This may be what the intention is,
> it may be what gcc and clang do now, and everybody involved today agrees
> with that interpretation. We still have to maintain the kernel tomorrow
> though, so explicit r13 it must be.

It has *always* been this way.  Very old GCC (say, GCC < 3.x) tried to
guarantee more, even, but that turned out to be untenable.  But this is
all in the distant past.

I have no idea if clang implements the GCC C extensions correctly.  If
they don't it is just another compiler bug and they'll just have to fix
it.

The rules *are* airtight.  But this does not mean you can assume random
other stuff, adjacent or not :-P

> > (Please use "n" instead of "i".  Doesn't matter here, but it does in
> > many other places.)
> 
> What is the difference? Just "i" allows assmebly-time constants?

"n" means "number": constant integers.  "i" means "immediate": any
constant.  The address of a global variable is "i" but not "n" (in most
ABIs, no -fPIC and such) for example.

> How about "I"? that looks like it was made for it. Gives much better
> errors.

For PowerPC, "I" is a signed 16-bit number.  "K" is unsigned 16-bit,
and there are more as well.  Just like for "n" you'll have to make
sure the number you feed in will work in the assembler, and you'll get
the same error message (but, as you say, for "I" in some cases the
compiler will give errors already).  It's otherwise only useful if you
use e.g. "IL" as constraint, and then write "addi%e2 %0,%1,%2" for
example, so the asm can generate "addis" insns.  Such things aren't very
often useful in internal asm.  The main reason any of this exists is
this is how GCC works internally; extended inline asm exposes a lot of
that.


Segher
