Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA96B629783
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiKOLdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiKOLcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:32:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D6B28E06
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:31:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC48E61602
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF55C433D6;
        Tue, 15 Nov 2022 11:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668511915;
        bh=pkya23GJbo/hm8ah9H7OHFt7gwMYoJxv5tApGuQ99pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeGSah0CFWgfHwouZQlJNOPsczhyC999b9NRz9VYRBzgC1W704rYLEOSgrbZGKKkT
         TSVJMtAUjM/VTms0UAtGZN1QNW8JVtYhQQCbWw/rL9hTEyQgDKrJGYvYkwuwLbDOq9
         kRN3APFtsWHHWfXlR9NDW87lcet11kQtSff93TNJIDaXa7oW3rBum0NjG/tFCl/00m
         KZTeolkTpRaN22sL5LOXWAZmGTewqwrI1n1wJd8mGGG/sdX6PKQKeCQGeY9AlIRkn5
         CNK4pweZy7nUgd5yjEZEULbVK3yv8wpN6G371e55kgdzQximpu46zLwK4I+ZOIVEXS
         JStlKqydWOkTA==
Date:   Tue, 15 Nov 2022 12:31:52 +0100
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
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 14/16] timer: Implement the hierarchical pull model
Message-ID: <20221115113152.GH590078@lothringen>
References: <20221104145737.71236-1-anna-maria@linutronix.de>
 <20221104145737.71236-15-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104145737.71236-15-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> +static bool tmigr_update_events(struct tmigr_group *group,
> +				struct tmigr_group *child,
> +				struct tmigr_walk *data)
> +{
> +	struct tmigr_event *evt, *first_childevt;
> +	bool walk_done;
> +	u64 nextexp;
> +
> +	if (child) {
> +		if (data->childstate.active)
> +			return true;
> +
> +		raw_spin_lock(&child->lock);
> +		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
> +
> +		first_childevt = tmigr_next_groupevt(child);
> +		nextexp = child->next_expiry;
> +		evt = &child->groupevt;
> +	} else {
> +		nextexp = data->nextexp;
> +
> +		/*
> +		 * Set @data->nextexp to KTIME_MAX; it is reused for first
> +		 * global event which needs to be handled by migrator (in
> +		 * toplevel group)
> +		 */
> +		data->nextexp = KTIME_MAX;
> +
> +		first_childevt = evt = data->evt;
> +		if (test_bit(0, &evt->ignore))
> +			return true;
> +
> +		raw_spin_lock(&group->lock);
> +	}
> +
> +	if (nextexp == KTIME_MAX) {
> +		set_bit(0, &evt->ignore);
> +		walk_done = true;
> +		goto unlock;
> +	}
> +
> +	walk_done = !group->parent;
> +
> +	/*
> +	 * Update of event cpu and ignore bit is required only when @child
> +	 * is set (child is equal or higher than lvl0), but it doesn't
> +	 * matter if it is written once more to per cpu event; make the
> +	 * update unconditional.
> +	 */
> +	evt->cpu = first_childevt->cpu;
> +	clear_bit(0, &evt->ignore);
> +
> +	/*
> +	 * If child event is already queued in group, remove it from queue
> +	 * when expiry time changed only
> +	 */
> +	if (timerqueue_node_queued(&evt->nextevt)) {
> +		if (evt->nextevt.expires == nextexp)
> +			goto check_toplvl;
> +
> +		if (evt->nextevt.expires != nextexp &&

At this point evt->nextevt.expires != nextexp has to be true.

> +		    !timerqueue_del(&group->events, &evt->nextevt))
> +			group->next_expiry = KTIME_MAX;
> +	}
> +
> +	evt->nextevt.expires = nextexp;
> +
> +	if (timerqueue_add(&group->events, &evt->nextevt))
> +		group->next_expiry = nextexp;
> +
> +check_toplvl:
> +	if (walk_done && (data->groupstate.migrator == TMIGR_NONE)) {
> +		/*
> +		 * Toplevel group is idle and it has to be ensured global
> +		 * timers are handled in time. (This could be optimized by
> +		 * keeping track of the last global scheduled event and
> +		 * only arming it on CPU if the new event is earlier. Not
> +		 * sure if its worth the complexity.)
> +		 */
> +		data->nextexp = tmigr_next_groupevt_expires(group);
> +	}
> +
> +unlock:
> +	raw_spin_unlock(&group->lock);
> +
> +	if (child)
> +		raw_spin_unlock(&child->lock);
> +
> +	return walk_done;
> +}
[...]
> +static int tmigr_cpu_offline(unsigned int cpu)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +
> +	raw_spin_lock_irq(&tmc->lock);
> +	tmc->online = 0;
> +	__tmigr_cpu_deactivate(tmc, KTIME_MAX);

This means that if the CPU is going idle for some time during
the hotplug process (ie: at some point between CPUHP_AP_TMIGR_ONLINE
and CPUHP_TEARDOWN_CPU), then a global timer may be delayed for that long.

I guess it shouldn't be too bad but worth mentioning...

Although if it happens to be a problem it could be solved with simply allowing
tmigr_cpu_deactivate() when !tmc->online.

Thanks.
