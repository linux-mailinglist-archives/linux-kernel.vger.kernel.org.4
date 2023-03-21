Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5786C35C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCUPep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCUPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:34:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0515098E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZAn2bad7QmSiOVECGASy51KQi3XkOfQ1o4WvLSSqIeo=; b=KOnwakLU5524mMtDbE9vuuDvHW
        +Y/ekSXychMuyW/IwgR4qD33ufGyaY11LExEkjIaCZX8LMr/e3kKz2RTAg1lKF3AR5RTf2sgYD3PH
        3jkO/vnSykOQuzjTnqreLi8Lt6rum2PYhvO6pz6YIYcfuVW1JL/o4S+PswFzcxzAhZTJSibBUhxp4
        1BQZIo6o4ZV0MdGF7MUt30z5tijwEvIn1CfJx/PuRoYHpu/lfJ7dxw+vVTOafuitMo2VhKR57nS56
        id02u1Wg38XoBPfuYVS4PJpaMi7FNwTdlewKC6wZcGBgNrIbmIGAGgo44T8C9rmQ3JDIGMcxtUcbD
        OnG5uUTA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pee01-0029ey-3f; Tue, 21 Mar 2023 15:34:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45C943002FC;
        Tue, 21 Mar 2023 16:34:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27F49240D2A01; Tue, 21 Mar 2023 16:34:07 +0100 (CET)
Date:   Tue, 21 Mar 2023 16:34:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <20230321153407.GB2272870@hirez.programming.kicks-ass.net>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen wrote:
> +static bool tmigr_inactive_up(struct tmigr_group *group,
> +			      struct tmigr_group *child,
> +			      void *ptr)
> +{
> +	union tmigr_state curstate, newstate;
> +	struct tmigr_walk *data = ptr;
> +	bool walk_done;
> +	u32 childmask;
> +
> +	childmask = data->childmask;
> +	newstate = curstate = data->groupstate;
> +
> +retry:
> +	walk_done = true;
> +
> +	/* Reset active bit when child is no longer active */
> +	if (!data->childstate.active)
> +		newstate.active &= ~(u8)childmask;
> +
> +	if (newstate.migrator == (u8)childmask) {
> +		/*
> +		 * Find a new migrator for the group, because child group
> +		 * is idle!
> +		 */
> +		if (!data->childstate.active) {
> +			unsigned long new_migr_bit, active = newstate.active;
> +
> +			new_migr_bit = find_first_bit(&active, BIT_CNT);
> +
> +			/* Changes need to be propagated */
> +			walk_done = false;
> +
> +			if (new_migr_bit != BIT_CNT)
> +				newstate.migrator = BIT(new_migr_bit);
> +			else
> +				newstate.migrator = TMIGR_NONE;
> +		}
> +	}
> +
> +	newstate.seq++;
> +
> +	DBG_BUG_ON((newstate.migrator != TMIGR_NONE) && !(newstate.active));
> +
> +	if (atomic_cmpxchg(group->migr_state, curstate.state, newstate.state) != curstate.state) {
> +		/*
> +		 * Something changed in child/parent group in the meantime,
> +		 * reread the state of child and parent; Update of
> +		 * data->childstate is required for event handling;
> +		 */
> +		if (child)
> +			data->childstate.state = atomic_read(child->migr_state);
> +		newstate.state = curstate.state = atomic_read(group->migr_state);
> +
> +		goto retry;
> +	}

Idem:

	if (!atomic_try_cmpxchg(group->migr_state, &curstate.state, newstate.state)) {
		newstate.state = curstate.state;
		if (child)
			data->childstate.state = atomic_read(child->migr_state);
		goto retry;
	}

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
> +		data->groupstate.state = atomic_read(group->parent->migr_state);
> +	}
> +
> +	/*
> +	 * data->nextexp was set by tmigr_update_events() and contains the
> +	 * expiry of first global event which needs to be handled
> +	 */
> +	if (data->nextexp != KTIME_MAX) {
> +		DBG_BUG_ON(group->parent);
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
> +		}
> +	}
> +
> +	return walk_done;
> +}
