Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E63723C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbjFFIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjFFIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:55:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6B2E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:55:48 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686041747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cd+JUiL0ywRxwd2ZYcL8vrhCuZmD85iBs9FdcgWCwPc=;
        b=E2YAC+kTU9nvRfmyvFVDUWuloG/YvTpHJUW/MMkr8gGPtrs7xX7CR67odfyY3LR9gtvWQB
        D1TmXGOYD7Iw01LmMuieMr/YXK6HzSI4FbQjmN/U/zVdHj6FWLfYer8RR3G6y9se0nxRsc
        CWG/GL3QRq8Ex6zWyBrjihfWSsS271qsDhc3s4bS+u58zdB+B2t3+idIgVZ2yRereqOQrF
        WcDSLnJN/CJhKGtHHHNa73SBQ+/TNSZGODlsBb/ESeq9PE9v2h6k3vtR5IWn2KpYedkmQB
        TSWH+KI8fqXYPcj5AtLNsYV/2+iIsWgABbMAnIXonHeu+F2JKh/mLkqZu9gTnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686041747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cd+JUiL0ywRxwd2ZYcL8vrhCuZmD85iBs9FdcgWCwPc=;
        b=WuR/aNAYTnmyD095A4LuzBzetucWJac5WMktFBXrvgD2zPHMbG6tgZbenLLOt2ptQSxHKf
        lm2X0eDM1jjzqbAA==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH REPOST 1/2] signal: Add proper comment about the preempt-disable in ptrace_stop().
Date:   Tue,  6 Jun 2023 10:55:23 +0200
Message-Id: <20230606085524.2049961-2-bigeasy@linutronix.de>
In-Reply-To: <20230606085524.2049961-1-bigeasy@linutronix.de>
References: <20230606085524.2049961-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 53da1d9456fe7 ("fix ptrace slowness") added a preempt-disable section
between read_unlock() and the following schedule() invocation without
explaining why it is needed.

Replace the comment with an explanation why this is needed. Clarify that
it is needed for correctness but for performance reasons.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 2547fa73bde51..da017a5461163 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2313,10 +2313,21 @@ static int ptrace_stop(int exit_code, int why, unsi=
gned long message,
 		do_notify_parent_cldstop(current, false, why);
=20
 	/*
-	 * Don't want to allow preemption here, because
-	 * sys_ptrace() needs this task to be inactive.
+	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
+	 * One a PREEMPTION kernel this can result in preemption requirement
+	 * which will be fulfilled after read_unlock() and the ptracer will be
+	 * put on the CPU.
+	 * The ptracer is in wait_task_inactive(, __TASK_TRACED) waiting for
+	 * this task wait in schedule(). If this task gets preempted then it
+	 * remains enqueued on the runqueue. The ptracer will observe this and
+	 * then sleep for a delay of one HZ tick. In the meantime this task
+	 * gets scheduled, enters schedule() and will wait for the ptracer.
 	 *
-	 * XXX: implement read_unlock_no_resched().
+	 * This preemption point is not bad from correctness point of view but
+	 * extends the runtime by one HZ tick time due to the ptracer's sleep.
+	 * The preempt-disable section ensures that there will be no preemption
+	 * between unlock and schedule() and so improving the performance since
+	 * the ptracer has no reason to sleep.
 	 */
 	preempt_disable();
 	read_unlock(&tasklist_lock);
--=20
2.40.1

