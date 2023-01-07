Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E42F660C06
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 03:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjAGCqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 21:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGCq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 21:46:29 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B5184BFC;
        Fri,  6 Jan 2023 18:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z80V7BWLLwigfiKI4dL/5j2LGkzDiZ6a+1vY1hMchMQ=; b=aBKfPNrS2h2+fLKta3N2z73QTi
        HoKRtKUXnLHT1i7pg9kITNSh1L8Uf8rPFCejKIqouYArS7xgfWwtWAzn39WwVcs6i9qNkpDBhqPPB
        eZodBcNpeK6VmsoXLc4FhJAqNDmN5nmwmN1ejH85wweziz4Gm3sblNjp0f695D9wHDXXwM0phGkPK
        pmIfQm+5ZR4pFo18qtSMhFDCJO5uWpWXbmxrVAlS6CW4/mFI9rpceVbCO3fJ5r6X3CH3gBigtjHZ3
        tT13+vA89kDAkG+vH+NDDpmFX64nyoxjrc27hjzaeXhJMdFChS/xwe/NFQz+uPjtXxCejb0qvs/EG
        4pd+1tZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pDzE1-000GZH-2c;
        Sat, 07 Jan 2023 02:46:26 +0000
Date:   Sat, 7 Jan 2023 02:46:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Richard Henderson <rth@twiddle.net>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: fix FEN fault handling
Message-ID: <Y7jdARsEQXPugR0t@ZenIV>
References: <Y7jD8XDZGnQkTvMI@ZenIV>
 <84c0d4ea-09e2-4907-d03d-939d40fa3c96@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84c0d4ea-09e2-4907-d03d-939d40fa3c96@twiddle.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:55:14PM -0800, Richard Henderson wrote:
> On 1/6/23 16:59, Al Viro wrote:
> > Type 3 instruction fault (FPU insn with FPU disabled) is handled
> > by quietly enabling FPU and returning.  Which is fine, except that
> > we need to do that both for fault in userland and in the kernel;
> > the latter *can* legitimately happen - all it takes is this:
> > 
> > .global _start
> > _start:
> > 	call_pal 0xae
> > 	lda $0, 0
> > 	ldq $0, 0($0)
> > 
> > - call_pal CLRFEN to clear "FPU enabled" flag and arrange for
> > a signal delivery (SIGSEGV in this case).
> > 
> > Fixed by moving the handling of type 3 into the common part of
> > do_entIF(), before we check for kernel vs. user mode.
> > 
> > Incidentally, check for kernel mode is unidiomatic; the normal
> > way to do that is !user_mode(regs).  The difference is that
> > the open-coded variant treats any of bits 63..3 of regs->ps being
> > set as "it's user mode" while the normal approach is to check just
> > the bit 3.  PS is a 4-bit register and regs->ps always will have
> > bits 63..4 clear, so the open-code variant here is actually equivalent
> > to !user_mode(regs).  Harder to follow, though...
> > 
> > Reproducer above will crash any box where CLRFEN is not ignored by
> > PAL (== any actual hardware, AFAICS; PAL used in qemu doesn't
> > bother implementing that crap).
> 
> I didn't realize I'd forgotten this in qemu.  Anyway,
> 
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Not sure it's worth bothering with in palcode-clipper - for Linux it's
useless (run out of timeslice and FEN will end up set, no matter what),
nothing in NetBSD or OpenBSD trees generates that call_pal, current
FreeBSD doesn't support alpha and their last version to do so hadn't
generated that call_pal either...  What else is out there?  OSF?
