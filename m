Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47D66139EE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiJaPWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiJaPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:22:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FADC11803;
        Mon, 31 Oct 2022 08:22:37 -0700 (PDT)
Date:   Mon, 31 Oct 2022 16:22:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667229755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfgV6mGS26skLphn6hioeVNQQARpNHg2LEwEcY6JCWk=;
        b=ttPlZw30ReFKM4Fq/UqmtOecjidGo55rrXy1DTsPutOc94LHYAZkwz6OdwAY+BL5Sx3X6e
        N+SlsYp7c6hoJw5cIqsgvrJu0bOOdYXxjhH0rLQ9dIU3D1oDuXTRjp7sqyGpl1dV079I08
        wjdpIotyTtnpDTmXz6pRYwkYnPhZdoJMsn+lG7zP8Z4jCnFfp7lSD3IpJVzVS37A5Jlnou
        Rr1z9PaTmx2UnqMno00obhr3a1Uf10hagCktj2W4N8L56VtAwySkLmU5V/r2qrn56FiOkT
        SShpnHSpxzPnDY2vbtlpmjMNF3/mjM0l941KVKCkH62Bemiud2PSXkYEr+x+4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667229755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfgV6mGS26skLphn6hioeVNQQARpNHg2LEwEcY6JCWk=;
        b=INLp3IinyZOrHN20dbK5JioVNwe8LkOV4Lq4rHokGCqbFFXkP6tJgz1hGlE2oEiTuZ5Ly6
        1tDaX5Xsy5Yfu7CA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 01/17] cpufreq: Prepare timer flags for hierarchical
 timer pull model
In-Reply-To: <20221026135423.GA1329996@lothringen>
Message-ID: <cb54d934-bef7-cc21-308b-e25aaeb63d94@linutronix.de>
References: <20221025135850.51044-1-anna-maria@linutronix.de> <20221025135850.51044-2-anna-maria@linutronix.de> <20221026135423.GA1329996@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022, Frederic Weisbecker wrote:

> On Tue, Oct 25, 2022 at 03:58:34PM +0200, Anna-Maria Behnsen wrote:
> > Note: This is a proposal only. I was waiting on input how to change this
> > driver properly to use the already existing infrastructure. See therfore
> > the thread on linux-pm mailinglist:
> > https://lore.kernel.org/linux-pm/4c99f34b-40f1-e6cc-2669-7854b615b5fd@linutronix.de/
> > 
> > gpstates timer is the only timer using TIMER_PINNED and TIMER_DEFERRABLE
> > flag. When moving to hierarchical timer pull model, pinned and deferrable
> > timers are stored in separate bases.
> > 
> > To ensure gpstates timer always expires on the CPU where it is pinned to,
> > keep only TIMER_PINNED flag and drop TIMER_DEFERRABLE flag.
> 
> OTOH there are deferrable timers out there that expect to run on a
> specific CPU, because there are always queued with add_timer_on().
> 
> For example workqueues using DECLARE_DEFERRABLE_WORK() that are queued
> with queue_delayed_work_on(). Like vmstat().
> 
> Those are not explicitely pinned because they don't rely on __mod_timer()
> but they expect CPU affinity.
> 

You are right. In contrast to the original plan, I'm not able (yet) to
remove the deferrable timers completely. But all timers using the
add_timer_on() path need the TIMER_PINNED flag. Then three timer bases per
CPU will be available:

- global base (TIMER_PINNED is not set)
- local base (TIMER_PINNED is set but not TIMER_DEFERRABLE)
- deferrable pinned base (TIMER_PINNED and TIMER_DEFERRABLE is set)

The logic stays the same as already implemented in patch queue: Timers in
global base will not prevent CPU from going idle. When the CPU has the
migrator duty, timers in hierarchy are taken into account. Timers in local
base force the CPU to wake up. Timers in the deferrable pinned base are not
taken into account when going idle.

With this, the rework of cpufreq driver is no longer required - the timer
will end up in deferrable pinned base the same with vmstat.

Thanks,

	Anna-Maria




