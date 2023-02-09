Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47469115F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBITbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjBITbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:31:20 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A02914D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1675971079; x=1707507079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A6SuQMpZpuB5tW6VlPsSxTVheKhW2mDISHCOjV6LkYE=;
  b=TqxfKW6VVoHUoY/HSQT9IgEv4heUzpPLib4OvqqPEBCGTK9V1bmw+OK/
   lvb1z0uY4KSRaZnjeaOnqEa2wvVwFQ7zNw7MTmdbhdDId9qXAhQkYdWTp
   tB4gd2Avf09uNdHxGP5e9OMBYUTOVZuQ0Up+a1bnuZzcmPID0kC0ZDCYs
   E=;
X-IronPort-AV: E=Sophos;i="5.97,284,1669075200"; 
   d="scan'208";a="309388136"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 19:31:14 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 0C98FA1427;
        Thu,  9 Feb 2023 19:31:13 +0000 (UTC)
Received: from EX19D025UWA003.ant.amazon.com (10.13.139.5) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 9 Feb 2023 19:31:12 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D025UWA003.ant.amazon.com (10.13.139.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Thu, 9 Feb 2023 19:31:12 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.1.212.9) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS) id
 15.0.1497.45 via Frontend Transport; Thu, 9 Feb 2023 19:31:10 +0000
From:   Roman Kagan <rkagan@amazon.de>
To:     <linux-kernel@vger.kernel.org>
CC:     Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Mel Gorman" <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
Date:   Thu, 9 Feb 2023 20:31:07 +0100
Message-ID: <20230209193107.1432770-1-rkagan@amazon.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
didn't execute for longer than the time that can lead to an overflow.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
[rkagan: formatted, adjusted commit log, comments, cutoff value]
Co-developed-by: Roman Kagan <rkagan@amazon.de>
Signed-off-by: Roman Kagan <rkagan@amazon.de>
---
v2 -> v3:
- make cutoff less arbitrary and update comments [Vincent]

v1 -> v2:
- add Zhang Qiao's s-o-b
- fix constant promotion on 32bit

 kernel/sched/fair.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f8736991427..3baa6b7ea860 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4656,6 +4656,7 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = cfs_rq->min_vruntime;
+	u64 sleep_time;
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -4685,8 +4686,24 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		vruntime -= thresh;
 	}
 
-	/* ensure we never gain time by being placed backwards. */
-	se->vruntime = max_vruntime(se->vruntime, vruntime);
+	/*
+	 * Pull vruntime of the entity being placed to the base level of
+	 * cfs_rq, to prevent boosting it if placed backwards.
+	 * However, min_vruntime can advance much faster than real time, with
+	 * the exterme being when an entity with the minimal weight always runs
+	 * on the cfs_rq.  If the new entity slept for long, its vruntime
+	 * difference from min_vruntime may overflow s64 and their comparison
+	 * may get inversed, so ignore the entity's original vruntime in that
+	 * case.
+	 * The maximal vruntime speedup is given by the ratio of normal to
+	 * minimal weight: NICE_0_LOAD / MIN_SHARES, so cutting off on the
+	 * sleep time of 2^63 / NICE_0_LOAD should be safe.
+	 */
+	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
+	if ((s64)sleep_time > (1ULL << 63) / NICE_0_LOAD)
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



