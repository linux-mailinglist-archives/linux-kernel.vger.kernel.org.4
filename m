Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6966FDEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbjEJNdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbjEJNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:33:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014AF98;
        Wed, 10 May 2023 06:33:42 -0700 (PDT)
Date:   Wed, 10 May 2023 13:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683725621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qADTTeN46tJznf0RtUMYpgdOlRKAf0uSFMM7i3CA1bM=;
        b=vTRknf9ohHDkFAi3ChtsEE7D+hLUQZGui6yb6fPwVigf0noDOKY+X7OjKc8kPotBKqe/LT
        FTgGEm3YTMK6s91UoFd8jvLwuL+det+39dkKDZQEXOXrjDMRCtSUHjobmkUcAa4ObiYGO3
        juQIqgpYKysdpuXWE7/T/kRxpDhboyNlLp9f6V93pjiQWZJgsG2S3bekr06aN/f3NsZxDT
        enVfhaCsIu/4WA3oIsUZnQ2H/DV3SHNjM0NPm4y2KT56catUR/O75HTlZF3kxfM/UJXeQM
        tgk+HdMX+en43j5lfA2Ai/4NoQlsg7ZL7sNywJXyGfBoMJ2APN1n3VrTb7pB3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683725621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qADTTeN46tJznf0RtUMYpgdOlRKAf0uSFMM7i3CA1bM=;
        b=GgFvvgJeOV9+aCLW+SlAQ1sp0yzyaJuBy+B/Zm390LLOHKhSIAc+182MSfKASIvF49LHjU
        8Ckkf8h/yJlzBLBQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Remove pmu linear searching code
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230504110003.2548-4-ravi.bangoria@amd.com>
References: <20230504110003.2548-4-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <168372562124.404.3938002441520901647.tip-bot2@tip-bot2>
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

Commit-ID:     9551fbb64d094cc105964716224adeb7765df8fd
Gitweb:        https://git.kernel.org/tip/9551fbb64d094cc105964716224adeb7765df8fd
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Thu, 04 May 2023 16:30:02 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:31 +02:00

perf/core: Remove pmu linear searching code

Searching for the right pmu by iterating over all pmus is no longer
required since all pmus now *must* be present in the 'pmu_idr' list.
So, remove linear searching code.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230504110003.2548-4-ravi.bangoria@amd.com
---
 kernel/events/core.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c01bbe9..231b187 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11630,38 +11630,27 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	}
 
 again:
+	ret = -ENOENT;
 	rcu_read_lock();
 	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
-	if (pmu) {
-		if (event->attr.type != type && type != PERF_TYPE_RAW &&
-		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-			goto fail;
-
-		ret = perf_try_init_event(pmu, event);
-		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
-			type = event->attr.type;
-			goto again;
-		}
+	if (!pmu)
+		goto fail;
 
-		if (ret)
-			pmu = ERR_PTR(ret);
+	if (event->attr.type != type && type != PERF_TYPE_RAW &&
+	    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
+		goto fail;
 
-		goto unlock;
+	ret = perf_try_init_event(pmu, event);
+	if (ret == -ENOENT && event->attr.type != type && !extended_type) {
+		type = event->attr.type;
+		goto again;
 	}
 
-	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
-		ret = perf_try_init_event(pmu, event);
-		if (!ret)
-			goto unlock;
-
-		if (ret != -ENOENT) {
-			pmu = ERR_PTR(ret);
-			goto unlock;
-		}
-	}
 fail:
-	pmu = ERR_PTR(-ENOENT);
+	if (ret)
+		pmu = ERR_PTR(ret);
+
 unlock:
 	srcu_read_unlock(&pmus_srcu, idx);
 
