Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9F6F022F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbjD0H5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242987AbjD0H5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:57:17 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 759DFDE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:57:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3EBBA1801193B1;
        Thu, 27 Apr 2023 15:57:14 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] sched: core: Simplify sched_can_stop_tick()
Date:   Sat, 29 Apr 2023 08:28:31 +0800
Message-Id: <20230429002831.2875-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless intermediate variable "fifo_nr_running".

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3249c1272e57..1bab401920e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1176,8 +1176,6 @@ static void nohz_csd_func(void *info)
 #ifdef CONFIG_NO_HZ_FULL
 bool sched_can_stop_tick(struct rq *rq)
 {
-	int fifo_nr_running;
-
 	/* Deadline tasks, even if single, need the tick */
 	if (rq->dl.dl_nr_running)
 		return false;
@@ -1197,8 +1195,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * If there's no RR tasks, but FIFO tasks, we can skip the tick, no
 	 * forced preemption between FIFO tasks.
 	 */
-	fifo_nr_running = rq->rt.rt_nr_running - rq->rt.rr_nr_running;
-	if (fifo_nr_running)
+	if (rq->rt.rt_nr_running - rq->rt.rr_nr_running)
 		return true;
 
 	/*
-- 
2.18.2

