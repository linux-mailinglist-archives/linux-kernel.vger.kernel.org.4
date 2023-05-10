Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E866FE2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjEJQ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjEJQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B67DF;
        Wed, 10 May 2023 09:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C4D963F3B;
        Wed, 10 May 2023 16:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB841C4339B;
        Wed, 10 May 2023 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737914;
        bh=DvqudYdWdeAAC6Fv9v/alqS+NZUrTSGbZqd+38O62+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbxQMV2lIShPlKpUOibNRU79u56DsG+OcHqVlC5JEv3Nj/5G/sif5bPc20LyOSxTx
         iFyGnsNO5VKyL26ZhdhvptqHTR718DbH0DUxgbw6/0ECzpuBgbmCgyQEoHhDvLbEFJ
         pgcX/PxCGB3uTc3K8SdOUA/Bu3N9Vwr95FaBcPrLRGt0Qh/9OFPzDqs9qNGxiVWxVK
         omaJ8XPmRAPmWpQ5kNPvXsLtZWu18v74M3sFJYFTjtbsw9lXnpMGbPG12j2HFL2kW0
         Ea/VhYsq+yZrFoh1sexh0ZOKx4DawQEhYUpZxp0CR2DaUHxm9/fRU5lX+imgz7FWR9
         541j+E34bcF7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8B0F2CE126D; Wed, 10 May 2023 09:58:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/8] rcu: Remove RCU_NONIDLE()
Date:   Wed, 10 May 2023 09:58:26 -0700
Message-Id: <20230510165832.2187453-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
References: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Since there are now exactly _zero_ users of RCU_NONIDLE(), make it go
away before someone else decides to (ab)use it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 36 +------------------
 Documentation/RCU/whatisRCU.rst               |  1 -
 include/linux/rcupdate.h                      | 25 -------------
 3 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 49387d823619..77155b51d4c2 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2071,41 +2071,7 @@ call.
 
 Because RCU avoids interrupting idle CPUs, it is illegal to execute an
 RCU read-side critical section on an idle CPU. (Kernels built with
-``CONFIG_PROVE_RCU=y`` will splat if you try it.) The RCU_NONIDLE()
-macro and ``_rcuidle`` event tracing is provided to work around this
-restriction. In addition, rcu_is_watching() may be used to test
-whether or not it is currently legal to run RCU read-side critical
-sections on this CPU. I learned of the need for diagnostics on the one
-hand and RCU_NONIDLE() on the other while inspecting idle-loop code.
-Steven Rostedt supplied ``_rcuidle`` event tracing, which is used quite
-heavily in the idle loop. However, there are some restrictions on the
-code placed within RCU_NONIDLE():
-
-#. Blocking is prohibited. In practice, this is not a serious
-   restriction given that idle tasks are prohibited from blocking to
-   begin with.
-#. Although nesting RCU_NONIDLE() is permitted, they cannot nest
-   indefinitely deeply. However, given that they can be nested on the
-   order of a million deep, even on 32-bit systems, this should not be a
-   serious restriction. This nesting limit would probably be reached
-   long after the compiler OOMed or the stack overflowed.
-#. Any code path that enters RCU_NONIDLE() must sequence out of that
-   same RCU_NONIDLE(). For example, the following is grossly
-   illegal:
-
-      ::
-
-	  1     RCU_NONIDLE({
-	  2       do_something();
-	  3       goto bad_idea;  /* BUG!!! */
-	  4       do_something_else();});
-	  5   bad_idea:
-
-
-   It is just as illegal to transfer control into the middle of
-   RCU_NONIDLE()'s argument. Yes, in theory, you could transfer in
-   as long as you also transferred out, but in practice you could also
-   expect to get sharply worded review comments.
+``CONFIG_PROVE_RCU=y`` will splat if you try it.) 
 
 It is similarly socially unacceptable to interrupt an ``nohz_full`` CPU
 running in userspace. RCU must therefore track ``nohz_full`` userspace
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 8eddef28d3a1..e488c8e557a9 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1117,7 +1117,6 @@ All: lockdep-checked RCU utility APIs::
 
 	RCU_LOCKDEP_WARN
 	rcu_sleep_check
-	RCU_NONIDLE
 
 All: Unchecked RCU-protected pointer access::
 
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dcd2cf1e8326..aae31a3e28dd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -156,31 +156,6 @@ static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
 static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
-/**
- * RCU_NONIDLE - Indicate idle-loop code that needs RCU readers
- * @a: Code that RCU needs to pay attention to.
- *
- * RCU read-side critical sections are forbidden in the inner idle loop,
- * that is, between the ct_idle_enter() and the ct_idle_exit() -- RCU
- * will happily ignore any such read-side critical sections.  However,
- * things like powertop need tracepoints in the inner idle loop.
- *
- * This macro provides the way out:  RCU_NONIDLE(do_something_with_RCU())
- * will tell RCU that it needs to pay attention, invoke its argument
- * (in this example, calling the do_something_with_RCU() function),
- * and then tell RCU to go back to ignoring this CPU.  It is permissible
- * to nest RCU_NONIDLE() wrappers, but not indefinitely (but the limit is
- * on the order of a million or so, even on 32-bit systems).  It is
- * not legal to block within RCU_NONIDLE(), nor is it permissible to
- * transfer control either into or out of RCU_NONIDLE()'s statement.
- */
-#define RCU_NONIDLE(a) \
-	do { \
-		ct_irq_enter_irqson(); \
-		do { a; } while (0); \
-		ct_irq_exit_irqson(); \
-	} while (0)
-
 /*
  * Note a quasi-voluntary context switch for RCU-tasks's benefit.
  * This is a macro rather than an inline function to avoid #include hell.
-- 
2.40.1

