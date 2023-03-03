Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5B6A8FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCCDzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCDzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:55:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230F511EB5;
        Thu,  2 Mar 2023 19:55:17 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3230C6nE019927;
        Fri, 3 Mar 2023 03:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=9TeXwaTlUIur8LJbd6hvm5hqtIFh+l6PHbAPi0+GvLo=;
 b=UZsB5fR23ggc/KX4XSizMIqEKjzpDoUYqFhv7JuhQjXlzfcfnvVvbz3U+4ttUS1cjFuT
 GaoVT6JxAwYVwdE8+nZflLxqOvzxagAttIPr9gwW89s7TRRCjT+htI8/081VhguBi32z
 sUDyovJDEJWA6umEfk+ujynFyT7WkkO+72/JKIib0rsAlPkXfNhX7G5Xx5TQbVZ/pL58
 K1LfugEimEBrGbjt4MgK2y5LVaIZAjKm+q+93CjV5ZR/UxxJF2XCftLM7TrzgN+f5plz
 0r40Om4JPt5JN+j/k1fd+eReoKuu/LPGSCg7PeSq9Y/BLuFtL3qEE6asvh3SgEQkFveq TQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p33g58uru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 03:55:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3233t8NT031888
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 03:55:08 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 19:55:07 -0800
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-trace-kernel@vger.kernel.org>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v2 1/1] remoteproc: qcom: Add remoteproc tracing
Date:   Thu, 2 Mar 2023 19:54:53 -0800
Message-ID: <20230303035453.19034-1-quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A_hbYAWJAd6K6wd7ZAhoOZFdfYlorbJL
X-Proofpoint-ORIG-GUID: A_hbYAWJAd6K6wd7ZAhoOZFdfYlorbJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change attempts to add traces for start, stop, crash
subsystem/subdevice event these will serve as standard checkpoints in
code and could help in debugging the failures in subdevice/subsystem
prepare, start, stop and unprepare functions. This will also breakdown
the time taken for each step in remoteproc bootup/shutdown process.

Change-Id: I202814452192ca0733f134daf7c99201881e2c9c
Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/qcom_common.c      |  37 ++++++++
 drivers/remoteproc/qcom_q6v5.c        |   9 ++
 drivers/remoteproc/qcom_tracepoints.c |  12 +++
 drivers/remoteproc/remoteproc_core.c  |   8 ++
 include/trace/events/rproc_qcom.h     | 128 ++++++++++++++++++++++++++
 6 files changed, 195 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_tracepoints.c
 create mode 100644 include/trace/events/rproc_qcom.h

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 91314a9b43ce..3399fcaba39b 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_debugfs.o
 remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
+remoteproc-y				+= qcom_tracepoints.o
 obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
 obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 020349f8979d..09b79f39ccd6 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem.h>
+#include <trace/events/rproc_qcom.h>
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
@@ -186,6 +187,10 @@ static int glink_subdev_start(struct rproc_subdev *subdev)
 
 	glink->edge = qcom_glink_smem_register(glink->dev, glink->node);
 
+	trace_rproc_subdev_event(dev_name(glink->dev->parent),
+					"glink", "start",
+					PTR_ERR_OR_ZERO(glink->edge));
+
 	return PTR_ERR_OR_ZERO(glink->edge);
 }
 
@@ -194,6 +199,11 @@ static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
 
 	qcom_glink_smem_unregister(glink->edge);
+
+	trace_rproc_subdev_event(dev_name(glink->dev->parent),
+					"glink", "stop",
+					PTR_ERR_OR_ZERO(glink->edge));
+
 	glink->edge = NULL;
 }
 
@@ -201,6 +211,10 @@ static void glink_subdev_unprepare(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
 
+	trace_rproc_subdev_event(dev_name(glink->dev->parent),
+					"glink", "unprepare",
+					PTR_ERR_OR_ZERO(glink->edge));
+
 	qcom_glink_ssr_notify(glink->ssr_name);
 }
 
@@ -295,6 +309,10 @@ static int smd_subdev_start(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
 
+	trace_rproc_subdev_event(dev_name(smd->dev->parent),
+					"smd", "start",
+					PTR_ERR_OR_ZERO(smd->edge));
+
 	smd->edge = qcom_smd_register_edge(smd->dev, smd->node);
 
 	return PTR_ERR_OR_ZERO(smd->edge);
@@ -304,6 +322,10 @@ static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
 
+	trace_rproc_subdev_event(dev_name(smd->dev->parent),
+					"smd", "stop",
+					PTR_ERR_OR_ZERO(smd->edge));
+
 	qcom_smd_unregister_edge(smd->edge);
 	smd->edge = NULL;
 }
