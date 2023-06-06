Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3B724663
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbjFFOig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjFFOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9421993
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:47 -0700 (PDT)
Message-ID: <20230606142031.983662966@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lbMmZ14JuZ/krQR6RrGQ1HvOBRw0gNG6TW4Rb4ueY4Q=;
        b=fr07iI8eiGqzm9c4spmDHsJoDzM4I3AshKTKn0B4qfJFd1pupaIcWrQv+EkERqd+s1WZXs
        wiyFUStOfDusf4fsevgOi6yqYiPcD5rIPfMqwufQ+O7nln7PpgKlnpIsyYAcPND2lKlfxA
        nqTeBws/rzNYwbtQMmrjRpBIwSy9mfkZP3jls4azpkFz+v692Oj9/0ucQAW5A1hsEuN5EF
        77uSwrbqgHYNvjBVYwOLZiuiSyeD2bDxvYe2gtARLMvpw5pOtrBLYk66YAeNkHilPxXN4m
        wMa16b0ivC9t/ywD/tYI0O1OYDxFMyZvUBXy4WPxPwgFAiCo2OzMTsscmUMgsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lbMmZ14JuZ/krQR6RrGQ1HvOBRw0gNG6TW4Rb4ueY4Q=;
        b=C/BEPwo7ibfW/Qaq98/UdgpbTp1XbZou+bEA3mK0iDko1X3WaoZgGPVPm/FyOape4HgzCU
        wfAtQ770fIo9KsDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 17/45] posix-cpu-timers: Make k_itimer::it_active consistent
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posix CPU timers are not updating k_itimer::it_active which makes it
impossible to base decisions in the common posix timer code on it.

Update it when queueing or dequeueing posix CPU timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -453,6 +453,7 @@ static void disarm_timer(struct k_itimer
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct posix_cputimer_base *base;
 
+	timer->it_active = 0;
 	if (!cpu_timer_dequeue(ctmr))
 		return;
 
@@ -559,6 +560,7 @@ static void arm_timer(struct k_itimer *t
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
 
+	timer->it_active = 1;
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
 
@@ -668,6 +670,7 @@ static int posix_cpu_timer_set(struct k_
 		ret = TIMER_RETRY;
 	} else {
 		cpu_timer_dequeue(ctmr);
+		timer->it_active = 0;
 	}
 
 	/*
@@ -787,6 +790,7 @@ static u64 collect_timerqueue(struct tim
 
 	while ((next = timerqueue_getnext(head))) {
 		struct cpu_timer *ctmr;
+		struct k_itimer *ktmr;
 		u64 expires;
 
 		ctmr = container_of(next, struct cpu_timer, node);
@@ -799,6 +803,8 @@ static u64 collect_timerqueue(struct tim
 		/* See posix_cpu_timer_wait_running() */
 		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
+		ktmr = container_of(ctmr, struct k_itimer, it.cpu);
+		ktmr->it_active = 0;
 		list_add_tail(&ctmr->elist, firing);
 	}
 

