Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DBA623BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiKJGeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiKJGeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:34:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208CA2B26C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:34:20 -0800 (PST)
Date:   Thu, 10 Nov 2022 07:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668062058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syhWQQJd55H34VBVZdoUeFW6JS341n8jsFsu+Tlr1qs=;
        b=uLnVhVYLXJnFS2hCBmmaBBZOELGNnN82fsvDSO14SXBUIpsguSGOgjStLCzTMj7rU2BC7f
        Fng+mq3sfPV+vZpSo78hNxd8URvfMQpsOf9WA2Hi2v+A3FECqeV/O1DzK8PH+lEcSBq6pG
        WwZ2ZBrosOZ96lzall4SBipL25glzsSMqpUkVgccf9hxYsbIy1Wb20iYoT0apDDhz7DuQN
        zAVz2yNq0nRzw0vGXkH5gg4y2C4e6kdRR5ZIotOVunIs8d6JV5EDEC7XrAz71yEH3uNFZe
        sGWbyjyXRZ83nNWNLHA890BQROp/ZwC8txngqwDGAx/4E+ycMLqk6BAE+AjNiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668062058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syhWQQJd55H34VBVZdoUeFW6JS341n8jsFsu+Tlr1qs=;
        b=0EvMXDIcR+mpwBdpD0I7DyjASCcVfMsxBds/WVHLXnlusHd/1v37h1x49HmDEtMrPHaJ6w
        j8G9V1UWmcGnNBCA==
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
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 14/16] timer: Implement the hierarchical pull model
In-Reply-To: <20221109163941.GC298683@lothringen>
Message-ID: <a1e17785-8a8b-2d42-bc66-73d8e263b9b@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de> <20221104145737.71236-15-anna-maria@linutronix.de> <20221109163941.GC298683@lothringen>
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

On Wed, 9 Nov 2022, Frederic Weisbecker wrote:

> On Fri, Nov 04, 2022 at 03:57:35PM +0100, Anna-Maria Behnsen wrote:
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index f8b2065df79b..214397d84747 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -53,6 +53,7 @@
> >  #include <asm/io.h>
> >  
> >  #include "tick-internal.h"
> > +#include "timer_migration.h"
> >  
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/timer.h>
> > @@ -592,10 +593,13 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
> >  
> >  	/*
> >  	 * We might have to IPI the remote CPU if the base is idle and the
> > -	 * timer is not deferrable. If the other CPU is on the way to idle
> > -	 * then it can't set base->is_idle as we hold the base lock:
> > +	 * timer is pinned. If it is a non pinned timer, it is only queued
> > +	 * on the remote CPU, when timer was running during queueing. Then
> > +	 * everything is handled by remote CPU anyway.
> > +	 * on the way to idle then it can't set base->is_idle as we hold
> > +	 * the base lock:
> >  	 */
> > -	if (base->is_idle)
> > +	if (base->is_idle && timer->flags & TIMER_PINNED)
> >  		wake_up_nohz_cpu(base->cpu);
> 
> I'm probably missing something but, shouldn't there be a call to
> tmigr_new_timer() on the target to handle the new non-pinned timer?
> 

We need to keep the original way right now. This TIMER_PINNED condition is
valid only when enqueue on local CPU is in place.
