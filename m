Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF15462894B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiKNT2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiKNT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:28:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0062497A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:28:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6850161377
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0856DC433C1;
        Mon, 14 Nov 2022 19:28:16 +0000 (UTC)
Date:   Mon, 14 Nov 2022 14:28:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
Message-ID: <20221114142858.59682a42@gandalf.local.home>
In-Reply-To: <87bkp9s61z.ffs@tglx>
References: <20221110064101.429013735@goodmis.org>
        <20221110064147.343514404@goodmis.org>
        <875yfitpdu.ffs@tglx>
        <20221113191518.0a3b29b1@rorschach.local.home>
        <87sfims7ca.ffs@tglx>
        <20221114083635.60e23559@gandalf.local.home>
        <87bkp9s61z.ffs@tglx>
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

On Mon, 14 Nov 2022 20:13:28 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, Nov 14 2022 at 08:36, Steven Rostedt wrote:
> > On Mon, 14 Nov 2022 01:33:25 +0100
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> >>    https://lore.kernel.org/all/87v8vjiaih.ffs@tglx/
> >>   
> > I'm not sure what you mean by that. The idea is that once timer_shutdown()
> > is called, we still warn on re-arming the timer.  
> 
> That's the whole point. As Linus and I discussed in that thread:
> 
>    "That would mean, that we still check the function pointer for NULL
>     without warning and just return. That would indeed be a good argument
>     for not having the warning at all."
> 
> and as I demonstrated you on the example of the BT driver which you
> "fixed" this is the only sensible way to handle this.

I agree that it wasn't a complete fix, but as I mentioned before, I was
pulled off before I could do more.

> 
> The warning does not buy us anything, unless you want to go and amend
> all the usage sites which trigger it with 'if (mystruct->shutdown)'
> conditionals.

The rationale for the warning was that it would let us know what drivers
need to be fixed for older kernels without the shutdown state. I'm
perfectly fine in removing the warning. We may just add it to the field
kernels so that we can know if there's any drivers that have issues that we
need to look at.

> 
> It's very similar to the work->canceling logic for kthreads that Linus
> mentioned in this thread which prevents that the work timer is rearmed
> concurrently. The difference is that timer_shutdown() is a final
> decision which renders the timer unusable unless it is explicitely
> reinitialized.
> 
> But that's mostly a matter of documentation and it has to be made clear
> that nothing in a shutdown path which has the BT pattern:
> 
>      timer_shutdown();
>      destroy_workqueue();
> 
> relies on the timer being functional after the shutdown point. I'm
> pretty sure that the vast majority of such use cases do not care, but
> given the size of the driver zoo I'm also sure that you'll find at least
> one which depends on the timer working accross teardown.
>

Agreed.

-- Steve
