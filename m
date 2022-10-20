Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4660642F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJTPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJTPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:20:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C50EC51E;
        Thu, 20 Oct 2022 08:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BE91B827AE;
        Thu, 20 Oct 2022 15:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEDBC433D7;
        Thu, 20 Oct 2022 15:20:16 +0000 (UTC)
Date:   Thu, 20 Oct 2022 11:20:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
Message-ID: <20221020112020.540d3b77@gandalf.local.home>
In-Reply-To: <20221020233318.aa41f0b5bb123c87af881316@kernel.org>
References: <20221019200137.70343645@gandalf.local.home>
        <20221020233318.aa41f0b5bb123c87af881316@kernel.org>
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

On Thu, 20 Oct 2022 23:33:18 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 19 Oct 2022 20:01:37 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Allow triggers to be enabled at kernel boot up. For example:
> > 
> >   trace_trigger="sched_switch.stacktrace if prev_state == 2"
> > 
> > The above will enable the stacktrace trigger on top of the sched_switch
> > event and only trigger if its prev_state is 2 (TASK_UNINTERRUPTIBLE). Then
> > at boot up, a stacktrace will trigger and be recorded in the tracing ring
> > buffer every time the sched_switch happens where the previous state is
> > TASK_INTERRUPTIBLE.
> > 
> > As this calls into tracepoint logic during very early boot (before
> > interrupts are enabled), a check has to be done to see if early boot
> > interrupts are still disabled, and if so, avoid any call to RCU
> > synchronization, as that will enable interrupts and cause boot up issues.  
> 
> Just out of curiousity, can you do it by boot-time tracer?
> (Is it too late for your issue?)

Yeah, I'm looking at adding triggers very early. I could even add
"traceoff" trigger too here. I'm guessing that bootconf is done later in
boot up? Especially since I needed to fix RCU calls to get this working.

> 
> $ cat >> stacktrace.bconf
> ftrace.event.sched.sched_switch.actions = "stacktrace if prev_state == 2"
> ^D
> $ bootconfig -a stacktrace.bconf initrd.img
> 

Not to mention, I'm doing this for Chromebooks where it's easy to update
the command line (on dev devices), but not as easy to modify the kernel.

-- Steve
