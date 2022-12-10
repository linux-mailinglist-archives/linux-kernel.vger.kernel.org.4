Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B581649191
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 00:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLJX4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 18:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJX4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 18:56:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D40CE19
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 15:56:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D79C60CEB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 23:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DCDC433D2;
        Sat, 10 Dec 2022 23:55:59 +0000 (UTC)
Date:   Sat, 10 Dec 2022 18:55:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH 13/25] x86/mm/kmmio: Use
 rcu_read_lock_sched_notrace()
Message-ID: <20221210185555.7abc4de4@gandalf.local.home>
In-Reply-To: <87359mdeg3.ffs@tglx>
References: <20221210135750.425719934@goodmis.org>
        <20221210135825.241167123@goodmis.org>
        <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
        <20221210133425.4657985e@gandalf.local.home>
        <87359mdeg3.ffs@tglx>
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

On Sun, 11 Dec 2022 00:30:36 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, Dec 10 2022 at 13:34, Steven Rostedt wrote:
> > On Sat, 10 Dec 2022 09:47:53 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:  
> >> This does mess with preempt_count() redundantly, but the overhead from
> >> that should be way down in the noise.  
> >
> > I was going to remove it, but then I realized that it would be a functional
> > change, as from the comment above, it uses "preempt_enable_no_resched(),
> > which there is not a rcu_read_unlock_sched() variant.  
> 
> preempt_enable_no_resched() in this context is simply garbage.
> 
> preempt_enable_no_resched() tries to avoid the overhead of checking
> whether rescheduling is due after decrementing preempt_count() because
> the code which it this claims to know that it is _not_ the outermost one
> which brings preempt count back to preemtible state.
> 
> I concede that there are hot paths which actually can benefit, but this
> code has exactly _ZERO_ benefit from that. Taking that tracing exception
> and handling it is orders of magnitudes more expensive than a regular
> preempt_enable().
> 
> So just get rid of it and don't proliferate cargo cult programming.
> 

The point of the patch is to just fix the lockdep issue. I'm happy to
remove that "no_resched" (I was planning to), but that would be a separate
change, with a different purpose, and thus a separate patch.

-- Steve

