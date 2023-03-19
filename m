Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE29B6BF78C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 04:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCRDbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 23:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCRDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 23:31:42 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E243E1E3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 20:31:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id DE4961A00AE2;
        Sat, 18 Mar 2023 11:31:40 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I47z3DFNmwEc; Sat, 18 Mar 2023 11:31:40 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id A5BDC1A0091E;
        Sat, 18 Mar 2023 11:31:39 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] sched: core: Optimize the structure of 'tg_cfs_schedulable_down' function
Date:   Mon, 20 Mar 2023 04:02:55 +0800
Message-Id: <20230319200255.3640-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize if branches and define  in the branch statement
block　parent_quota variable.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/sched/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 488655f2319f..7e8535d2e36d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10915,15 +10915,12 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
 {
 	struct cfs_schedulable_data *d = data;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-	s64 quota = 0, parent_quota = -1;
+	s64 quota = RUNTIME_INF;
 
-	if (!tg->parent) {
-		quota = RUNTIME_INF;
-	} else {
+	if (tg->parent) {
 		struct cfs_bandwidth *parent_b = &tg->parent->cfs_bandwidth;
-
+		s64 parent_quota = parent_b->hierarchical_quota;
 		quota = normalize_cfs_quota(tg, d);
-		parent_quota = parent_b->hierarchical_quota;
 
 		/*
 		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
-- 
2.18.2

