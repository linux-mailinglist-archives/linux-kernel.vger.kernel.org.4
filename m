Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE364D0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLNUMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLNULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:11:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D132DA95;
        Wed, 14 Dec 2022 12:03:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46ABF61BAD;
        Wed, 14 Dec 2022 20:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34F4C433D2;
        Wed, 14 Dec 2022 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671048213;
        bh=LuM96yeF21ctL5PzTyNsYuJ6k4tHYP8q+wx7BHmFcdk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c3icnLPQAeY1jmKGVq91T6iqzw1+BhkD1afHRVn6fbnN3jJvMQc4E/Lm+XpkAwqQy
         tiFu3+PUjjI+NTX82EMlk3efSkEmljNEiwNK2qdOw02rBFGY5zR7p8ZrUJAwnfuuTT
         sOteQqZpvBY58q5SidnQmQ1ZBQDICVzR0wGIVquNlu2rySpyOsKzHn9YGzQ9wcc+ft
         px/zdTVrn9/2wzsJFqTWYF1OUrnQb/xw5p56y6BxwNR5rnqI5wubGwvXbWMO5GWXMB
         HR4mfMyFEqzr8ukkowxIrJFdLP6swg+nkcL/YR8/uR/Y/JK81wPDiL8KgBq6eFo3zU
         bAHLZh6mlbsdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42BA85C0A6A; Wed, 14 Dec 2022 12:03:33 -0800 (PST)
Date:   Wed, 14 Dec 2022 12:03:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221213172429.7774f4ba@gandalf.local.home>
 <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 08:49:54AM +0900, Masami Hiramatsu wrote:
> On Tue, 13 Dec 2022 17:24:29 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > If a trigger filter on the kernel command line fails to apply (due to
> > syntax error), it will be freed. The freeing will call
> > tracepoint_synchronize_unregister(), but this is not needed during early
> > boot up, and will even trigger a lockdep splat.
> > 
> > Avoid calling the synchronization function when system_state is
> > SYSTEM_BOOTING.
> 
> Shouldn't this be done inside tracepoint_synchronize_unregister()?
> Then, it will prevent similar warnings if we expand boot time feature.

How about the following wide-spectrum fix within RCU_LOCKDEP_WARN()?
Just in case there are ever additional issues of this sort?

							Thanx, Paul

------------------------------------------------------------------------

commit d493ffca2df6c1963bd1d7b8f8c652a172f095ae
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Dec 14 11:41:44 2022 -0800

    rcu: Make RCU_LOCKDEP_WARN() avoid early lockdep checks
    
    Currently, RCU_LOCKDEP_WARN() checks the condition before checking
    to see if lockdep is still enabled.  This is necessary to avoid the
    false-positive splats fixed by commit 3066820034b5dd ("rcu: Reject
    RCU_LOCKDEP_WARN() false positives").  However, the current state can
    result in false-positive splats during early boot before lockdep is fully
    initialized.  This commit therefore checks debug_lockdep_rcu_enabled()
    both before and after checking the condition, thus avoiding both sets
    of false-positive error reports.
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Boqun Feng <boqun.feng@gmail.com>
    Cc: Matthew Wilcox <willy@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index aa1b1c3546d7a..1aec1d53b0c91 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -364,11 +364,18 @@ static inline int debug_lockdep_rcu_enabled(void)
  * RCU_LOCKDEP_WARN - emit lockdep splat if specified condition is met
  * @c: condition to check
  * @s: informative message
+ *
+ * This checks debug_lockdep_rcu_enabled() before checking (c) to
+ * prevent early boot splats due to lockdep not yet being initialized,
+ * and rechecks it after checking (c) to prevent false-positive splats
+ * due to races with lockdep being disabled.  See commit 3066820034b5dd
+ * ("rcu: Reject RCU_LOCKDEP_WARN() false positives") for more detail.
  */
 #define RCU_LOCKDEP_WARN(c, s)						\
 	do {								\
 		static bool __section(".data.unlikely") __warned;	\
-		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
+		if (debug_lockdep_rcu_enabled() && (c) &&		\
+		    debug_lockdep_rcu_enabled() && !__warned) {		\
 			__warned = true;				\
 			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
 		}							\
