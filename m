Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F356FE399
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjEJSFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjEJSFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:05:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB065B80;
        Wed, 10 May 2023 11:05:29 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AEYjYq015448;
        Wed, 10 May 2023 18:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TFO+ASYvrLFqEdFOPQ+XU8KFRwDiwNBhRyhH+x2G6ig=;
 b=jw9IHQd6+FU7taS6mAknpwPYh4KmVBiF9OB7b/ed57sGKokY7kQCkupXr23joC+UWbRZ
 wqd8ufa9UMqeuwBRpBWRoJeQuJXjao8Oy+J+KuNsPEOQkeW6/1sWnzkwOgudijRZmjAW
 3m9PISwACseE/qIAL/zkfBYAOvbo58aEj/Da3JcltMGnxGGbt55ZenG1ZHNo+KS+CfBh
 IIs67Ne/5yDNxJahLfBf5UISdGZunrrlZKc0XIczjOMFScDDrymCLrO2SzoYflRUWuQO
 LnKhKunuX8vCvtApQkDOIduzsgVyRJOY5JGoV6i3SdXSuS5pDKh8fszCbut9WgnjdBlX 1w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg79cs7yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 18:05:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AI5OMQ022918
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 18:05:24 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 11:05:24 -0700
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
Subject: [PATCH v3 2/2] remoteproc: qcom: Add remoteproc tracing
Date:   Wed, 10 May 2023 11:05:04 -0700
Message-ID: <3efc06319d52973e74c64fec701111427639044c.1683741283.git.quic_gokukris@quicinc.com>
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
X-Proofpoint-GUID: hGxEcqL0z165_sjwqT2TYQaVqaIREBX0
X-Proofpoint-ORIG-GUID: hGxEcqL0z165_sjwqT2TYQaVqaIREBX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=904 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change attempts to add traces for start, stop, crash
subsystem/subdevice events, these will serve as standard checkpoints in
code and could help in debugging the failures in subdevice/subsystem
prepare, start, stop and unprepare functions. This will also breakdown
the time taken for each step in remoteproc bootup/shutdown process.

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
 drivers/remoteproc/qcom_common.c     | 37 ++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5.c       |  9 +++++++
 drivers/remoteproc/remoteproc_core.c |  8 ++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index a0d4238492e9..c19bcb2dd603 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/soc/qcom/smem.h>
+#include <trace/events/rproc_qcom.h>
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
@@ -191,6 +192,10 @@ static int glink_subdev_start(struct rproc_subdev *subdev)
 
 	glink->edge = qcom_glink_smem_register(glink->dev, glink->node);
 
+	trace_rproc_subdev_event(dev_name(glink->dev->parent),
+					"glink", "start",
+					PTR_ERR_OR_ZERO(glink->edge));
+
 	return PTR_ERR_OR_ZERO(glink->edge);
 }
 
@@ -199,6 +204,11 @@ static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
 
 	qcom_glink_smem_unregister(glink->edge);
+
+	trace_rproc_subdev_event(dev_name(glink->dev->parent),
+					"glink", "stop",
+					PTR_ERR_OR_ZERO(glink->edge));
+
 	glink->edge = NULL;
 }
 
@@ -206,6 +216,10 @@ static void glink_subdev_unprepare(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
 
+	trace_rproc_subdev_event(dev_name(glink->dev->parent),
+					"glink", "unprepare",
+					PTR_ERR_OR_ZERO(glink->edge));
+
 	qcom_glink_ssr_notify(glink->ssr_name);
 }
 
@@ -300,6 +314,10 @@ static int smd_subdev_start(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
 
+	trace_rproc_subdev_event(dev_name(smd->dev->parent),
+					"smd", "start",
+					PTR_ERR_OR_ZERO(smd->edge));
+
 	smd->edge = qcom_smd_register_edge(smd->dev, smd->node);
 
 	return PTR_ERR_OR_ZERO(smd->edge);
@@ -309,6 +327,10 @@ static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
 
+	trace_rproc_subdev_event(dev_name(smd->dev->parent),
+					"smd", "stop",
+					PTR_ERR_OR_ZERO(smd->edge));
+
 	qcom_smd_unregister_edge(smd->edge);
 	smd->edge = NULL;
 }
@@ -425,6 +447,10 @@ static int ssr_notify_prepare(struct rproc_subdev *subdev)
 		.crashed = false,
 	};
 
+	trace_rproc_subdev_event(ssr->info->name,
+					"ssr", "QCOM_SSR_BEFORE_POWERUP",
+					data.crashed);
+
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
 				 QCOM_SSR_BEFORE_POWERUP, &data);
 	return 0;
@@ -437,6 +463,9 @@ static int ssr_notify_start(struct rproc_subdev *subdev)
 		.name = ssr->info->name,
 		.crashed = false,
 	};
+	trace_rproc_subdev_event(ssr->info->name,
+					"ssr", "QCOM_SSR_AFTER_POWERUP",
+					data.crashed);
 
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
 				 QCOM_SSR_AFTER_POWERUP, &data);
@@ -451,6 +480,10 @@ static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
 		.crashed = crashed,
 	};
 
+	trace_rproc_subdev_event(ssr->info->name,
+					"ssr", "QCOM_SSR_BEFORE_SHUTDOWN",
+					data.crashed);
+
 	srcu_notifier_call_chain(&ssr->info->notifier_list,
 				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
 }
@@ -463,6 +496,10 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
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
index 192c7aa0e39e..2f4e9c8ebbf9 100644
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
 
+	trace_rproc_interrupt_event(q6v5->rproc, "Ready", !ret ? "-ETIMEDOUT":"done");
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
 
+	trace_rproc_interrupt_event(q6v5->rproc, "Stop", ret ? "done":"-EETIMEDOUT");
+
 	return ret == 0 ? -ETIMEDOUT : 0;
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 695cce218e8c..ced7584c27c3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -38,6 +38,7 @@
 #include <linux/virtio_ring.h>
 #include <asm/byteorder.h>
 #include <linux/platform_device.h>
+#include <trace/events/rproc_qcom.h>
 
 #include "remoteproc_internal.h"
 
@@ -1271,6 +1272,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 
 	/* load the ELF segments to memory */
 	ret = rproc_load_segments(rproc, fw);
+	trace_rproc_load_event(rproc, ret);
 	if (ret) {
 		dev_err(dev, "Failed to load program segments: %d\n", ret);
 		return ret;
@@ -1306,6 +1308,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 
 	/* Start any subdevices for the remote processor */
 	ret = rproc_start_subdevices(rproc);
+
 	if (ret) {
 		dev_err(dev, "failed to probe subdevices for %s: %d\n",
 			rproc->name, ret);
@@ -1730,6 +1733,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 		return ret;
 	}
 
+	trace_rproc_stop_event(rproc, crashed ? "crash stop" : "stop");
+
 	rproc_unprepare_subdevices(rproc);
 
 	rproc->state = RPROC_OFFLINE;
@@ -1940,6 +1945,8 @@ int rproc_boot(struct rproc *rproc)
 		dev_info(dev, "attaching to %s\n", rproc->name);
 
 		ret = rproc_attach(rproc);
+		trace_rproc_start_event(rproc, ret);
+
 	} else {
 		dev_info(dev, "powering up %s\n", rproc->name);
 
@@ -1951,6 +1958,7 @@ int rproc_boot(struct rproc *rproc)
 		}
 
 		ret = rproc_fw_boot(rproc, firmware_p);
+		trace_rproc_start_event(rproc, ret);
 
 		release_firmware(firmware_p);
 	}
-- 
2.40.1

