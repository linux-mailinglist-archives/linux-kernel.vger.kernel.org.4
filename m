Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D751723B31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjFFIS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjFFISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:18:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5117518E;
        Tue,  6 Jun 2023 01:18:44 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:18:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loGpNdhbZ2dJUcxifiO+fpK1K/ID5CqdSLfcmB+jq1I=;
        b=GgogaaHTQPfiKBzoSVKpwHt3PCTaE/7QDSKf/NQVSKnZo/uN5n+xYflJUIMTAGQaMW05Ej
        2i4F9QugWfvxYQZneN7kJHa2SCrAN9h7NKv6gw6DwuApmM8eb+mDz4ohBFjw9DKtxtO9a3
        Ulyl5+N/zRRD1TQ+N/f3fuG+qwIv/h/B6eb7OBSH02dNbh9YoVIxu3jgToVo3OY2mIuL+0
        0Mzn0s0UlC6d/3Fqb9elHsDTn2ayQ024kKNSWCEY0bHxdlsGYmEUwBsvGLoiW9SUqAPBtT
        JjkVWb+g+KjOUdDnKi3/KXoWXnNptQ6iXtSdO74WdandLCUWhCgElA7l6gtxNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039523;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loGpNdhbZ2dJUcxifiO+fpK1K/ID5CqdSLfcmB+jq1I=;
        b=vzW2RcWE4SkiQ8S83SYsZJcIrtz/4zjo+CoCkV4ye+G6ARa5tSvSk1f/LjWyUGyiHPxbET
        Afzvs7Qlu19CFvDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Re-instate the linear PMU search
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605101401.GL38236@hirez.programming.kicks-ass.net>
References: <20230605101401.GL38236@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <168603952210.404.6172864840237247274.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     228020b490eda9133c9cb6f59a5ee1278d8c463f
Gitweb:        https://git.kernel.org/tip/228020b490eda9133c9cb6f59a5ee1278d8c463f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 05 Jun 2023 12:14:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jun 2023 10:09:21 +02:00

perf: Re-instate the linear PMU search

Full revert of commit 9551fbb64d09 ("perf/core: Remove pmu linear
searching code").

Some architectures (notably arm/arm64) still relied on the linear
search in order to find the PMU that consumes
PERF_TYPE_{HARDWARE,HW_CACHE,RAW}.

This will need a more thorought audit and cleanup.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230605101401.GL38236@hirez.programming.kicks-ass.net
---
 kernel/events/core.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 231b187..c01bbe9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11630,27 +11630,38 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	}
 
 again:
-	ret = -ENOENT;
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
-	if (!pmu)
-		goto fail;
+	if (pmu) {
+		if (event->attr.type != type && type != PERF_TYPE_RAW &&
+		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+			goto fail;
 
-	if (event->attr.type != type && type != PERF_TYPE_RAW &&
-	    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-		goto fail;
+		ret = perf_try_init_event(pmu, event);
+		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
+			type = event->attr.type;
+			goto again;
+		}
 
-	ret = perf_try_init_event(pmu, event);
-	if (ret == -ENOENT && event->attr.type != type && !extended_type) {
-		type = event->attr.type;
-		goto again;
+		if (ret)
+			pmu = ERR_PTR(ret);
+
+		goto unlock;
 	}
 
-fail:
-	if (ret)
-		pmu = ERR_PTR(ret);
+	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
+		ret = perf_try_init_event(pmu, event);
+		if (!ret)
+			goto unlock;
 
+		if (ret != -ENOENT) {
+			pmu = ERR_PTR(ret);
+			goto unlock;
+		}
+	}
+fail:
+	pmu = ERR_PTR(-ENOENT);
 unlock:
 	srcu_read_unlock(&pmus_srcu, idx);
 
