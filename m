Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6127A72D406
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbjFLWEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbjFLWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:03:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7F6E7B;
        Mon, 12 Jun 2023 15:03:50 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CLr4lK011906;
        Mon, 12 Jun 2023 22:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7/n3eMpd+ZhB5IRljn9OAR65+Wo+m69I3A2TKs2gFrY=;
 b=ERfJo2k6oA31Ie2iPKPM2fCY3YIps7Y+iiDe+y4NBif+oZA2ChRuvHbuKOrOdqJHjvIi
 GSvUiKQZupsOzDLUi8Yjaqys9iCH9V8vRkEWYrubs6hr6N8bSdWVsvnmUr2ETv5jSdW4
 V2N7exyZRrSiv/F3YeKBvNPZSpqOwyT2utH0ZRk40hKmMVdwwh+tdMCFxSPKeru3n5ZN
 bnvzMD1520jm/XICSTEG3j/lazhL3RlAXJP9FVmdiBXWYYPdWXicmAJozYlpPaNoDHMY
 tz8a5zUoUYjUY9HB6mOHNOB/38qM4zlNZl5Kk0jmjhi58+bfYb6oh9lwXKHFECsCVeC6 Ow== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r68x9896h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:03:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CM3lk0009941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:03:47 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 15:03:46 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v5 1/2] remoteproc: Introduce traces for remoteproc events
Date:   Mon, 12 Jun 2023 15:03:25 -0700
Message-ID: <df6c882a0da17cca90dc6ef3d3501eb87ac0eb73.1686606835.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686606835.git.quic_gokukris@quicinc.com>
References: <cover.1686606835.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PNTvKuSHknbAwIMCNfed_eg8Ihrdszl8
X-Proofpoint-ORIG-GUID: PNTvKuSHknbAwIMCNfed_eg8Ihrdszl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/remoteproc/Kconfig                    |   9 ++
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_tracepoints.c   |  14 ++
 include/trace/events/remoteproc_tracepoints.h | 152 ++++++++++++++++++
 4 files changed, 176 insertions(+)
 create mode 100644 drivers/remoteproc/remoteproc_tracepoints.c
 create mode 100644 include/trace/events/remoteproc_tracepoints.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index a850e9f486dd..4bc4e42a8a36 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -365,6 +365,15 @@ config XLNX_R5_REMOTEPROC
 
 	  It's safe to say N if not interested in using RPU r5f cores.
 
+config REMOTEPROC_TRACEPOINTS
+	bool "Support for Remote Processor subsystem traces"
+	help
+	  Say y to add traces to remoteproc events of interest such as
+	  the start/stop/crash events in a remote-processor and also
+	  sub-device stop/start events and there errors. These traces
+	  can be useful while debugging errors with subsystem restart
+	  and draw an estimate on how long each event takes to run.
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
index 000000000000..cafebda02f8b
--- /dev/null
+++ b/drivers/remoteproc/remoteproc_tracepoints.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/remoteproc_tracepoints.h>
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_load_segment_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_attach_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_start_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_stop_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_interrupt_event);
+EXPORT_TRACEPOINT_SYMBOL_GPL(rproc_subdev_event);
diff --git a/include/trace/events/remoteproc_tracepoints.h b/include/trace/events/remoteproc_tracepoints.h
new file mode 100644
index 000000000000..4d12d463cb39
--- /dev/null
+++ b/include/trace/events/remoteproc_tracepoints.h
@@ -0,0 +1,152 @@
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
+TRACE_EVENT(rproc_load_segment_event,
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
+TRACE_EVENT(rproc_attach_event,
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
+	TP_printk("%s attaching returned %d",
+			__get_str(name),
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

