Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C338C723C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbjFFI4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjFFIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:55:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46EEA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:55:48 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686041747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FExOD5E8HJtGy/lm1D7DIYTsTEtzFIwKcZPbLrNzZPE=;
        b=tftlDy4XknmZgpUOkAK9spHUoXUymEYXhvGp8Mi84sBJhmSus1Q2hCVNc+glOyG0RkYJ4q
        XjMNM6qo0PSUnDMmWBHEdLb2BUYrAJCRwDEWe122xr8ft93TorEyGBfvd0TY5vqT7NrqvL
        QTDZiaysFVl/+k8vQwJzwTaE7dQPfFbB7FTkA1NMfxhvzdVA4rGyJVp0Yk0E/d9l08h5X5
        Ptlb7RCUo4TiCcrEfmGI59m2HEjZql4d/8zUKlclohrDD1T9S2C7ki/RgNGvqYfcFYy6oG
        dJFHFGeqprFB5EfAdGTV468f2zKp7jZJMgheWy6523CHjQJDn+ZYq9NkLmYvCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686041747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FExOD5E8HJtGy/lm1D7DIYTsTEtzFIwKcZPbLrNzZPE=;
        b=Qgdn5lAt6sr9Rgf+wlV5JethHHVroIcnnXwYK0rSnbfsrdjqYsviPU0ZyubGn58uCDQasW
        NKwkTEQplbPP0fAQ==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH REPOST 2/2] signal: Don't disable preemption in ptrace_stop() on PREEMPT_RT.
Date:   Tue,  6 Jun 2023 10:55:24 +0200
Message-Id: <20230606085524.2049961-3-bigeasy@linutronix.de>
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
 kernel/signal.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index da017a5461163..9e07b3075c72e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2328,11 +2328,16 @@ static int ptrace_stop(int exit_code, int why, unsi=
gned long message,
 	 * The preempt-disable section ensures that there will be no preemption
 	 * between unlock and schedule() and so improving the performance since
 	 * the ptracer has no reason to sleep.
+	 *
+	 * This optimisation is not doable on PREEMPT_RT due to the spinlock_t
+	 * within the preempt-disable section.
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

