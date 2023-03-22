Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B516C4B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCVMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCVMxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:53:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C617CFE;
        Wed, 22 Mar 2023 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BRyU+JbkSdh5FU2QQ8gNeV3eQhFmOfGX6dsLMm751I=; b=Wn4ZgGHpfD6yPJFUT5oLuFN3qw
        UfwHFLXgWP5rl/xFiyT4EcY81xma2D2cL1/AyfutYWo1Wv25FiR7Kz5v1/C3sJ1SlD/AvnbrWpipp
        gz3ao5le8asoZrMVWTAiI7VYVeHTSZ+XQVTwYj1bg0NLj6yCkkayJAQNlkiEWqvqtPplz+j9f7taf
        ErnrrG7r6ryAIf0drZhRYZaCpFt3Mh7YWOoEQfOvNtwNRcBdETtdYKBJhpBSR7//MhcP7QnXweZ/q
        SKQfFLELiKFR2xJn+5A+D6/HwjVSaO+Ar0niJ59rYCTr5osVIvnHQ2aSynYd/3hZiOfh+lBMV+OOT
        k49oq18g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pexxc-0031Ii-3q; Wed, 22 Mar 2023 12:53:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0E0230030F;
        Wed, 22 Mar 2023 13:52:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D34D205D08C3; Wed, 22 Mar 2023 13:52:57 +0100 (CET)
Date:   Wed, 22 Mar 2023 13:52:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ross Zwisler <zwisler@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] tracing: Trace instrumentation begin and end
Message-ID: <20230322125257.GA2357380@hirez.programming.kicks-ass.net>
References: <20230321215121.71b339c5@gandalf.local.home>
 <87y1np824t.ffs@tglx>
 <20230322084834.37ed755e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322084834.37ed755e@gandalf.local.home>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 08:48:34AM -0400, Steven Rostedt wrote:
> On Wed, 22 Mar 2023 12:19:14 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Steven!
> > 
> > On Tue, Mar 21 2023 at 21:51, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > produces:
> > >
> > >  2)   0.764 us    |  exit_to_user_mode_prepare();
> > >  2)               |  /* page_fault_user: address=0x7fadaba40fd8 ip=0x7fadaba40fd8 error_code=0x14 */
> > >  2)   0.581 us    |  down_read_trylock();
> > >
> > > The "page_fault_user" event is not encapsulated around any function, which
> > > means it probably triggered and went back to user space without any trace
> > > to know how long that page fault took (the down_read_trylock() is likely to
> > > be part of the page fault function, but that's besides the point).
> > >
> > > To help bring back the old functionality, two trace points are added. One
> > > just after instrumentation begins, and one just before it ends. This way,
> > > we can see all the time that the kernel can do something meaningful, and we
> > > will trace it.  
> > 
> > Seriously? That's completely insane. Have you actually looked how many
> > instrumentation_begin()/end() pairs are in the affected code pathes?
> > 
> > Obviously not. It's a total of _five_ for every syscall and at least
> > _four_ for every interrupt/exception from user mode.
> > 
> > The number #1 design rule for instrumentation is to be as non-intrusive as
> > possible and not to be as lazy as possible.
> 
> And it still is. It still uses nops when not enabled. I could even add a
> config to only have this compiled in when the config is set, so that
> production can disable it if it wants to.
> 
> Just in case it's not obvious:
> 
> 	if (tracepoint_enabled(instrumentation_begin))
> 		call_trace_instrumentation_begin(ip, pip);
> 
> is equivalent to:
> 
> 	if (static_key_false(&__tracepoint_instrumentation_begin.key))
> 		call_trace_instrumentation_begin(ip, pip);
> 

It is still completely insane.

NAK.
