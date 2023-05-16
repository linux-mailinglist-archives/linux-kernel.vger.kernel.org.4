Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46A7048AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjEPJLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjEPJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C935AC;
        Tue, 16 May 2023 02:10:04 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228200;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iumz4nYEL/eZH8YC/m5GHga++Vy/iQFId5+7wJh361g=;
        b=IWRjGTSg9wd7zx8Ge/KuatrCVMV95GML14viMSKJFJs4cI5hbnTHk+1/CgMzcxlWOewH0z
        fdfoh7J3jQaI6s4xSGL1ONfulIEsNT7fhEkc3xpRPmhTeBMM8/pHnH7kWt5RH0kKIH9brr
        PCU9W5uW1r8up3ARAD3upCZ2RMSc0wbtrPCcsKPQWXO4o808Gqy3pl8Do4COT/UmdwyHIE
        fKj4pEyscU5GDwmWl7XTJFrwbE/2M0RPTAnMdsMIlLTJQi3mXBZ4gUoc8Z7zftLtHSQvr9
        yulVQ413IbPdR8zf98II8eyn+XSndE8B7juvkX516DAjyUoOl6KXFqDI0S526A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228200;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iumz4nYEL/eZH8YC/m5GHga++Vy/iQFId5+7wJh361g=;
        b=q9QvoAPghBUA0YnEc8ZWGmd8umozTdmVGbDcOXXRgc2xap17mNT1Y2wklUOi0VqOZUiw11
        j5yt6zDI1YLimVAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Rework sparse_irq locking in bringup_cpu()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.263722880@linutronix.de>
References: <20230512205256.263722880@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819974.404.13412319672677019398.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     22b612e2d53f6e13ce7b55ed565a104512f0eb00
Gitweb:        https://git.kernel.org/tip/22b612e2d53f6e13ce7b55ed565a104512f0eb00
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:54 +02:00

cpu/hotplug: Rework sparse_irq locking in bringup_cpu()

There is no harm to hold sparse_irq lock until the upcoming CPU completes
in cpuhp_online_idle(). This allows to remove cpu_online() synchronization
from architecture code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.263722880@linutronix.de
---
 kernel/cpu.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c0d859c..df8f137 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -558,7 +558,7 @@ static int cpuhp_kick_ap(int cpu, struct cpuhp_cpu_state *st,
 	return ret;
 }
 
-static int bringup_wait_for_ap(unsigned int cpu)
+static int bringup_wait_for_ap_online(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 
@@ -579,15 +579,12 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	 */
 	if (!cpu_smt_allowed(cpu))
 		return -ECANCELED;
-
-	if (st->target <= CPUHP_AP_ONLINE_IDLE)
-		return 0;
-
-	return cpuhp_kick_ap(cpu, st, st->target);
+	return 0;
 }
 
 static int bringup_cpu(unsigned int cpu)
 {
+	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	struct task_struct *idle = idle_thread_get(cpu);
 	int ret;
 
@@ -600,16 +597,33 @@ static int bringup_cpu(unsigned int cpu)
 	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
-	 * Prevent irq alloc/free across the bringup.
+	 *
+	 * Prevent irq alloc/free across the bringup by acquiring the
+	 * sparse irq lock. Hold it until the upcoming CPU completes the
+	 * startup in cpuhp_online_idle() which allows to avoid
+	 * intermediate synchronization points in the architecture code.
 	 */
 	irq_lock_sparse();
 
 	/* Arch-specific enabling code. */
 	ret = __cpu_up(cpu, idle);
-	irq_unlock_sparse();
 	if (ret)
-		return ret;
-	return bringup_wait_for_ap(cpu);
+		goto out_unlock;
+
+	ret = bringup_wait_for_ap_online(cpu);
+	if (ret)
+		goto out_unlock;
+
+	irq_unlock_sparse();
+
+	if (st->target <= CPUHP_AP_ONLINE_IDLE)
+		return 0;
+
+	return cpuhp_kick_ap(cpu, st, st->target);
+
+out_unlock:
+	irq_unlock_sparse();
+	return ret;
 }
 
 static int finish_cpu(unsigned int cpu)
