Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3A705E86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjEQEDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjEQEDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:03:12 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 84B6A3A9C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:03:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id B2F4D180120CD7;
        Wed, 17 May 2023 12:03:00 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] sched: core: Simplify cpuset_cpumask_can_shrink()
Date:   Fri, 19 May 2023 04:34:16 +0800
Message-Id: <20230518203416.3323-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless intermediate variable "ret" and its initialization.
Directly return dl_cpuset_cpumask_can_shrink() result.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/sched/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a66960da3f5c..f3f2ece26291 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9273,14 +9273,10 @@ void __init init_idle(struct task_struct *idle, int cpu)
 int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 			      const struct cpumask *trial)
 {
-	int ret = 1;
-
 	if (cpumask_empty(cur))
-		return ret;
-
-	ret = dl_cpuset_cpumask_can_shrink(cur, trial);
+		return 1;
 
-	return ret;
+	return dl_cpuset_cpumask_can_shrink(cur, trial);
 }
 
 int task_can_attach(struct task_struct *p,
-- 
2.18.2

