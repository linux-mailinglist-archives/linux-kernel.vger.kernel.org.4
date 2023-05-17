Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A6706FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEQRvv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 13:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEQRvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:51:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C535B5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:51:28 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HH1SVH002117
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:51:28 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qmrcccj29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:51:27 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 10:51:26 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 10:51:26 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id D5ECB1DC3A20D; Wed, 17 May 2023 10:51:11 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@meta.com>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3] watchdog: Allow nmi watchdog to use "ref-cycles" event
Date:   Wed, 17 May 2023 10:51:04 -0700
Message-ID: <20230517175105.1614575-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: P_vrUK5B1Izk-ncGcXpXnHLEZvo5ibGa
X-Proofpoint-ORIG-GUID: P_vrUK5B1Izk-ncGcXpXnHLEZvo5ibGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
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
used. Add kernel cmdline arg nmi_watchdog=ref-cycles to configure the
watchdog to use "ref-cycles" event instead of "cycles".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Song Liu <song@kernel.org>

---
Changes in v3:

Pivot the design to use kernel arg nmi_watchdog=ref-cycles (Peter)
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 include/linux/nmi.h                             | 2 ++
 kernel/watchdog.c                               | 2 ++
 kernel/watchdog_hld.c                           | 9 +++++++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..d378e23dad7c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3593,10 +3593,12 @@
 			Format: [state][,regs][,debounce][,die]
 
 	nmi_watchdog=	[KNL,BUGS=X86] Debugging features for SMP kernels
-			Format: [panic,][nopanic,][num]
+			Format: [panic,][nopanic,][ref-cycles][num]
 			Valid num: 0 or 1
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
+			ref-cycles - configure the watchdog with perf event
+			             "ref-cycles" instead of "cycles"
 			When panic is specified, panic when an NMI watchdog
 			timeout occurs (or 'nopanic' to not panic on an NMI
 			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
@@ -7097,4 +7099,3 @@
 				memory, and other data can't be written using
 				xmon commands.
 			off	xmon is disabled.
-
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 048c0b9aa623..9fe1c1831287 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -102,12 +102,14 @@ extern void hardlockup_detector_perf_disable(void);
 extern void hardlockup_detector_perf_enable(void);
 extern void hardlockup_detector_perf_cleanup(void);
 extern int hardlockup_detector_perf_init(void);
+extern void hardlockup_config_perf_event(const char *str);
 #else
 static inline void hardlockup_detector_perf_stop(void) { }
 static inline void hardlockup_detector_perf_restart(void) { }
 static inline void hardlockup_detector_perf_disable(void) { }
 static inline void hardlockup_detector_perf_enable(void) { }
 static inline void hardlockup_detector_perf_cleanup(void) { }
+extern void hardlockup_config_perf_event(const char *str) { }
 # if !defined(CONFIG_HAVE_NMI_WATCHDOG)
 static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
 static inline void arch_touch_nmi_watchdog(void) {}
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7e33..fed4f0be8e1a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -81,6 +81,8 @@ static int __init hardlockup_panic_setup(char *str)
 		nmi_watchdog_user_enabled = 0;
 	else if (!strncmp(str, "1", 1))
 		nmi_watchdog_user_enabled = 1;
+	else if (!strncmp(str, "ref-cycles", 10))
+		hardlockup_config_perf_event(str);
 	return 1;
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..4deca58ba6ed 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -294,3 +294,12 @@ int __init hardlockup_detector_perf_init(void)
 	}
 	return ret;
 }
+
+/**
+ * hardlockup_config_perf_event - Overwrite config of wd_hw_attr
+ */
+void __init hardlockup_config_perf_event(const char *str)
+{
+	if (!strncmp(str, "ref-cycles", 10))
+		wd_hw_attr.config = PERF_COUNT_HW_REF_CPU_CYCLES;
+}
-- 
2.34.1

