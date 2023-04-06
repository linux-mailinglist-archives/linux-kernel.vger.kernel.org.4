Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC16D93A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbjDFKGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbjDFKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:05:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A23B5FCF;
        Thu,  6 Apr 2023 03:05:21 -0700 (PDT)
Date:   Thu, 06 Apr 2023 10:05:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680775519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtBwv407r3SAF6Swovvpje9RF/5WDCm8wYaw2CnX4Sc=;
        b=ZdX2rvYe3ClPSQAb8kALWpLgrxSKUFNS8S6fbkhmGB217LowdRgPgx4bHFbb6k3l93ti5h
        NOVhy50nZ510upWaiSptUatUXY0OIw4PpJ60ZhHuURetMtATYwIveOf5iP/VSkZyERZS3m
        6ZYrdQFjFu6cfkkPb6vmfLe3neJbRIm1b7EyvScqy0J4VBxvrUgUW7gv+qEZgq7TTVVgW0
        AJ+kv2U5Xcb9S7iGPO1gSu+oeY4ZaJe0kzwfQs/J49Z8pYsMfw0TY3Xo2OQdoe1Dpr5o54
        C27I3XhyCo9WefbUnjFVKgJjbn2jfAQ3zSObSN5ixlCMl8CfrE1ZaOdxgU2QFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680775519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RtBwv407r3SAF6Swovvpje9RF/5WDCm8wYaw2CnX4Sc=;
        b=crAfDN44zbMVh3jCuDRfhfAfgkuERL7EdJk0z9fOi1bfNEAHJtudV1451+Dhm32dGGzADj
        HnRwx2qQncrnhYBg==
From:   "tip-bot2 for Libo Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix inaccurate tally of ttwu_move_affine
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Libo Chen <libo.chen@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220810223313.386614-1-libo.chen@oracle.com>
References: <20220810223313.386614-1-libo.chen@oracle.com>
MIME-Version: 1.0
Message-ID: <168077551915.404.18277041961422238219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     39afe5d6fc59237ff7738bf3ede5a8856822d59d
Gitweb:        https://git.kernel.org/tip/39afe5d6fc59237ff7738bf3ede5a8856822d59d
Author:        Libo Chen <libo.chen@oracle.com>
AuthorDate:    Wed, 10 Aug 2022 15:33:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Apr 2023 09:58:48 +02:00

sched/fair: Fix inaccurate tally of ttwu_move_affine

There are scenarios where non-affine wakeups are incorrectly counted as
affine wakeups by schedstats.

When wake_affine_idle() returns prev_cpu which doesn't equal to
nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
in wake_affine() and be counted as if target == this_cpu in schedstats.

Replace target == nr_cpumask_bits with target != this_cpu to make sure
affine wakeups are accurately tallied.

Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Libo Chen <libo.chen@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20220810223313.386614-1-libo.chen@oracle.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc358dc..f5da01a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6582,7 +6582,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
 	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
-	if (target == nr_cpumask_bits)
+	if (target != this_cpu)
 		return prev_cpu;
 
 	schedstat_inc(sd->ttwu_move_affine);
