Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EB61DD51
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiKESnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKESnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 14:43:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E661A62D0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 11:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83D806092A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 18:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B68C433C1;
        Sat,  5 Nov 2022 18:43:05 +0000 (UTC)
Date:   Sat, 5 Nov 2022 14:43:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v4a 00/38] timers: Use timer_shutdown*() before freeing
 timers
Message-ID: <20221105144303.3552bf85@rorschach.local.home>
In-Reply-To: <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
References: <20221105060024.598488967@goodmis.org>
        <CAHk-=wi95dGkg7DiuOZ27gGW+mxJipn9ykB6LHB-HrbbLG6OMQ@mail.gmail.com>
        <20221105123642.596371c7@rorschach.local.home>
        <20221105140356.6a3da628@rorschach.local.home>
        <CAHk-=wjnASLkTdPd+wxto2RBQH+S9MUm4FrNPWvU87opFG5SKQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Nov 2022 11:28:33 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Nov 5, 2022 at 11:04 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Here's the changes I made after running the script  
> 
> Please. No.
> 
> What part of "I don't want extra crud" was I unclear on?

The first one was a false change. That is, the script *did* catch it,
when it should not have. So I reverted the change. The coccinelle
documentation even states to look over the changes to see if there are
false positives.

The second change is that it frees three timers all for the same
object. If you want, I could run the script 2 more times on the same
file, and it will catch it then.

Would you be happier if I just ran it three times on that file? I can do
that, and it will produce the same result.

> 
> I'm not interested in converting everything. That's clearly a 6.,2
> issue, possibly even longer considering how complicated the networking
> side has been.
> 
> I'm not AT ALL interested in "oh, I then added my own small cleanups
> on top to random files because I happened to notice them".
> 
> Repeat after me: "If the script didn't catch them, they weren't
> trivially obvious".

Of the two clean ups, one was a false positive, so I had to revert it.
The other, just needs me to run the script more than once. I can do
that, and then I only have the false positive case to clean up.

> 
> And it does seem that right now the script itself is a bit too
> generous, which is why it didn't notice that sometimes there wasn't a
> kfree after all because of a goto around it. So clearly that "..."
> doesn't really work, I think it accepts "_any_ path leads to the
> second situation" rather than "_all_ paths lead to the second
> situation".
> 
> But yeah, my coccinelle-foo is very weak too, and maybe there's no
> pattern for "no flow control".
> 
> I would also like the coccinelle script to notice the "timer is used
> afterwards", so that it does *not* modify that case that does
> 
>                 del_timer(&dch->timer);
>                 dch->timer.function = NULL;
> 
> since now the timer is modified in between the del_timer() and the kfree.
> 
> Again, that timer modification is then made pointless by changing the
> del_timer() to a "timer_shutdown()", but at that point it is no longer
> a "so obvious non-semantic change that it should be scripted". At that
> point it's a manual thing.
> 
> So I think the "..." in your script should be "no flow control, and no
> access to the timer", but do not know how to do that in coccinelle.
> 
> Julia?
> 
> And this thread has way too many participants, I suspect some email

I was told to make sure the cover letter had all the required mailing lists :-p

I removed them for this email.

> systems will just mark it as spam as a result. Which is partly *why* I
> would like to get rid of noisy changes that really don't matter - but
> I would like it to be truly mindlessly obvious that there are *zero*
> questions about it, and absolutely no manual intervention because the
> patch is so strict that it's just unquestionably correct.

OK, I'll wait on Julia for an answer on this.

-- Steve
