Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED946C4F97
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCVPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCVPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:39:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D2D14E94;
        Wed, 22 Mar 2023 08:39:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679499582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnI5FUKH+VXuOsSKw2KeY0TziAMCvQOxA2QzpSUcaFU=;
        b=qTTpltSA8nJyB7slxoIsBrLpn/Vem2Z8PGSVcNBga70/xYf/+9G/Vqnelv2cYQepzEMTa/
        uinAXTwB0r5r+h9Gv+AI4bqhihPuze6c4GoLrmVK7BNbd7EssfR6jWosYuA6/2I8rloM1n
        rLLxLfuba72PKYo12tERWepUhqMh3R+u8hfHvpv2SqqOjAhWz9U1aJY/W4cd7yQBSlHwjv
        zTcOpkrYhORYZvsthQN7hkVXHmTCuLuF54nSPTaL19M9MXIzLkr0XudhVVY8Oc+i/Njk7T
        2PXF8Qt9OXWdO7JcAcBULz1BMpzsYEeLPT8SnbVzG+Tz2kNMLxHJZY67GJqkog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679499582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FnI5FUKH+VXuOsSKw2KeY0TziAMCvQOxA2QzpSUcaFU=;
        b=qXFl48UbCrhfJo7nDwl6I7FRiMTzel7OHkAEnZQB9q3sthM/NtR8KFvyAK74i4HA6hBHeL
        p6IR1ThdcuxrAeDw==
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
In-Reply-To: <20230322084834.37ed755e@gandalf.local.home>
References: <20230321215121.71b339c5@gandalf.local.home>
 <87y1np824t.ffs@tglx> <20230322084834.37ed755e@gandalf.local.home>
Date:   Wed, 22 Mar 2023 16:39:41 +0100
Message-ID: <87v8is94n6.ffs@tglx>
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

On Wed, Mar 22 2023 at 08:48, Steven Rostedt wrote:
> On Wed, 22 Mar 2023 12:19:14 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> Seriously? That's completely insane. Have you actually looked how many
>> instrumentation_begin()/end() pairs are in the affected code pathes?
>> 
>> Obviously not. It's a total of _five_ for every syscall and at least
>> _four_ for every interrupt/exception from user mode.
>> 
>> The number #1 design rule for instrumentation is to be as non-intrusive as
>> possible and not to be as lazy as possible.
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

And that makes the insanity of enabling 10 tracepoints in the syscall
path and at mininum 8 tracepoints in the exception/interrupt path any
smaller?

> We have trace points in preempt_enable/disable() I think that's *far* more
> intrusive.

What? If you want to do preempt_enable()/disable() tracing then there is
no other choice than tracing every single invocation.

But for figuring out how long a syscall, interrupt or exception takes
there are exactly TWO tracepoints required, not 10 or 8. And it's bloody
obvious where to place them, right?

>> instrumentation_begin()/end() is solely meant for objtool validation and
>> nothing else.
>> 
>> There are clearly less horrible ways to retrieve the #PF duration, no?
>
> It's not just for #PF, that was just one example. I use to use function
> graph tracing max_depth_count=1 to verify NO_HZ_FULL to make sure there's
> no entry into the kernel. That doesn't work anymore. Even compat syscalls
> are not traced.

That still works. noinstr did neither break syscall tracing nor any of
the interrupt/exception tracepoints which can be used to validate the
NOHZ full mechanics. Your fancy favourite script might not work anymore,
but claiming that it can't be traced is just nonsense.

> I lost a kernel feature with the noinstr push and this is the closest that
> comes to bringing it back.

This is the closest _you_ came up with without thinking about it for a
split second.

> And the more we add noinstr, the more the kernel becomes a black box
> again.

It does not. noinstr is a technical requirement to keep instrumentation
out of code pathes which are not able to handle instrumentation. You
know that very well, so please stop this theatrical handwaving and come
back if you have sensible technical arguments.

Thanks,

        tglx
