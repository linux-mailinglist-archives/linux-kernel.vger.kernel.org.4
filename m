Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F99649292
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 06:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLKFwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 00:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiLKFwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 00:52:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4775111C0B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:52:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFE6AB80950
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B07C433D2;
        Sun, 11 Dec 2022 05:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670737938;
        bh=dU5purS73n4wE/THJMlnQt5y+u9ZRm9YWQ3uapO5Uxw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JlavB0qUQ+zVPxcMqmqpnVKenDoD2cvBtPkb+z8WdQQpjXWBqnhItxcPeJCybmMyv
         q0oOj81S6haE2JseSZyqLQLIj8rPFkYzrJaUbePrlnGg5K5o6jiPoqZ5Bhaxgpea4O
         8iQfBiUCV0D68q2ElHo1eOzFKCAtnTnniwOyO75cICPYPJvMKN4hsFpJ+eJaa4GO4Z
         /Zh7cxoBSTvCol2/JhHVWV+yhqB7bwhiu2rQmJmc1tkgwCUWqQNOVKzHLKoM0RXVIi
         azUrqxfELBYjAJUU1xn/mAGqXqB/bRGfd5rkj3fgG/72aCeGSpWBDt99wNm23Ko06d
         wxGfco5w/j1lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42ECC5C095D; Sat, 10 Dec 2022 21:52:18 -0800 (PST)
Date:   Sat, 10 Dec 2022 21:52:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH 13/25] x86/mm/kmmio: Use
 rcu_read_lock_sched_notrace()
Message-ID: <20221211055218.GH4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221210135750.425719934@goodmis.org>
 <20221210135825.241167123@goodmis.org>
 <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <20221210133425.4657985e@gandalf.local.home>
 <20221210213412.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221210173227.7063269d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210173227.7063269d@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 05:32:27PM -0500, Steven Rostedt wrote:
> On Sat, 10 Dec 2022 13:34:12 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > I was going to remove it, but then I realized that it would be a functional
> > > change, as from the comment above, it uses "preempt_enable_no_resched(),
> > > which there is not a rcu_read_unlock_sched() variant.  
> > 
> > If this happens often enough, it might be worth adding something like
> > rcu_read_unlock_sched_no_resched(), but we clearly are not there yet.
> > Especially not with a name like that!  ;-)
> 
> Please don't ;-)
> 
> This is only to handle the bizarre case that mmio tracing does. Remember,
> this tracer is only for those that want to reverse engineer a binary
> driver. It's not even SMP safe! When you enable it, it shuts down all but
> one CPU. This is actually the reason I worked so hard to keep it working
> with lockdep. The shutting down of CPUs has caught so many bugs in other
> parts of the kernel! ;-)
> 
> Thus, anything that mmio tracer does, is considered niche, and not
> something to much care about.

Agreed, as I said, we are clearly not there yet.

							Thanx, Paul
