Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BFD6A8A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCBUVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:21:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D551FA4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 12:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F44FCE1FC7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 20:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431A1C433D2;
        Thu,  2 Mar 2023 20:21:05 +0000 (UTC)
Date:   Thu, 2 Mar 2023 15:21:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230302152103.2618f1b7@gandalf.local.home>
In-Reply-To: <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 11:39:12 -0800
John Stultz <jstultz@google.com> wrote:

> This sounds like something to try as well (though I'd still want to
> push this revert in the meantime to avoid regressions).
> 
> Do you have a more specific pointer to this adaptive spinning
> rt_mutexes for spinlocks? Looking at the current PREEMPT_RT patch I'm
> not seeing any changes to locking.

Actually, it's in mainline too.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/rtmutex.c#n1557

The rtmutex_spin_on_owner() is the code.

But currently, only the highest priority waiter will spin. If you have two
waiters, the second one will sleep.

With today's computers, where it's not uncommon to have more than 16 CPUs,
it is very likely (and probably what happened in your case), that there's
more than one waiter in contention. I'm thinking all waiters should spin if
the owner and the top waiter are also running. But only the top waiter
should be allowed to grab the lock.

There's no harm in spinning, as the task can still be preempted, and
there's no issue of priority inversion, because the spinners will not be on
the same CPU as the owner and the top waiter, if they only spin if those
two tasks are also running on a CPU.

I could possibly add a patch, and see if that also works.

-- Steve
