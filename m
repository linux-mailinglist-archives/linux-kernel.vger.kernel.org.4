Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6427E7048DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjEPJRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjEPJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:16:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C91720
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E90636B2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2ADC433D2;
        Tue, 16 May 2023 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684228532;
        bh=U6y3925vAkGSTn35sRSDGfUP0WGwMaGFa9+WDRyDGYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKdnaR7prRfXN3CcQ3sPI5JcWTQg+MdRsUK/nnCtwy4crSz7qKEgLCg2FlD3CSpvd
         PHHVgQy57MpvI2o37ij0FhyAkEBlqjw7guK02cTWAGR4tYfjBVemVw9GdlyO4Y82LL
         RhpRPcRSwxo/sivGoVPpXwvR/RdKZ+SeFAt6myh+yR+3+9G3DkwW+5/kiKm0vdtW9f
         KzUTt6xR+jI1204+tcfPngSWf6FzjLnUFEzO/fHE+ClfP9UzM1WPauwmS8AYI3HFa0
         6WM/hu4+yYmk5XmA9do1O+GnatoVN29GsciZuSsvZ6kQixWIjnJn6Kn1bQu3V6jgiG
         6o++Z3VFTAmUQ==
Date:   Tue, 16 May 2023 11:15:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
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
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
Message-ID: <ZGNJq_ZITmZ5YciL@localhost.localdomain>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-20-anna-maria@linutronix.de>
 <ZFty1fNMlnuLk4qF@localhost.localdomain>
 <20230515101936.3amAvw0T@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515101936.3amAvw0T@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, May 15, 2023 at 12:19:36PM +0200, Sebastian Siewior a écrit :
> On 2023-05-10 12:32:53 [+0200], Frederic Weisbecker wrote:
> > In the case of !PREEMPT_RT, I suppose it's impossible for the target
> > CPU to be offline. You checked above tmc->online and in-between the
> > call to timer_lock_remote_bases(), the path is BH-disabled, this prevents
> > stop_machine from running and from setting the CPU as offline.
> 
> I think you refer to the last one invoked from takedown_cpu(). This does
> not matter, see below.
> 
> What bothers me is that _current_ CPU is check for cpu_is_offline() and
> not the variable 'cpu'. Before the check timer_expire_remote() is
> invoked on 'cpu' and not on current.

Oh right!

> 
> > However in PREEMPT_RT, ksoftirqd (or timersd) is preemptible, so it seems
> > that it could happen in theory. And that could create a locking imbalance.
> 
> The ksoftirqd thread is part of smpboot_park_threads(). They have to
> stop running and clean up before the machinery continues bringing down
> the CPU (that is before takedown_cpu()). On the way down we have:
> - tmigr_cpu_offline() followed by
> - smpboot_park_threads().
> 
> So ksoftirqd (preempted or not) finishes before. This is for the
> _target_ CPU.

Ok I forgot about the smpboot cleanup part.

> 
> After the "tmc->online" check the lock is dropped and this is invoked
> from run_timer_softirq(). That means that _this_ CPU could get preempted
> (by an IRQ for instance) at this point, and once the CPU gets back here,
> the remote CPU (as specified in `cpu') can already be offline by the
> time timer_lock_remote_bases() is invoked.
> 
> So RT or not, this is racy.

Well, all CPUs must schedule to stop machine on take_cpu_down().

So:

  //CPU 1                            //CPU 2
  softirq()
     tmigr_handle_remote_cpu()
        LOCK(tmc->lock)
           if (!tmc->online)
              UNLOCK(tmc->lock)
              return;
                                     cpu_down()
                                        tmigr_cpu_offline()
                                           LOCK(tmc->lock)
                                           tmc->online = 0
                                           UNLOCK(tmc->lock)
                                        stop_machine()
                                           //wait for CPU 1  
                                           poll on MULTI_STOP_PREPARE
        if (cpu_is_offline(2))
           //not possible
   //end of softirq
   stop_machine()
                                           set MULTI_STOP_PREPARE
                                           ...
                                           set_cpu_online(0)


Things should be fine on !RT but I may easily be missing something.

As for RT it should be fine as well as you pointed out since CPU 1
can be preempted but the CPU still needs to park the kthreads before joining
the stop machine party.

> 
> > My suggestion would be to unconditionally lock the bases, you already checked if
> > !tmc->online before. The remote CPU may have gone down since then because the
> > tmc lock has been relaxed but it should be rare enough that you don't care
> > about optimizing with a lockless check. So you can just lock the bases,
> > lock the tmc and check again if tmc->online. If not then you can just ignore
> > the tmigr_new_timer_up call and propagation.
> 
> Regardless the previous point, this still looks odd as you pointed out.
> The return code is ignored and the two functions perform lock + unlock
> depending on it.

Agreed!
