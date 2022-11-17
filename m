Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6293862D531
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiKQIlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239597AbiKQIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:41:03 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066AA73408
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fDZT9FBMEcmn4v7ZpGQ4rwaIFRFiJJ9SjRwrHLlObY4=; b=jOQNVJzFDIsiys3iaBF0CBs05M
        9S3qgrBHFiG3wqYMJk9fV0gbl2wzvnug3ZyzjFvXbsaKL3Q3rmRmA/KqB+BDlloJ4cqZbaAtndQ6t
        7UfENddcRK9feckdfpA77rZeD0cFXx5AAaCzGVqykorxRecDsEKbh734Z5yiaeJLHQlDX7jseS7A2
        3+EZY0NqCbxbqMTHIRuX1AwF9aTgr0awTze32Np+Nx7gagctS6FssxdBNruC13DDSoOxSIq0B4nmE
        NAnl0I2hRnnku2481s1WKcaxyI6BrfFUSOXUxQxR6W0K+IyXk+kgnFrNQFKOL8oTiM4S8oCEaIk3u
        YDXvgNpA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovaS3-001cmX-SA; Thu, 17 Nov 2022 08:40:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F866300454;
        Thu, 17 Nov 2022 09:40:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A9332022F73A; Thu, 17 Nov 2022 09:40:51 +0100 (CET)
Date:   Thu, 17 Nov 2022 09:40:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 18/46] entry, lto: Mark raw_irqentry_exit_cond_resched()
 as __visible
Message-ID: <Y3XzkxNVTvdB4a/1@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-19-jirislaby@kernel.org>
 <87a64qo4th.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a64qo4th.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:30:34AM +0100, Thomas Gleixner wrote:
> On Mon, Nov 14 2022 at 12:43, Jiri Slaby wrote:
> > Symbols referenced from assembler (either directly or e.f. from
> 
> from assembler? I'm not aware that the assembler references anything.
> 
> Also what does e.f. mean? Did you want to write e.g.?
> 
> > DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> > they could end up in a different object file than the assembler. This
> 
> than the assembler? Are we shipping the assembler in an object file?
> 
> > can lead to linker errors without this patch.
> 
> git grep -i 'this patch' Documentation/process/
> 
> > So mark raw_irqentry_exit_cond_resched() as __visible.
> 
> And all that tells me what? I know what you want to say, but it's not
> there.
> 
>   Symbols in different compilation units which are referenced from
>   assembly code either directly or indirectly, e.g. from
>   DEFINE_STATIC_KEY(), must be marked visible for GCC based LTO builds.
> 
>   Add the missing __visible annotation to raw_irqentry_exit_cond_resched().
> 
> See?
> 
> There is no 'global' because it's obvious that a symbol in a different
> compilation unit must be global to be resolvable. It's also obvious that
> code in different compilation units ends up in different object files.
> 
> So stating that it's a 'must' to have such symbols marked visible is
> good enough for an argument because that tells the reader that this is a
> mandatory requirement for an GCC based LTO build.
> 
> No?

I still don't understand any of it -- this symbol is not static (and
thus lives in the global namespace and it's name must not be mangled
lest it breaks ABI), this symbol has it's address taken, so it must not
be eliminated.

WTF does this crazy LTO thing require __visible on it?

The original Changelog babbles something about multiple object files,
which doesn't make sense either, there is only a single object file with
LTO -- that's sort of the whole point. The translation unit output
becomes some intermediate gunk -- to be used as input for the LTO pass,
but it is not an ELF object file.

The linker takes all these intermediate files, does the global
optimization thing and then generates a real ELF object file.

Anyway; I think we can drop all this crazy on the floor again, since per
the 0/n (which I didn't get) there isn't any actual benefit from using
GCC-LTO, so why should we bother with all this ugly.

I would suggest GCC implement this integrated assembler and follow the
clang lead here -- or people who want LTO use clang. GCC is clearly
inferior here.
