Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063576A5F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjB1TWA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Feb 2023 14:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1TV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:21:58 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33831A6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:21:56 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SIOUKo005371
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:21:56 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p1f6hksvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:21:56 -0800
Received: from twshared18553.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 28 Feb 2023 11:21:54 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 93814172324C9; Tue, 28 Feb 2023 11:21:47 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@meta.com>, Song Liu <song@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf: fix perf_event_context->time
Date:   Tue, 28 Feb 2023 11:21:45 -0800
Message-ID: <20230228192145.2120675-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X1EUv-MQOayHSKzHgXQ_39_8hTzy6Z68
X-Proofpoint-GUID: X1EUv-MQOayHSKzHgXQ_39_8hTzy6Z68
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Time readers rely on perf_event_context->[time|timestamp|timeoffset] to get
accurate time_enabled and time_running for an event. The difference between
ctx->timestamp and ctx->time is the among of time when the context is not
enabled. For cpuctx.ctx, time and timestamp should stay the same, however,
it is not the case at the moment. To show this with drgn [1]:

    drgn 0.0.22 (using Python 3.8.6, elfutils 0.185, with libkdumpfile)
    For help, type help(drgn).
    ...
    >>> ctx = per_cpu_ptr(prog['pmu'].pmu_cpu_context, 0).ctx
    >>> ctx.timestamp * 1.0 / ctx.time
    (double)1.0385869134111765
    >>>

ctx->timestamp is about 4% larger than ctx.time. This issue causes time
read by perf_event_read_local() goes back in some cases.

Fix this by updating the condition for __update_context_time(ctx, false).
Specifically, it should only be called when we enable EVENT_TIME for the
ctx.

[1] drgn: https://github.com/osandov/drgn
Fixes: 09f5e7dc7ad7 ("perf: Fix perf_event_read_local() time")
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 380476a934e8..67478f43e26e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3872,7 +3872,7 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 	if (likely(!ctx->nr_events))
 		return;
 
-	if (is_active ^ EVENT_TIME) {
+	if (!(is_active & EVENT_TIME)) {
 		/* start ctx time */
 		__update_context_time(ctx, false);
 		perf_cgroup_set_timestamp(cpuctx);
-- 
2.30.2

