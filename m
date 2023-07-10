Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D774D018
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGJIiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGJIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:37:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D7E6;
        Mon, 10 Jul 2023 01:37:53 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:37:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688978272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUn+6Bo1QBKBDK8RwHrPsSPwL7VkjRzPfS9/sg4u31c=;
        b=M06fGKAE6ERw5kLlpZVH/oGeAXIfutzXNjrVHaTNY0+LfYNz3SVhofFih2djuPpTu/wxym
        cpg7RIx5SAeWxfl++M/5N/oXje9d3PsrcLWug31KsCEdPCeEJK6Suy03XwLqe8kJEAKv1v
        5htR/HyXst+a66Pt5yWtaQeSpqv+WnSD81eiWcfK9OVAXRoFhbeLRrqRDV+gnxIKzQRHZt
        gWw3YxqAg16scveBvdoVS/ns2bvhsSIdvWcIfhknyuw2i9nrdbI3I5dBCTYZuQqOmA8WC+
        6Zs/SHBofcvOp+QKUBIapJ4qe8FMZnRm6OO/UoN7Y14VLF6ZVsbF/841AEWUPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688978272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUn+6Bo1QBKBDK8RwHrPsSPwL7VkjRzPfS9/sg4u31c=;
        b=8vptgk6J3Ee6tJikx/zsVGwBt4ClhLlWY8hA+syearJDRE/Ss5P9TAj0U+HaZC66ORj5+Z
        janxNOAO5nRSflCg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Use local64_try_cmpxchg in
 perf_swevent_set_period
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230708081129.45915-1-ubizjak@gmail.com>
References: <20230708081129.45915-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168897827147.404.3167586601225398989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     28fd85a10a2a73658c6e26056d9e093de06b5a22
Gitweb:        https://git.kernel.org/tip/28fd85a10a2a73658c6e26056d9e093de06b5a22
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sat, 08 Jul 2023 10:10:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:35 +02:00

perf/core: Use local64_try_cmpxchg in perf_swevent_set_period

Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old
in perf_swevent_set_period.  x86 CMPXCHG instruction returns success in ZF
flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230708081129.45915-1-ubizjak@gmail.com
---
 kernel/events/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 78ae7b6..f84e264 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9595,16 +9595,16 @@ u64 perf_swevent_set_period(struct perf_event *event)
 
 	hwc->last_period = hwc->sample_period;
 
-again:
-	old = val = local64_read(&hwc->period_left);
-	if (val < 0)
-		return 0;
+	old = local64_read(&hwc->period_left);
+	do {
+		val = old;
+		if (val < 0)
+			return 0;
 
-	nr = div64_u64(period + val, period);
-	offset = nr * period;
-	val -= offset;
-	if (local64_cmpxchg(&hwc->period_left, old, val) != old)
-		goto again;
+		nr = div64_u64(period + val, period);
+		offset = nr * period;
+		val -= offset;
+	} while (!local64_try_cmpxchg(&hwc->period_left, &old, val));
 
 	return nr;
 }
