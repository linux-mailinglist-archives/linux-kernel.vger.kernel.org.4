Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5564E485
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLOXKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLOXKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:10:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C52497A;
        Thu, 15 Dec 2022 15:10:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B772B81CD8;
        Thu, 15 Dec 2022 23:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E139CC433F0;
        Thu, 15 Dec 2022 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671145827;
        bh=9ET6dNSpK/yx9s+5+oLBMdonkIl0n5X4rrrQmmt7Xn0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ITQjdzH/0Nnmg79x4+7uU48x4NCzVodMPKsOclWFAwg/Tuvb/FNeiBGBG349RCecj
         SICT2hINGuJMKQj3tEDmlmLL4gT31y/QsP8tI75BHZqQMue1yd/VMVzUcFs01FM3X0
         l4GWSaUIu6G6MPOr1GMxfvHX5trWNRlhM9EjXiQGDdSUhIqs+dMEsUg0hAHrpq8ran
         hp1qEFJohLnc5RQSqIUzyKRImyv7DjM1XNtItCtkrxYZKno2jPS/UOBbM0YmOzxVeb
         cro6OkJprMFXUp5OuHq5uhg5N+RGnxxmqKa+BmCYt2xQ6okfUse0ieNorrStqajBlY
         DfkfKyiBVxeLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 82CFB5C1C5B; Thu, 15 Dec 2022 15:10:27 -0800 (PST)
Date:   Thu, 15 Dec 2022 15:10:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221215231027.GS4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221213172429.7774f4ba@gandalf.local.home>
 <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
 <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
 <20221215100241.73a30da8@gandalf.local.home>
 <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215135102.556ee076@gandalf.local.home>
 <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215173913.5432bfbf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215173913.5432bfbf@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:39:13PM -0500, Steven Rostedt wrote:
> On Thu, 15 Dec 2022 11:01:58 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > What case?
> > 
> > Here is one:
> > 
> > o	The newly spawned init process does something that uses RCU,
> > 	but is preempted while holding rcu_read_lock().
> > 
> > o	The boot thread, which did the preempting, waits for a grace
> > 	period.  If we use rcu_scheduler_active, all is well because
> > 	synchronize_rcu() will do a real run-time grace period, thus
> > 	waiting for that reader.
> > 
> > 	But system_state has not yet been updated, so if synchronize_rcu()
> > 	were instead to pay attention to that one, there might be a
> > 	tragically too-short RCU grace period.
> 
> The thing is, preemption is disabled the entire time here.
> 
> That is, from:
> 
> void kthread_show_list(void);
> noinline void __ref rest_init(void)
> {
> 	struct task_struct *tsk;
> 	int pid;
> 
> 	rcu_scheduler_starting();
> 
> through:
> 
> 	system_state = SYSTEM_SCHEDULING;
> 
> 	complete(&kthreadd_done);
> 
> 
> Preemption is disabled and other CPUs have not even been started yet.
> 
> Although the might_sleep() call might schedule the kernel_init() task but
> that will only block on the completion.
> 
> In other words, I don't think anything can cause any issues this early in
> the boot up.

The nice thing about the current placement of rcu_scheduler_starting()
is that there is not yet any other task to switch to.  ;-)

							Thanx, Paul
