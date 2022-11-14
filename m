Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F7A62899D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiKNTpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiKNTpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:45:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFBF101F7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668455130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcOwoMmtRfpEcec4fb3EfiDIbbnctB2tyNqPSNegIvc=;
        b=UNUtc9Rg0BC9FFgTcDhCXb4J45YIREJhmq1ERzGMX29+2SWoJCwdxpRJ/+xNXHNYDgQYqE
        drboq5N6UkzOec4xyrgBp1kLLfIS89vtCuQ8DCAhw6hbvcKpb2f1USbLp4xAxatdaXakdP
        T9yw1WXCU1G/FYDz0GmYUYm2Olg73t5cJl9lrY12LXy8+eJtlf6/veFznowA8rLoQ2Xb7s
        e2nwsx9ApkViQVG9mjfFQR0h8P9zJ89jBSKAVQiKnASeYE/cXKF0mrqnwu9X7xf/y3Ck4n
        t5Hgf0fxUVTA7pur4+TC6oyZMaOKmU9hryakRqSx2tU2LikRDfdXAqzKQ8KdfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668455130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcOwoMmtRfpEcec4fb3EfiDIbbnctB2tyNqPSNegIvc=;
        b=MRHucAuVOeKg9+1WLu/Yqlpr/xhJsYqxaVIZNQ2Bp3aRjApypWnGsFQyDBMeaLSPrOf9Op
        phdwZ+HgV6HUlGDw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Eric Dumazet <edumazet@google.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
In-Reply-To: <CAHk-=wj7DtViDctAzV3PqdYBEh5vcQnRJPtFFB=uaAP=W-VG4A@mail.gmail.com>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org> <875yfitpdu.ffs@tglx>
 <20221113191518.0a3b29b1@rorschach.local.home> <87sfims7ca.ffs@tglx>
 <87iljhsftt.ffs@tglx>
 <CAHk-=wj7DtViDctAzV3PqdYBEh5vcQnRJPtFFB=uaAP=W-VG4A@mail.gmail.com>
Date:   Mon, 14 Nov 2022 20:45:29 +0100
Message-ID: <875yfhs4km.ffs@tglx>
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

Linus!

On Mon, Nov 14 2022 at 09:16, Linus Torvalds wrote:
> On Mon, Nov 14, 2022 at 7:42 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> So if we want to make this solid and make the life of driver writers
>> easier, then we cannot issue a warning as I said in the original thread
>> already.
>
> So I think that there are two issues at play:
>
>  (a) do we want to *find* problem places after the conversion
>
>  (b) do we want to make driver writing easier
>
> and (a) argues for warning on timer re-arming, but (b) just says
> "don't warn, just ignore it, the driver is being shut down".
>
> I'm personally ok with either of those approaches, and it's literally
> just a question of mindset.

Correct. I'm very much for (b). Look at the bluetooth example. The "fix"
was obviously right and then introduced a new subtle bug which will only
happen every 7th half-moon.

But if you turn it around then:

    timer_shutdown();
    destroy_workqueue();

will trigger the warning in mod_timer() every 6.5th half-moon.

And then you have to go and sprinkle 'if (mydev->inshutdown)'
conditionals all over the place with a high probability that they will
not cut it completely. Or you end up with the reverse order of shutdown
calls which is wrong too.

So I rather have the very simple semantics that attempts to arm a
shutdown timer are silently ignored. As I said to Steven in the other
mail, I'm sure that the vast majority of teardown sites will not depend
on the timer(s) being functional. The two other esoteric cases will have
to be treated special.

>> The semantics of timer_shutdown_sync() have to be:
>>
>>    After return:
>>      - the timer is not queued
>>      - the timer callbacks is not running
>>      - the timer cannot be enqueued again
>
> Yes, but that last case is literally a "do we expect the *driver* to
> not enqueue it and warn if it tries, or do we just silently enforce
> it"?
>
> I agree with all three points. I'm just not sure about who we expect
> to do the "don't enqueue again".
>
> There's a big argument for "make it easy for driver writers" in just
> saying "make mod_timer() silently just ignore a re-arming". Making
> things easier for driver writers is a good thing.
>
> But maybe it's a "you shouldn't have done that in the first place"
> thing, and merits a warning?

See above.

> I have no strong opinions on that.
>
> What I *do* still want to happen is for subsystems to be able to start
> doing the conversion one by one. Which is why I'd still prefer to have
> the new names available just so that we don't have to have one
> 50-patch series, but we can have subsystems apply the obvious cases.
>
> And I'd still like the mindless "let's get the non-semantic changes
> out of the way" as one single patch, to get rid of mindless noise.
>
> And honestly, for that to happen I'd be perfectly happy with something like
>
>   #define timer_shutdown(t) del_timer(t)
>   #define timer_shutdown_sync(t) del_timer_sync(t)
>
> (obviously with the patches that first remove the existing
> 'timer_shutdown()' uses first). That wouldn't introduce the *new*
> semantics, but it would at least allow the different subsystems to do
> the obvious cases, and let the networking people wonder about the much
> less obvious ones.

As we are at -rc5 now and the core code is not yet ready, I suggest that
we get the core changes done for the next merge window and have some
obvious fixes which demonstrate the usage, e.g. the borked BT fix
replacement, and then subsystem people can queue their stuff for 6.3 or
send in the obvious bugfixes during the 6.2-rc series.

I'm not a fan of having

   #define timer_shutdown_sync(t) del_timer_sync(t)

as a gap measure right now. That's just going to make things worse
because the semantical difference between the both functions is
significant and I don't want people to run around and replace their
'if (mydev->in_shutdown)' conditionals prematurely or do any other fancy
"fixes" which cause more problems than they solve.

This problem exists for ever so there is no need to rush this just
because.

If we all agree that the semantics of timer_shutdown_sync() are:

    After return:
      - the timer is not queued
      - the timer callback is not running
      - the timer cannot be enqueued again. Any attempts to do
        so are silently ignored (needs some more explanation...)

and the semantics of timer_shutdown() are:

    After return:
      - the timer is not queued
      - the timer cannot be enqueued again. Any attempts to do
        so are silently ignored (needs some more explanation...)
      - the timer callback might be still running

then we can definitly get this in shape for 6.2.

Thanks,

        tglx
