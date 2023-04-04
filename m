Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356616D64C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjDDOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjDDOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:09:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DF744A7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:09:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 035C620657;
        Tue,  4 Apr 2023 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680617356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPANXDP5t/GmyxIOw625H4rq9d/nbTVMM/IIX3p3RHU=;
        b=YE9ZDzTuAPBMe6VeomUjASYnkxq78eUiOZn8SHNlxzTYyhi1Musg9F0Q0Gr6668wTf0Hhj
        CsO4AN1rCbrwj64whggz48vH3X8V4UO178DoeDYnduyBv7EMSNReeQcC8+lZ3YBI0RmGIz
        kPRZi42YQO4Fg8yUczjI4IKWCKMVBP0=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9AE742C141;
        Tue,  4 Apr 2023 14:09:15 +0000 (UTC)
Date:   Tue, 4 Apr 2023 16:09:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: semantic: Re: [PATCH printk v1 10/18] printk: nobkl: Add emit
 function and callback functions for atomic printing
Message-ID: <ZCwvi0dU0C+IUemO@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-11-john.ogness@linutronix.de>
 <ZCa3kg960HJPf9Ko@alley>
 <87edp29kvq.fsf@jogness.linutronix.de>
 <ZCraqrkqFtsfLWuP@alley>
 <87ilecsrvl.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilecsrvl.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-04-03 21:17:26, John Ogness wrote:
> On 2023-04-03, Petr Mladek <pmladek@suse.com> wrote:
> >> The main difference is that the kthread variant is invoked _only_
> >> from the kthread printer. It may or may not mean that the callback
> >> can sleep. (That depends on how the console implements the
> >> port_lock() callback.) But the function can be certain that it wasn't
> >> called from any bizarre interrupt/nmi/scheduler contexts.
> >> 
> >> The atomic callback can be called from anywhere! Including when it
> >> was already inside the atomic callback function! That probably
> >> requires much more careful coding than in the kthread case.
> >
> > Is it just about coding? Or is it also about making write_khtread()
> > better schedulable, please?
> 
> For UARTs there probably isn't much of a difference because most disable
> interrupts anyway. A diff in the latest version [0] of the 8250 nbcon
> console between serial8250_console_write_atomic() and
> serial8250_console_write_thread() shows no significant difference in the
> two except that the atomic variant may prefix with a newline if it
> interrupted a printing context.
> 
> But for vtcon and netconsole I expect there would be a very significant
> difference. For vtcon (and possibly netconsole) I expect there will be
> no atomic implementation at all.

Then these consoles might need another solution for the panic()
situation, like blocking the kthread and switching to the legacy
mode.

OK, so it might really make sense to have a separate callback
for the kthread and emergency/panic contexts.


> > Hmm, it is very questional if the callbacks should be optional.
> >
> > Do we really want to allow introducing non-blocking consoles without
> > the way to print emergency and panic messages? Such a console would
> > not be fully-flegged replacement of the legacy mode.
> 
> Not necessarily. For vtcon we are "planning" on a BSoD, probably based
> on the kmsg_dump interface. For netconsole it could be similar.
> 
> We are trying to give drivers an opportunity to implement some safety
> and control to maximize the chances of getting a dump out without
> jeopardizing other panic functions.
> 
> As a quick implementation a UART driver could simply set @unsafe upon
> entrace of write_thread() and clear it on exit. Then its write_atomic()
> would only be called at the very end of panic() if the panic happened
> during printing. For its write_atomic() implementation it could be a
> NOOP if !oops_in_progress. All locking is handled with the port_lock()
> callback, which is only called from the kthread context. It isn't
> particularly pretty, but it most likely would be more reliable than what
> we have now.

If I get it correctly, the above scenario requires both
write_kthread() and write_atomic(). Otherwise, it would not be
able to print in panic() at all. Right, please?


> > What about making write_atomic() mandatory and write_kthread()
> > optional?
> 
> I doubt there will ever be a write_atomic() for vtcon. BSoD based on
> kmsg_dump is a simpler approach.

But we would need to add an infrastructure for the BSoD(). For example,
call yet another callback at the end of panic(). Also it does not mean
that we might completely give up on printk() messages in panic().

Anyway, this might be solved later. I would really like to enforce
having both callbacks and good enough solution for now. It might later
be updated to another good enough solution using another panic() mode.


> > write_atomic() would be used in the kthread when write_kthread()
> > is not defined. write_kthread() would allow to create an alternative
> > implementation that might work better in the well defined kthread
> > context.
> 
> write_atomic() is the difficult callback to implement. It certainly
> could be used in the write_thread() case if no write_thread() was
> provided. But I still think there are valid cases to have a
> write_thread() implementation without a write_atomic().

The proposed framework does not provide a solution for consoles
that can't implement write_atomic(). And ignoring the messages
in panic() is not acceptable.

Either we need to enforce another good enough solution for these
consoles. Or we must not allow them now. We could update the logic
later when we see how the BSoD really looks and works.

Best Regards,
Petr
