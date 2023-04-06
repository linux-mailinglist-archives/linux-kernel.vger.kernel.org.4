Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289956D939E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbjDFKF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjDFKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:05:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6D4ED2;
        Thu,  6 Apr 2023 03:05:08 -0700 (PDT)
Date:   Thu, 06 Apr 2023 10:05:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680775506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4U473xiBwsWpVCNwCcEEXKybetROkdDo1lDqE9zYZc=;
        b=IuvRBVCGpqZSxz2dJ+nMTmxpblUmFLfKzcC1to+zBR9n9AVzEsMSGGZzWuzBeF8Vok/TYM
        GbkNPweUVPTJFaxiGAl/hCou2NJTEInXjLtlIkJKdVVf6wIzoL9jtHOkFllaZpcqBhWsl3
        oJRu/LXyM8yTsa+0TxfysEb5gvnLnllvobWQu3eeI2TKlLuHRy9bss6aty/IC30fP0Z1aN
        F8YAoHHdSDGAkREtHv/pwhc7lQ2kjpbyOBsIU2bG+26aAF9CIQ2bbWP5cXl8+WkgBqqPiV
        Cp78xpTu+knCWIqQN9bUa54FIGLW6X17H38mKZDgzVCePkB7DJErQF+pLdeUlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680775506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4U473xiBwsWpVCNwCcEEXKybetROkdDo1lDqE9zYZc=;
        b=ZeRDUUMRYXlc04IM+ZC4phXV2Njb5iVxmRqBwtVyNyks0AsyOBLG05e/y9KQwBR7ns/sYt
        KP/1Zf41WGBLxSAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Optimize perf_pmu_migrate_context()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230403090858.GT4253@hirez.programming.kicks-ass.net>
References: <20230403090858.GT4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <168077550562.404.4256750619103519881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b168098912926236bbeebaf7795eb7aab76d2b45
Gitweb:        https://git.kernel.org/tip/b168098912926236bbeebaf7795eb7aab76d2b45
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 03 Apr 2023 11:08:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Apr 2023 09:58:46 +02:00

perf: Optimize perf_pmu_migrate_context()

Thomas reported that offlining CPUs spends a lot of time in
synchronize_rcu() as called from perf_pmu_migrate_context() even though
he's not actually using uncore events.

Turns out, the thing is unconditionally waiting for RCU, even if there's
no actual events to migrate.

Fixes: 0cda4c023132 ("perf: Introduce perf_pmu_migrate_context()")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20230403090858.GT4253@hirez.programming.kicks-ass.net
---
 kernel/events/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fb3e436..115320f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12893,12 +12893,14 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->pinned_groups, &events);
 	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->flexible_groups, &events);
 
-	/*
-	 * Wait for the events to quiesce before re-instating them.
-	 */
-	synchronize_rcu();
+	if (!list_empty(&events)) {
+		/*
+		 * Wait for the events to quiesce before re-instating them.
+		 */
+		synchronize_rcu();
 
-	__perf_pmu_install(dst_ctx, dst_cpu, pmu, &events);
+		__perf_pmu_install(dst_ctx, dst_cpu, pmu, &events);
+	}
 
 	mutex_unlock(&dst_ctx->mutex);
 	mutex_unlock(&src_ctx->mutex);
