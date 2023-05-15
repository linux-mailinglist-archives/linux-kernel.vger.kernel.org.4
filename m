Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CEA702A60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjEOKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240789AbjEOKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:19:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914EE56
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:19:41 -0700 (PDT)
Date:   Mon, 15 May 2023 12:19:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684145978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwQ/dte7xGBpT9S/LJ/asraKKUsTrX2pGKwoZVhDWSI=;
        b=kVOQ5EG86gIP5F9zu2FSUbMvtI4o4Qjr4lR76MnIJLRc5v/aiA8S7/UThkvBn38Q06Z3c5
        Qyx0wgP+jb2brh1cnrrfWtedpa8pQV4nmrRw4XoEC/hkund0CTcPL13Sxt85KBru++u5FS
        bMaDYp+D9z0+ZLalFPvNydyLA8YXX5SXLza9FZ2rrBdYOUSQHXO7YqiNf2ZEIcWmQ64Kpg
        rewyMWe9DXibkNYB9pFDMYnNVuxhGlCm1BUDl5DPrtzFdHbakFtS6yvLl+qsRRqT5mkYv8
        nyJpLtZvnEvukh9zHpFKXKcXcl6uP8wO7G2nrkOlFXXwF8kgsypCG4+e/nRALQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684145978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwQ/dte7xGBpT9S/LJ/asraKKUsTrX2pGKwoZVhDWSI=;
        b=c+A4d45QhFr+nwhq2U8CjmN9PEOSlshc3TCi4NyBsxE3DTLnXuHnx+11b4P4l0/dHNwNB7
        75pVNuuzZCHxM+AA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
Message-ID: <20230515101936.3amAvw0T@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-20-anna-maria@linutronix.de>
 <ZFty1fNMlnuLk4qF@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZFty1fNMlnuLk4qF@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-10 12:32:53 [+0200], Frederic Weisbecker wrote:
> Le Wed, May 10, 2023 at 09:28:15AM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
> > +static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
> > +				   unsigned long jif)
> > +{
> > +	struct timer_events tevt;
> > +	struct tmigr_walk data;
> > +	struct tmigr_cpu *tmc;
> > +	u64 next =3D KTIME_MAX;
> > +
> > +	tmc =3D per_cpu_ptr(&tmigr_cpu, cpu);
> > +
> > +	raw_spin_lock_irq(&tmc->lock);
> > +	/*
> > +	 * Remote CPU is offline or no longer idle or other cpu handles cpu
> > +	 * timers already or next event was already expired - return!
> > +	 */
> > +	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
> > +	    now < tmc->cpuevt.nextevt.expires) {
> > +		raw_spin_unlock_irq(&tmc->lock);
> > +		return next;
> > +	}
> > +
> > +	tmc->remote =3D 1;
> > +
> > +	/* Drop the lock to allow the remote CPU to exit idle */
> > +	raw_spin_unlock_irq(&tmc->lock);
> > +
> > +	if (cpu !=3D smp_processor_id())
> > +		timer_expire_remote(cpu);
> > +
> > +	/*
> > +	 * Pretend that there is no timer pending if the cpu is offline.
> > +	 * Possible pending timers will be migrated later to an active cpu.
> > +	 */
> > +	if (cpu_is_offline(smp_processor_id())) {
> > +		raw_spin_lock_irq(&tmc->lock);
> > +		tevt.local =3D tevt.global =3D KTIME_MAX;
> > +	} else {
> > +		/*
> > +		 * Lock ordering needs to be preserved - timer_base locks
> > +		 * before tmigr related locks. During fetching the next
> > +		 * timer interrupt, also tmc->lock needs to be
> > +		 * held. Otherwise there is a possible race window against
> > +		 * the CPU itself when it comes out of idle, updates the
> > +		 * first timer and goes back to idle.
> > +		 */
> > +		timer_lock_remote_bases(cpu);
>=20
> So the return value is ignored here.
>=20
> In the case of !PREEMPT_RT, I suppose it's impossible for the target
> CPU to be offline. You checked above tmc->online and in-between the
> call to timer_lock_remote_bases(), the path is BH-disabled, this prevents
> stop_machine from running and from setting the CPU as offline.

I think you refer to the last one invoked from takedown_cpu(). This does
not matter, see below.

What bothers me is that _current_ CPU is check for cpu_is_offline() and
not the variable 'cpu'. Before the check timer_expire_remote() is
invoked on 'cpu' and not on current.

> However in PREEMPT_RT, ksoftirqd (or timersd) is preemptible, so it seems
> that it could happen in theory. And that could create a locking imbalance.

The ksoftirqd thread is part of smpboot_park_threads(). They have to
stop running and clean up before the machinery continues bringing down
the CPU (that is before takedown_cpu()). On the way down we have:
- tmigr_cpu_offline() followed by
- smpboot_park_threads().

So ksoftirqd (preempted or not) finishes before. This is for the
_target_ CPU.=20

After the "tmc->online" check the lock is dropped and this is invoked
=66rom run_timer_softirq(). That means that _this_ CPU could get preempted
(by an IRQ for instance) at this point, and once the CPU gets back here,
the remote CPU (as specified in `cpu') can already be offline by the
time timer_lock_remote_bases() is invoked.

So RT or not, this is racy.

> My suggestion would be to unconditionally lock the bases, you already che=
cked if
> !tmc->online before. The remote CPU may have gone down since then because=
 the
> tmc lock has been relaxed but it should be rare enough that you don't care
> about optimizing with a lockless check. So you can just lock the bases,
> lock the tmc and check again if tmc->online. If not then you can just ign=
ore
> the tmigr_new_timer_up call and propagation.

Regardless the previous point, this still looks odd as you pointed out.
The return code is ignored and the two functions perform lock + unlock
depending on it.

> Thanks.

Sebastian
