Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CD7660E47
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjAGLgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGLgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:36:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA676208;
        Sat,  7 Jan 2023 03:36:42 -0800 (PST)
Date:   Sat, 07 Jan 2023 11:36:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673091400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLGeeiX99ZdKBwzoi7gJevgvo93/CE40yLBgMH+PF2c=;
        b=TFbvazGDKE4OXZk4ezJn8eOpIFxvyiMIR9SNAFuIKMwj2S8Ek9aTjdX6DlJe+m2kKE4HoV
        0MR6fdUznK/8F9gAVU3uhmJBe4Qt/CNjWoGEE/ECJC1FFOMcPEE3s+TR3wXmKqURrdVFjt
        Ux5UQNAY1FrAaog7nVmCPjg1S831PGk8uA5hqS/TeWhesUpYBgitYmdghHupXXP5VvWfgy
        /7bl6TI3odQ2BifCp5y+Xkd26/EsFXmbYpa/cOlVziwggmeTKoUolLmE5yw2Q5u2r3XFPr
        PRuXkJis3t5AE7+j9j7aR1yv5PZFnIaMJZ5aECm/LKRWYDggPyDU8nYqiM3JQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673091400;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLGeeiX99ZdKBwzoi7gJevgvo93/CE40yLBgMH+PF2c=;
        b=42u01Ivvai5h7drSrJ2ymLXDlM8/gfUkK5DPWhlQgFLoV917VUMixeDMnKG7J9753ny1x2
        PECq/5RcbT+ZxPBA==
From:   "tip-bot2 for Yair Podemsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix arch_scale_freq_tick() on
 tickless systems
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yair Podemsky <ypodemsk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221130125121.34407-1-ypodemsk@redhat.com>
References: <20221130125121.34407-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Message-ID: <167309140038.4906.5738152542834674773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     7fb3ff22ad8772bbf0e3ce1ef3eb7b09f431807f
Gitweb:        https://git.kernel.org/tip/7fb3ff22ad8772bbf0e3ce1ef3eb7b09f431807f
Author:        Yair Podemsky <ypodemsk@redhat.com>
AuthorDate:    Wed, 30 Nov 2022 14:51:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 12:25:50 +01:00

sched/core: Fix arch_scale_freq_tick() on tickless systems

In order for the scheduler to be frequency invariant we measure the
ratio between the maximum CPU frequency and the actual CPU frequency.

During long tickless periods of time the calculations that keep track
of that might overflow, in the function scale_freq_tick():

  if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
          goto error;

eventually forcing the kernel to disable the feature for all CPUs,
and show the warning message:

   "Scheduler frequency invariance went wobbly, disabling!".

Let's avoid that by limiting the frequency invariant calculations
to CPUs with regular tick.

Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Link: https://lore.kernel.org/r/20221130125121.34407-1-ypodemsk@redhat.com
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b..965d813 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5504,7 +5504,9 @@ void scheduler_tick(void)
 	unsigned long thermal_pressure;
 	u64 resched_latency;
 
-	arch_scale_freq_tick();
+	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+		arch_scale_freq_tick();
+
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
