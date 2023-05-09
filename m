Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5F96FD282
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjEIWR6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 May 2023 18:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjEIWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:17:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0497B93
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:17:43 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349KVue4022845
        for <linux-kernel@vger.kernel.org>; Tue, 9 May 2023 15:17:34 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qfrf2u5t4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:17:34 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 9 May 2023 15:17:32 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 8323F1D54669C; Tue,  9 May 2023 15:17:18 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@meta.com>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
Date:   Tue, 9 May 2023 15:17:00 -0700
Message-ID: <20230509221700.859865-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KAAC0ys7_igI88cCGTrVtA4ETSojQHhZ
X-Proofpoint-ORIG-GUID: KAAC0ys7_igI88cCGTrVtA4ETSojQHhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_14,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NMI watchdog permanently consumes one hardware counters per CPU on the
system. For systems that use many hardware counters, this causes more
aggressive time multiplexing of perf events.

OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
used. Try use "ref-cycles" for the watchdog. If the CPU supports it, so
that one more hardware counter is available to the user. If the CPU doesn't
support "ref-cycles", fall back to "cycles".

The downside of this change is that users of "ref-cycles" need to disable
nmi_watchdog.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/watchdog_hld.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..f77109d98641 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -100,7 +100,7 @@ static inline bool watchdog_check_timestamp(void)
 
 static struct perf_event_attr wd_hw_attr = {
 	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.config		= PERF_COUNT_HW_REF_CPU_CYCLES,
 	.size		= sizeof(struct perf_event_attr),
 	.pinned		= 1,
 	.disabled	= 1,
@@ -286,6 +286,12 @@ int __init hardlockup_detector_perf_init(void)
 {
 	int ret = hardlockup_detector_event_create();
 
+	if (ret) {
+		/* Failed to create "ref-cycles", try "cycles" instead */
+		wd_hw_attr.config = PERF_COUNT_HW_CPU_CYCLES;
+		ret = hardlockup_detector_event_create();
+	}
+
 	if (ret) {
 		pr_info("Perf NMI watchdog permanently disabled\n");
 	} else {
-- 
2.34.1

