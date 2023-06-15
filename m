Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E637315D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbjFOK4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbjFOK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:56:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF381A2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:56:43 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686826600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/QLlkP12aZg2OG62D74WUAk4h5OegU8e3v3LQUZTFk=;
        b=ZUbs71h1JxlcirLnjh96NF0dj08tpsOtNdYeN750JN+DnI94kftP24X6Ei1sYjMuCvdbbW
        SlaP7MRfaAWkqAxqxqKKWOagPkcxtHWl0icsRhJUnUwhBdE2VmWkhND9lO0I+HfLog5Aki
        L8dL303ixRxZ7sFPaxPsxHoEkRj+yIWt037CFnS0ng0Cr31Rs7SHJ+OGnBTg+e55ron1Oi
        Fd04WmRxo8H4CN+8hLRhfzzIFoy+3lba7XUqzCRVayZ4tFYodz+7Gmgg0AE51t8Xr6xA+y
        2TAKNT42biJ7NLEHi5NyC6VJ3jky8/TOji47halPux/b0Z47Asf1vxZzzFdPLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686826600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/QLlkP12aZg2OG62D74WUAk4h5OegU8e3v3LQUZTFk=;
        b=ggyL+eW02COW//bhBK3KlTKd60ubVbq/Q6p4lXVX1rIuoTmVll0DeBr+qgdLI/EBxtSX3T
        btBb0YyjAqniYTAA==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 2/2] signal: Don't disable preemption in ptrace_stop() on PREEMPT_RT.
Date:   Thu, 15 Jun 2023 12:56:27 +0200
Message-Id: <20230615105627.1311437-3-bigeasy@linutronix.de>
In-Reply-To: <20230615105627.1311437-1-bigeasy@linutronix.de>
References: <20230615105627.1311437-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index da017a5461163..e887cd684d17a 100644
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

