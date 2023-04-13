Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C46E0CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDMLjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjDMLjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:39:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3030F2D44;
        Thu, 13 Apr 2023 04:39:09 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:39:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681385947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2I/H6ikXZS+0X6d3hXT76wrpWBLuX8bWchyD1Vp8Ch0=;
        b=AIkH/eQICTWpOesNhSiyK4hR856+jA6Nur7zLyZrUuO24Ar6RK8MD4IR1XSmIZXIqQ5l//
        EmKFqNZYA9LxQcmSwHRO957izHNdfIA1Q5ZEUTuQcDLUEazdVztxu0G9qUSNysmq23owkz
        OfXuN91+VB8LDJ/KrL8rwaXQO8sCTDALxAXq99hifI99jeiFfOz13oMJWXZewGsvwhmGiS
        V8TNs7VX3xJMbkZsssSiEGExUdfLD+WuZqJ0WiJ0qRqYNBDa853+w10SfgieNCjUgDyCle
        s0mZfqjhD+nPBvd0OFdARa/JjUZFRUWxhIjtLbwmAxSVYgnP11okG6/N8xak/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681385947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2I/H6ikXZS+0X6d3hXT76wrpWBLuX8bWchyD1Vp8Ch0=;
        b=YFXCyzPwJsOETZBX+ECJ9kNa86xLkzlA3eQEd2CgIfSnfOp/AtUUMY2c8nvzjcNzn2dD8O
        x6IXKy++062+sEBg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix imbalance overflow
Cc:     Tingjia Cao <tjcao980311@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168138594723.404.11738777497442624414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     91dcf1e8068e9a8823e419a7a34ff4341275fb70
Gitweb:        https://git.kernel.org/tip/91dcf1e8068e9a8823e419a7a34ff4341275fb70
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 11 Apr 2023 11:06:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 Apr 2023 16:46:30 +02:00

sched/fair: Fix imbalance overflow

When local group is fully busy but its average load is above system load,
computing the imbalance will overflow and local group is not the best
target for pulling this load.

Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
Reported-by: Tingjia Cao <tjcao980311@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Tingjia Cao <tjcao980311@gmail.com>
Link: https://lore.kernel.org/lkml/CABcWv9_DAhVBOq2=W=2ypKE9dKM5s2DvoV8-U0+GDwwuKZ89jQ@mail.gmail.com/T/
---
 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6986ea3..5f6587d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10238,6 +10238,16 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
 				sds->total_capacity;
+
+		/*
+		 * If the local group is more loaded than the average system
+		 * load, don't try to pull any tasks.
+		 */
+		if (local->avg_load >= sds->avg_load) {
+			env->imbalance = 0;
+			return;
+		}
+
 	}
 
 	/*
