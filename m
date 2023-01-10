Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9559664DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjAJVXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAJVXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:23:45 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC41C106;
        Tue, 10 Jan 2023 13:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=HMyMBFRESow/WM9ygWpCSGTusSEWJqvkUIysz1wv1dE=; b=mBx0U3jxjMHQOE0pq78Ghngrd6
        yL+fwmUmdLpuk6/N8DUP3Ml3v2eqOkcgxNaHxpQLlzVliLQCofMrqhy/q0LOU8mkNjB7xWpGqa/sl
        Rhla/vldS+0AFV/FnfPE06TGlKpKwZBlYqFRMzRClUHtzOMfJdRGiPi1fwHkn2GaOyuLbB05+rk9D
        cdbNO4XlKpHIQLouUWyIGxHgoITsEEbEU2dYkwJWZNB+o4GmY/FzqqdeSH1xmFgud0iw3P3QTtXCx
        saQMvF9oFMKPydfH0i5SgQYHhTM3wvmBJ9KYgiHHZ5dyOatOjcLSFmCmNjeu+5gUP8uQfwK4Q4D91
        qNG3QIQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFM5n-0014fx-21;
        Tue, 10 Jan 2023 21:23:35 +0000
Date:   Tue, 10 Jan 2023 21:23:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vineet Gupta <vgupta@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bit_spinlock: Include <asm/processor.h>
Message-ID: <Y73XV1SRtcpJQ1Vq@ZenIV>
References: <8b81101d59a31f4927016c17e49be96754a23380.1673204461.git.christophe.jaillet@wanadoo.fr>
 <b5e0bd90-ff29-d301-30ca-2f12028109ce@kernel.org>
 <f4aa7f0d-50a9-b5e0-e980-1e8e779b48bc@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4aa7f0d-50a9-b5e0-e980-1e8e779b48bc@wanadoo.fr>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 07:08:33PM +0100, Christophe JAILLET wrote:
> Le 10/01/2023 à 08:19, Vineet Gupta a écrit :
> > 
> > On 1/8/23 11:04, Christophe JAILLET wrote:
> > > In an attempt to simplify some includes in <include/dcache.h>, it
> > > appeared, when compiling fs/ecryptfs/dentry.c, that
> > > <linux/bit_spinlock.h>
> > > was relying on other includes to get the definition of cpu_relax().
> > > (see [1])
> > > 
> > > It broke on arc.
> > 
> > It its just ARC that broke, maybe we can do something there ?
> 
> Hi,
> 
> It is all what build-bots have spotted so far :)
> 
> I don't think that "fixing" it in ARC is the right approach, unless I missed
> something.
> 
> <linux/bit_spinlock.h> does use cpu_relax(), so it should include what is
> need for that, and not rely on other black magic.

Umm...  That's not obvious - it only uses cpu_relax() in macros, so missing
include would not cause problems if all actual users of those macros happen
to pull the needed header by other means.

Said that, we have

1) defined directly in asm/processor.h, using nothing but the stuff provided by
compiler.h:
	alpha, arc, csky, loongarch, m68k, microblaze, nios2,
	openrisc, parisc, s390, sh, xtensa
2) same, using something in headers pulled by asm/processor.h itself:
	ia64 (needs asm/intrinsic.h)
	hexagon (needs asm/hexagon_vm.h)
	um (needs arch/um/include/linux/time-internal.h)
3) same, but defined in something pulled by asm/processor.h rather than
in asm/processor.h itself; asm/vdso/processor.h is the common location -
those are the cases when we share the same definition for kernel and
vdso builds
	sparc (asm/processor_32.h or asm/processor_64.h)
	arm (asm/vdso/processor.h)
	arm64 (asm/vdso/processor.h)
	powerpc (asm/vdso/processor.h)
	x86 (asm/vdso/processor.h)
	riscv (asm/vdso/processor.h; needs several headers included there -
jump_label.h, etc.)
	mips (asm/vdso/processor.h, needs asm/barrier.h, pulled from asm/processor.h
by way of linux/atomic.h -> asm/atomic.h -> asm/barrier.h)

So asm/processor.h is sufficient for working cpu_relax() and if some
arch-independent code wants cpu_relax() it should pull either
asm/processor.h or linux/processor.h
