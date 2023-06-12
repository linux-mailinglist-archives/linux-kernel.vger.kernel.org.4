Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E272CAD0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbjFLP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbjFLP5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:57:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898701711
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:57:02 -0700 (PDT)
Date:   Mon, 12 Jun 2023 17:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686585421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gg+64sYyZZXn8p/Rp7XltmrBCvLTluCjudOpzSabG/w=;
        b=GrTCzVIElgo4anWLvg3rt7hZwsCsI3NdJ7sbLKPZapujSuzorZ7qxifC8+B+oXqTtlnFym
        mWyJSSXkk1VquZggnibo9yxsCxZHL/eb9oXxGdx+6Btj5HQbZW19PfTFoUmdH1Bh7aepon
        KNqYMm5YePvkgYpZi4pciK8gJ2vEDN519KHPJI/5kdUpEgkU8zalSgCpRRBRXF6G84w/RW
        jPmR1WhlM4tv26gfG/tL9afv9K2HPUiCGtLgw54oB6UQgYyRy00IRdn0U/hf+QcAExgc3J
        3KVE4frjO6jDyH48YnDjhNWoTiyXQUGTiJ3AO1V0oTQPQecW2rL/8kgvhH07Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686585421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gg+64sYyZZXn8p/Rp7XltmrBCvLTluCjudOpzSabG/w=;
        b=K7wilGoKe9M2bZLqhT3TE+iSbIXQQhN7wt+PQ91yi/pwlD75l6UE4dtqn9p0bh7X1E23VW
        58vZZEPlrYGINsDA==
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
Subject: Re: [PATCH v7 19/21] timer: Implement the hierarchical pull model
In-Reply-To: <ZIc1LX4Dm2HJ70bZ@2a01cb0980221ec3a67fd23915238df5.ipv6.abo.wanadoo.fr>
Message-ID: <12d6e6ef-2b8a-7ed2-e386-60c0f4d76683@linutronix.de>
References: <20230524070629.6377-1-anna-maria@linutronix.de> <20230524070629.6377-20-anna-maria@linutronix.de> <ZIc1LX4Dm2HJ70bZ@2a01cb0980221ec3a67fd23915238df5.ipv6.abo.wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1722915258-1686585421=:2279"
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

--8323329-1722915258-1686585421=:2279
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 12 Jun 2023, Frederic Weisbecker wrote:

> Le Wed, May 24, 2023 at 09:06:27AM +0200, Anna-Maria Behnsen a écrit :
> > +void tmigr_handle_remote(void)
> > +{
> > +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> > +	struct tmigr_remote_data data;
> > +
> > +	if (!is_tmigr_enabled() || !tmc->tmgroup || !tmc->online)
> > +		return;
> > +
> > +	/*
> > +	 * NOTE: This is a doubled check because migrator test will be done
> > +	 * in tmigr_handle_remote_up() anyway. Keep this check to fasten
> > +	 * the return when nothing has to be done.
> > +	 */
> > +	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
> > +		return;
> > +
> > +	data.now = get_jiffies_update(&data.basej);
> > +	data.childmask = tmc->childmask;
> > +	data.wakeup = KTIME_MAX;
> > +
> > +	__walk_groups(&tmigr_handle_remote_up, &data, tmc);
> > +
> > +	raw_spin_lock_irq(&tmc->lock);
> > +	if (tmc->idle)
> > +		tmc->wakeup = data.wakeup;
> 
> So this assumes there will be a timer re-eavluation right after
> in the idle path but this is not true in the case of nohz_full.
> 
> If the softirq happens at the tail of the timer interrupt, you're
> good because the dynticks is re-evaluated right after. But if the
> softirq happens in ksoftirqd, you'll have no timer re-evaluation.

Ok. This problem is around only for nohz_full and not for nohz idle?

> The crude trick used by nohz_full in order to re-evaluate the dynticks when
> a timer is queued from the timer softirq is to launch a self IPI (from
> trigger_dyntick_cpu()). Here you would need something like that but
> that's not something we wish either.
> 
> In fact we don't want any nohz_full CPU to perform an idle migrator job.
> And the problem here is that whenever a timer interrupt occurs while
> tmc->idle == 1 (and that _might_ happen in nohz_full), it will go up the
> hierarchy as long as there is no active migrator on a given level and
> check for remote expiry. And if something expired it will not only perform
> the remote callbacks handling but also reprogram the next tick to fire in
> the next expiry. That's a potential disturbance on a nohz_full CPU.
> 
> There is always an active CPU in nohz_full so there is always an active
> migrator at least at the top level. Therefore you can spare concurrent
> idle migrators if they are nohz_full.
>

As long as the top level group is not/never idle, the wakeup value will be
KTIME_MAX and so it is no problem for nohz_full cpus - or? The check for
handling remote expiry is still a problem but please read my proposal for
this below.

> My suggestion is to make tmigr_requires_handle_remote() return 0 if
> tick_nohz_full_cpu(smp_processor_id()), so that we don't even bother
> raising the softirq. But if the timer softirq happens nevertheless, due
> to some local timer to process, also make tmigr_handle_remote() to
> return early.

Regarding this problem and also the two things you mentioned in the two
earlier review remarks (timer IRQ which fires too early, IPI when CPU goes
offline), I would propose to use the tmc->wakeup value slightly different
as it is used right now:

 - Whenever a wakeup value is required, because top level group is
   completely idle, the value is set in per CPU tmc struct. It could be
   then reevaluated in idle code in irq exit path.

 - For checking whether remote expiry is required, the wakeup value could
   also be used.

 - For nohz_full CPUs wakeup will be always KTIME_MAX - under the
   assumption that there is alwasy an active CPU in top level group.

What do you think about this? Do I miss something else here?

Thanks,

	Anna-Maria

--8323329-1722915258-1686585421=:2279--
