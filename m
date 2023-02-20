Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1272F69D115
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjBTQH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjBTQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:07:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE1C8A4C;
        Mon, 20 Feb 2023 08:07:56 -0800 (PST)
Date:   Mon, 20 Feb 2023 17:07:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676909274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=aihUiQAEYGdNDVVk+BW/pwYwHfkq0+AinKSL9XApArY=;
        b=Sxp/DeR+VuahpcpFk3ZIiwIC7YqX6L7PR/b+tgkvZib9VaAIHgPtcedb6GtVFQcQ6Mvkq+
        h8e7BR/Lel1lLj7VA0Bfjd9Yk68kNNe9NceTtuPxCSwes2wekPV0aFo1TOe31d+wbRtJMQ
        aJt2iGMIZOVLHruYmwpR87zScsBWScYbaSERlunV2RQURfIFEn8PZBoKkbmV/dFQksHu5e
        XL8Bh3dQySS+vwpLdMR9HqWSEmsdfCZPe94HBxHTrBARdqODp0oBTlF6D11JXCQ52l6mzH
        TznDTHt66IE/tEyotDOXurBYJn7VrhOWXiAVvbjUi0CVtyWLH9Vlccv9yfU0hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676909274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=aihUiQAEYGdNDVVk+BW/pwYwHfkq0+AinKSL9XApArY=;
        b=+GSbN38bE7NBgyavRO1AjQydQbHXWzhCUPR5LKWkEHHveKw/aKS2X2nJ+EUqAVbu7ErgT6
        GTizKT6TkFKY+lAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.2-rt3
Message-ID: <Y/Oa2P9sedRWtc5E@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.2-rt3 patch set. 

Changes since v6.2-rt2:

  - Always wake the ktimers thread once the hrtimer softirq is raised.
    If the softirq is running then the wake of the thread will be
    delayed until the next jiffy tick. Patch by Junxiao Chang.

  - The splats reported by Valentin Schneider have been dealt with and
    are removed from the "known issues" sections. See
      https://lore.kernel.org/all/953300ac-25fa-db8d-c270-d10559a0fa02@arm.com/

Known issues
     None.

The delta patch against v6.2-rt2 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.2/incr/patch-6.2-rt2-rt3.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.2-rt3

The RT patch against v6.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.2/older/patch-6.2-rt3.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.2/older/patches-6.2-rt3.tar.xz

Sebastian


diff --git a/kernel/softirq.c b/kernel/softirq.c
index ab1fe34326bab..82f3e68fbe220 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -664,13 +664,12 @@ static inline void __irq_exit_rcu(void)
 #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt()) {
-		if (local_softirq_pending())
-			invoke_softirq();
+	if (!in_interrupt() && local_softirq_pending())
+		invoke_softirq();
 
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers())
-			wake_timersd();
-	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers() &&
+	    !(in_nmi() | in_hardirq()))
+		wake_timersd();
 
 	tick_irq_exit();
 }
diff --git a/localversion-rt b/localversion-rt
index c3054d08a1129..1445cd65885cd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt2
+-rt3
