Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71760710F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbjEYPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbjEYPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:25:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AB618D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:25:08 -0700 (PDT)
Date:   Thu, 25 May 2023 17:25:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685028307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8IcW9rC36xzwMdbICTITL2z/ciN/8f8kQF9VFbHEV/M=;
        b=DipyCF2VJlIvZhy1SaQDDJGeqdtzdKSIr3hldqaBDuALGxnV4F9qpRgOAa3xV7N98OKai9
        XwCef9hPfzy0so0FmGGN8viFmO33snwdazU2vP+6iCqgpvUIHsLWgDrQ1B/wNpea4BPHh7
        azCuXvSsLtnCXBm8BwHx11lbxRfk2vgz4/cnGONP5vo6OAUGe3V7ySW5O9UMNfOQ3npZ0+
        Qs3FSIxHQnyJgxQNbx/tHPPp8jmah93HuOO2JJkMYGk6R6fFhJknAR845k0oy0sXlPQr8i
        8oSt6GIhAifm93+R5c4DJDCP0qt7RCMPVHxOi/PPCDZx3y8rZL/D8NWGPVaD6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685028307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8IcW9rC36xzwMdbICTITL2z/ciN/8f8kQF9VFbHEV/M=;
        b=72LYjcqsdNTY0LTHn7swrYGO8pKrQ0aok0hlESiwa1Kf4cNTPCOoBIiFOH63b6FtezcjJu
        aaEx+/ePBQAdWhCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Crystal Wood <swood@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/core: Provide sched_rtmutex() and expose
 sched work helpers
Message-ID: <20230525152505.obklNijZ@linutronix.de>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
 <20230427111937.2745231-2-bigeasy@linutronix.de>
 <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
 <20230510150415.6BXNs0I1@linutronix.de>
 <20230511134308.GV4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230511134308.GV4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-11 15:43:08 [+0200], Peter Zijlstra wrote:
> > If a sched_submit_work() would use a mutex_t lock then we would
> > recursively call blk_flush_plug() before setting tsk->blocked_on and
>=20
> I'm not following, mutex code sets tsk->blocked_on before it calls
> schedule(), getting into the very same problem you have with rt_mutex.
>=20
> > perform the same callback and block on the very same lock (again).
> > This isn't different compared to !RT therefore you must not use a
> > sleeping lock (mutex_t) in the callback.
>=20
> See the enforcement thing; today nothing stops the code from using a
> mutex or other blocking primitives here.

I tried to explain that if blk_flush_plug() blocks on a mutex_t then it
will invoke schedule() -> blk_flush_plug() -> schedule() ->
blk_flush_plug() -> =E2=80=A6 until it runs out of stack.

So it is broken regardless of RT but yes we don't enforce it and yes
people might use it and it would work as long as the lock is not
contended.

> > Do I rebase my stuff on top of his then and we good?
>=20
> I just suggested he try something else:
>=20
>   https://lkml.kernel.org/r/20230510150946.GO4253@hirez.programming.kicks=
-ass.net
>=20
> if that works out this worry goes away.
>=20
> If we get PROVE_RAW_LOCK_NESTING usable, something like the below might
> help out with the validation part...

Okay. So if I don't collide with workqueue do you buy this or do you
ask for something else. I'm not sure=E2=80=A6

Regarding PROVE_RAW_LOCK_NESTING: If I boot -rc3 with `quiet' then I
don't see any complains.
Otherwise it is printk during boot (caller is holding raw_spinlock_t and
then printk() calls to serial driver with spinlock_t).
=46rom time to time ppl send "fixes" for PROVE_RAW_LOCK_NESTING splats so
I would guess they boot with `quiet' and there isn't much else. So we
are getting close here I guess.

Do you want me to test the suggested validation map somewhere? Because
if it works, it could be queued.

Sebastian
