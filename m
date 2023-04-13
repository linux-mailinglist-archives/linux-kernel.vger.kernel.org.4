Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68536E0B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDMKJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDMKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:09:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D871D9750
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:42 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D8Q7BQ003975;
        Thu, 13 Apr 2023 10:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=VXmvsb+hnxaTo9wc9S7lxkclisncj9vjgTNoeT5eZbg=;
 b=F0Ml3lRrtwMbQBDbSUzIG6crD7h/pQZW5fLbb+omaOI+PMXSeszL8c6/eyG2ZCnKKJDx
 w8VDYMCmqL4UPH6LkAMnAMS6A1uL3Jnr2vD2skXZTfcIp23+cPqcqu6qKoBDDtfu19VW
 fXMvVqbpaHtUooD5Fo/x3KMA0OIexFuScyPzl2VqqV7iljdF9dtipNJvIBbY8uq/NlG0
 sbac69U+A9xdUNhBOHJD5ATbwMOFX8ntji2kfnA7J2k4abG+EKXnyav53B5nouzyHEmw
 rZ6Gx3/wIzyJZHIY4mhulISdH8BTrGh8UQmHVhzHvA591/9oESZ54oPjkeWtGfhe2Q/D jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3px5pks4h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 10:09:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DA9FrV020429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 10:09:15 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 13 Apr
 2023 03:09:10 -0700
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        "Petr Mladek" <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Subject: [PATCH] printk: Export console trace point for kcsan/kasan/kfence/kmsan
Date:   Thu, 13 Apr 2023 15:38:59 +0530
Message-ID: <20230413100859.1492323-1-quic_pkondeti@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t97JO5bgO05dqWQcoE3wtonyMnjCzuS8
X-Proofpoint-GUID: t97JO5bgO05dqWQcoE3wtonyMnjCzuS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=944 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304130091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The console tracepoint is used by kcsan/kasan/kfence/kmsan test
modules. Since this tracepoint is not exported, these modules iterate
over all available tracepoints to find the console trace point.
Export the trace point so that it can be directly used.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 kernel/kcsan/kcsan_test.c | 20 ++++++--------------
 kernel/printk/printk.c    |  2 ++
 mm/kasan/kasan_test.c     | 22 ++--------------------
 mm/kfence/kfence_test.c   | 22 ++--------------------
 mm/kmsan/kmsan_test.c     | 22 ++--------------------
 5 files changed, 14 insertions(+), 74 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index a60c561724be..0ddbdab5903d 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1572,34 +1572,26 @@ static void test_exit(struct kunit *test)
 }
 
 __no_kcsan
-static void register_tracepoints(struct tracepoint *tp, void *ignore)
+static void register_tracepoints(void)
 {
-	check_trace_callback_type_console(probe_console);
-	if (!strcmp(tp->name, "console"))
-		WARN_ON(tracepoint_probe_register(tp, probe_console, NULL));
+	register_trace_console(probe_console, NULL);
 }
 
 __no_kcsan
