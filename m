Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1707A6C593D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCVWDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCVWDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:03:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF2D307;
        Wed, 22 Mar 2023 15:03:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679522617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/M+ljBNIE5oJFKtf6KCEV8v2OTJg2/aQzgbtxFKqFk8=;
        b=4paOE+N8kusW/YyURznb/FtA4Hi570566Kd4dRgqz/OXXyq7eJ1Jy3guYjqaskuwgmEh93
        tE8prg9/wO3uKMZ/Epp7/qyjg8ehRDskXHxkoEJwanRhlIOIBVjzbJ38ivLPSaomqvfl6X
        SCJp+3/Zq0dUrveWCPiW6XMDYQL5UMeEUVmb8DEDPMGmkdGxSKbZmXVFEwLS9URajFh6bz
        7ttxGtLLb/DeaBNcxlXqljGA4F/tfP3T+H1uYp7IBIdWAoBjbeJFiTbWhMJFUh0mChvAPi
        JIWWWOBmYdy85jT/qbTHpHBYz+l7erKIL5fFV+9orvEM0rCXbH4M3YN+Hhz4yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679522617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/M+ljBNIE5oJFKtf6KCEV8v2OTJg2/aQzgbtxFKqFk8=;
        b=cdoAWXTCmSyhwqHhcPMvx4dvxMb7sZAAcu5puaTuTQNekaMB4HjimU4Y4xcYqryQmdYX9w
        YE0MAxHg6+vnvWBg==
To:     Steven Rostedt <rostedt@goodmis.org>
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
In-Reply-To: <20230322141657.7d00a9bd@gandalf.local.home>
References: <20230321215121.71b339c5@gandalf.local.home>
 <87y1np824t.ffs@tglx> <20230322084834.37ed755e@gandalf.local.home>
 <87v8is94n6.ffs@tglx> <20230322141657.7d00a9bd@gandalf.local.home>
Date:   Wed, 22 Mar 2023 23:03:36 +0100
Message-ID: <87jzz88mvb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven!

On Wed, Mar 22 2023 at 14:16, Steven Rostedt wrote:
> On Wed, 22 Mar 2023 16:39:41 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> But for figuring out how long a syscall, interrupt or exception takes
>> there are exactly TWO tracepoints required, not 10 or 8. And it's bloody
>> obvious where to place them, right?
>
> Not always, and it's pretty much always architecture dependent. I was
> looking for an architecture agnostic approach, as I imagine all archs will
> be eventually using this.

All architectures, at least those which matter, will eventually use the
generic entry code, which is completely architecture agnostic.

And again, while instrumentation_begin/end() might be in use on more
architectures today, it's still the fundamentally wrong place to stick a
tracepoint into. See below.

> Things could have changed since then. But if adding trace events for the
> missing syscalls and around exceptions for timing purposes is OK, then I'm
> happy to go that approach.

If there are tracepoints missing for syscalls then the obvious correct
thing is to add them so that the syscall coverage is complete instead of
abusing the lack of tracepoints as an argument for horrible hackery.

If there is a value to have tracepoints around exceptions etc. for
timing purposes then they definitely make more sense than the abuse of
instrumentation_begin/end() which just generates noise and adds overhead
into completely unrelated code pathes.

>> > And the more we add noinstr, the more the kernel becomes a black box
>> > again.  
>> 
>> It does not. noinstr is a technical requirement to keep instrumentation
>> out of code pathes which are not able to handle instrumentation. You
>> know that very well, so please stop this theatrical handwaving and come
>> back if you have sensible technical arguments.
>
> I never said nor implied that it's not important. I'm just concerned that
> we currently have no way to see when it's happening.

There is no value to see the instrumentation_begin()/end() annotations
in tracing, really.

They are annotations to enable objtool to validate that the noinstr
constraints are not violated. We need quite a few of them as the tooling
operates at function scope. So a function which is invoked from noinstr
low level code looks like this:

noinstr foo(...)
{
        enter();

        instrumentation_begin();        #2
        do_other_stuff();
        instrumentation_end();          #2

        exit();
}

enter()/exit() need to be noinstr functions as well, but as enter()
might be the function which actually establishes the context,
e.g. __enter_from_user_mode(), it can contain calls into instrumentable
code too:

noinstr enter(..)
{
        enter_context();

        instrumentation_begin();        #1
        do_instrumentable_enter();
        instrumentation_end();          #1
}

See? So you end up with two pairs of instrumentation_begin()/end() in
this simple example. Add exit() to the picture:

noinstr exit(..)
{
        instrumentation_begin();        #3
        do_instrumentable_exit();
        instrumentation_end();          #3

        exit_context();
}

So you have already three.

In reality it's five pairs per syscall and at least four pairs per
exception/interrupt.

As you can see above end() #1 and begin() #2 are identical from a
tracing POV. So are end() #2 and begin() #3.

IOW there is zero value to have tracepoints in them. Especially as
do_instrumentable_enter()/exit() and do_other_stuff() are subject to
tracing already unless the compiler decides to inline them.

The only relevant information is begin() #1 and end() #3, right?

And as you cannot piggy-pack that on instrumentation_begin()/end() for
obvious reasons, you need explicit tracepoints, which are in the very
end more informative and come with a factor of 4-5 less overhead in both
the enabled and disabled case.

Contrary to popular believe, disabled tracepoints are not completely
free of overhead either.

Thanks,

        tglx




