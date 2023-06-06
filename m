Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DFD724422
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjFFNQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbjFFNQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:16:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050F10C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:16:25 -0700 (PDT)
Date:   Tue, 6 Jun 2023 15:16:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686057383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnnwGQjwBJKNKyeoriEOiM1KFg3/YDdFChAUa/K2FB0=;
        b=a8aXfBKn/IZyYqgFSLg9sq8bcadvMZ2xUAAA4h/iYmpYz/0dYTDs9F2pa2cnYqNSumyJrc
        h16hD8Q+bP2vMjJikVozrCcJ46aF2LPtbPGz6NQoZDIh9Clyojmk6kb8Uyksun2tOGMMuk
        pSnnWyxaOQcvnW55FXzx28xGkHgmirWnSL0ftYZrLIFCaLwxDDbfIkvqqWTl+umnIMqqzZ
        8MSYnA8X3ZapZrF1uz9DIlvf6nMIJLBv27o7t9SlDxlyumy8QDIn0uOltFxhYjsCvqdixQ
        rWV1PL6WmOuvxMqPawxdweSODTppa7NUNPr3KA4H8pyiwPU9mr9HT5+mt/KmtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686057383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TnnwGQjwBJKNKyeoriEOiM1KFg3/YDdFChAUa/K2FB0=;
        b=2/rp97Sq+RaZMj/w2kuIhza8UlmzuhCDhIVyADr4hDXYRtgT076EtiTSUMagixW2eIp6vq
        Vi9FlZOmzNvJblAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2 v2] signal: Don't disable preemption in ptrace_stop() on
 PREEMPT_RT.
Message-ID: <20230606131621.nbXfkFvG@linutronix.de>
References: <20230606085524.2049961-1-bigeasy@linutronix.de>
 <20230606085524.2049961-3-bigeasy@linutronix.de>
 <20230606110447.GA7542@redhat.com>
 <20230606111418.GA906324@hirez.programming.kicks-ass.net>
 <20230606113853.GC7542@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230606113853.GC7542@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT keeping preemption disabled during the invocation of
cgroup_enter_frozen() is a problem because the function acquires css_set_lo=
ck
which is a sleeping lock on PREEMPT_RT and must not be acquired with disabl=
ed
preemption.
The preempt-disabled section is only for performance optimisation
reasons and can be avoided.

Extend the comment and don't disable preemption before scheduling on
PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Is this better?

v1=E2=80=A6v2:
  - Extend the comment to note that preemption isn't disabled due to
    the lock to make it obvious that the optimisation isn't just
    harmful but also pointless.

 kernel/signal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index da017a5461163..dcb0b1fbcb3a8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2328,11 +2328,20 @@ static int ptrace_stop(int exit_code, int why, unsi=
gned long message,
 	 * The preempt-disable section ensures that there will be no preemption
 	 * between unlock and schedule() and so improving the performance since
 	 * the ptracer has no reason to sleep.
+	 *
+	 * On PREEMPT_RT locking tasklist_lock does not disable preemption.
+	 * Therefore the task can be preempted (after
+	 * do_notify_parent_cldstop()) before unlocking tasklist_lock so there
+	 * is no benefit in doing this. The optimisation is harmful on
+	 * PEEMPT_RT because the spinlock_t (in cgroup_enter_frozen()) must not
+	 * be acquired with disabled preemption.
 	 */
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	read_unlock(&tasklist_lock);
 	cgroup_enter_frozen();
-	preempt_enable_no_resched();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable_no_resched();
 	schedule();
 	cgroup_leave_frozen(true);
=20
--=20
2.40.1