@@ -420,6 +442,10 @@ static int ssr_notify_prepare(struct rproc_subdev *subdev)
 		.crashed = false,
 	};
 
+	trace_rproc_subdev_event(ssr->info->name,
+					"ssr", "QCOM_SSR_BEFORE_POWERUP",
+					data.crashed);
+
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
 				 QCOM_SSR_BEFORE_POWERUP, &data);
 	return 0;
@@ -432,6 +458,9 @@ static int ssr_notify_start(struct rproc_subdev *subdev)
 		.name = ssr->info->name,
 		.crashed = false,
 	};
+	trace_rproc_subdev_event(ssr->info->name,
+					"ssr", "QCOM_SSR_AFTER_POWERUP",
+					data.crashed);
 
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
 				 QCOM_SSR_AFTER_POWERUP, &data);
@@ -446,6 +475,10 @@ static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
 		.crashed = crashed,
 	};
 
+	trace_rproc_subdev_event(ssr->info->name,
+					"ssr", "QCOM_SSR_BEFORE_SHUTDOWN",
+					data.crashed);
+
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
 				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
 }
@@ -458,6 +491,10 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
 		.crashed = false,
 	};
 
+	trace_rproc_subdev_event(ssr->info->name,
+					"ssr", "QCOM_SSR_AFTER_SHUTDOWN",
+					data.crashed);
+
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
 				 QCOM_SSR_AFTER_SHUTDOWN, &data);
 }
diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 497acfb33f8f..aff91de3cea0 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -15,6 +15,7 @@
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/remoteproc.h>
+#include <trace/events/rproc_qcom.h>
 #include "qcom_common.h"
 #include "qcom_q6v5.h"
 
@@ -113,6 +114,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 		dev_err(q6v5->dev, "watchdog without message\n");
 
 	q6v5->running = false;
+	trace_rproc_interrupt_event(q6v5->rproc, "q6v5_wdog", msg);
 	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
 
 	return IRQ_HANDLED;
@@ -134,6 +136,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 		dev_err(q6v5->dev, "fatal error without message\n");
 
 	q6v5->running = false;
+	trace_rproc_interrupt_event(q6v5->rproc, "fatal", msg);
 	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
 
 	return IRQ_HANDLED;
@@ -165,6 +168,8 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
 	if (!ret)
 		disable_irq(q6v5->handover_irq);
 
+	trace_rproc_interrupt_event(q6v5->rproc, "Ready", !ret? "-ETIMEDOUT":"done");
+
 	return !ret ? -ETIMEDOUT : 0;
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);
@@ -180,6 +185,8 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
 
 	q6v5->handover_issued = true;
 
+	trace_rproc_interrupt_event(q6v5->rproc, "handover", "Proxy votes removed");
+
 	return IRQ_HANDLED;
 }
 
@@ -216,6 +223,8 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon)
 
 	qcom_smem_state_update_bits(q6v5->state, BIT(q6v5->stop_bit), 0);
 
+	trace_rproc_interrupt_event(q6v5->rproc, "Stop", ret? "done":"-EETIMEDOUT");
+
 	return ret == 0 ? -ETIMEDOUT : 0;
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
diff --git a/drivers/remoteproc/qcom_tracepoints.c b/drivers/remoteproc/qcom_tracepoints.c
new file mode 100644
index 000000000000..1b587ef54aa7
--- /dev/null
+++ b/drivers/remoteproc/qcom_tracepoints.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/rproc_qcom.h>
+EXPORT_TRACEPOINT_SYMBOL(rproc_load_event);
+EXPORT_TRACEPOINT_SYMBOL(rproc_start_event);
+EXPORT_TRACEPOINT_SYMBOL(rproc_stop_event);
+EXPORT_TRACEPOINT_SYMBOL(rproc_interrupt_event);
+EXPORT_TRACEPOINT_SYMBOL(rproc_subdev_event);
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1cd4815a6dd1..6def868f0a98 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -38,6 +38,7 @@
 #include <linux/virtio_ring.h>
 #include <asm/byteorder.h>
 #include <linux/platform_device.h>
+#include <trace/events/rproc_qcom.h>
 
 #include "remoteproc_internal.h"
 
@@ -1270,6 +1271,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 
 	/* load the ELF segments to memory */
 	ret = rproc_load_segments(rproc, fw);
