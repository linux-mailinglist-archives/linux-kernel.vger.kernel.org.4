Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39636694BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjBMPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjBMPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:52:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EC21A650;
        Mon, 13 Feb 2023 07:52:26 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DBTLnZ015094;
        Mon, 13 Feb 2023 15:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=F7oxpfsDLAX+sB8d/rOwe/QPj8h6a7CRnboFVtjIcjU=;
 b=TUvH5l3KL760sHn4M0YPWEg1Z8UqaDCssVA6BhOBgQHaeBZxIGdyyh0LmS85MRHfOIPC
 NFYgogDdCdG37cLfI6U6tPRAgxOaHfqd79b/ql3CDmFEyoSm1Sgn8iYc6GoqYMvCyttn
 5ASLapPAscVPCwcw6tYVnha3xT5moQzHOIZ6+Sq6euDOS0cT5JSe4PKHa2P91EOB3piK
 m47dHhvPWzNosuBpnwBj5qyh1vF2v+QLmMQ6opybvRbinFuZHLQjV+8QU8EemrQjPPQe
 UjeebGdo5KvCKf4KPefeJuNlx2Oqxnbwft2kmn5vOwxvi2FGq4Mpt8Du+3eD7fIwPFpv kg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np389vb6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DFqLQZ021286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 15:52:21 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 07:52:21 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] rpmsg: glink: smem: Wrap driver context
Date:   Mon, 13 Feb 2023 07:52:11 -0800
Message-ID: <20230213155215.1237059-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
References: <20230213155215.1237059-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ToHCvDwM4ecq-W0SoffOR9pJ8YLHIzag
X-Proofpoint-GUID: ToHCvDwM4ecq-W0SoffOR9pJ8YLHIzag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_10,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Glink SMEM driver allocates a struct device and hangs two
devres-allocated pipe objects thereon. To facilitate the move of
interrupt and mailbox handling to the driver, introduce a wrapper object
capturing the device, glink reference and remote processor id.

The type of the remoteproc reference is updated, as these are
specifically targeting the SMEM implementation.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v1:
- Revert back to use a local struct device * in register, to reduce size of
  diff.
- Reverse xmas tree of variables in register
- Fix spelling of targeting in commit message.

 drivers/remoteproc/qcom_common.h |  3 ++-
 drivers/rpmsg/qcom_glink_smem.c  | 43 ++++++++++++++++++++++++--------
 include/linux/rpmsg/qcom_glink.h | 12 ++++-----
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index c35adf730be0..2747c7d9ba44 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -6,6 +6,7 @@
 #include "remoteproc_internal.h"
 #include <linux/soc/qcom/qmi.h>
 
