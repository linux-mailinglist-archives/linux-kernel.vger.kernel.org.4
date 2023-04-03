Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD816D3FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjDCJJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjDCJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:09:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B937687
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=s5+SYFBClxDh4bJ30eLDdVhCobI2olLYK6GT1ov2ndE=; b=JrK5oZ/o94uvV4z/gpuml4hvnz
        mexRqZV729zcVUL5s58Unf93AZ+Sj1Y82mNF8ZCFQ7VeuiUszuSSbIA5dWLdWhAZt9kvubQAenIDZ
        z8XufWjOSxHe5mtFcODptZMYwj6ynorDSVEgpW8BNu54C2R5koroWV8dexVQdc97tgr1cW8WiutKz
        goFD1LIGOEQSnpKU9jef2+fTiFYaPUBPBBiIwTDdEJuEJEGoO32/p+QEKz5f1ERbDqqShWttD3Qyx
        JYzfnVgOkmE0hdqEFKCZgF5lJXNYralH6PQC6ZmOwCm5OjsSsg0gKV6osfr3VU8PjurBc4iBInvXi
        Gj+pEL8w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjGBQ-00DyBN-Ip; Mon, 03 Apr 2023 09:09:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05597300194;
        Mon,  3 Apr 2023 11:08:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7E3024233365; Mon,  3 Apr 2023 11:08:58 +0200 (CEST)
Date:   Mon, 3 Apr 2023 11:08:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] perf: Optimize perf_pmu_migrate_context()
Message-ID: <20230403090858.GT4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas reported that offlining CPUs spends a lot of time in
synchronize_rcu() as called from perf_pmu_migrate_context() even though
he's not actually using uncore events.

Turns out, the thing is unconditionally waiting for RCU, even if there's
no actual events to migrate.

Fixes: 0cda4c023132 ("perf: Introduce perf_pmu_migrate_context()")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/events/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fb3e436bcd4a..115320faf1db 100644
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
