Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9169D1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjBTQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBTQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:54:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8418AAC;
        Mon, 20 Feb 2023 08:54:04 -0800 (PST)
Date:   Mon, 20 Feb 2023 17:54:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676912042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MavDyGT1xeppoPKTgqyDw9Ojgq7OmsmvM2dptZkC7PE=;
        b=u9o0bd8/huXnf95zp/XdhvA0ovWIaj/TbDCcfaLoqQnh5vI3XhsgHAkbEwujkWeHdttibo
        q0oB6mcfMl8kFCAkNMdTAuYeelFGwufkHoGDw1ad9J4xoO97YZBvxZyYxBa1zaOfkimggR
        n4KS1+ghZLcFGItXNLTB6SU22vMcb2VtFs2KN1fC/DdG5dLPP2bVPDeoGnjKUhBgbO7qtq
        944ftxZmNM4KJYsC8KnI2YiLqVI5qoQuxJMTMWUgSQncbuJJxREO+HcCuS4v4R14tUlODg
        LibVMQsu2DMXd9Wb63LLZCbDJ5Q6tW8MooU7lx4o6Nlql/Q+45bgWy5wuwXIPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676912042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MavDyGT1xeppoPKTgqyDw9Ojgq7OmsmvM2dptZkC7PE=;
        b=qNNaa6qfhhcXmAUHrlrjaQrhlxkbeJINQ/6wCOZGeJSL7uvXfkbEplBzCcHurjFyrPKgdV
        wwM3pJbF+/WnyZAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.1.12-rt7
Message-ID: <Y/Olqd9NQkVW5NJ0@linutronix.de>
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

I'm pleased to announce the v6.1.12-rt7 patch set. 

Changes since v6.1.12-rt6:

  - Always wake the ktimers thread once the hrtimer softirq is raised.
    If the softirq is running then the wake of the thread will be
    delayed until the next jiffy tick. Patch by Junxiao Chang.

Known issues
     None.

The delta patch against v6.1.12-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.1/incr/patch-6.1.12-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.1.12-rt7

The RT patch against v6.1.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.1/older/patch-6.1.12-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.1/older/patches-6.1.12-rt7.tar.xz

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
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
