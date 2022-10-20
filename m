Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD7606878
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJTSxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJTSxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD9B20C9AB;
        Thu, 20 Oct 2022 11:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBAC861CE7;
        Thu, 20 Oct 2022 18:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68463C433D6;
        Thu, 20 Oct 2022 18:53:36 +0000 (UTC)
Date:   Thu, 20 Oct 2022 14:53:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
Message-ID: <20221020145340.5feef48f@gandalf.local.home>
In-Reply-To: <20221020175512.GT5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221019200137.70343645@gandalf.local.home>
        <20221019200745.0152fc51@gandalf.local.home>
        <20221020155900.GM5600@paulmck-ThinkPad-P17-Gen-1>
        <20221020123357.0f90e823@gandalf.local.home>
        <20221020130528.5f7436c3@gandalf.local.home>
        <20221020175512.GT5600@paulmck-ThinkPad-P17-Gen-1>
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

On Thu, 20 Oct 2022 10:55:12 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > synchronize_rcu() {
> >     rcu_poll_gp_seq_start_unlocked() {
> > 	struct rcu_node *rnp = rcu_get_root();
> > 
> > 	if (rcu_init_invoked()) {
> > 		lockdep_assert_irqs_enabled();
> > 		raw_spin_lock_irq_rcu_node(rnp);
> > 	}
> > 	rcu_poll_gp_seq_start(snap);
> > 	if (rcu_init_invoked())
> > 		raw_spin_unlock_irq_rcu_node(rnp);  <<-- Interrupts enabled here
> >    }  
> 
> Thank you for digging into this!
> 
> Does the following help?

It does indeed!

I can remove the early_boot_irqs_disabled checks if you can add this to
this rc cycle and mark it stable.

-- Steve
