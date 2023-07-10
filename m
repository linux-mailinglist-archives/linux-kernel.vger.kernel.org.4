Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6ED74D01C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGJIiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGJIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:37:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34BAE7;
        Mon, 10 Jul 2023 01:37:53 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:37:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688978272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkEV7e94CvD29tG1A+d36LoGy9+Z10KJyC4UL+8m9vA=;
        b=E8fcE1zE/0LL0PTIC0UeKJ7pC2LWoMgmNJHt4pVpiUU9Iy50ohNZi5IlEz0wYRdZhyeDSK
        69cL8rCVvP1lOnEGG0s3uAwtYW3qHaLgE3XZX9OlM2bD6Greuvq6Heng67GEUjckGhkMbi
        lCksUVzpyfHoSjaM8UuXQ4ysGwJ0RzRL/VFKt/B0TgFXmS+PORx+56EpSucKihp4t9MxHQ
        7yEgDLy5gX2XWE1jEn8Sm0lP0R83CbvOqvQnG3eABsscgs/47i1lAOBy8Kl8FSEtc7GmzI
        IK4M0LeCDd4UVFBu67p0A2TKALfi58lOs1+H1Qmdmq2OuU2O5wS+Ur1MN+cEXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688978272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkEV7e94CvD29tG1A+d36LoGy9+Z10KJyC4UL+8m9vA=;
        b=7WXTwqYYgsdP5/PLGDq/L4BOl1mLw/sgBUusU7m8IIQrc7V8NgSXa0mMTIKf64O0cIhfjx
        GHG7phTOQ5APlECg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Use local64_try_cmpxchg
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230706141720.2672-1-ubizjak@gmail.com>
References: <20230706141720.2672-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168897827185.404.3533982389263997885.tip-bot2@tip-bot2>
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

Commit-ID:     4c1c9dea2089374cb58505a0df6136969ff3c8b9
Gitweb:        https://git.kernel.org/tip/4c1c9dea2089374cb58505a0df6136969ff3c8b9
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 06 Jul 2023 16:16:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:35 +02:00

perf/x86: Use local64_try_cmpxchg

Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after cmpxchg (and related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc. "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230706141720.2672-1-ubizjak@gmail.com
---
 arch/x86/events/amd/ibs.c      |  4 ++--
 arch/x86/events/core.c         | 10 ++++------
 arch/x86/events/intel/cstate.c | 10 ++++------
 arch/x86/events/msr.c          |  8 +++-----
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 74e6642..7d29be0 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -156,8 +156,8 @@ perf_event_try_update(struct perf_event *event, u64 new_raw_count, int width)
 	 * count to the generic event atomically:
 	 */
 	prev_raw_count = local64_read(&hwc->prev_count);
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-					new_raw_count) != prev_raw_count)
+	if (!local64_try_cmpxchg(&hwc->prev_count,
+				 &prev_raw_count, new_raw_count))
 		return 0;
 
 	/*
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9d24870..23c9642 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -129,13 +129,11 @@ u64 x86_perf_event_update(struct perf_event *event)
 	 * exchange a new raw count - then add that new-prev delta
 	 * count to the generic event atomically:
 	 */
-again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	rdpmcl(hwc->event_base_rdpmc, new_raw_count);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-					new_raw_count) != prev_raw_count)
-		goto again;
+	do {
+		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+				      &prev_raw_count, new_raw_count));
 
 	/*
 	 * Now we have the new raw value and have updated the prev
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 835862c..97035db 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -365,13 +365,11 @@ static void cstate_pmu_event_update(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	u64 prev_raw_count, new_raw_count;
 
-again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	new_raw_count = cstate_pmu_read_counter(event);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count)
-		goto again;
+	do {
+		new_raw_count = cstate_pmu_read_counter(event);
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+				      &prev_raw_count, new_raw_count));
 
 	local64_add(new_raw_count - prev_raw_count, &event->count);
 }
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 0feaaa5..61c59e0 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -244,12 +244,10 @@ static void msr_event_update(struct perf_event *event)
 	s64 delta;
 
 	/* Careful, an NMI might modify the previous event value: */
-again:
 	prev = local64_read(&event->hw.prev_count);
-	now = msr_read_counter(event);
-
-	if (local64_cmpxchg(&event->hw.prev_count, prev, now) != prev)
-		goto again;
+	do {
+		now = msr_read_counter(event);
+	} while (!local64_try_cmpxchg(&event->hw.prev_count, &prev, now));
 
 	delta = now - prev;
 	if (unlikely(event->hw.event_base == MSR_SMI_COUNT)) {