+struct qcom_glink_smem;
 struct qcom_sysmon;
 
 struct qcom_rproc_glink {
@@ -15,7 +16,7 @@ struct qcom_rproc_glink {
 
 	struct device *dev;
 	struct device_node *node;
-	struct qcom_glink *edge;
+	struct qcom_glink_smem *edge;
 };
 
 struct qcom_rproc_subdev {
diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 579bc4443f6d..a9c477df4d68 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -33,6 +33,14 @@
 #define SMEM_GLINK_NATIVE_XPRT_FIFO_0		479
 #define SMEM_GLINK_NATIVE_XPRT_FIFO_1		480
 
+struct qcom_glink_smem {
+	struct device dev;
+
+	struct qcom_glink *glink;
+
+	u32 remote_pid;
+};
+
 struct glink_smem_pipe {
 	struct qcom_glink_pipe native;
 
@@ -41,7 +49,7 @@ struct glink_smem_pipe {
 
 	void *fifo;
 
-	int remote_pid;
+	struct qcom_glink_smem *smem;
 };
 
 #define to_smem_pipe(p) container_of(p, struct glink_smem_pipe, native)
@@ -49,13 +57,14 @@ struct glink_smem_pipe {
 static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
 {
 	struct glink_smem_pipe *pipe = to_smem_pipe(np);
+	struct qcom_glink_smem *smem = pipe->smem;
 	size_t len;
 	void *fifo;
 	u32 head;
 	u32 tail;
 
 	if (!pipe->fifo) {
-		fifo = qcom_smem_get(pipe->remote_pid,
+		fifo = qcom_smem_get(smem->remote_pid,
 				     SMEM_GLINK_NATIVE_XPRT_FIFO_1, &len);
 		if (IS_ERR(fifo)) {
 			pr_err("failed to acquire RX fifo handle: %ld\n",
@@ -179,14 +188,17 @@ static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
 
 static void qcom_glink_smem_release(struct device *dev)
 {
-	kfree(dev);
+	struct qcom_glink_smem *smem = container_of(dev, struct qcom_glink_smem, dev);
+
+	kfree(smem);
 }
 
-struct qcom_glink *qcom_glink_smem_register(struct device *parent,
-					    struct device_node *node)
+struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
+						 struct device_node *node)
 {
 	struct glink_smem_pipe *rx_pipe;
 	struct glink_smem_pipe *tx_pipe;
+	struct qcom_glink_smem *smem;
 	struct qcom_glink *glink;
 	struct device *dev;
 	u32 remote_pid;
@@ -194,10 +206,12 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	size_t size;
 	int ret;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
+	smem = kzalloc(sizeof(*smem), GFP_KERNEL);
+	if (!smem)
 		return ERR_PTR(-ENOMEM);
 
+	dev = &smem->dev;
+
 	dev->parent = parent;
 	dev->of_node = node;
 	dev->release = qcom_glink_smem_release;
@@ -216,6 +230,8 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 		goto err_put_dev;
 	}
 
+	smem->remote_pid = remote_pid;
+
 	rx_pipe = devm_kzalloc(dev, sizeof(*rx_pipe), GFP_KERNEL);
 	tx_pipe = devm_kzalloc(dev, sizeof(*tx_pipe), GFP_KERNEL);
 	if (!rx_pipe || !tx_pipe) {
@@ -264,14 +280,14 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 		goto err_put_dev;
 	}
 
+	rx_pipe->smem = smem;
 	rx_pipe->native.avail = glink_smem_rx_avail;
 	rx_pipe->native.peak = glink_smem_rx_peak;
 	rx_pipe->native.advance = glink_smem_rx_advance;
-	rx_pipe->remote_pid = remote_pid;
 
+	tx_pipe->smem = smem;
 	tx_pipe->native.avail = glink_smem_tx_avail;
 	tx_pipe->native.write = glink_smem_tx_write;
-	tx_pipe->remote_pid = remote_pid;
 
 	*rx_pipe->tail = 0;
 	*tx_pipe->head = 0;
@@ -285,7 +301,10 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 		goto err_put_dev;
 	}
 
-	return glink;
+	smem->glink = glink;
+
+	return smem;
+
 
 err_put_dev:
 	device_unregister(dev);
@@ -294,8 +313,10 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(qcom_glink_smem_register);
 
-void qcom_glink_smem_unregister(struct qcom_glink *glink)
+void qcom_glink_smem_unregister(struct qcom_glink_smem *smem)
 {
+	struct qcom_glink *glink = smem->glink;
+
 	qcom_glink_native_remove(glink);
 	qcom_glink_native_unregister(glink);
 }
diff --git a/include/linux/rpmsg/qcom_glink.h b/include/linux/rpmsg/qcom_glink.h
index 22fc3a69b683..bfbd48f435fa 100644
--- a/include/linux/rpmsg/qcom_glink.h
+++ b/include/linux/rpmsg/qcom_glink.h
@@ -5,7 +5,7 @@
 
 #include <linux/device.h>
 
-struct qcom_glink;
+struct qcom_glink_smem;
 
 #if IS_ENABLED(CONFIG_RPMSG_QCOM_GLINK)
 void qcom_glink_ssr_notify(const char *ssr_name);
@@ -15,20 +15,20 @@ static inline void qcom_glink_ssr_notify(const char *ssr_name) {}
 
 #if IS_ENABLED(CONFIG_RPMSG_QCOM_GLINK_SMEM)
 
-struct qcom_glink *qcom_glink_smem_register(struct device *parent,
-					    struct device_node *node);
-void qcom_glink_smem_unregister(struct qcom_glink *glink);
+struct qcom_glink_smem *qcom_glink_smem_register(struct device *parent,
+						 struct device_node *node);
+void qcom_glink_smem_unregister(struct qcom_glink_smem *glink);
 
 #else
 
-static inline struct qcom_glink *
+static inline struct qcom_glink_smem *
 qcom_glink_smem_register(struct device *parent,
 			 struct device_node *node)
 {
 	return NULL;
 }
 
-static inline void qcom_glink_smem_unregister(struct qcom_glink *glink) {}
+static inline void qcom_glink_smem_unregister(struct qcom_glink_smem *glink) {}
 #endif
 
 #endif
-- 
2.25.1

