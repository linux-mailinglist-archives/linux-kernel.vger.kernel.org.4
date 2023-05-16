Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3006B705B86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjEPX6j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 May 2023 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEPX6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:58:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1D55B7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:58:35 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GMHUCM004098
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:58:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qkwa49909-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:58:35 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 16:58:34 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id EEAE01DB91CB8; Tue, 16 May 2023 16:58:20 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@meta.com>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] watchdog: Prefer use "ref-cycles" for NMI watchdog
Date:   Tue, 16 May 2023 16:58:17 -0700
Message-ID: <20230516235817.2323062-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6H4KL0wW3ZjPpM6a5-A0aNqv3AKof5he
X-Proofpoint-GUID: 6H4KL0wW3ZjPpM6a5-A0aNqv3AKof5he
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_13,2023-05-16_01,2023-02-09_01
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
used. Try use "ref-cycles" for the watchdog, so that one more hardware
counter is available to the user. If the CPU doesn't support "ref-cycles",
fall back to "cycles".

The downside of this change is that users of "ref-cycles" need to disable
nmi_watchdog.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Song Liu <song@kernel.org>

---

Changes in v2:
1. Do not send warning when failed to create ref-cycles event.
---
 kernel/watchdog_hld.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..a1d2a43ea31f 100644
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
@@ -163,7 +163,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	return;
 }
 
-static int hardlockup_detector_event_create(void)
+static int hardlockup_detector_event_create(bool send_warning)
 {
 	unsigned int cpu = smp_processor_id();
 	struct perf_event_attr *wd_attr;
@@ -176,8 +176,10 @@ static int hardlockup_detector_event_create(void)
 	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
 					       watchdog_overflow_callback, NULL);
 	if (IS_ERR(evt)) {
-		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
-			 PTR_ERR(evt));
+		if (send_warning) {
+			pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
+				 PTR_ERR(evt));
+		}
 		return PTR_ERR(evt);
 	}
 	this_cpu_write(watchdog_ev, evt);
@@ -189,7 +191,7 @@ static int hardlockup_detector_event_create(void)
  */
 void hardlockup_detector_perf_enable(void)
 {
-	if (hardlockup_detector_event_create())
+	if (hardlockup_detector_event_create(true))
 		return;
 
 	/* use original value for check */
@@ -284,7 +286,13 @@ void __init hardlockup_detector_perf_restart(void)
  */
 int __init hardlockup_detector_perf_init(void)
 {
-	int ret = hardlockup_detector_event_create();
+	int ret = hardlockup_detector_event_create(false);
+
+	if (ret) {
+		/* Failed to create "ref-cycles", try "cycles" instead */
+		wd_hw_attr.config = PERF_COUNT_HW_CPU_CYCLES;
+		ret = hardlockup_detector_event_create(true);
+	}
 
 	if (ret) {
 		pr_info("Perf NMI watchdog permanently disabled\n");
-- 
2.34.1

