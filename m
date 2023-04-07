Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE86D8DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjDFC73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjDFC7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:59:25 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 19:59:24 PDT
Received: from mail.nfschina.com (unknown [42.101.60.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27125BA9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:59:24 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7E1801A00B0A;
        Thu,  6 Apr 2023 10:53:39 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v_UpTTwXU7gC; Thu,  6 Apr 2023 10:53:38 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 827B81A00877;
        Thu,  6 Apr 2023 10:53:38 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] sched: rt: Simplify pick_task_rt()
Date:   Sat,  8 Apr 2023 03:24:35 +0800
Message-Id: <20230407192435.3390-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=2.5 required=5.0 tests=DATE_IN_FUTURE_24_48,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless intermediate variable "p" and its initialization. 
Directly return the next RT scheduling task obtained from
_pick_next_task_rt().

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/sched/rt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e9b1c08c20a7..71c930fafac5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1799,14 +1799,10 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 
 static struct task_struct *pick_task_rt(struct rq *rq)
 {
-	struct task_struct *p;
-
 	if (!sched_rt_runnable(rq))
 		return NULL;
 
-	p = _pick_next_task_rt(rq);
-
-	return p;
+	return _pick_next_task_rt(rq);
 }
 
 static struct task_struct *pick_next_task_rt(struct rq *rq)
-- 
2.18.2

