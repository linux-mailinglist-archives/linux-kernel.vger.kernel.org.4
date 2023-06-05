Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33709722A77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjFEPJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjFEPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59780F1;
        Mon,  5 Jun 2023 08:08:33 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=if2dVjYa5Bi/ydn9IhPeAQMayijHDMtDpj3hYChXRrM=;
        b=3V9VYLj+6bPxodnXQaHdrFFS1L2pA2xBGBUlnifBtNBdlVEd6L3Q3upqiOOc22u6UgW8xw
        nqhoZJuo3iEj82TpsrYHFbkKPFwtNYI6FOjmlYTfq4OHMAuFUx5joR1mZ0izXYGHoYYfEE
        ViBDZJ+dlhwLEazUHDkQUp7EzaOtPCfkP8MX7EC9QvYL0LZ9d+t/yMocKpJCXwAN441IfP
        xGxL6CEKe1EjY7TKMyriHl2xFJA/V7gF/GTS1LJoMolQtRdSY6AS7TXTZK7xuGdVpOzpCS
        W8/qRNGBgI1wSHkCdpGuiZZOd1NDoUDVfMWwddWKp8mLnWyOBfA2/u8hKGOEVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=if2dVjYa5Bi/ydn9IhPeAQMayijHDMtDpj3hYChXRrM=;
        b=QEr+VH/c5GfbB0LGGQXy4t2GAp43L2wpyw5CwdXMnijOCP921O73PvP6WuIq6Dey50yXqw
        KadpD0q/VdcMdwAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Clarify timer_wait_running() comment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183312.985681995@linutronix.de>
References: <20230425183312.985681995@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597771152.404.15026662809779436776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     07ca14d623d8b0e6c4a0d3de4ca8a8ea35a85470
Gitweb:        https://git.kernel.org/tip/07ca14d623d8b0e6c4a0d3de4ca8a8ea35a85470
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:37 +02:00

posix-timers: Clarify timer_wait_running() comment

Explain it better and add the CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y aspect
for completeness.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183312.985681995@linutronix.de

---
 kernel/time/posix-timers.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2c5daeb..4017533 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -836,10 +836,18 @@ static void common_timer_wait_running(struct k_itimer *timer)
 }
 
 /*
- * On PREEMPT_RT this prevent priority inversion against softirq kthread in
- * case it gets preempted while executing a timer callback. See comments in
- * hrtimer_cancel_wait_running. For PREEMPT_RT=n this just results in a
- * cpu_relax().
+ * On PREEMPT_RT this prevents priority inversion and a potential livelock
+ * against the ksoftirqd thread in case that ksoftirqd gets preempted while
+ * executing a hrtimer callback.
+ *
+ * See the comments in hrtimer_cancel_wait_running(). For PREEMPT_RT=n this
+ * just results in a cpu_relax().
+ *
+ * For POSIX CPU timers with CONFIG_POSIX_CPU_TIMERS_TASK_WORK=n this is
+ * just a cpu_relax(). With CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y this
+ * prevents spinning on an eventually scheduled out task and a livelock
+ * when the task which tries to delete or disarm the timer has preempted
+ * the task which runs the expiry in task work context.
  */
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
