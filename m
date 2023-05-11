Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBBA6FF21D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjEKNGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEKNGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:06:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443B519BD
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:06:46 -0700 (PDT)
Date:   Thu, 11 May 2023 15:06:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683810404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QbSc+WW26dkKG3IMBEP7Nf8RtWe4bCsbSW45SCpJCo=;
        b=c40TRRMOeNzKMC8HNi17z1VOlWprWjA28b7efv00oyFJ6Z4+skdikmuwUSquyNn+BNyina
        VaALtOte5CmQ5owjU8vhwzyr+LKYiAATlEYHShb7GS4a62lAyPiXErX0OWTBzWWn5l/eKA
        2lO4q1Yo9JkVxTUYxIUeH6ytm3buISKOvdDt2LlGZAgNzLyB4tv9gioVwpgz6OVB7jvcrx
        F/c18acjkTs4c2m62ICADSo2GSoXYbYk2W8NHk9akoSO1w14guESCdYt8MeWncqB7NNO8W
        OrjiBpJGrrbJgwPmCIhOpatuxNPueVN8K6dm980l26lP/IPhqPE/mlhsQf4gBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683810404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QbSc+WW26dkKG3IMBEP7Nf8RtWe4bCsbSW45SCpJCo=;
        b=ccD9NF5VDy0oTkJHEroQbOlDoWKVZb2o7ohbUkMLw+Mna046krRumW/ozaukaS6iURZkUG
        dWFv89ha20mf4lAA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
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
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 15/21] timer: Add get next timer interrupt functionality
 for remote CPUs
In-Reply-To: <ZFtu9l35Tg89NAiZ@localhost.localdomain>
Message-ID: <c92c4491-d183-4b15-5c94-504c9c8c681@linutronix.de>
References: <20230510072817.116056-1-anna-maria@linutronix.de> <20230510072817.116056-16-anna-maria@linutronix.de> <ZFtu9l35Tg89NAiZ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-870218387-1683810404=:1817"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-870218387-1683810404=:1817
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 10 May 2023, Frederic Weisbecker wrote:

> Le Wed, May 10, 2023 at 09:28:11AM +0200, Anna-Maria Behnsen a écrit :
> > +/**
> > + * fetch_next_timer_interrupt_remote
> > + * @basej:	base time jiffies
> > + * @basem:	base time clock monotonic
> > + * @tevt:	Pointer to the storage for the expiry values
> > + * @cpu:	Remote CPU
> > + *
> > + * Stores the next pending local and global timer expiry values in the
> > + * struct pointed to by @tevt. If a queue is empty the corresponding
> > + * field is set to KTIME_MAX. If local event expires before global
> > + * event, global event is set to KTIME_MAX as well.
> > + *
> > + * Caller needs to make sure timer base locks are held (use
> > + * timer_lock_remote_bases() for this purpose). Caller must make sure
> > + * interrupts are reopened, if required.
> > + */
> > +void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
> > +				       struct timer_events *tevt,
> > +				       unsigned int cpu)
> > +{
> > +	struct timer_base *base_local, *base_global;
> > +
> > +	/* Preset local / global events */
> > +	tevt->local = tevt->global = KTIME_MAX;
> > +
> > +	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
> > +	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
> > +
> > +	lockdep_assert_held(&base_local->lock);
> > +	lockdep_assert_held(&base_global->lock);
> > +
> > +	fetch_next_timer_interrupt(base_local, base_global, basej, basem, tevt);
> > +
> > +	raw_spin_unlock(&base_global->lock);
> > +	raw_spin_unlock(&base_local->lock);
> 
> Oh so that makes:
> 
> LOCK(baseL)
> LOCK(baseG)
> LOCK(tmc)
> UNLOCK(baseG)
> UNLOCK(baseL)
> UNLOCK(tmc)
> 
> I guess you can keep the bases locks locked until the end of
> tmigr_handle_remote_cpu(). After all that's what get_next_timer_interrupt()
> does. I'm not sure the above early release of bases locks will bring much
> in case of contention...
> 
> Then a timer_unlock_remote_bases() would restore symmetry.

When the walk of the hierarchy for updating the new timer is done,
additional locks has to be taken. So then 5 locks are held during the
update in lvl1 and higher: baseL, baseG, tmc, child, group

I don't see a problem releasing the baseL and baseG lock earlier. But I
will add an extra function for releasing the base locks to make it more
clear. The whole section is protected by a local_irq_disable() and
irq_enable is done when unlocking the tmc lock.

No?

> > +/**
> > + * timer_lock_remote_bases - lock timer bases of cpu
> > + * @cpu:	Remote CPU
> > + *
> > + * Locks the remote timer bases.
> > + *
> > + * Returns false if cpu is offline, otherwise true is returned.
> > + */
> > +bool timer_lock_remote_bases(unsigned int cpu)
> > +{
> > +	struct timer_base *base_local, *base_global;
> > +
> > +	/*
> > +	 * Pretend that there is no timer pending if the cpu is offline.
> > +	 * Possible pending timers will be migrated later to an active cpu.
> > +	 */
> > +	if (cpu_is_offline(cpu))
> > +		return false;
> 
> This value is never checked and the caller assumes the bases are
> always locked upon calling this (more on this on the big patch).
> 
> Thanks.
> 
> > +
> > +	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
> > +	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
> > +
> > +	raw_spin_lock_irq(&base_local->lock);
> > +	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
> > +
> > +	return true;
> > +}
> 
> 
--8323329-870218387-1683810404=:1817--
