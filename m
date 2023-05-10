Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0F6FDF1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbjEJNt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbjEJNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E6B132;
        Wed, 10 May 2023 06:49:20 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STLE+lEn62lghiT5iyQdNTaJC1NuBzr89zYXWMekTp0=;
        b=CtPMBuVF7WaWozv6J/2r2cPCspuBicu0mgOKHgKgyZzBmA2IjQbgNibO0EgHXx2zKTGp9w
        yrHDv+69j1GNkbG1ZFtmnPjO8uM/9SPvfEK1J3Z5WwV6llTPs7sYrwwbNdbYn0Jw5b8WVV
        aL6Ik/VjNslXFj8AqF37yefAzM0rrwNzwhB14aG5zO+Gk54VOB4/ohf66dbI4OZH2aqVjL
        dF5ZPnyHBe0rvNYSRTvgcVtuwzG1WsLwfGHMyRmCc9FVcDxacV5iHr62wm+RDzCcPJy28f
        uPBipye2MbhXDh9LI1y+6+W42TwtFRSwqBdBlKV6jjEvyyxNdx716dZP6fsEzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STLE+lEn62lghiT5iyQdNTaJC1NuBzr89zYXWMekTp0=;
        b=qdK8CC51mcF/5yQ4xwGrP1jwTrcPp0N8/lKICf2Wz09XpBSo7vH9gLUvPvcVpa0+10BJxU
        un6tQDRg5B0aK/CA==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use the busiest group to set prefer_sibling
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-7-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-7-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655311.404.12627370082433827466.tip-bot2@tip-bot2>
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

Commit-ID:     43726bdedd29797d8e1fee2e7300a6d2b9a74ba8
Gitweb:        https://git.kernel.org/tip/43726bdedd29797d8e1fee2e7300a6d2b9a74ba8
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:35 +02:00

sched/fair: Use the busiest group to set prefer_sibling

The prefer_sibling setting acts on the busiest group to move excess tasks
to the local group. This should be done as per request of the child of the
busiest group's sched domain, not the local group's.

Using the flags of the child domain of the local group works fortuitously
if both groups have child domains.

There are cases, however, in which the busiest group's sched domain has
child but the local group's does not. Consider, for instance a non-SMT
core (or an SMT core with only one online sibling) doing load balance with
an SMT core at the MC level. SD_PREFER_SIBLING of the busiest group's child
domain will not be honored. We are left with a fully busy SMT core and an
idle non-SMT core.

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-7-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4a9f040..3bb8934 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10109,7 +10109,6 @@ static void update_idle_cpu_scan(struct lb_env *env,
 
 static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
 {
-	struct sched_domain *child = env->sd->child;
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
@@ -10150,8 +10149,13 @@ next_group:
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
-	/* Tag domain that child domain prefers tasks go to siblings first */
-	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
+	/*
+	 * Indicate that the child domain of the busiest group prefers tasks
+	 * go to a child's sibling domains first. NB the flags of a sched group
+	 * are those of the child domain.
+	 */
+	if (sds->busiest)
+		sds->prefer_sibling = !!(sds->busiest->flags & SD_PREFER_SIBLING);
 
 
 	if (env->sd->flags & SD_NUMA)
@@ -10461,7 +10465,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 			goto out_balanced;
 	}
 
-	/* Try to move all excess tasks to child's sibling domain */
+	/*
+	 * Try to move all excess tasks to a sibling domain of the busiest
+	 * group's child domain.
+	 */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
 	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
