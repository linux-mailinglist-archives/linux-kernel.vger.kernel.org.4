Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D2680D85
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjA3MWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjA3MW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:22:28 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C21165C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1675081348; x=1706617348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IZENi4qwURaFTGnTC1AN+BYamxiUSoV3AazWj7gWB9k=;
  b=cedyAKEOrpUWgH4TliFSQbycNUwFTmOjP1GJrWfTtSXKQgCBMf7tl0oo
   K4AA8smmDTWimrF5EM7Im+IjiStxNIr5DXhLOBRT0DTELZzFXPKh7PuQe
   eG8JwNXbyNXAa2yugCVDL7M3VTifGAd6hQWeXL9R69AoqhqOI43pa2OuP
   8=;
X-IronPort-AV: E=Sophos;i="5.97,257,1669075200"; 
   d="scan'208";a="293443713"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 12:22:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 06F2C60FC4;
        Mon, 30 Jan 2023 12:22:21 +0000 (UTC)
Received: from EX19D024UWB004.ant.amazon.com (10.13.138.96) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Mon, 30 Jan 2023 12:22:21 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D024UWB004.ant.amazon.com (10.13.138.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Mon, 30 Jan 2023 12:22:21 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.1.212.21) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS) id
 15.0.1497.45 via Frontend Transport; Mon, 30 Jan 2023 12:22:18 +0000
From:   Roman Kagan <rkagan@amazon.de>
To:     <linux-kernel@vger.kernel.org>
CC:     Juri Lelli <juri.lelli@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2] sched/fair: sanitize vruntime of entity being placed
Date:   Mon, 30 Jan 2023 13:22:16 +0100
Message-ID: <20230130122216.3555094-1-rkagan@amazon.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiao <zhangqiao22@huawei.com>

When a scheduling entity is placed onto cfs_rq, its vruntime is pulled
to the base level (around cfs_rq->min_vruntime), so that the entity
doesn't gain extra boost when placed backwards.

However, if the entity being placed wasn't executed for a long time, its
vruntime may get too far behind (e.g. while cfs_rq was executing a
low-weight hog), which can inverse the vruntime comparison due to s64
overflow.  This results in the entity being placed with its original
vruntime way forwards, so that it will effectively never get to the cpu.

To prevent that, ignore the vruntime of the entity being placed if it
didn't execute for much longer than the characteristic sheduler time
scale.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
[rkagan: formatted, adjusted commit log, comments, cutoff value]
Co-developed-by: Roman Kagan <rkagan@amazon.de>
Signed-off-by: Roman Kagan <rkagan@amazon.de>
---
v1 -> v2:
- add Zhang Qiao's s-o-b
- fix constant promotion on 32bit

 kernel/sched/fair.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f8736991427..717c3ca970e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4656,6 +4656,7 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = cfs_rq->min_vruntime;
+	u64 sleep_time;
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -4685,8 +4686,18 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		vruntime -= thresh;
 	}
 
-	/* ensure we never gain time by being placed backwards. */
-	se->vruntime = max_vruntime(se->vruntime, vruntime);
+	/*
+	 * Pull vruntime of the entity being placed to the base level of
+	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
+	 * slept for a long time, don't even try to compare its vruntime with
+	 * the base as it may be too far off and the comparison may get
+	 * inversed due to s64 overflow.
+	 */
+	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
+	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
+		se->vruntime = vruntime;
+	else
+		se->vruntime = max_vruntime(se->vruntime, vruntime);
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
-- 
2.34.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



