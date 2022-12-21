Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC6653772
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiLUUQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiLUUQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:16:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C5CBDE;
        Wed, 21 Dec 2022 12:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3679961926;
        Wed, 21 Dec 2022 20:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ED4C433D2;
        Wed, 21 Dec 2022 20:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671653794;
        bh=hg2Kn9h2HBlKWh0BcTWlEi5gwHmpS1nBQDmwTLKHBcQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aN6NkNgmUlJRWyexy7G/rLGPauYIOmxbia55zJCognHglSuZUlBaJZeA9WqD2xxP6
         noHNbQnG66pkJzglrEOZGuztVkMJBeFt4wSOai/Xto931au9FrZVL4wex1R5PgyK1v
         IJwXSNmy3Hpap64eIZw4K8bSSKEg5ZNHAS8F+JVrmlJccNB0FoTQSGqTvlkSIMNWog
         51z6H2eLv4hGK/Y01ZaNSXWCm7UqmismF1BDaRImAIJymfJP396ntfY6Ri8cWxK6ld
         /TIAdP2wdOGUNYpkDnWI1Mg4QynWf388o0Vj4sOfGHJDssc0yhCWFhJYdFio2F9dRV
         wlohh9saZ0yAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2C9F15C12EC; Wed, 21 Dec 2022 12:16:34 -0800 (PST)
Date:   Wed, 21 Dec 2022 12:16:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Message-ID: <20221221201634.GH4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220141625.3612085-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220141625.3612085-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:16:25PM +0800, Zqiang wrote:
> This commit add TICK_DEP_MASK_RCU_EXP dependency check in
> check_tick_dependency(), fix commit df1e849ae4559 ("rcu: Enable
> tick for nohz_full CPUs slow to provide expedited QS").
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Again, good eyes, thank you!!!

I have queued this for further review and testing, given that it affects
pretty much only RCU.  However, if someone else would rather take it:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

------------------------------------------------------------------------

commit f22caef6cda5ed19a55ec2e703f60f1fa85e52bc
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Dec 20 22:16:25 2022 +0800

    rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
    
    This commit adds checks for the TICK_DEP_MASK_RCU_EXP bit, thus enabling
    RCU expedited grace periods to actually force-enable scheduling-clock
    interrupts on holdout CPUs.
    
    Fixes: df1e849ae455 ("rcu: Enable tick for nohz_full CPUs slow to provide expedited QS")
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 2e713a7d9aa3a..3e8619c72f774 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -371,7 +371,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
 		tick_dep_name(CLOCK_UNSTABLE)		\
-		tick_dep_name_end(RCU)
+		tick_dep_name(RCU)			\
+		tick_dep_name_end(RCU_EXP)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946f..ba2ac1469d473 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -281,6 +281,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU_EXP) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		return true;
+	}
+
 	return false;
 }
 