-static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
+static void unregister_tracepoints(void)
 {
-	if (!strcmp(tp->name, "console"))
-		tracepoint_probe_unregister(tp, probe_console, NULL);
+	unregister_trace_console(probe_console, NULL);
 }
 
 static int kcsan_suite_init(struct kunit_suite *suite)
 {
-	/*
-	 * Because we want to be able to build the test as a module, we need to
-	 * iterate through all known tracepoints, since the static registration
-	 * won't work here.
-	 */
-	for_each_kernel_tracepoint(register_tracepoints, NULL);
+	register_tracepoints();
 	return 0;
 }
 
 static void kcsan_suite_exit(struct kunit_suite *suite)
 {
-	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
+	unregister_tracepoints();
 	tracepoint_synchronize_unregister();
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a5ed2e53547c..8bb9e8752d65 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -71,6 +71,8 @@ EXPORT_SYMBOL_GPL(console_printk);
 atomic_t ignore_console_lock_warning __read_mostly = ATOMIC_INIT(0);
 EXPORT_SYMBOL(ignore_console_lock_warning);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(console);
+
 /*
  * Low level drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 74cd80c12b25..edf3158fc075 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -56,19 +56,6 @@ static void probe_console(void *ignore, const char *buf, size_t len)
 		WRITE_ONCE(test_status.async_fault, true);
 }
 
-static void register_tracepoints(struct tracepoint *tp, void *ignore)
-{
-	check_trace_callback_type_console(probe_console);
-	if (!strcmp(tp->name, "console"))
-		WARN_ON(tracepoint_probe_register(tp, probe_console, NULL));
-}
-
-static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
-{
-	if (!strcmp(tp->name, "console"))
-		tracepoint_probe_unregister(tp, probe_console, NULL);
-}
-
 static int kasan_suite_init(struct kunit_suite *suite)
 {
 	if (!kasan_enabled()) {
@@ -86,12 +73,7 @@ static int kasan_suite_init(struct kunit_suite *suite)
 	 */
 	multishot = kasan_save_enable_multi_shot();
 
-	/*
-	 * Because we want to be able to build the test as a module, we need to
-	 * iterate through all known tracepoints, since the static registration
-	 * won't work here.
-	 */
-	for_each_kernel_tracepoint(register_tracepoints, NULL);
+	register_trace_console(probe_console, NULL);
 	return 0;
 }
 
@@ -99,7 +81,7 @@ static void kasan_suite_exit(struct kunit_suite *suite)
 {
 	kasan_kunit_test_suite_end();
 	kasan_restore_multi_shot(multishot);
-	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
+	unregister_trace_console(probe_console, NULL);
 	tracepoint_synchronize_unregister();
 }
 
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index b5d66a69200d..6aee19a79236 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -825,33 +825,15 @@ static void test_exit(struct kunit *test)
 	test_cache_destroy();
 }
 
-static void register_tracepoints(struct tracepoint *tp, void *ignore)
-{
-	check_trace_callback_type_console(probe_console);
-	if (!strcmp(tp->name, "console"))
-		WARN_ON(tracepoint_probe_register(tp, probe_console, NULL));
-}
-
-static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
-{
-	if (!strcmp(tp->name, "console"))
-		tracepoint_probe_unregister(tp, probe_console, NULL);
-}
-
 static int kfence_suite_init(struct kunit_suite *suite)
 {
-	/*
-	 * Because we want to be able to build the test as a module, we need to
-	 * iterate through all known tracepoints, since the static registration
-	 * won't work here.
-	 */
-	for_each_kernel_tracepoint(register_tracepoints, NULL);
+	register_trace_console(probe_console, NULL);
 	return 0;
 }
 
 static void kfence_suite_exit(struct kunit_suite *suite)
 {
-	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
+	unregister_trace_console(probe_console, NULL);
 	tracepoint_synchronize_unregister();
 }
 
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 088e21a48dc4..06e18f76c641 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -541,33 +541,15 @@ static void test_exit(struct kunit *test)
 {
 }
 
-static void register_tracepoints(struct tracepoint *tp, void *ignore)
-{
-	check_trace_callback_type_console(probe_console);
-	if (!strcmp(tp->name, "console"))
-		WARN_ON(tracepoint_probe_register(tp, probe_console, NULL));
-}
-
-static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
-{
-	if (!strcmp(tp->name, "console"))
-		tracepoint_probe_unregister(tp, probe_console, NULL);
-}
-
 static int kmsan_suite_init(struct kunit_suite *suite)
 {
-	/*
-	 * Because we want to be able to build the test as a module, we need to
-	 * iterate through all known tracepoints, since the static registration
-	 * won't work here.
-	 */
-	for_each_kernel_tracepoint(register_tracepoints, NULL);
+	register_trace_console(probe_console, NULL);
 	return 0;
 }
 
 static void kmsan_suite_exit(struct kunit_suite *suite)
 {
-	for_each_kernel_tracepoint(unregister_tracepoints, NULL);
+	unregister_trace_console(probe_console, NULL);
 	tracepoint_synchronize_unregister();
 }
 
-- 
2.25.1

