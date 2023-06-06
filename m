Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC7724DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjFFUKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjFFUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD3510FB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F355637C8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC39C433EF;
        Tue,  6 Jun 2023 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686082246;
        bh=51J3Dh5Hqu7d4KulHxAABsRhA+qSdaH/GUWaIfb1tkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQgJae45NsKOKem4o0dTCa2lTfYYAqFaU+5UHGegJsaQtJMGh8s+L9HnS7RdEAidK
         M+OcXw+uHiCCZYr3HPRigCJQPcHMWt+67eNDKhVEPumQegH4sXUub5GsRBXt26GmjZ
         3h2XlPxLT+Uj5+5rtnjn8k/a1c6k3GDl5zrw7sjpMToSwC9B0wdluWulP8PRlGtvHU
         2ORY0UwBM/KPSCJFgAskRNtge0Xza996YDu3z2yaxgscUdSzwTrRexzBd5cJQUCXJE
         u5YIUh4IIzHBKt0i35m3iPsQFtgp+NhGXYjoGDpGur6vnYkOKGAh+f7A5gkdsdnFKv
         kZD40DhOPxDdQ==
Date:   Tue, 6 Jun 2023 22:10:43 +0200
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
Message-ID: <ZH-SwxgV-Ec9ulq-@localhost.localdomain>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524070629.6377-20-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 24, 2023 at 09:06:27AM +0200, Anna-Maria Behnsen a écrit :
> +u64 tmigr_cpu_deactivate(u64 nextexp)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +	u64 ret;
> +
> +	if (!is_tmigr_enabled() || !tmc->tmgroup || !tmc->online)
> +		return nextexp;
> +
> +	raw_spin_lock(&tmc->lock);
> +
> +	/*
> +	 * CPU is already deactivated in timer migration
> +	 * hierarchy. tick_nohz_get_sleep_length() calls
> +	 * tick_nohz_next_event() and thereby timer idle path is
> +	 * executed once more. tmc->wakeup holds the first timer, when
> +	 * timer migration hierarchy is completely idle and remote
> +	 * expiry was done.

This can also hold the first timer in the hierarchy on nodes
having no true migrator, but still with upper nodes having potentially
a migrator, right??

> +	 * If there is no new next expiry value
> +	 * handed in which should be inserted into the timer migration
> +	 * hierarchy, wakeup value is returned.
> +	 */
> +	if (tmc->idle) {
> +		ret = tmc->wakeup;
> +
> +		tmc->wakeup = KTIME_MAX;
> +
> +		if (nextexp != KTIME_MAX) {

This seem to assume that tick_nohz_next_event() on the last idle CPU in an idle
hierarchy is always called right after a timer interrupt arriving on time
(ie: right after a call to tmigr_handle_remote()), but this can actually be called
after any interrupt. Can the following happen or am I overlooking something?

do_idle() {
	// ===> <IRQ>
	tmigr_handle_remote() {
		// find some timer in the hierarchy
		// expiring in 2 jiffies
		tmc->wakeup = jiffies + 2
	}
	//<=== </IRQ>
	tick_nohz_get_sleep_length() {
		get_next_timer_interrupt() {
			tmigr_cpu_deactivate() {
				wakeup = tmc->wakeup
				tmc->wakeup = KTIME_MAX
				return wakeup // jiffies + 2
			}
		}
	}
	tick_nohz_idle_stop_tick() {
		// SLEEP 2 jiffies
	}

	// ===> <IRQ>
	// whatever IRQ that is not timer
	// or a timer IRQ firing too early
	//<=== </IRQ>
	
	tick_nohz_get_sleep_length() {
		get_next_timer_interrupt() {
			tmigr_cpu_deactivate() {
				wakeup = tmc->wakeup
				 tmc->wakeup = KTIME_MAX
				return wakeup // KTIME_MAX
			}
		}
	}
	tick_nohz_idle_stop_tick() {
		// SLEEP forever, misses the timer in 2 jiffies
	}
}

Thanks.
