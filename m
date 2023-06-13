Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119EA72E778
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbjFMPlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbjFMPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5597B1A5;
        Tue, 13 Jun 2023 08:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF11B6253F;
        Tue, 13 Jun 2023 15:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E1FC433F0;
        Tue, 13 Jun 2023 15:40:51 +0000 (UTC)
Date:   Tue, 13 Jun 2023 11:40:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Song Liu <song@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2] ftrace: Allow inline functions not inlined to be
 traced
Message-ID: <20230613114049.096a8844@gandalf.local.home>
In-Reply-To: <87lego7m50.ffs@tglx>
References: <20230609174422.04824a9e@gandalf.local.home>
        <87lego7m50.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 17:09:31 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> >
> > Currently only x86 uses this.  
> 
> I assume this passes the objtool noinstr validation. If so, if would be
> helpful to document that.

I haven't run this through the full test suite. But I will check.

> >  /*
> >   * gcc provides both __inline__ and __inline as alternate spellings of
> > @@ -230,7 +240,7 @@ struct ftrace_likely_data {
> >   *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
> >   * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
> >   */
> > -# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
> > +# define __no_kasan_or_inline __no_sanitize_address __notrace_inline __maybe_unused  
> 
> I'm not convinced that this is correct
> 
> >  # define __no_sanitize_or_inline __no_kasan_or_inline
> >  #else  
> 
> given that the !__SANITIZE_ADDRESS__ variant is:
> 
> >  # define __no_kasan_or_inline __always_inline  
> 
> which cannot be traced.
> 
> > @@ -247,7 +257,7 @@ struct ftrace_likely_data {
> >   * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
> >   */
> >  # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
> > -# define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
> > +# define __no_sanitize_or_inline __no_kcsan __notrace_inline  __maybe_unused  
> 
> Ditto. 

I'll just keep the notrace on these.

> 
> >  #else
> >  # define __no_kcsan
> >  #endif
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index abe5c583bd59..b66ab0e6ce19 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -106,6 +106,13 @@ config HAVE_BUILDTIME_MCOUNT_SORT
> >           An architecture selects this if it sorts the mcount_loc section
> >  	 at build time.
> >  
> > +config ARCH_CAN_TRACE_INLINE
> > +       bool
> > +       help
> > +         It is safe for an architecture to trace any function marked  
> 
> Spaces instead of tab.

Bah, I noticed that my emacs is doing this on other configs I just added.
It adds spaces for the first entry, then tabs for the rest.

> 
> > +	 as inline (not __always_inline) that the compiler decides to  
> 
> and this one has a tab.
> 
> > +	 not inline.
> > +
> >  config BUILDTIME_MCOUNT_SORT
> >         bool
> >         default y  

Thanks for the review!

-- Steve
