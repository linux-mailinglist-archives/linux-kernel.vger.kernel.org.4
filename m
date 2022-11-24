Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646AB637876
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiKXMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiKXMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCCC60685;
        Thu, 24 Nov 2022 04:03:04 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:03:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10A2Ap9seqEIVSGltb1NkNdPUOpWyyLq4f6tk2n+K6w=;
        b=WQdc3Xr9lC331UbiUsUnYAsc+yKSIX9To/F/K3713N3/Ho9lkKQqJ3QRII+4GgICTuYG5c
        YTrwETf5jDvLVM2dqBRPWlvsWd+5F9vdLP3TcXJv+qxSUXdIR42D8AQVHpoykpB7bU8tyL
        UB6uK84eXsrRt5sPlInVBxWSA8CFAYE8qSxbW2oUpORXOcTR7Z4O7zq9UvzUKxugWHtjHb
        htmh+jZAGuyAJLhxBLKsaFsgIh6LZAF67pLDeXVUorqBwIikQREp50ZEEICmOd6gchMSzY
        0eeBwpUKPTQjRLa8QfEhX+N6WPTAxmAZbkTvVzNTWQ8M9KXMRDQ6uwCED0g6Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10A2Ap9seqEIVSGltb1NkNdPUOpWyyLq4f6tk2n+K6w=;
        b=AvVHk75+BIjqEiI/45TYnbrtjlWtnhJDZJ1Am3T9kUuz4Ocg8WCRhI1Ky5zX5zym3H1/FH
        DesckpDE4vlHM9CQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Don't allow grouping events from
 different hw pmus
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122080326.228-1-ravi.bangoria@amd.com>
References: <20221122080326.228-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166929138240.4906.17980748237008458473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bf480f9385667309a8866e65833f261d4773df9a
Gitweb:        https://git.kernel.org/tip/bf480f9385667309a8866e65833f261d4773df9a
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Tue, 22 Nov 2022 13:33:26 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:19 +01:00

perf/core: Don't allow grouping events from different hw pmus

Event group from different hw pmus does not make sense and thus perf
has never allowed it. However, with recent rewrite that restriction
has been inadvertently removed. Fix it.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221122080326.228-1-ravi.bangoria@amd.com
---
 kernel/events/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f2b865c..65e20c5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12503,15 +12503,21 @@ SYSCALL_DEFINE5(perf_event_open,
 			 * perf_event_pmu_context.
 			 */
 			pmu = group_leader->pmu_ctx->pmu;
-		} else if (!is_software_event(event) &&
-			is_software_event(group_leader) &&
-			(group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
-			/*
-			 * In case the group is a pure software group, and we
-			 * try to add a hardware event, move the whole group to
-			 * the hardware context.
-			 */
-			move_group = 1;
+		} else if (!is_software_event(event)) {
+			if (is_software_event(group_leader) &&
+			    (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
+				/*
+				 * In case the group is a pure software group, and we
+				 * try to add a hardware event, move the whole group to
+				 * the hardware context.
+				 */
+				move_group = 1;
+			}
+
+			/* Don't allow group of multiple hw events from different pmus */
+			if (!in_software_context(group_leader) &&
+			    group_leader->pmu_ctx->pmu != pmu)
+				goto err_locked;
 		}
 	}
 
