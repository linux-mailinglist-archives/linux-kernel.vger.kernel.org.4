Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2636C4B09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjCVMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCVMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A568B471;
        Wed, 22 Mar 2023 05:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0736E620C9;
        Wed, 22 Mar 2023 12:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65061C433EF;
        Wed, 22 Mar 2023 12:48:36 +0000 (UTC)
Date:   Wed, 22 Mar 2023 08:48:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ross Zwisler <zwisler@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] tracing: Trace instrumentation begin and end
Message-ID: <20230322084834.37ed755e@gandalf.local.home>
In-Reply-To: <87y1np824t.ffs@tglx>
References: <20230321215121.71b339c5@gandalf.local.home>
        <87y1np824t.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 12:19:14 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Steven!
> 
> On Tue, Mar 21 2023 at 21:51, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > produces:
> >
> >  2)   0.764 us    |  exit_to_user_mode_prepare();
> >  2)               |  /* page_fault_user: address=0x7fadaba40fd8 ip=0x7fadaba40fd8 error_code=0x14 */
> >  2)   0.581 us    |  down_read_trylock();
> >
> > The "page_fault_user" event is not encapsulated around any function, which
> > means it probably triggered and went back to user space without any trace
> > to know how long that page fault took (the down_read_trylock() is likely to
> > be part of the page fault function, but that's besides the point).
> >
> > To help bring back the old functionality, two trace points are added. One
> > just after instrumentation begins, and one just before it ends. This way,
> > we can see all the time that the kernel can do something meaningful, and we
> > will trace it.  
> 
> Seriously? That's completely insane. Have you actually looked how many
> instrumentation_begin()/end() pairs are in the affected code pathes?
> 
> Obviously not. It's a total of _five_ for every syscall and at least
> _four_ for every interrupt/exception from user mode.
> 
> The number #1 design rule for instrumentation is to be as non-intrusive as
> possible and not to be as lazy as possible.

And it still is. It still uses nops when not enabled. I could even add a
config to only have this compiled in when the config is set, so that
production can disable it if it wants to.

Just in case it's not obvious:

	if (tracepoint_enabled(instrumentation_begin))
		call_trace_instrumentation_begin(ip, pip);

is equivalent to:

	if (static_key_false(&__tracepoint_instrumentation_begin.key))
		call_trace_instrumentation_begin(ip, pip);

We have trace points in preempt_enable/disable() I think that's *far* more
intrusive.

> 
> instrumentation_begin()/end() is solely meant for objtool validation and
> nothing else.
> 
> There are clearly less horrible ways to retrieve the #PF duration, no?

It's not just for #PF, that was just one example. I use to use function
graph tracing max_depth_count=1 to verify NO_HZ_FULL to make sure there's
no entry into the kernel. That doesn't work anymore. Even compat syscalls
are not traced.

I lost a kernel feature with the noinstr push and this is the closest that
comes to bringing it back. And the more we add noinstr, the more the kernel
becomes a black box again.

-- Steve
