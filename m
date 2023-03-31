Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90AD6D27F8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjCaSj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjCaSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7B20C12;
        Fri, 31 Mar 2023 11:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50EE962B10;
        Fri, 31 Mar 2023 18:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02A2C4339E;
        Fri, 31 Mar 2023 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680287956;
        bh=acVPnBMJt0hUCMkiZhSY7H0emae9RIGRERfPiV5sZ+0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FMXD1DHWft8HrouqOCBFSlxsCMSfkcTY6f2OslWcu6rkAP3bTxvnq9gLLI61+Q0YY
         ex7XZiEnNRDEOPcHgJm11EdihBJKAlLIGwDDzxhJflK7eHZR9oFFvd8qoWvfQ8EONa
         qHj+sYf5LZnZa/O7OsmHwfp6hT+IJlpZSKbyDiSGG9HtCqOALAccdatVp2tIV9hlK1
         rQJS4N04mWRUPTWmrjVNYbzHJ0q/FJjOjmEv4QL/hHxM3MhZR/5+S2qNAmYrcPbGey
         yXepH0C8C2PuKdUtjPvIczSpgZZd/dlvqdCKozDH8ALLgEtfLjbPYfrvWjRgXRzBqy
         KBr4jR8v+FquA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 47ED41540476; Fri, 31 Mar 2023 11:39:16 -0700 (PDT)
Date:   Fri, 31 Mar 2023 11:39:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, RCU <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <fcbeabc5-4951-4339-b056-91e9c3921074@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ca153af5-bd66-4d48-afa5-ace3a13aec3c@paulmck-laptop>
 <FC49F388-0480-4687-8DD3-94049FCBC92B@joelfernandes.org>
 <2cd8f407-2b77-48b1-9f17-9aa8e4ce9c64@paulmck-laptop>
 <20230330150933.GB2114899@google.com>
 <ZCWuE+b+QDApqgWG@pc636>
 <f529af35-557a-4a19-b14d-295e88aace9c@paulmck-laptop>
 <ZCXglNnT9EpeBf4t@pc636>
 <d4d42909-bf1b-45a8-8ef1-e4a1fc8cb742@paulmck-laptop>
 <ZCa8KB7Os9yJWz3P@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCa8KB7Os9yJWz3P@pc636>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 12:55:36PM +0200, Uladzislau Rezki wrote:
