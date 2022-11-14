Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8818B6273FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiKNBFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKNBFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:05:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1E9DEA4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:04:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668387897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYrrFj7Gv89GLXIPqrWGEgc6foBu8yMfZoClwOCUfT4=;
        b=gbrbWZRrxOjNzigCcSBlmTAQqfkt6CJCSU8ALnpnSbFrBFQ+0DyLKMlR8z4LiRY7uCoD4+
        S2bUMMxmDFqzz4M+Os6bp80AMMATh6oJ8GGVc60cR3KvceD2JMqmDTIsKmWzQpB3vdPMJn
        a36D36R1lRJfRx3f+P/M66Romt+HkDGmURk/ibBEhUj/exWe2aO2SxxflnWJPcdv1KF9pF
        Z75Mh0z/FbLbgUh9YmUkVByKdC1tuNDSFvvbfLzU7xWs9TDbQG61wB85h3xASZwEFADhGe
        fNPCdrLNFiC9lmKtXuE0qqyC2faO2lBCCuJdVn90nnJGhAWStUwRQEbVUAFgcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668387897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYrrFj7Gv89GLXIPqrWGEgc6foBu8yMfZoClwOCUfT4=;
        b=6auwk9biI+VhVAD4ZQmG5VWHf9zS1GTmQUZNhoNwBZQDrB/kV7cF46ZgYD79XiY+PRgW5r
        sL1u8CT5GALX47DA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
In-Reply-To: <20221113191135.0b61bb51@rorschach.local.home>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org> <87cz9qttdb.ffs@tglx>
 <20221113191135.0b61bb51@rorschach.local.home>
Date:   Mon, 14 Nov 2022 02:04:56 +0100
Message-ID: <87pmdqs5vr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13 2022 at 19:11, Steven Rostedt wrote:
> On Sun, 13 Nov 2022 22:52:16 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> > We are hitting a common bug were a timer is being triggered after it
>> > is  
>> 
>> We are hitting? Talking in pluralis majestatis by now?
>
> Should I say Chromebooks are hitting?

That would be at least more comprehensible than 'We', unless you (or
whoever is 'We') is a synomym for chromeborks.

>> > freed. This causes a corruption in the timer link list and crashes the
>> > kernel. Unfortunately it is not easy to know what timer it was that was  
>> 
>> Well, that's not entirely true. debugobjects can tell you exactly what
>> happens. 
>
> Only if you have it enabled when it happens, and it has too much
> overhead to run in production. The full series changes debug object
> timers to report an issue if there's a timer not in the shutdown state
> when it is freed.

The series changes 'debug object timers' to report an issue?

Can you pretty please stop this completely nonsensical blurb? This
series has absolutely nothing to do with debugobjects at least not to
my knowledge. If the series expands the magics of debugobjects then
you fundamentaly failed to explain that.

> This catches potential issues similar to how lockdep can catch
> potential deadlocks without having to hit the deadlock.

By introducing new problems?

> The current debug object timers only catches it if the race condition
> is hit.

True. But most if not all of the mentioned issues have been reported
before via debugobject enabled kernels. So what's the actual benefit?

>> > + * @timer: The timer to be freed
>> > + *
>> > + * Shutdown the timer before freeing. This will return when all pending timers
>> > + * have finished and it is safe to free the timer.  
>> 
>>    "_ALL_ pending timers have finished?"
>> 
>> This is about exactly _ONE_ timer, i.e. the one which is handed in via
>> the @timer argument.
>> 
>> You want to educate people to do the right thing and then you go and
>> provide them uncomprehensible documentation garbage. How is that
>> supposed to work?
>
> I don't know. Other people I showed this to appeared to understand it.
> But I'm all for updates.

Do I really need to explain to you what the diffference between 'all
pending timers' and the one which is subject of the function call is?

No, I'm not rewriting this for you and your peers who care obviously as
much about correctness as you do.

>> Can you please stop this frenzy and get your act together?
>
> What the hell. I'm just trying to get this in because it's a thorn in
> our side.

It's not a thorn in 'our' (who ever is our) side. It's a fundamental
problem of circular shutdown dependencies as I explained to you long
ago.

> Sorry I'm not up to par with your expectations. I'm willing to make
> changes, but let's leave out the insults. This work is being done on
> top of my day job.

Sure and because of that you are talking about this as a 'thorn on our
side'. If that's a thorn at (I assume) your employers side, which is
then related to your day job, then you should have the backing of that
company to spend company time on it and not inflict half baken changes
on the kernel which solve nothing.

Coming back to your claim that I'm insulting. Please point me to the
actual insult I commenced and I'm happy to apologize.

Thanks,

        Thomas


