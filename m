Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F836E678F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjDROxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjDROxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF29EC9;
        Tue, 18 Apr 2023 07:53:30 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:53:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681829609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhnur3/FfFvvoWBfWqpAV9Qz7hLwFbxsVzxcnah7ISY=;
        b=ODq4r6wythEElHoWY4Bqwr8DsFTthFCrHCCX/VULNbBDCgdV2ymP0dkmf0Rxrl2Ve3Uc2h
        OGYP6gOi9SjQV51S3ymtkaYXr3oylxNC/uxAJghVxs9tp/gxVuVv+jTmU0Rd+yRqOFd1vn
        MyQ6R2lejuMdUI1wn998JG0ZMbbytddfGK24T2NQFY21Taoe7h+j3gwwJWQ9bSCLX30Nw+
        O/uPfM3LgZB3UWJbuQ9OZ9/+oG3BE31pvTPqWfKfYTSa4kYw9uSTMr1ouqeH9P0jaJBNs6
        uVyOkvr5bbvHZIK65tdnvWIHQgJZ3hV/pWPtKTUAS7MXpil2iaURn6X5J/+Onw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681829609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhnur3/FfFvvoWBfWqpAV9Qz7hLwFbxsVzxcnah7ISY=;
        b=DL2kebB57CFBtZhPT4XOWqa8r4OhntC0S9dBEKXf9NIo7G6qFB2IxEpLC3QWoiJVzvkIBe
        +udr8wDxm8Tp70Bg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/nohz: Remove middle-function
 __tick_nohz_idle_stop_tick()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222144649.624380-6-frederic@kernel.org>
References: <20230222144649.624380-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <168182960880.404.17395403193683319943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     289dafed3851a7693a47896f5d09420bf6046ef2
Gitweb:        https://git.kernel.org/tip/289dafed3851a7693a47896f5d09420bf6046ef2
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 22 Feb 2023 15:46:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 16:35:12 +02:00

timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()

There is no need for the __tick_nohz_idle_stop_tick() function between
tick_nohz_idle_stop_tick() and its implementation. Remove that
unnecessary step.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230222144649.624380-6-frederic@kernel.org

---
 kernel/time/tick-sched.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index edd6e9f..3b53b89 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1079,10 +1079,16 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	return true;
 }
 
-static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
+/**
+ * tick_nohz_idle_stop_tick - stop the idle tick from the idle task
+ *
+ * When the next event is more than a tick into the future, stop the idle tick
+ */
+void tick_nohz_idle_stop_tick(void)
 {
-	ktime_t expires;
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	int cpu = smp_processor_id();
+	ktime_t expires;
 
 	/*
 	 * If tick_nohz_get_sleep_length() ran tick_nohz_next_event(), the
@@ -1114,16 +1120,6 @@ static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
 	}
 }
 
-/**
- * tick_nohz_idle_stop_tick - stop the idle tick from the idle task
- *
- * When the next event is more than a tick into the future, stop the idle tick
- */
-void tick_nohz_idle_stop_tick(void)
-{
-	__tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched));
-}
-
 void tick_nohz_idle_retain_tick(void)
 {
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
