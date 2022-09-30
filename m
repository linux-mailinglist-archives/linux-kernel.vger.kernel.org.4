Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4B5F0E73
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiI3PI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiI3PIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:08:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C50123862;
        Fri, 30 Sep 2022 08:08:22 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:08:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664550500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X/ScWaJn1guN80DtTj6ved5QMmkDsamZLtRuGzb/tdU=;
        b=2HqaEC8Rv+3wVi5ktmDC2UD3kd7o289DbYKlmn3vW2zhpqlx2BxY3cRC0Sef7TsUEjaC2f
        GMtDA3Xrl00+opeRSTOZ+p75ZvcAJsWnTahQ67vvtW1/hpJ7P/i30F86rBWZM36JHd2gSA
        XvBmmF2/Kvonmv25z0eurm6DVD/Z0Rcsf/TcHWxdxKgRVJanVoEHnbwtTwT63VUGhQI4I6
        y5sQPpHSalLtSzhL6RAVYXiFr+cvrV+CIWSwt6iGchFe750MyuXjLDWEdrwWktqHgpMw+j
        gmFXdKCiAfFHGWuJy/R/tgUEhyERp3hQNq+n2nFHiYy+R/Mz8H5cnnqIDQ93ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664550500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X/ScWaJn1guN80DtTj6ved5QMmkDsamZLtRuGzb/tdU=;
        b=5ovaI+0zVgzLa+8H5FEJdbaBRZRA+JMLcK2dPEGQcxpxoQp95k+GGhQSTcjTzKmsCSKz4M
        5V1H88hjbegyeTAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix more TASK_state comparisons
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166455049908.401.1699307801221496389.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fdf756f7127185eeffe00e918e66dfee797f3625
Gitweb:        https://git.kernel.org/tip/fdf756f7127185eeffe00e918e66dfee797f3625
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Sep 2022 16:39:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 30 Sep 2022 16:50:39 +02:00

sched: Fix more TASK_state comparisons

Boris reported hung_task splats after commit 5aec788aeb8e ("sched: Fix
TASK_state comparisons"). Upon closer consideration of that change it
doesn't only exclude TASK_KILLABLE, but also TASK_IDLE.

Update the comment to reflect this fact and add an additional
TASK_NOLOAD test to exclude them.

Additionally, remove the TASK_FREEZABLE early exit from
check_hung_task(), a freezable task is not a frozen task.

Fixes: 5aec788aeb8e ("sched: Fix TASK_state comparisons")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Borislav Petkov <bp@alien8.de>
---
 kernel/hung_task.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 3a15169..c71889f 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -95,7 +95,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * Ensure the task is not frozen.
 	 * Also, skip vfork and any other user process that freezer should skip.
 	 */
-	if (unlikely(READ_ONCE(t->__state) & (TASK_FREEZABLE | TASK_FROZEN)))
+	if (unlikely(READ_ONCE(t->__state) & TASK_FROZEN))
 		return;
 
 	/*
@@ -200,10 +200,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 				goto unlock;
 			last_break = jiffies;
 		}
-		/* skip the TASK_KILLABLE tasks -- these can be killed */
+		/*
+		 * skip the TASK_KILLABLE tasks -- these can be killed
+		 * skip the TASK_IDLE tasks -- those are genuinely idle
+		 */
 		state = READ_ONCE(t->__state);
 		if ((state & TASK_UNINTERRUPTIBLE) &&
-		    !(state & TASK_WAKEKILL))
+		    !(state & TASK_WAKEKILL) &&
+		    !(state & TASK_NOLOAD))
 			check_hung_task(t, timeout);
 	}
  unlock:
