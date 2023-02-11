Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D63693000
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBKKbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBKKa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:30:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DA2197F;
        Sat, 11 Feb 2023 02:30:56 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:30:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676111454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmdPyDM+tz9rqCjEuFxQxMiI/xnQqO9uZI+vZtzn3Wk=;
        b=X2RJ+HJ1WB/o9LsLjk5UpoikHGHsiOe95xxcU4MNZCNBydle+Idg0S8Bg39uYdO97kKvaA
        ihSx6E1D9ekBJak8kuBN/p3wL59VzKtpFCyG71uuHhU5Ok5wOImL9aanY1+nUMM8UgWOBB
        sHLpFMYffqj2T7boEFik8FXNpZUbr00IOX1a6oS/H4lmnDveBtbX+sre6FlZNSIB2HcJck
        JDm/SNf8uUlyLytqEuD+w0QkeC4+IkWBTwNEtJFlYAEDa7nvxgmc1Wtai4lB32b/LV4Hzh
        OfiW+J5WF6ZE2EsV0eg7ulOxxzBqrVnQlIUuFdWtNzEnLbBPVCWpZZpMrsfYng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676111454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmdPyDM+tz9rqCjEuFxQxMiI/xnQqO9uZI+vZtzn3Wk=;
        b=ygGh37fT/U8VUfzwN02SQL2XQczNcXlTzUNXmMloRz8kEAtKoOLRhY5m4tyZmAN9W0JPtN
        xgDvr4ej7m7UG7Bw==
From:   "tip-bot2 for Zhang Qiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: sanitize vruntime of entity being placed
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        Roman Kagan <rkagan@amazon.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130122216.3555094-1-rkagan@amazon.de>
References: <20230130122216.3555094-1-rkagan@amazon.de>
MIME-Version: 1.0
Message-ID: <167611145417.4906.10757655452818382605.tip-bot2@tip-bot2>
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

Commit-ID:     829c1651e9c4a6f78398d3e67651cef9bb6b42cc
Gitweb:        https://git.kernel.org/tip/829c1651e9c4a6f78398d3e67651cef9bb6b42cc
Author:        Zhang Qiao <zhangqiao22@huawei.com>
AuthorDate:    Mon, 30 Jan 2023 13:22:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Feb 2023 11:18:09 +01:00

sched/fair: sanitize vruntime of entity being placed

When a scheduling entity is placed onto cfs_rq, its vruntime is pulled
to the base level (around cfs_rq->min_vruntime), so that the entity
doesn't gain extra boost when placed backwards.

However, if the entity being placed wasn't executed for a long time, its
vruntime may get too far behind (e.g. while cfs_rq was executing a
low-weight hog), which can inverse the vruntime comparison due to s64
overflow.  This results in the entity being placed with its original
vruntime way forwards, so that it will effectively never get to the cpu.

To prevent that, ignore the vruntime of the entity being placed if it
didn't execute for much longer than the characteristic sheduler time
scale.

[rkagan: formatted, adjusted commit log, comments, cutoff value]
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Co-developed-by: Roman Kagan <rkagan@amazon.de>
Signed-off-by: Roman Kagan <rkagan@amazon.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230130122216.3555094-1-rkagan@amazon.de
---
 kernel/sched/fair.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6c8e7f..ff4dbba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4652,6 +4652,7 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = cfs_rq->min_vruntime;
+	u64 sleep_time;
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -4681,8 +4682,18 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		vruntime -= thresh;
 	}
 
-	/* ensure we never gain time by being placed backwards. */
-	se->vruntime = max_vruntime(se->vruntime, vruntime);
+	/*
+	 * Pull vruntime of the entity being placed to the base level of
+	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
+	 * slept for a long time, don't even try to compare its vruntime with
+	 * the base as it may be too far off and the comparison may get
+	 * inversed due to s64 overflow.
+	 */
+	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
+	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+		se->vruntime = vruntime;
+	else
+		se->vruntime = max_vruntime(se->vruntime, vruntime);
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