+	trace_rproc_load_event(rproc, ret);
 	if (ret) {
 		dev_err(dev, "Failed to load program segments: %d\n", ret);
 		return ret;
@@ -1305,6 +1307,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 
 	/* Start any subdevices for the remote processor */
 	ret = rproc_start_subdevices(rproc);
+
 	if (ret) {
 		dev_err(dev, "failed to probe subdevices for %s: %d\n",
 			rproc->name, ret);
@@ -1729,6 +1732,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 		return ret;
 	}
 
+	trace_rproc_stop_event(rproc, crashed ? "crash stop" : "stop");
+
 	rproc_unprepare_subdevices(rproc);
 
 	rproc->state = RPROC_OFFLINE;
@@ -1939,6 +1944,8 @@ int rproc_boot(struct rproc *rproc)
 		dev_info(dev, "attaching to %s\n", rproc->name);
 
 		ret = rproc_attach(rproc);
+		trace_rproc_start_event(rproc, ret);
+
 	} else {
 		dev_info(dev, "powering up %s\n", rproc->name);
 
@@ -1950,6 +1957,7 @@ int rproc_boot(struct rproc *rproc)
 		}
 
 		ret = rproc_fw_boot(rproc, firmware_p);
+		trace_rproc_start_event(rproc, ret);
 
 		release_firmware(firmware_p);
 	}
diff --git a/include/trace/events/rproc_qcom.h b/include/trace/events/rproc_qcom.h
new file mode 100644
index 000000000000..66b10cb17965
--- /dev/null
+++ b/include/trace/events/rproc_qcom.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rproc_qcom
+
+#if !defined(_TRACE_RPROC_QCOM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RPROC_QCOM_H
+#include <linux/tracepoint.h>
+#include <linux/remoteproc.h>
+
+/*
+ * Tracepoints for remoteproc and subdevice events
+ */
+TRACE_EVENT(rproc_load_event,
+
+	TP_PROTO(struct rproc *rproc, int ret),
+
+	TP_ARGS(rproc, ret),
+
+	TP_STRUCT__entry(
+		__string(name, rproc->name)
+		__string(firmware, rproc->firmware)
+		__field(int,ret)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, rproc->name);
+		__assign_str(firmware, rproc->firmware);
+		__entry->ret = ret;
+	),
+
+	TP_printk("%s loading firmware %s returned %d",
+			__get_str(name), __get_str(firmware),
+			__entry->ret)
+);
+
+TRACE_EVENT(rproc_start_event,
+
+	TP_PROTO(struct rproc *rproc, int ret),
+
+	TP_ARGS(rproc, ret),
+
+	TP_STRUCT__entry(
+		__string(name, rproc->name)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, rproc->name);
+		__entry->ret = ret;
+	),
+
+	TP_printk("%s %d", __get_str(name), __entry->ret)
+);
+
+TRACE_EVENT(rproc_stop_event,
+
+	TP_PROTO(struct rproc *rproc, char* crash_msg),
+
+	TP_ARGS(rproc, crash_msg),
+
+	TP_STRUCT__entry(
+		__string(name, rproc->name)
+		__string(crash_msg, crash_msg)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, rproc->name);
+		__assign_str(crash_msg, crash_msg)
+	),
+
+	TP_printk("%s %s", __get_str(name), __get_str(crash_msg))
+);
+
+TRACE_EVENT(rproc_interrupt_event,
+
+	TP_PROTO(struct rproc *rproc, const char* event,
+			 const char* msg),
+
+	TP_ARGS(rproc, event, msg),
+
+	TP_STRUCT__entry(
+		__string(name, rproc->name)
+		__string(event, event)
+		__string(msg, msg)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, rproc->name);
+		__assign_str(event, event);
+		__assign_str(msg, msg);
+	),
+
+	TP_printk("%s %s returned %s", __get_str(name),
+			 __get_str(event), __get_str(msg))
+);
+
+TRACE_EVENT(rproc_subdev_event,
+
+	TP_PROTO(const char* rproc, const char* subdev,
+			const char* event, int ret),
+
+	TP_ARGS(rproc, subdev, event, ret),
+
+	TP_STRUCT__entry(
+		__string(rproc, rproc)
+		__string(subdev, subdev)
+		__string(event, event)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__assign_str(rproc, rproc);
+		__assign_str(subdev, subdev);
+		__assign_str(event, event);
+		__entry->ret = ret;
+	),
+
+	TP_printk("%s %s %s %d", __get_str(rproc), __get_str(subdev),
+			__get_str(event), __entry->ret)
+);
+#endif /* _TRACE_RPROC_QCOM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.39.2

