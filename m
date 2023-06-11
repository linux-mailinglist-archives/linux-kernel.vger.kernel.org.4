Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFF872B420
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 23:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjFKVTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 17:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DB1A8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7129D610AA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED08C433EF;
        Sun, 11 Jun 2023 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686518344;
        bh=vJKhxBrtVeUqjaQ+DatC3N3vE9uMZrzSqPG7aOAj+c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tkjqg9H9KAJtrazTsVyYB5RgBBFcw+wPyKoDnrpTeDOpGmmf/8J5YhhSpiRJBfY0S
         fIXslX6UhqxgU1f98opuA9/Izz1kkmzL+CmQmjYT819ZKUvVXAS9/TOjVqnND5nX/b
         gcoxMm8n3kHVrtHfYyYjiWGmy0UpVpLITNEGh1hRm9ckHt49ahODYB0/aJhA9o7oF7
         rgd7jodV/czCqgQ6EpwVAVDeGKf1Wy21do3sbsUOxvdUSCjY52ojPgZe0IQtyVA7G8
         vNDtAMPSjYV7HuYPfiMdTiw52S3hGhOeBVYB2Y/DJ8/9yA24bqM2UUqABbjZZ7S1CP
         qiEPnM2rH25Gw==
Date:   Sun, 11 Jun 2023 23:19:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <ZIY6RTUfGuEmn8Iz@localhost.localdomain>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524070629.6377-20-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 24, 2023 at 09:06:27AM +0200, Anna-Maria Behnsen a écrit :
> +static bool tmigr_inactive_up(struct tmigr_group *group,
> +			      struct tmigr_group *child,
> +			      void *ptr)
> +{
> +	union tmigr_state curstate, newstate;
> +	struct tmigr_walk *data = ptr;
> +	bool walk_done;
> +	u8 childmask;
> +
> +	childmask = data->childmask;
> +	newstate = curstate = data->groupstate;
> +
> +retry:
> +	walk_done = true;
> +
> +	/* Reset active bit when child is no longer active */
> +	if (!data->childstate.active)
> +		newstate.active &= ~childmask;
> +
> +	if (newstate.migrator == childmask) {
> +		/*
> +		 * Find a new migrator for the group, because child group
> +		 * is idle!
> +		 */
> +		if (!data->childstate.active) {
> +			unsigned long new_migr_bit, active = newstate.active;
> +
> +			new_migr_bit = find_first_bit(&active, BIT_CNT);
> +
> +			if (new_migr_bit != BIT_CNT) {
> +				newstate.migrator = BIT(new_migr_bit);
> +			} else {
> +				newstate.migrator = TMIGR_NONE;
> +
> +				/* Changes need to be propagated */
> +				walk_done = false;
> +			}
> +		}
> +	}
> +
> +	newstate.seq++;
> +
> +	WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
> +
> +	if (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state)) {
> +		newstate.state = curstate.state;
> +
> +		/*
> +		 * Something changed in child/parent group in the meantime,
> +		 * reread the state of child and parent; Update of
> +		 * data->childstate is required for event handling;
> +		 */
> +		if (child)
> +			data->childstate.state = atomic_read(&child->migr_state);
> +
> +		goto retry;
> +	}
> +
> +	data->groupstate = newstate;
> +	data->remote = false;
> +
> +	/* Event Handling */
> +	tmigr_update_events(group, child, data);
> +
> +	if (group->parent && (walk_done == false)) {
> +		data->childmask = group->childmask;
> +		data->childstate = newstate;
> +		data->groupstate.state = atomic_read(&group->parent->migr_state);
> +	}
> +
> +	/*
> +	 * data->nextexp was set by tmigr_update_events() and contains the
> +	 * expiry of first global event which needs to be handled
> +	 */
> +	if (data->nextexp != KTIME_MAX) {
> +		WARN_ON_ONCE(group->parent);
> +		/*
> +		 * Toplevel path - If this cpu is about going offline wake
> +		 * up some random other cpu so it will take over the
> +		 * migrator duty and program its timer properly. Ideally
> +		 * wake the cpu with the closest expiry time, but that's
> +		 * overkill to figure out.
> +		 */
> +		if (!(this_cpu_ptr(&tmigr_cpu)->online)) {
> +			unsigned int cpu = smp_processor_id();
> +
> +			cpu = cpumask_any_but(cpu_online_mask, cpu);
> +			smp_send_reschedule(cpu);

Is that enough?
Assume the following:

* CPU 0 is idle and CPU 1 is the migrator
* CPU 1 goes offline and send the above IPI to CPU 0.
* CPU 0 doesn't have any global timer in its own queue, it calls
  tmigr_cpu_deactivate() with KTIME_MAX. It's already ->idle, so it
  returns ->wakeup that may be KTIME_MAX (also the call to tmigr_new_timer()
  is ignored)
* CPU 0 doesn't handle the idle migrator duty

Or is there something else I'm missing?

I guess the effect should be mostly invisible due to the fact the hotplug
BP process has to be carried by another active CPU afterward, which will take
the migrator duty.

But still, it means you may have no migrator between CPUHP_AP_TMIGR_ONLINE and
CPUHP_AP_IDLE_DEAD.

Thanks.
