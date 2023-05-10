Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06F6FDB76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbjEJKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D11BE7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D24864860
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBCCC433EF;
        Wed, 10 May 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683713786;
        bh=ZSbZgAoMh5LnKeTr6TYqbQqHTrrmga9LBiMNaVOVVKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yqcy2PtThYGb4x7qcBy1q02y2LyCP2zZIkqTCIuvP1FmbDNJREdVmNwlS6LfXO745
         +2v5i16x8L5Q/INe+tElDmUpG2delFKOGXOoljfN5x2Za+sOcXccHElvqb/cV56HMc
         negVOx81D9h5P50hbPnjxAA3Cmm3ktKPexbI9yaIBYqVH1j2ZWmdPwLz/5l6SrMA/P
         f89V4L85KDo/jYwbQkgxjv5Pjz6sLY0G00G1SnSrlUyA3mtpWNOfTQErBnVO/vKZ3g
         LqMu/HpPhEh1TgzFgElrtZEopTKfy/mAlyW5zuKxHOX9dccAPOvVXYngJ+UF6EGR3i
         qjUsLUC7NaZHw==
Date:   Wed, 10 May 2023 12:16:22 +0200
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
Subject: Re: [PATCH v6 15/21] timer: Add get next timer interrupt
 functionality for remote CPUs
Message-ID: <ZFtu9l35Tg89NAiZ@localhost.localdomain>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-16-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510072817.116056-16-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 10, 2023 at 09:28:11AM +0200, Anna-Maria Behnsen a écrit :
> +/**
> + * fetch_next_timer_interrupt_remote
> + * @basej:	base time jiffies
> + * @basem:	base time clock monotonic
> + * @tevt:	Pointer to the storage for the expiry values
> + * @cpu:	Remote CPU
> + *
> + * Stores the next pending local and global timer expiry values in the
> + * struct pointed to by @tevt. If a queue is empty the corresponding
> + * field is set to KTIME_MAX. If local event expires before global
> + * event, global event is set to KTIME_MAX as well.
> + *
> + * Caller needs to make sure timer base locks are held (use
> + * timer_lock_remote_bases() for this purpose). Caller must make sure
> + * interrupts are reopened, if required.
> + */
> +void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
> +				       struct timer_events *tevt,
> +				       unsigned int cpu)
> +{
> +	struct timer_base *base_local, *base_global;
> +
> +	/* Preset local / global events */
> +	tevt->local = tevt->global = KTIME_MAX;
> +
> +	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
> +	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
> +
> +	lockdep_assert_held(&base_local->lock);
> +	lockdep_assert_held(&base_global->lock);
> +
> +	fetch_next_timer_interrupt(base_local, base_global, basej, basem, tevt);
> +
> +	raw_spin_unlock(&base_global->lock);
> +	raw_spin_unlock(&base_local->lock);

Oh so that makes:

LOCK(baseL)
LOCK(baseG)
LOCK(tmc)
UNLOCK(baseG)
UNLOCK(baseL)
UNLOCK(tmc)

I guess you can keep the bases locks locked until the end of
tmigr_handle_remote_cpu(). After all that's what get_next_timer_interrupt()
does. I'm not sure the above early release of bases locks will bring much
in case of contention...

Then a timer_unlock_remote_bases() would restore symmetry.

> +/**
> + * timer_lock_remote_bases - lock timer bases of cpu
> + * @cpu:	Remote CPU
> + *
> + * Locks the remote timer bases.
> + *
> + * Returns false if cpu is offline, otherwise true is returned.
> + */
> +bool timer_lock_remote_bases(unsigned int cpu)
> +{
> +	struct timer_base *base_local, *base_global;
> +
> +	/*
> +	 * Pretend that there is no timer pending if the cpu is offline.
> +	 * Possible pending timers will be migrated later to an active cpu.
> +	 */
> +	if (cpu_is_offline(cpu))
> +		return false;

This value is never checked and the caller assumes the bases are
always locked upon calling this (more on this on the big patch).

Thanks.

> +
> +	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
> +	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
> +
> +	raw_spin_lock_irq(&base_local->lock);
> +	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
> +
> +	return true;
> +}

