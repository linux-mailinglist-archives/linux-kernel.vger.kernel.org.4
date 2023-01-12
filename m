Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53A2666B43
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 07:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjALGqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 01:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjALGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 01:46:15 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8535DE0B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 22:46:14 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30C6jIxt010374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1673505928; bh=CyRnDzsMBmOI7XtmSzCn6s4XIqiz+Q3AJ472rqOgfMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=djUOCHe0k9OZwoDMrv9/DyFjwkPNlF5cBZsnNyU6be8AYYFrWu9ayDS6Fu2ouysG+
         XaEgrnUnas6aZtBhFgPGoXmS6qvLlQQtXtVfBZ8AtNo6dniUXVI5ey3RDwfIqQ4QRK
         ZcMTdCUb3sUynFCKovy8rJEywXYZ1QUmyqpuJDaQHIUx3ZLbtN13nRtXbFSbB7+3nw
         vqwQ8vJzpm6PuqgbjfSJVZYYtrJieNSHKEWCttBOoDeAX8uEg6N9YGD0dx5ozIq6zZ
         4vrybwEJnkejwT9LsX6iLQtTOT8fz45WAEiPyh1tUAb1ZMdO5MBupbuAUUsqv9mIm9
         LNNpMD75/pcsg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 8C1DC8C0873; Thu, 12 Jan 2023 01:45:15 -0500 (EST)
Date:   Thu, 12 Jan 2023 01:45:15 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Arseniy Lesin <emptiedsoul@hardclanz.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC] SIGOOM Proposal
Message-ID: <Y7+se9vpA7JB3Mmm@mit.edu>
References: <CPPXX7JYJGIE.3F2R53GC3ULGZ@hardclanz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CPPXX7JYJGIE.3F2R53GC3ULGZ@hardclanz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 07:51:45AM +0300, Arseniy Lesin wrote:
> 
> 2. Proposal
> ==================
> 
> 2.1. The SIGOOM Signal
> ------------------
> 
> I propose the addition of new signal: SIGOOM (Out-Of-Memory SIGnal)

AIX had a similar SIGDANGER signal which was sent to all processes
when memory was low.  By default, it was ignored, but processes that
were aware of it could use this as an opportunity to shrink their
memory footprint.

> The technical detail of this addition is a bit unpleasant: there is
> actually no room for new signals! 
> 
> Numbers 1-31 are already assigned, every signal with number > SIGRTMIN 
> (currently 32) is considered realtime and queued accordingly. 
> 
> Adding SIGOOM as signal #32 by shifting SIGRTMIN to 33 can do a trick,
> but this will almost certainly break compatibility (namely, with glibc
> threading)
> 
> I propose adding SIGOOM as signal #65 (after SIGRTMAX), but we should
> clarify some checks in kernel/signal.c (possibly in other places too,
> where signal number is tested against being realtime) and possibly add a
> such-like macro:
> 
> #define SIG_IS_REALTIME(signum) (((signum) > SIGRTMIN) && ((signum) < SIGRTMAX))

It's actually worse than this.  The problem is space in the signal
mask.  From the signal(7) man page:

   Signal mask and pending signals

       A signal may be blocked, which means that it will not be
       delivered until it is later unblocked.  Between the time when
       it is generated and when it is deliv‐ ered a signal is said to
       be pending.

       Each thread in a process has an independent signal mask, which
       indicates the set of signals that the thread is currently
       blocking.  A thread can manipulate its signal mask using
       pthread_sigmask(3).  In a traditional single-threaded ap‐
       plication, sigprocmask(2) can be used to manipulate the signal
       mask.

The signal mask is stored in the signal set structure (sigset_t /
kernel_sigset_t).    Later in that same man page:

       The addition of real-time signals required the widening of the
       signal set structure (sigset_t) from 32 to 64 bits.
       Consequently, various system calls were superseded by new
       system calls that supported the larger signal sets.  The old
       and new system calls are as follows:

       Linux 2.0 and earlier   Linux 2.2 and later
       sigaction(2)            rt_sigaction(2)
       sigpending(2)           rt_sigpending(2)
       sigprocmask(2)          rt_sigprocmask(2)
       sigreturn(2)            rt_sigreturn(2)
       sigsuspend(2)           rt_sigsuspend(2)
       sigtimedwait(2)         rt_sigtimedwait(2)

This is why adding a new signal is _hard_, whether it's
SIGDANGER/SIGOOM, or the SIGINFO from the people who want BSD-style
control-T support.

						- Ted
