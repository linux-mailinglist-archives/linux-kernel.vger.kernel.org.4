Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D926C537E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCVSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjCVSRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA467030;
        Wed, 22 Mar 2023 11:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67D2562264;
        Wed, 22 Mar 2023 18:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC589C433D2;
        Wed, 22 Mar 2023 18:16:58 +0000 (UTC)
Date:   Wed, 22 Mar 2023 14:16:57 -0400
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
Message-ID: <20230322141657.7d00a9bd@gandalf.local.home>
In-Reply-To: <87v8is94n6.ffs@tglx>
References: <20230321215121.71b339c5@gandalf.local.home>
        <87y1np824t.ffs@tglx>
        <20230322084834.37ed755e@gandalf.local.home>
        <87v8is94n6.ffs@tglx>
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

On Wed, 22 Mar 2023 16:39:41 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> But for figuring out how long a syscall, interrupt or exception takes
> there are exactly TWO tracepoints required, not 10 or 8. And it's bloody
> obvious where to place them, right?

Not always, and it's pretty much always architecture dependent. I was
looking for an architecture agnostic approach, as I imagine all archs will
be eventually using this.

> 
> >> instrumentation_begin()/end() is solely meant for objtool validation and
> >> nothing else.
> >> 
> >> There are clearly less horrible ways to retrieve the #PF duration, no?  
> >
> > It's not just for #PF, that was just one example. I use to use function
> > graph tracing max_depth_count=1 to verify NO_HZ_FULL to make sure there's
> > no entry into the kernel. That doesn't work anymore. Even compat syscalls
> > are not traced.  
> 
> That still works. noinstr did neither break syscall tracing nor any of
> the interrupt/exception tracepoints which can be used to validate the
> NOHZ full mechanics. Your fancy favourite script might not work anymore,
> but claiming that it can't be traced is just nonsense.

I don't remember fully, but there was something that was missing. It was
back in 2021, so I do not remember fully. That's when I first wrote this
patch. I only just redisovered it and wanted to share ;-) The only thing I
did differently since then was to add the page fault logic, because that
was something I am currently interested it.

Things could have changed since then. But if adding trace events for the
missing syscalls and around exceptions for timing purposes is OK, then I'm
happy to go that approach.

> 
> > I lost a kernel feature with the noinstr push and this is the closest that
> > comes to bringing it back.  
> 
> This is the closest _you_ came up with without thinking about it for a
> split second.
> 
> > And the more we add noinstr, the more the kernel becomes a black box
> > again.  
> 
> It does not. noinstr is a technical requirement to keep instrumentation
> out of code pathes which are not able to handle instrumentation. You
> know that very well, so please stop this theatrical handwaving and come
> back if you have sensible technical arguments.

I never said nor implied that it's not important. I'm just concerned that
we currently have no way to see when it's happening.

But I'll drop this patch and look to add specific trace events in specific
points to be able to get the timings that are useful.

Thanks,

-- Steve
