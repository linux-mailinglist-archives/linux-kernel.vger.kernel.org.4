Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039F64E14F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiLOSvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiLOSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:51:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094621A5;
        Thu, 15 Dec 2022 10:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CD361ED6;
        Thu, 15 Dec 2022 18:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13790C433D2;
        Thu, 15 Dec 2022 18:51:03 +0000 (UTC)
Date:   Thu, 15 Dec 2022 13:51:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter
 on boot up
Message-ID: <20221215135102.556ee076@gandalf.local.home>
In-Reply-To: <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
References: <20221213172429.7774f4ba@gandalf.local.home>
        <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
        <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
        <20221215100241.73a30da8@gandalf.local.home>
        <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
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

On Thu, 15 Dec 2022 09:02:56 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, Dec 15, 2022 at 10:02:41AM -0500, Steven Rostedt wrote:
> > On Wed, 14 Dec 2022 12:03:33 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >   
> > > > > Avoid calling the synchronization function when system_state is
> > > > > SYSTEM_BOOTING.    
> > > > 
> > > > Shouldn't this be done inside tracepoint_synchronize_unregister()?
> > > > Then, it will prevent similar warnings if we expand boot time feature.    
> > > 
> > > How about the following wide-spectrum fix within RCU_LOCKDEP_WARN()?
> > > Just in case there are ever additional issues of this sort?  
> > 
> > Adding more tracing command line parameters is triggering this more. I now
> > hit:  
> 
> Fair point, and apologies for the hassle.
> 
> Any chance of getting an official "it is now late enough in boot to
> safely invoke lockdep" API?  ;-)

lockdep API isn't the problem, it's that we are still in the earlyboot stage
where interrupts are disabled, and you can't enable them. Lockdep works
just fine there, and is reporting interrupts being disabled correctly. The
backtrace reported *does* have interrupts disabled.

The thing is, because we are still running on a single CPU with interrupts
disabled, there is no need for synchronization. Even grabbing a mutex is
safe because there's guaranteed to be no contention (unless it's not
released). This is why a lot of warnings are suppressed if system_state is
SYSTEM_BOOTING.

> 
> In the meantime, does the (untested and quite crude) patch at the end
> of this message help?

I'll go and test it, but I'm guessing it will work fine. You could also test
against system_state != SYSTEM_BOOTING, as that gets cleared just before
kernel_init() can continue (it waits for the complete() that is called
after system_state is set to SYSTEM_SCHEDULING). Which happens shortly
after rcu_scheduler_starting().

I wonder if you could even replace RCU_SCHEDULER_RUNNING with
system_state != SYSTEM_BOOTING, and remove the rcu_scheduler_starting()
call.

-- Steve
