Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB3365E14E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbjAEALI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbjAEAKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BB843A37;
        Wed,  4 Jan 2023 16:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14DA7B81985;
        Thu,  5 Jan 2023 00:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E43C433A1;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=IqhCvimGfZ6hCH77O9U7PJxJALGcr3RAART03cZb3mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOJumSyHIUQLJHJH8yAGISoWY3aVL31iHDHdYPe1G5fcVVIkI+dmUweZGgjAqjTdM
         l6oFc/DTvPx1DE1GszgTuRH2K2hLKgrCcxaUrRMJEngB3EWHS8eaF+/XhwR1WROQTB
         wZ8LGjpDAEt9mg9VMq/I5gFlisDaxwMJCyaiIYaznH6n1sd8LDu09V9GT0gRXIc/jN
         YLHseN62xSBFcJPu+D+XY4PBKSStSVPw+qzPR3ltzJNJp9h991yErAJYLs2AWYcagF
         IAnj+5y8oKCJtDCkLWOOVNbtKS0h4mHViaTu/opXeH/H+BS0TkCipxU74y9O2QSy35
         10IfXarPBv3Qg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CF7085C1AE0; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/15] doc: Update stallwarn.rst
Date:   Wed,  4 Jan 2023 16:09:47 -0800
Message-Id: <20230105000955.1767218-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates stallwarn.rst to reflect RCU additions and changes
over the past few years.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 43 +++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index e38c587067fc8..dfa4db8c0931e 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -25,10 +25,10 @@ warnings:
 
 -	A CPU looping with bottom halves disabled.
 
--	For !CONFIG_PREEMPTION kernels, a CPU looping anywhere in the kernel
-	without invoking schedule().  If the looping in the kernel is
-	really expected and desirable behavior, you might need to add
-	some calls to cond_resched().
+-	For !CONFIG_PREEMPTION kernels, a CPU looping anywhere in the
+	kernel without potentially invoking schedule().  If the looping
+	in the kernel is really expected and desirable behavior, you
+	might need to add some calls to cond_resched().
 
 -	Booting Linux using a console connection that is too slow to
 	keep up with the boot-time console-message rate.  For example,
@@ -108,16 +108,17 @@ warnings:
 
 -	A bug in the RCU implementation.
 
--	A hardware failure.  This is quite unlikely, but has occurred
-	at least once in real life.  A CPU failed in a running system,
-	becoming unresponsive, but not causing an immediate crash.
-	This resulted in a series of RCU CPU stall warnings, eventually
-	leading the realization that the CPU had failed.
+-	A hardware failure.  This is quite unlikely, but is not at all
+	uncommon in large datacenter.  In one memorable case some decades
+	back, a CPU failed in a running system, becoming unresponsive,
+	but not causing an immediate crash.  This resulted in a series
+	of RCU CPU stall warnings, eventually leading the realization
+	that the CPU had failed.
 
-The RCU, RCU-sched, and RCU-tasks implementations have CPU stall warning.
-Note that SRCU does *not* have CPU stall warnings.  Please note that
-RCU only detects CPU stalls when there is a grace period in progress.
-No grace period, no CPU stall warnings.
+The RCU, RCU-sched, RCU-tasks, and RCU-tasks-trace implementations have
+CPU stall warning.  Note that SRCU does *not* have CPU stall warnings.
+Please note that RCU only detects CPU stalls when there is a grace period
+in progress.  No grace period, no CPU stall warnings.
 
 To diagnose the cause of the stall, inspect the stack traces.
 The offending function will usually be near the top of the stack.
@@ -205,16 +206,21 @@ RCU_STALL_RAT_DELAY
 rcupdate.rcu_task_stall_timeout
 -------------------------------
 
-	This boot/sysfs parameter controls the RCU-tasks stall warning
-	interval.  A value of zero or less suppresses RCU-tasks stall
-	warnings.  A positive value sets the stall-warning interval
-	in seconds.  An RCU-tasks stall warning starts with the line:
+	This boot/sysfs parameter controls the RCU-tasks and
+	RCU-tasks-trace stall warning intervals.  A value of zero or less
+	suppresses RCU-tasks stall warnings.  A positive value sets the
+	stall-warning interval in seconds.  An RCU-tasks stall warning
+	starts with the line:
 
 		INFO: rcu_tasks detected stalls on tasks:
 
 	And continues with the output of sched_show_task() for each
 	task stalling the current RCU-tasks grace period.
 
+	An RCU-tasks-trace stall warning starts (and continues) similarly:
+
+		INFO: rcu_tasks_trace detected stalls on tasks
+
 
 Interpreting RCU's CPU Stall-Detector "Splats"
 ==============================================
@@ -248,7 +254,8 @@ dynticks counter, which will have an even-numbered value if the CPU
 is in dyntick-idle mode and an odd-numbered value otherwise.  The hex
 number between the two "/"s is the value of the nesting, which will be
 a small non-negative number if in the idle loop (as shown above) and a
-very large positive number otherwise.
+very large positive number otherwise.  The number following the final
+"/" is the NMI nesting, which will be a small non-negative number.
 
 The "softirq=" portion of the message tracks the number of RCU softirq
 handlers that the stalled CPU has executed.  The number before the "/"
-- 
2.31.1.189.g2e36527f23

