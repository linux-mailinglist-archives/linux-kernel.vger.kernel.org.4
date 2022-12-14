Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DCC64D1C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLNV1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiLNV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:26:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959D45ED6;
        Wed, 14 Dec 2022 13:26:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD560B81A28;
        Wed, 14 Dec 2022 21:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6028FC433EF;
        Wed, 14 Dec 2022 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671053167;
        bh=9bxuldjOZDge1l8qF4FsbF9QWJX/VFO2OFQjNAhKpSM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WmMAG4Tj6i5IRFeuUxs7ws2mtGB45Wy3/+5ieJVY/duVv8UBVUR7wvHA2RcRsol0t
         WUhiowk6PEx0P//1qbpzERhRfwVCwpLFrf3reRSvBeEQC83IWrTECplcR28tdtSo+z
         3Y325FisoUMDHgKF8fOuQQPtb+bXVIPZYqtm74VxX1J7iDikK8oOOkEEbXa3Tte/Xk
         vrGwf4iZO7wa2PszDREa7MeQ6vLjcQ4QdlHGkZJYnzY4H6+H6EtiIZj37u0aXbQhLR
         enzBqXIefb5YjybESGJ1cscqlz+sS0IX+/58HKe42L6OUtUk2FeCvs0ZNAdpBYIlvO
         9hdw7Om/KtS+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E2845C0A6A; Wed, 14 Dec 2022 13:26:07 -0800 (PST)
Date:   Wed, 14 Dec 2022 13:26:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221214212607.GB4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221213172429.7774f4ba@gandalf.local.home>
 <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
 <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
 <f36375fb-fdd2-4be6-3d74-5137533b6264@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36375fb-fdd2-4be6-3d74-5137533b6264@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:37:13PM -0500, Mathieu Desnoyers wrote:
> On 2022-12-14 15:03, Paul E. McKenney wrote:
> > On Wed, Dec 14, 2022 at 08:49:54AM +0900, Masami Hiramatsu wrote:
> > > On Tue, 13 Dec 2022 17:24:29 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > > 
> > > > If a trigger filter on the kernel command line fails to apply (due to
> > > > syntax error), it will be freed. The freeing will call
> > > > tracepoint_synchronize_unregister(), but this is not needed during early
> > > > boot up, and will even trigger a lockdep splat.
> > > > 
> > > > Avoid calling the synchronization function when system_state is
> > > > SYSTEM_BOOTING.
> > > 
> > > Shouldn't this be done inside tracepoint_synchronize_unregister()?
> > > Then, it will prevent similar warnings if we expand boot time feature.
> > 
> > How about the following wide-spectrum fix within RCU_LOCKDEP_WARN()?
> > Just in case there are ever additional issues of this sort?
> 
> Hi Paul,
> 
> Your approach makes sense. Thanks for looking into this.
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thank you, I will apply this on my next rebase.

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > commit d493ffca2df6c1963bd1d7b8f8c652a172f095ae
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Wed Dec 14 11:41:44 2022 -0800
> > 
> >      rcu: Make RCU_LOCKDEP_WARN() avoid early lockdep checks
> >      Currently, RCU_LOCKDEP_WARN() checks the condition before checking
> >      to see if lockdep is still enabled.  This is necessary to avoid the
> >      false-positive splats fixed by commit 3066820034b5dd ("rcu: Reject
> >      RCU_LOCKDEP_WARN() false positives").  However, the current state can
> >      result in false-positive splats during early boot before lockdep is fully
> >      initialized.  This commit therefore checks debug_lockdep_rcu_enabled()
> >      both before and after checking the condition, thus avoiding both sets
> >      of false-positive error reports.
> >      Reported-by: Steven Rostedt <rostedt@goodmis.org>
> >      Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >      Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >      Cc: Boqun Feng <boqun.feng@gmail.com>
> >      Cc: Matthew Wilcox <willy@infradead.org>
> >      Cc: Thomas Gleixner <tglx@linutronix.de>
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index aa1b1c3546d7a..1aec1d53b0c91 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -364,11 +364,18 @@ static inline int debug_lockdep_rcu_enabled(void)
> >    * RCU_LOCKDEP_WARN - emit lockdep splat if specified condition is met
> >    * @c: condition to check
> >    * @s: informative message
> > + *
> > + * This checks debug_lockdep_rcu_enabled() before checking (c) to
> > + * prevent early boot splats due to lockdep not yet being initialized,
> > + * and rechecks it after checking (c) to prevent false-positive splats
> > + * due to races with lockdep being disabled.  See commit 3066820034b5dd
> > + * ("rcu: Reject RCU_LOCKDEP_WARN() false positives") for more detail.
> >    */
> >   #define RCU_LOCKDEP_WARN(c, s)						\
> >   	do {								\
> >   		static bool __section(".data.unlikely") __warned;	\
> > -		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
> > +		if (debug_lockdep_rcu_enabled() && (c) &&		\
> > +		    debug_lockdep_rcu_enabled() && !__warned) {		\
> >   			__warned = true;				\
> >   			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
> >   		}							\
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
