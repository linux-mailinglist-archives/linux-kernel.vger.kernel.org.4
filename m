Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B0A6AA9B6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCDNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 08:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCDNAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:00:11 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6FA1E281
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 04:59:44 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 324CsVkZ026579;
        Sat, 4 Mar 2023 04:59:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=NAU/fDApdHlX4dhwQF99yzpDuztxYGl0ZGZRKvFr43k=;
 b=i0xb7E6HVS3DrZMoNsP9zVitIPv3UTFB7c/UAPq8TRAP6MxNGqswKkJZEmWymP7IdMXo
 DNwWtS35QZNgcpYtgqtsZ1BiQz1Xh66o/Ez7y/68FUzokQtPY/uK6hPLMpV029KQoyIa
 ElsSmQGpdhOX8aYKnnKxPHvKwb6P3grpM6pezXHbINHAauHlQ5AvCoKI4TC1VCpJ7pfn
 NbdJUKH0vsbYkjGCTJn93XFYGJUbRuzeO/L/SvTk1DzXBc2tEGHbQDF7kxARuGm/PB1o
 UlAYl8GpKc0VYAFwANIPxqCGqGcQz7WMfqdyPlvKCgvwCV0eAJ9bDb1Sn8LoOqzHmPl5 MA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3p46csg0ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 04 Mar 2023 04:59:09 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 4 Mar
 2023 04:59:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Sat, 4 Mar 2023 04:59:07 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 721473F708E;
        Sat,  4 Mar 2023 04:59:00 -0800 (PST)
From:   Rakesh Babu Saladi <rsaladi2@marvell.com>
To:     <mark.rutland@arm.com>, <lpieralisi@kernel.org>,
        <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, <naveenm@marvell.com>
CC:     Rakesh Babu Saladi <rsaladi2@marvell.com>
Subject: [PATCH] arm64: smccc: Add trace events to SMC calls.
Date:   Sat, 4 Mar 2023 18:28:50 +0530
Message-ID: <20230304125850.32687-1-rsaladi2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: M4nL1lBGzwxtCldDrHotDChGkjcJKFfg
X-Proofpoint-ORIG-GUID: M4nL1lBGzwxtCldDrHotDChGkjcJKFfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-04_06,2023-03-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds start and end trace events to an SMC call sent from
kernel to ATF. The start trace event prints the smc_id and the end
trace event prints the smc_id and the time taken to process the SMC
call.

Signed-off-by: Rakesh Babu Saladi <rsaladi2@marvell.com>
---
 drivers/firmware/smccc/Makefile      |  3 +-
 drivers/firmware/smccc/smccc.c       | 14 ++++++++++
 drivers/firmware/smccc/smccc_trace.c |  7 +++++
 drivers/firmware/smccc/smccc_trace.h | 41 ++++++++++++++++++++++++++++
 include/linux/arm-smccc.h            |  4 ++-
 kernel/time/timekeeping.c            |  7 +++++
 6 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/smccc/smccc_trace.c
 create mode 100644 drivers/firmware/smccc/smccc_trace.h

diff --git a/drivers/firmware/smccc/Makefile b/drivers/firmware/smccc/Makefile
index 40d19144a860..e74c35191b49 100644
--- a/drivers/firmware/smccc/Makefile
+++ b/drivers/firmware/smccc/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+= smccc.o kvm_guest.o
+ccflags-y += -I$(src)
+obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+= smccc_trace.o smccc.o kvm_guest.o
 obj-$(CONFIG_ARM_SMCCC_SOC_ID)	+= soc_id.o
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 60ccf3e90d7d..7631a16479e9 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <asm/archrandom.h>
+#include "smccc_trace.h"
 
 static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
 static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
@@ -59,3 +60,16 @@ static int __init smccc_devices_init(void)
 	return 0;
 }
 device_initcall(smccc_devices_init);
+
+void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2, unsigned long a3,
+		   unsigned long a4, unsigned long a5, unsigned long a6, unsigned long a7,
+		   struct arm_smccc_res *res)
+{
+	u64 start, elapsed;
+
+	trace_arm_smccc_smc_start(a0);
+	start = ktime_get_ns();
+	__arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res, NULL);
+	elapsed = ktime_get_ns() - start;
+	trace_arm_smccc_smc_end(a0, elapsed);
+}
diff --git a/drivers/firmware/smccc/smccc_trace.c b/drivers/firmware/smccc/smccc_trace.c
new file mode 100644
index 000000000000..6b94d5d9c0f4
--- /dev/null
+++ b/drivers/firmware/smccc/smccc_trace.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "smccc_trace.h"
+
+EXPORT_TRACEPOINT_SYMBOL(arm_smccc_smc_start);
+EXPORT_TRACEPOINT_SYMBOL(arm_smccc_smc_end);
diff --git a/drivers/firmware/smccc/smccc_trace.h b/drivers/firmware/smccc/smccc_trace.h
new file mode 100644
index 000000000000..c0ef836bc093
--- /dev/null
+++ b/drivers/firmware/smccc/smccc_trace.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM smccc
+
+#if !defined(__SMCCC_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __SMCCC_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(arm_smccc_smc_start,
+	    TP_PROTO(unsigned long smc_id),
+	    TP_ARGS(smc_id),
+	    TP_STRUCT__entry(__field(unsigned long, smc_id)),
+	    TP_fast_assign(__entry->smc_id = smc_id;),
+	    TP_printk("SMC ID: 0x%lx", __entry->smc_id)
+);
+
+TRACE_EVENT(arm_smccc_smc_end,
+	    TP_PROTO(unsigned long smc_id, u64 elapsed_time),
+	    TP_ARGS(smc_id, elapsed_time),
+	    TP_STRUCT__entry(__field(unsigned long, smc_id)
+			     __field(u64, elapsed_time)
+	    ),
+	    TP_fast_assign(__entry->smc_id = smc_id;
+			   __entry->elapsed_time = elapsed_time;
+	    ),
+	    TP_printk("SMC ID: 0x%lx time taken to process : %llu ns",
+		      __entry->smc_id, __entry->elapsed_time)
+);
+
+#endif /* __SMCCC_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE smccc_trace
+
+#include <trace/define_trace.h>
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c60e021..39588c3db486 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -358,7 +358,9 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 			unsigned long a5, unsigned long a6, unsigned long a7,
 			struct arm_smccc_res *res, struct arm_smccc_quirk *quirk);
 
-#define arm_smccc_smc(...) __arm_smccc_smc(__VA_ARGS__, NULL)
+void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
+		   unsigned long a3, unsigned long a4, unsigned long a5,
+		   unsigned long a6, unsigned long a7, struct arm_smccc_res *res);
 
 #define arm_smccc_smc_quirk(...) __arm_smccc_smc(__VA_ARGS__)
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5579ead449f2..3a3bf2d674a3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -192,6 +192,13 @@ static inline u64 tk_clock_read(const struct tk_read_base *tkr)
 {
 	struct clocksource *clock = READ_ONCE(tkr->clock);
 
+	/* At the time of kernel booting some SMC calls are called before the
+	 * clock is initialized, in such cases it would lead to kernel crash.
+	 * To prevent kernel crash in such cases this check is included.
+	 */
+	if (unlikely(!clock))
+		return 0;
+
 	return clock->read(clock);
 }
 
-- 
2.17.1

