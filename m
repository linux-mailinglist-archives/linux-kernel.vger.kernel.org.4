Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331CF64E3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiLOWjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLOWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:39:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2BF5E08B;
        Thu, 15 Dec 2022 14:39:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A773B81B25;
        Thu, 15 Dec 2022 22:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729FAC433D2;
        Thu, 15 Dec 2022 22:39:15 +0000 (UTC)
Date:   Thu, 15 Dec 2022 17:39:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter
 on boot up
Message-ID: <20221215173913.5432bfbf@gandalf.local.home>
In-Reply-To: <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
References: <20221213172429.7774f4ba@gandalf.local.home>
        <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
        <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
        <20221215100241.73a30da8@gandalf.local.home>
        <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
        <20221215135102.556ee076@gandalf.local.home>
        <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 11:01:58 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> What case?
> 
> Here is one:
> 
> o	The newly spawned init process does something that uses RCU,
> 	but is preempted while holding rcu_read_lock().
> 
> o	The boot thread, which did the preempting, waits for a grace
> 	period.  If we use rcu_scheduler_active, all is well because
> 	synchronize_rcu() will do a real run-time grace period, thus
> 	waiting for that reader.
> 
> 	But system_state has not yet been updated, so if synchronize_rcu()
> 	were instead to pay attention to that one, there might be a
> 	tragically too-short RCU grace period.

The thing is, preemption is disabled the entire time here.

That is, from:

void kthread_show_list(void);
noinline void __ref rest_init(void)
{
	struct task_struct *tsk;
	int pid;

	rcu_scheduler_starting();

through:

	system_state = SYSTEM_SCHEDULING;

	complete(&kthreadd_done);


Preemption is disabled and other CPUs have not even been started yet.

Although the might_sleep() call might schedule the kernel_init() task but
that will only block on the completion.

In other words, I don't think anything can cause any issues this early in
the boot up.

-- Steve
