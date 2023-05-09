Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D257F6FD193
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbjEIVms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjEIVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:42:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A531359E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:42:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683668560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lzmY6Y14dnFJA0zPl9iC+WzA8TYCi0UMWVPvY6cOZk=;
        b=Ld79Pk3ank9KIgaZ6QDpPRdbUa7HltX2tiHNZeTlAkGuuekx2axtRE+bTbLPV/vdK4HsSL
        /EyQJ1DvdzaZFPgzbVSAcOwsnVdkFEJLkNrRHLuwAvBEKuNloBSuU57ryWrZzv6Ld5psoz
        trkSM/UwVq/4Bd7lU7RyYyyKpaG7AfkMsgyCwMVvjDAT2a9wueCh4Qmm3R2W6nNAExX9db
        ZehHbuQnUYfPUXXPFDQBXXWiTQZ2B0bwZ9Ju/Hy72PuGHsVY5F7Gk/ZhUGAycUwyu8VO8z
        ZNJo6aDYrHFDgmE+7YQulfz04+Mkhsitbkpn6PKNnkWgut3zi8YKB4L8fkFdlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683668560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lzmY6Y14dnFJA0zPl9iC+WzA8TYCi0UMWVPvY6cOZk=;
        b=VKs7dRZnQW1xtFxcFh/2rFj/RhM9lXLfIXZiTCj1ABKfW6StJ0qEnn+++GX/yKUXKXUHD4
        2ocjezUEClvhtdDw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: [RFD] posix-timers: CRIU woes
In-Reply-To: <875y911xeg.ffs@tglx>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx>
Date:   Tue, 09 May 2023 23:42:39 +0200
Message-ID: <87ednpyyeo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a summary of several mails so that the CRIU people have the full
picture.

A recent syzbot report made me look at the timer ID management, which
was modified 7 years ago to accomodate CRIU:

    5ed67f05f66c ("posix timers: Allocate timer id per process (v2)")

and introduced that reported issue along with a bogus loop termination
problem. See

    https://lore.kernel.org/lkml/000000000000a3723305f9d98fc3@google.com/
    https://lore.kernel.org/lkml/20230425183312.932345089@linutronix.de

for details.

The intent to make the timer IDs per process is definitely correct, but
the implementation is beyond suboptimal. I really regret that I did not
catch this back then when picking those changes up.

The way it works is that each process keeps a 'next_timer_id' which it
uses to allocate the next timer. That allows CRIU to reconstruct timers
with the same ID by walking the ID space via

  do {
     timer_create(&timer, ...., &id);
     if (id == original_id)
        goto success;
     timer_delete(&timer);
  } while (idspace_not_exhausted());

That works by some definition of works, but it is problematic in two ways:

 1) As the timer ID space is up to INT_MAX, a process which creates and
    deletes timers frequently, can easily move up close to the INT_MAX
    id space over time.

    If such a process is checkpointed and restored, then the above loop
    will run for at least an hour to restore a single timer.

    And no, this is not only a hypothetical issue. There are legitimate
    scenarios where threads are created and the control thread arms a
    posix CPU timer on them. Such threads can be torn down on a regular
    base due to thread pool consolidations. As CRIU does not happen
    every 5 minutes it's not completely unlikely that such a process
    surives quite some time on a particular host and thereby approaches
    the ID space limit.

    Sure we can restrict the ID space to a way smaller number so the
    search wraps around earlier, but what's a sensible limit?

    Though restricting the ID space has its own issue vs. backwards
    compability. A process which created a timer on an older kernel with
    an ID larger than the newer kernels ID limit cannot longer be
    restored on that newer kernel.

    Aside of that it does not solve the other problem this created:

 2) That change created an user space ABI, which means that the kernel
    side has to stick with this next ID search mechanism forever.

    That prevents to get rid of that global lock and hash table by
    sticking an xarray into task::signal which makes a lot of sense in
    terms of cache locality and gets rid of the extra timer list
    management in task::signal. Making this change would be very useful
    to address some other issues in the posix-timer code without
    creating yet more duct tape horrors.

    Such a change obviously has to aim for a dense ID space to keep the
    memory overhead low, but that breaks existing CRIU userspace because
    dense ID space and next ID search does not fit together.

    Next ID search is obviously creating non-recoverable holes in the
    case that timers are deleted afterwards.

    A dense ID space approach can create holes too, but they are
    recoverable and well within the resource limits, because the process
    has to be able to create enough timers in the first place in order
    to release those in the middle.

    With the next ID search brute force recovery is not possible on a
    kernel with dense ID as there is no way to create all intermediate
    timers first before reaching the one at the far end due to resource
    limits.

So because of that half thought out user space ABI we are now up the
regression creek without a paddle, unless CRIU can accomodate to a
different restore mechanism to lift this restriction from the kernel.

Thoughts?

Thanks,

        tglx


