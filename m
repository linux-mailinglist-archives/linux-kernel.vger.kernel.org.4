Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48B6FDF21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjEJNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbjEJNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62941BE5;
        Wed, 10 May 2023 06:49:20 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKGyqrD8zYmw4nObiR+R8GcM1J6bpSuoUPrrBmfOVuQ=;
        b=Ju4n2lm4LwUBxgaIR0G8TXRAYnSCGfOa4+YGCSbp3relLpmPnxjC/VMEnQ5zHbSvUGtWsW
        l3+sgzcl/6Z2m4pO4qytTu6blG1I1fz/wIHXSauTJynlNdP7nj+Odqg1jZD5wFblLLN366
        GfYMuXzJl0nuFRyUkqfNYuUK+rsnmuZV9ZT4DtsBtA1EFpN/93rGKZnVpbFYO4nRHiwhB0
        ZodMurDaYdDan3wHe68h9VP5CwO9sUoiORX2F2BHsooN3DqO2uixu139aVc2M90WB+J6H8
        +rv81dS7htX1uTB7AIQAlLAnT3ZpxD6EbV6Qaj2mjK/j8a74gkYnIsO4awc+cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726554;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKGyqrD8zYmw4nObiR+R8GcM1J6bpSuoUPrrBmfOVuQ=;
        b=GK8BhBBMjofjX2uB1ahdZRDsw28rp0kbR1XazHu7tzEKzWi+T1Xd3sc7Cz3t1415GWFTvB
        DXbTE4nA3+MGGCBQ==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Keep a fully_busy SMT sched group as busiest
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-6-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-6-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655364.404.8890048970678444740.tip-bot2@tip-bot2>
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

Commit-ID:     5fd6d7f43958cb62da105c8413eac3e78480f09a
Gitweb:        https://git.kernel.org/tip/5fd6d7f43958cb62da105c8413eac3e78480f09a
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:35 +02:00

sched/fair: Keep a fully_busy SMT sched group as busiest

When comparing two fully_busy scheduling groups, keep the current busiest
group if it represents an SMT core. Tasks in such scheduling group share
CPU resources and need more help than tasks in a non-SMT fully_busy group.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-6-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 85ce249..4a9f040 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9619,10 +9619,22 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		 * contention when accessing shared HW resources.
 		 *
 		 * XXX for now avg_load is not computed and always 0 so we
-		 * select the 1st one.
+		 * select the 1st one, except if @sg is composed of SMT
+		 * siblings.
 		 */
-		if (sgs->avg_load <= busiest->avg_load)
+
+		if (sgs->avg_load < busiest->avg_load)
 			return false;
+
+		if (sgs->avg_load == busiest->avg_load) {
+			/*
+			 * SMT sched groups need more help than non-SMT groups.
+			 * If @sg happens to also be SMT, either choice is good.
+			 */
+			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
+				return false;
+		}
+
 		break;
 
 	case group_has_spare:
