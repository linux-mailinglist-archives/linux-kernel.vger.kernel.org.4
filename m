Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C666FDF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbjEJNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbjEJNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82D7D96;
        Wed, 10 May 2023 06:49:19 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daQbWBn3z/bvLFEar+JNX4QlqkiGxgGZ2GC2wZDBP28=;
        b=KCPxjakpb1DTXH5KU3uqYR8/XSkWM2tuIn9yfutd+3eAdfqC2ZcFTuP7FzDtP4J5E3l2mI
        9hNBfbOlk5WN2yfVAL3rCpFR8Zq83VuprtiM6SGsE5kTQUCYs2BUtFi2KpP9iTRwXu9X9P
        +mKlfgFDDZRlNdXVcXrOV/Q8bzYhZpYAvoh1uyAZHAKU3s1rTl7vLKPoLSCzG/+kO478fz
        rlM7F3ik9yaN/8hPr5MmBI/kJvu4UGsnuvOWvTldMMa2d0r7nhbLRnnDUOpPQiMacN3jGu
        7YiHggxw14ZvSQWd3jTeMdJjyBxpYbxIcYDhKI1UhMih40JkEToUUgTfaJPULQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726552;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=daQbWBn3z/bvLFEar+JNX4QlqkiGxgGZ2GC2wZDBP28=;
        b=1Nj8HBSJfrBJuU2UTNJp2flUKQ8sxOdyQ2Cv4ddPB2jbLBFYfVCZyVIDAd2m7Hiu/0Pcpd
        NNUJu6SAv+x/N5DQ==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Check SDF_SHARED_CHILD in
 highest_flag_domain()
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-9-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-9-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655213.404.5276333289857461855.tip-bot2@tip-bot2>
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

Commit-ID:     40b4d3dc328265c8ec6688657d74813edf785c83
Gitweb:        https://git.kernel.org/tip/40b4d3dc328265c8ec6688657d74813edf785c83
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:44 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:36 +02:00

sched/topology: Check SDF_SHARED_CHILD in highest_flag_domain()

Do not assume that all the children of a scheduling domain have a given
flag. Check whether it has the SDF_SHARED_CHILD meta flag.

Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230406203148.19182-9-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/sched.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0..6784462 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1772,6 +1772,13 @@ queue_balance_callback(struct rq *rq,
 	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
 			__sd; __sd = __sd->parent)
 
+/* A mask of all the SD flags that have the SDF_SHARED_CHILD metaflag */
+#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_SHARED_CHILD)) |
+static const unsigned int SD_SHARED_CHILD_MASK =
+#include <linux/sched/sd_flags.h>
+0;
+#undef SD_FLAG
+
 /**
  * highest_flag_domain - Return highest sched_domain containing flag.
  * @cpu:	The CPU whose highest level of sched domain is to
@@ -1779,16 +1786,25 @@ queue_balance_callback(struct rq *rq,
  * @flag:	The flag to check for the highest sched_domain
  *		for the given CPU.
  *
- * Returns the highest sched_domain of a CPU which contains the given flag.
+ * Returns the highest sched_domain of a CPU which contains @flag. If @flag has
+ * the SDF_SHARED_CHILD metaflag, all the children domains also have @flag.
  */
 static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
 {
 	struct sched_domain *sd, *hsd = NULL;
 
 	for_each_domain(cpu, sd) {
-		if (!(sd->flags & flag))
+		if (sd->flags & flag) {
+			hsd = sd;
+			continue;
+		}
+
+		/*
+		 * Stop the search if @flag is known to be shared at lower
+		 * levels. It will not be found further up.
+		 */
+		if (flag & SD_SHARED_CHILD_MASK)
 			break;
-		hsd = sd;
 	}
 
 	return hsd;
