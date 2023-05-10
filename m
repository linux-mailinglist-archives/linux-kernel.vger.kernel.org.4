Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352EB6FE397
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjEJSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbjEJSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:05:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A8859F4;
        Wed, 10 May 2023 11:05:27 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AGSIWg024965;
        Wed, 10 May 2023 18:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=k/cDQFkn6T8/fGU26erDY5d/FZyY5SPYRKfscGG7tLc=;
 b=L/zJ1JC5YFF0J87+hUmaFg5wF6j/rEl0Zn33sno5UwyhQ1bFklco6tshUPy3b5BNg8ED
 jZf0Ofk+P2lNvtV1gpRIqvr2mNt5Yp1R8ok95L0RRcUqXqM63HrgDusigtxBLSb+W0+E
 aMLhVppcEcgKuNlnB2a/sfAHtlnFS3XChlLOqFRuYnCXS/npw+cdbN9HpnLUNroZ8lD5
 yX3AtrWlmg7/UUf9NFJXydpZUWsMLvnsdhXw7Db7I1JFYx/d+tdVEB4P4snjSZMvodJW
 AvA4I84EvFxfJbllk6mcTWAosFvt2Rxd1aKtaMVUX82F1K28BgqnkLlNfHYuUVHv2e8Q Eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg1g11tey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 18:05:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AI5MWh016083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 18:05:22 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 11:05:21 -0700
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
Subject: [PATCH v3 1/2] remoteproc: Introduce traces for remoteproc events
Date:   Wed, 10 May 2023 11:05:03 -0700
Message-ID: <5c7c2657d12808e211942d71ad79e3846f4e70bb.1683741283.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683741283.git.quic_gokukris@quicinc.com>
References: <cover.1683741283.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lkNT23nSbAdSaDBhKO5Kq4YtT5b2doar
X-Proofpoint-ORIG-GUID: lkNT23nSbAdSaDBhKO5Kq4YtT5b2doar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/qcom_tracepoints.c |  12 +++
 include/trace/events/rproc_qcom.h     | 128 ++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
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
diff --git a/include/trace/events/rproc_qcom.h b/include/trace/events/rproc_qcom.h
new file mode 100644
index 000000000000..48ad26ce18a3
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
+	TP_PROTO(struct rproc *rproc, char *crash_msg),
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
+			 __get_str(event), __get_str(msg))
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
+	TP_printk("%s %s %s %d", __get_str(rproc), __get_str(subdev),
+			__get_str(event), __entry->ret)
+);
+#endif /* _TRACE_RPROC_QCOM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.40.1

