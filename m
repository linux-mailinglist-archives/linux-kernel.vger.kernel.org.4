Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9C6B7F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjCMRTZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 13:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCMRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:18:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313B1A8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:17:58 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32DDBo6C005100
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:16:31 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p8p1jjs1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:16:31 -0700
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Mar 2023 10:16:29 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id DBAD11842FC48; Mon, 13 Mar 2023 10:16:19 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@meta.com>, Song Liu <song@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2] perf: fix perf_event_context->time
Date:   Mon, 13 Mar 2023 10:16:08 -0700
Message-ID: <20230313171608.298734-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: c5QADoIkh4ZcrNpUYWSfAFIRl_uAeI-4
X-Proofpoint-ORIG-GUID: c5QADoIkh4ZcrNpUYWSfAFIRl_uAeI-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_08,2023-03-13_02,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
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
enabled. __update_context_time(ctx, false) is used to increase timestamp,
but not time. Therefore, it should only be called in ctx_sched_in() when
EVENT_TIME was not enabled.

Fixes: 09f5e7dc7ad7 ("perf: Fix perf_event_read_local() time")
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
2.34.1

