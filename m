Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA36C1E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCTRnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCTRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:42:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEE62FCF4;
        Mon, 20 Mar 2023 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xIGBDX2EZEpc0ssKQVBXvgtW7cG0vVRXRGdmOwZy7tY=; b=tXbPP4VleH5r7CSdvSeL8/zd0i
        rT5Nl2nGvLYuZa12d2BS9tD6u4ajBZY8+4tU6DblhI+TEwj0ahJt6TmAtZq86fbJq5YajWtBSMPIC
        2mbSafqDkRx9PsZYgv8KbIL2thuVNmgC2nEEP/lu6HjjaKYJbRr4j9uVN0NPD+Sj9bcFeQ+MpK49k
        DdSmFt/klha96UIcqVPyJqFrDIKyAeaziiy/UnxjakYG1+gUFYmBGDbves3Qr3CdNY5uNiJoPYPeS
        nkla2pc+FLuw6nHZ/VxSXhbjqoNo/VPi1XlcE7/15UoxcXFXxpf0tYqiwNPzAXwaeIIHwCcaCrKlc
        hve7mxWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peJSD-001Fqg-Jt; Mon, 20 Mar 2023 17:37:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 617BB300652;
        Mon, 20 Mar 2023 18:37:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2199A240AEA49; Mon, 20 Mar 2023 18:37:51 +0100 (CET)
Date:   Mon, 20 Mar 2023 18:37:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul McKenney <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Subject: [PATCH] rcu: Remove RCU_NONIDLE()
Message-ID: <20230320173751.GU2194297@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since there are now exactly _zero_ users of RCU_NONIDLE(), make it go
away before someone else decides to (ab)use it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 .../RCU/Design/Requirements/Requirements.rst       | 36 +---------------------
 Documentation/RCU/whatisRCU.rst                    |  1 -
 include/linux/rcupdate.h                           | 25 ---------------
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
index 2c5563a91998..c3b1cbfa1530 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1117,7 +1117,6 @@ in docbook.  Here is the list, by category.
 
 	RCU_LOCKDEP_WARN
 	rcu_sleep_check
-	RCU_NONIDLE
 
 All: Unchecked RCU-protected pointer access::
 
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 094321c17e48..ddd42efc6224 100644
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
