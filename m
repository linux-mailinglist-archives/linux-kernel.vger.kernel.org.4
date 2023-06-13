Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736ED72E01D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbjFMKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjFMKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62873B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:52:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49D26614F1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1F2C433EF;
        Tue, 13 Jun 2023 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686653522;
        bh=Gugy51XfM7p7YvaMbFh7Z+QWr45s2XEc9c8cxeX76e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZUz65iCPcCD8l+kpRVLyxl+kv1NvOZTARChoFOeCOUT9HuZgkqiZ+gGgPG9C5kF7
         3zb3aa/ZnPyS0HC9tfwq/bV+Ras7f8fkNHM9Tgy1cRK0fHiA4OOQ+pzAn0JD/DuMoq
         eQPy1vrNcx5wN5hPj1u/vsKWmor20/8Kx7hrqAQ9ggp4rSLEjWPlTM6KbR6dEPemvn
         qbJYdFEDFft9dPguN5pP7PiUoD1UJu1yAmd/VJ18Xou85ORhi67yetlywxEFYwnqY0
         b2c91Qpj4dDiXD54y+BSLFvID71Pe31e6xRp/WFdRX1o7AdBaY8Gwrp1x6oPF5Pwry
         9xZVeA5bxki6w==
Date:   Tue, 13 Jun 2023 12:51:59 +0200
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
Message-ID: <ZIhKT3h7Dc0G3xoU@lothringen>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Wed, May 24, 2023 at 09:06:27AM +0200, Anna-Maria Behnsen wrote:
> +static bool tmigr_update_events(struct tmigr_group *group,
> +				struct tmigr_group *child,
> +				struct tmigr_walk *data)
> +{
> +	struct tmigr_event *evt, *first_childevt;
> +	bool walk_done, remote = data->remote;
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
> +
> +		/*
> +		 * Walking the hierarchy is required in any case, when a
> +		 * remote expiry was done before. This ensures to not lost
> +		 * already queued events in non active groups (see section
> +		 * "Required event and timerqueue update after remote
> +		 * expiry" in documentation at the top).
> +		 */
> +		if (evt->ignore && !remote)
> +			return true;
> +
> +		raw_spin_lock(&group->lock);
> +	}
> +
> +	if (nextexp == KTIME_MAX) {
> +		evt->ignore = 1;
> +
> +		/*
> +		 * When next child event could be ignored (nextexp is
> +		 * KTIME_MAX) and there was no remote timer handling before
> +		 * or the group is already active, there is no need to walk
> +		 * the hierarchy even if there is a parent group.
> +		 *
> +		 * The other way round: even if the event could be ignored,
> +		 * but if a remote timer handling was executed before and
> +		 * the group is not active, walking the hierarchy is
> +		 * required to not miss an enqueued timer in the non active
> +		 * group. The enqueued timer of the group needs to be
> +		 * propagated to a higher level to ensure it is handled.
> +		 */
> +		if (!remote || data->groupstate.active) {
> +			walk_done = true;
> +			goto unlock;
> +		}
> +	} else {
> +		/*
> +		 * Update of event cpu and ignore bit is required only when
> +		 * @child is set (child is equal or higher than lvl0), but
> +		 * it doesn't matter if it is written once more to per cpu
> +		 * event; make the update unconditional.
> +		 */
> +		evt->cpu = first_childevt->cpu;
> +		evt->ignore = 0;
> +	}
> +
> +	walk_done = !group->parent;
> +
> +	/*
> +	 * If child event is already queued in group, remove it from queue
> +	 * when expiry time changed only.
> +	 */
> +	if (timerqueue_node_queued(&evt->nextevt)) {
> +		if (evt->nextevt.expires == nextexp)
> +			goto check_toplvl;
> +		else if (!timerqueue_del(&group->events, &evt->nextevt))
> +			WRITE_ONCE(group->next_expiry, KTIME_MAX);
> +	}
> +
> +	evt->nextevt.expires = nextexp;
> +
> +	if (timerqueue_add(&group->events, &evt->nextevt))
> +		WRITE_ONCE(group->next_expiry, nextexp);
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

This looks racy against a concurrent top migrator going idle.

1) Suppose you have the following configuration:

    LVL 1            [GRP1:0]
                     migrator = GRP0:1
                     active   = GRP0:1
                     nextevt  = KTIME_MAX
                   /                \
    LVL 0  [GRP0:0]                  [GRP0:1]
           migrator = NONE           migrator = CPU2
           active   = NONE           active   = CPU2
           nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
              /         \                /         \
    CPUs     0           1              2           3
            idle       idle           active      idle

2) Now CPU 2 goes idle and propagates that entirely:

    LVL 1            [GRP1:0]
                     migrator = NONE
                     active   = NONE
                     nextevt  = KTIME_MAX
                   /                \
    LVL 0  [GRP0:0]                  [GRP0:1]
           migrator = NONE           migrator = NONE
           active   = NONE           active   = NONE
           nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
              /         \                /         \
    CPUs     0           1              2           3
            idle       idle           active      idle

3) CPU 0 has a new timer queued from idle, it propagates that
   to LVL 0, so far so good:

    LVL 1            [GRP1:0]
                     migrator = NONE
                     active   = NONE
                     nextevt  = KTIME_MAX
                   /                \
    LVL 0  [GRP0:0]                  [GRP0:1]
           migrator = NONE           migrator = NONE
           active   = NONE           active   = NONE
           nextevt  = TIMER0         nextevt  = KTIME_MAX
              /         \                /         \
    CPUs     0           1              2           3
            idle       idle           active      idle

4) Finally CPU 0 is about to propagate TIMER0 to LVL1,
   so in tmigr_new_timer_up() it reads the state of GRP1:0
   but what makes sure it reads the freshest value modified
   in step 2 ? There is no locking or cmpxchg() from the reader
   side. It's a plain atomic_read(). It may well observe
   the stalled value that was in step 1 which has migrator == GRP0:1
   and as a result data->nextexp will stay KTIME_MAX and TIMER0 will
   be ignored entirely.


As usual I prefer to announce I may be easily missing something that
makes this impossible to happen :)

Otherwise, fortunately there is an easy way to fix this, you need to read the
group state within the group->lock. Because then you have this ordering:

    tmigr_inactive_up()                               tmigr_new_timer_up()
    -------------------                               --------------------
    cmpxchg(&group->migr_state, ..., TMIGR_NONE)
    tmigr_update_events() {
        spin_lock(&group->lock)
        //update events ....
        spin_unlock(&group->lock) //release migr_state modification
    }
                                                      tmigr_update_events() {
                                                          spin_lock(&group->lock) // acquire migr_state modificaton
                                                          group_state = atomic_read(&group->migr_state)
                                                          //update events ....
                                                          spin_unlock(&group->lock) //makes migr_state visible
                                                       }						       

Everything happening before an UNLOCK (including before the preceding LOCK) is
visible after the next LOCK. So it works. And if tmigr_new_timer_up() runs
while tmigr_inactive_up() is between the group->migr_state modification and
the call to tmigr_update_events(), it's fine as well because it will lock
group->lock and re-evaluate the situation.

I see another check on data->groupstate.active in tmigr_new_timer_up()
when nextexp == KTIME_MAX. From a quick glance it has the same issue and
could be fixed along the same way.

Thanks.
