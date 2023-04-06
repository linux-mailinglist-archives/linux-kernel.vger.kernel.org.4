Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99E56DA423
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbjDFU5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbjDFU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:57:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650C16589
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:57:19 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680814638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nu76zb774yFa0MN+XeDDVckETU/rIQgmqAyiuYXOZF4=;
        b=ok/5H9AVhG4+VER7ECM77WvJqsQZU1sqfH0H6uB6goaWUVT7XjjvHYneCIQXhq5ZPxu7XM
        0mv7+kQ0vFK1Zwu3OppSweFZGJTgKKd/3ijOeUjmlb22SU49pfp1ligy0ofAuPSjrZVN/G
        ViQCTIpnipT5yduH18OIIIGw/T7N+dDXE3pLwm46NWPCExLBpEfx+0i++TPoeOVHSO4d7S
        7T5HbGYBCnwtIAN+JeiLB4dsi3/Vb8sdwxE8nfrkl8oQcRsb1ffnkL1K3DxLlFfvfe91MG
        XM9apuHzjpQQHgYQM1mGgvdLR1rSye7S7rb3c7tkt0/nirmRAplNQVGnf0qlVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680814638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nu76zb774yFa0MN+XeDDVckETU/rIQgmqAyiuYXOZF4=;
        b=e3ECoxC2dOBtyRnv+0S4QRsRciqxy0q5gbj5g8fsovpTWXZaDSQSbtVJ2dpm4whxkszSxE
        aC/nrYE03vNxZ4BA==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] signal: Don't disable preemption in ptrace_stop() on PREEMPT_RT.
Date:   Thu,  6 Apr 2023 22:57:12 +0200
Message-Id: <20230406205713.1843072-3-bigeasy@linutronix.de>
In-Reply-To: <20230406205713.1843072-1-bigeasy@linutronix.de>
References: <20230406205713.1843072-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 kernel/signal.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2352,11 +2352,16 @@ static int ptrace_stop(int exit_code, in
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
