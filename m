Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591296A9EED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjCCShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCCShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:37:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F5460D5B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:37:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 434A5B819B6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C17C433D2;
        Fri,  3 Mar 2023 18:37:04 +0000 (UTC)
Date:   Fri, 3 Mar 2023 13:37:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230303133702.4d336ee9@gandalf.local.home>
In-Reply-To: <20230303181134.GA1837196@google.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
        <20230302152103.2618f1b7@gandalf.local.home>
        <20230302163253.541ac3a8@gandalf.local.home>
        <20230302163603.223313ba@gandalf.local.home>
        <20230302165613.2dcc18ca@gandalf.local.home>
        <20230302200136.381468f0@gandalf.local.home>
        <20230303181134.GA1837196@google.com>
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

On Fri, 3 Mar 2023 18:11:34 +0000
Joel Fernandes <joel@joelfernandes.org> wrote:

> In the normal mutex's adaptive spinning, there is no check for if there is a
> change in waiter AFAICS (ignoring ww mutex stuff for a second).
> 
> I can see one may want to do that waiter-check, as spinning
> indefinitely if the lock owner is on the CPU for too long may result in
> excessing power burn. But normal mutex does not seem to do that.
> 
> What  makes the rtmutex spin logic different from normal mutex in this
> scenario, so that rtmutex wants to do that but normal ones dont?

Well, the point of the patch is that I don't think they should be different
;-)

> 
> Another thought is, I am wondering if all of them spinning indefinitely might
> be Ok for rtmutex as well, since as you mentioned, preemption is enabled. So
> adding the if (top_waiter != last_waiter) {...} might be unnecessary? In fact
> may be even harmful as you are disabling interrupts in the process.

The last patch only does the interrupt disabling if the top waiter changes.
Which in practice is seldom.

But, I don't think a non top waiter should spin if the top waiter is not
running. The top waiter is the one that will get the lock next. If the
owner releases the lock and gives it to the top waiter, then it has to go
through the wake up of the top waiter. I don't see why a task should spin
to save a wake up if a wake up has to happen anyway.

> 
> Either way, I think a comment should go on top of the "if (top_waiter !=
> waiter)" check IMO.

What type of comment?

-- Steve
