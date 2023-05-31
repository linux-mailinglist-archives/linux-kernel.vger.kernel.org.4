Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B12718BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEaV3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjEaV3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:29:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E301C12F;
        Wed, 31 May 2023 14:29:05 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLECAq028230;
        Wed, 31 May 2023 21:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VL5CKC8cwHsQcWxaiy5qgHbw3vH3w2KD6brOuQf2lTQ=;
 b=o0e6ADHUCtT5E+3R3l0KBc8Kmnbha8yQLAL6+RjWNOvG+zD6BWnQma87BsjcU4jcK5GZ
 89reSrqlNA/l2DrAogKgASgpP/zEONAjGoB+zH3HjXnG3ioS8pWsr6vOzv45VXnL7NIR
 VLZQkeeKpqNv2NjnPmsTSjFt/ecB+IKKFecZ1Mp9nx7q7JXg9Gal+McB7tjx1ybz7yXN
 U7iaRuTNnDySoHwoJRjDqX+K08Z57sNOOGmWMHpl8OB54rxYYCS84KwpRJ6u0LHNDBL6
 tjZTxmWX2g5l+zjxQRknL7F0bezkBu078D+RDOjPP9elBXrem6uiO91FC9fUV5TXQnJ2 3g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxbt8g93v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:29:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VLT1cg012562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:29:01 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 14:29:00 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v4 1/2] remoteproc: Introduce traces for remoteproc events
Date:   Wed, 31 May 2023 14:28:39 -0700
Message-ID: <5c1744bc362fbc80615349f12c18c8ab5c4f0a6e.1685486994.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685486994.git.quic_gokukris@quicinc.com>
References: <cover.1685486994.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1aJa-yAfM6To4j-uOYp_QEOOWRbxexly
X-Proofpoint-ORIG-GUID: 1aJa-yAfM6To4j-uOYp_QEOOWRbxexly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Traces for the following remoteproc events:
	rproc_subdev_event,
	rproc_interrupt_event,
	rproc_load_event,
	rproc_start_event,
	rproc_stop_event

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/Kconfig                    |   5 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_tracepoints.c   |  13 ++
 include/trace/events/remoteproc_tracepoints.h | 129 ++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 drivers/remoteproc/remoteproc_tracepoints.c
 create mode 100644 include/trace/events/remoteproc_tracepoints.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index a850e9f486dd..2ef4f527f1c1 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -365,6 +365,11 @@ config XLNX_R5_REMOTEPROC
 
 	  It's safe to say N if not interested in using RPU r5f cores.
 
+config REMOTEPROC_TRACEPOINTS
+	bool "Support for Remote Processor subsystem traces"
+	help
+	  Say y to add traces to the remoteproc events.
+
 endif # REMOTEPROC
 
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 91314a9b43ce..7045cde5ca76 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_debugfs.o
 remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
+obj-$(CONFIG_REMOTEPROC_TRACEPOINTS)	+= remoteproc_tracepoints.o
 obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
 obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
diff --git a/drivers/remoteproc/remoteproc_tracepoints.c b/drivers/remoteproc/remoteproc_tracepoints.c
new file mode 100644
index 000000000000..f082441022c3
--- /dev/null
+++ b/drivers/remoteproc/remoteproc_tracepoints.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/remoteproc_tracepoints.h>
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_load_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_start_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_stop_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_interrupt_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_subdev_event);
diff --git a/include/trace/events/remoteproc_tracepoints.h b/include/trace/events/remoteproc_tracepoints.h
new file mode 100644
index 000000000000..f2de61f42eb1
--- /dev/null
+++ b/include/trace/events/remoteproc_tracepoints.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM remoteproc_tracepoints
+
+#if !defined(_TRACE_REMOTEPROC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_REMOTEPROC_H
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
+		__field(int, ret)
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
+	TP_PROTO(struct rproc *rproc, const char *crash_msg),
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
+	TP_PROTO(struct rproc *rproc, const char *event,
+			 const char *msg),
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
+		 __get_str(event), __get_str(msg))
+);
+
+TRACE_EVENT(rproc_subdev_event,
+
+	TP_PROTO(const char *rproc, const char *subdev,
+			const char *event, int ret),
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
+	TP_printk("rproc:%s subdev:%s event:%s ret:%d",
+		__get_str(rproc), __get_str(subdev),
+		__get_str(event), __entry->ret)
+);
+#endif /* _TRACE_REMOTEPROC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.40.1

