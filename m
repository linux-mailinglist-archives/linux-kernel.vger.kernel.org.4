Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C6D66B015
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAOJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjAOJG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:06:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0310B745;
        Sun, 15 Jan 2023 01:06:53 -0800 (PST)
Date:   Sun, 15 Jan 2023 09:06:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673773610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GvZmeTyhLrh/x15CvyWb5V4GzfxinH27mW5DVzh4sOs=;
        b=OMJlEiDgfzwg/CwsPccOjMMf0xmIhAxd5UAfTgGvW9b0fOYH5QMcT4hj2RkBxtIlXZ6eBA
        mdengPvjSjrtC11oUsbyy22oDZ/RVnLbCiGZAmEp4meuqF/tpSHmRFcTZ+AOQ/jZo+8H1F
        2s3gqAEdDJYuhzogEJntn6j3jJZ7Pbu4fZ8dzexpoLyzOmXKXVpEHrlHkxkcx+ZeLjOwXB
        vNdg/FG/vJ6oXTqp+um9xXhYxsCONTKrALHORHQs1bLKJs1aoBFQcRFOmD1zZcBZvDD0tB
        bIxpQTm8JWh0tn16u22WHuOF8ezo5MvaNlQDf3dr611o3w6AS82Z+S9iF6CnPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673773610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GvZmeTyhLrh/x15CvyWb5V4GzfxinH27mW5DVzh4sOs=;
        b=GhXJeylMjTkGKp6dEdJqhQIIkIteTzskpULxKSlGtxGQPZ61wM69qHS7/7bwNlX/KqsQtp
        QnuuvFwMD2OQhfBA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Limit sched slice duration
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113133613.257342-1-vincent.guittot@linaro.org>
References: <20230113133613.257342-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <167377360979.4906.12177832193233588440.tip-bot2@tip-bot2>
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

Commit-ID:     79ba1e607d68178db7d3fe4f6a4aa38f06805e7b
Gitweb:        https://git.kernel.org/tip/79ba1e607d68178db7d3fe4f6a4aa38f06805e7b
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 13 Jan 2023 14:36:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 15 Jan 2023 09:59:00 +01:00

sched/fair: Limit sched slice duration

In presence of a lot of small weight tasks like sched_idle tasks, normal
or high weight tasks can see their ideal runtime (sched_slice) to increase
to hundreds ms whereas it normally stays below sysctl_sched_latency.

2 normal tasks running on a CPU will have a max sched_slice of 12ms
(half of the sched_period). This means that they will make progress
every sysctl_sched_latency period.

If we now add 1000 idle tasks on the CPU, the sched_period becomes
3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
It will even become 1500ms if the idle tasks belongs to an idle cgroup.
This means that the scheduler will look for picking another waiting task
after 609ms running time (1500ms respectively). The idle tasks change
significantly the way the 2 normal tasks interleave their running time
slot whereas they should have a small impact.

Such long sched_slice can delay significantly the release of resources
as the tasks can wait hundreds of ms before the next running slot just
because of idle tasks queued on the rq.

Cap the ideal_runtime to sysctl_sched_latency to make sure that tasks will
regularly make progress and will not be significantly impacted by
idle/background tasks queued on the rq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20230113133613.257342-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e9d906a..d4db72f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4896,7 +4896,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	struct sched_entity *se;
 	s64 delta;
 
-	ideal_runtime = sched_slice(cfs_rq, curr);
+	/*
+	 * When many tasks blow up the sched_period; it is possible that
+	 * sched_slice() reports unusually large results (when many tasks are
+	 * very light for example). Therefore impose a maximum.
+	 */
+	ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
+
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
 	if (delta_exec > ideal_runtime) {
 		resched_curr(rq_of(cfs_rq));