> On Thu, Mar 30, 2023 at 02:16:36PM -0700, Paul E. McKenney wrote:
> > On Thu, Mar 30, 2023 at 09:18:44PM +0200, Uladzislau Rezki wrote:
> > > On Thu, Mar 30, 2023 at 11:58:41AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Mar 30, 2023 at 05:43:15PM +0200, Uladzislau Rezki wrote:
> > > > > On Thu, Mar 30, 2023 at 03:09:33PM +0000, Joel Fernandes wrote:
> > > > > > On Tue, Mar 28, 2023 at 08:26:13AM -0700, Paul E. McKenney wrote:
> > > > > > > On Mon, Mar 27, 2023 at 10:29:31PM -0400, Joel Fernandes wrote:
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > > On Mar 27, 2023, at 9:06 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > > 
> > > > > > > > > ﻿On Mon, Mar 27, 2023 at 11:21:23AM +0000, Zhang, Qiang1 wrote:
> > > > > > > > >>>> From: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > > >>>> Sent: Tuesday, March 21, 2023 6:28 PM
> > > > > > > > >>>> [...]
> > > > > > > > >>>> Subject: [PATCH 1/1] Reduce synchronize_rcu() waiting time
> > > > > > > > >>>> 
> > > > > > > > >>>> A call to a synchronize_rcu() can be expensive from time point of view.
> > > > > > > > >>>> Different workloads can be affected by this especially the ones which use this
> > > > > > > > >>>> API in its time critical sections.
> > > > > > > > >>>> 
> > > > > > > > >>> 
> > > > > > > > >>> This is interesting and meaningful research. ;-)
> > > > > > > > >>> 
> > > > > > > > >>>> For example in case of NOCB scenario the wakeme_after_rcu() callback
> > > > > > > > >>>> invocation depends on where in a nocb-list it is located. Below is an example
> > > > > > > > >>>> when it was the last out of ~3600 callbacks:
> > > > > > > > >>> 
> > > > > > > > >> 
> > > > > > > > >> 
> > > > > > > > >> 
> > > > > > > > >> Can it be implemented separately as follows?  it seems that the code is simpler
> > > > > > > > >> (only personal opinion)  😊.
> > > > > > > > >> 
> > > > > > > > >> But I didn't test whether this reduce synchronize_rcu() waiting time
> > > > > > > > >> 
> > > > > > > > >> +static void rcu_poll_wait_gp(struct rcu_tasks *rtp)
> > > > > > > > >> +{
> > > > > > > > >> +       unsigned long gp_snap;
> > > > > > > > >> +
> > > > > > > > >> +       gp_snap = start_poll_synchronize_rcu();
> > > > > > > > >> +       while (!poll_state_synchronize_rcu(gp_snap))
> > > > > > > > >> +               schedule_timeout_idle(1);
> > > > > > > > > 
> > > > > > > > > I could be wrong, but my guess is that the guys working with
> > > > > > > > > battery-powered devices are not going to be very happy with this loop.
> > > > > > > > > 
> > > > > > > > > All those wakeups by all tasks waiting for a grace period end up
> > > > > > > > > consuming a surprisingly large amount of energy.
> > > > > > > > 
> > > > > > > > Is that really the common case? On the general topic of wake-ups:
> > > > > > > > Most of the time there should be only one
> > > > > > > > task waiting synchronously on a GP to end. If that is
> > > > > > > > true, then it feels like waking
> > > > > > > > up nocb Kthreads which indirectly wake other threads is doing more work than usual?
> > > > > > > 
> > > > > > > A good question, and the number of outstanding synchronize_rcu()
> > > > > > > calls will of course be limited by the number of tasks in the system.
> > > > > > > But I myself have raised the ire of battery-powered embedded folks with
> > > > > > > a rather small number of wakeups, so...
> > > > > > 
> > > > > > But unless I am missing something, even if there is single synchronize_rcu(),
> > > > > > you have a flurry of potential wakeups right now, instead of the bare minimum
> > > > > > I think. I have not measured how many wake ups, but I'd love to when I get
> > > > > > time. Maybe Vlad has some numbers.
> > > > > > 
> > > > > I will measure and have a look at wake-ups. But, what we have for now is
> > > > > if there are two callers of synchronize_rcu() on different CPUs, i guess
> > > > > two nocb-kthreads have to handle it, thus two nocb-kthreads have to be
> > > > > awaken to do the work. This patch needs only one wake-up to serve all
> > > > > users.
> > > > 
> > > > One wakeup per synchronize_rcu(), right?
> > > > 
> > > The gp-kthread wake-ups only one work, in its turn a worker wake-ups all
> > > registered users of synchronize_rcu() for which a gp was passed. How many
> > > users of synchonize_rcu() awaken by one worker depends on how many were
> > > registered before initiating a new GP by the gp-kthread.
> > > 
> > > > > Anyway, i will provide some data and analysis of it.
> > > > 
> > > > Looking forward to seeing it!
> > > > 
> > > Good. I will switch fully on it soon. I need to sort out some perf.
> > > issues at work.
> > 
> > And if you are looking for reduced wakeups instead of lower latency for
> > synchronize_rcu(), I could see where the extra workqueue wakeup might
> > be a problem for you.
> > 
> > Assuming that this is all default-off, you could keep a count of the
> > number of required wakeups for each grace period (indexed as usual by
> > the bottom few bits of the grace-period counter without the low-order
> > state bits), and do the wakeups directly from the grace-period kthread
> > if there are not all that many of them.
> > 
> At least if there is only one user of synchronize_rcu(), we can wake
> it directly, i mean to invoke comlete() from the gp-kthread. I think
> we should split such parts into different patches.

Agreed, especially given that some experimentation will be required
to work out which techniques actually help.

> > Except that, given that workqueues try hard to make the handler be on the
> > same CPU as the one that did the corresponding schedule_work() invocation,
> > it is not clear that this particular wakeup is really costing you enough
> > to notice.  (That CPU is not idle, after all.)  But there is nothing
> > quite like measuring the actual energy consumption on real hardware!
> > 
> AFAICR the schedule_work() wants to use current CPU, indeed. For few
> users it might be OK to comlete() them directly. Energy wise, +1 wake-up
> of our worker to kick all users, if not "direct" option. I do not think
> energy is a problem here.

Agreed, estimating/modeling energy consumption is as far as I know still
is more of an art than a science.  I did something like eight or nine
rewrites of the old NO_HZ_FULL code learning that one.  ;-)

							Thanx, Paul
