Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397F86FDF23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjEJNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbjEJNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF1A469B;
        Wed, 10 May 2023 06:49:21 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qa6epiS/rQZ6R6hQykpfIRIE1kFbFThqRMJpi8z/Ro=;
        b=UYIHxwniLV3tlvYSngJ/wxmw3CImKjnBLbm9EnQwCyWPh02SXTn6xWKAF9av+falLlbEwB
        4l3/l7v+ZJnUGMSiQvNdn/jHhmIdo29HrwQDSqgtpnobodb+tNs+feGvxiCs7v3YFVW8aZ
        ERO1YYDJOleeeB2xAw+w+jPxnl3ZyNfwNr4lZ/4LF+dGmSkI0wmOQTIWFKDkzRsfS27HxN
        4acPK/La6GO+KUg8rnHW0mAt/dPVtQ4L74P957xxxdcGLWSyjWiM2yD5VX5RoRD/eDBkt3
        Je8kZtQMLlDrVp1XJGKyBdmLayv7cH+hwPQZQ59TMUcv2PQEV6SP60lkTVyjUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Qa6epiS/rQZ6R6hQykpfIRIE1kFbFThqRMJpi8z/Ro=;
        b=br7TRLPXyn60a7ohtzxKpLuGg8BCfsKD4c738Nlj3tVB2ETG43QpvXl2ngTFmHG6x5CU52
        W6uuwsysMH54IHDA==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Move is_core_idle() out of CONFIG_NUMA
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-2-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-2-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655561.404.2932262333236727103.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8b36d07f1d63de102d464f44a89704bc62d00811
Gitweb:        https://git.kernel.org/tip/8b36d07f1d63de102d464f44a89704bc62d00811
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:33 +02:00

sched/fair: Move is_core_idle() out of CONFIG_NUMA

asym_packing needs this function to determine whether an SMT core is a
suitable destination for load balancing.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-2-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f..a47208d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1064,6 +1064,23 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * Scheduling class queueing methods:
  */
 
+static inline bool is_core_idle(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	int sibling;
+
+	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
+		if (cpu == sibling)
+			continue;
+
+		if (!idle_cpu(sibling))
+			return false;
+	}
+#endif
+
+	return true;
+}
+
 #ifdef CONFIG_NUMA
 #define NUMA_IMBALANCE_MIN 2
 
@@ -1700,23 +1717,6 @@ struct numa_stats {
 	int idle_cpu;
 };
 
-static inline bool is_core_idle(int cpu)
-{
-#ifdef CONFIG_SCHED_SMT
-	int sibling;
-
-	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
-		if (cpu == sibling)
-			continue;
-
-		if (!idle_cpu(sibling))
-			return false;
-	}
-#endif
-
-	return true;
-}
-
 struct task_numa_env {
 	struct task_struct *p;
 
