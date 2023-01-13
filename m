Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9D66A0BD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjAMR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjAMR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:29:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0B8BF3D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EDJ4xEF3lLYItJUA9SlN4B6NAGGeDix65KOyh4872KE=; b=aXGlnATjL/pIS/dvAc4QlTkC6n
        98Kga71sLav22h3qllusB8eu2B0ZdlIgpZcdvtKspuKgFQbCbUSVBF4X8qJwLt51fu8xisXhXywWa
        twLWUZjoFoNDX9Ees0xi3v4KhtyssJl04flS52YYf5y7rUuUyrU1GiJfmx+YfQMvbLOLl8Ngq4hfl
        Gm4QGhDNhBkYsb0ocZfuUvta1wC1w+K/gD/h2lN/BnXJXCf6VWmWxO/D7rY41Udntbi3TZupthNkl
        22GSsyOJZyDXLiDsVCH8BGAIXlR7Mc/CEOuAerH/v8gnYftKmtj4kulSxMXdLOU85rp5RmPxEGxh9
        y1vEGrDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGNgZ-006HaL-9N; Fri, 13 Jan 2023 17:17:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80FF7300094;
        Fri, 13 Jan 2023 18:17:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59EA620A72A62; Fri, 13 Jan 2023 18:17:32 +0100 (CET)
Date:   Fri, 13 Jan 2023 18:17:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>, mark.rutland@arm.com
Subject: Re: [RFC][PATCH 2/6] x86/power: Inline write_cr[04]()
Message-ID: <Y8GSLDhgMlE96P6+@hirez.programming.kicks-ass.net>
References: <20230112143141.645645775@infradead.org>
 <20230112143825.644480983@infradead.org>
 <Y8FZvLq+MeQ7A+lI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8FZvLq+MeQ7A+lI@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:16:44PM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Since we can't do CALL/RET until GS is restored and CR[04] pinning is
> > of dubious value in this code path, simply write the stored values.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/power/cpu.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/x86/power/cpu.c
> > +++ b/arch/x86/power/cpu.c
> > @@ -208,11 +208,11 @@ static void notrace __restore_processor_
> >  #else
> >  /* CONFIG X86_64 */
> >  	native_wrmsrl(MSR_EFER, ctxt->efer);
> > -	native_write_cr4(ctxt->cr4);
> > +	asm volatile("mov %0,%%cr4": "+r" (ctxt->cr4) : : "memory");
> 
> >  #endif
> >  	native_write_cr3(ctxt->cr3);
> >  	native_write_cr2(ctxt->cr2);
> > -	native_write_cr0(ctxt->cr0);
> > +	asm volatile("mov %0,%%cr0": "+r" (ctxt->cr0) : : "memory");
> 
> Yeah, so CR pinning protects against are easily accessible 'gadget' 
> functions that exploits can call to disable HW protection features in the 
> CR register.
> 
> __restore_processor_state() might be such a gadget if an exploit can pass 
> in a well-prepared 'struct saved_context' on the stack.

Given the extent of saved_context, I think it's a total loss. Best we
can do is something like the last patch here that dis-allows indirect
calls of this function entirely (on appropriate builds/hardware).

> Can we set up cr0/cr4 after we have a proper GS, or is that a 
> chicken-and-egg scenario?

Can be done, but given the state we're in, I'd rather have the simplest
possible rules, calling out to functions with dodgy CR[04] is
'suboptimal' as well.

If people really worry about this I suppose we can call the full
native_write_cr4() later to double check the value in the context or
something.
