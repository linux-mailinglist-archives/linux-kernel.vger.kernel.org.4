Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E680F66342A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjAIWk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjAIWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:40:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05A2F58C;
        Mon,  9 Jan 2023 14:40:12 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309LepaQ020592;
        Mon, 9 Jan 2023 22:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=4e8Mz6h5RL7FchyNrlIzMuzEyjtxoOYy8k36C7ow1bQ=;
 b=SLO8blYcV7A/7Pyi2k5MqTRRT6FXPnRBds0FEHT4SMSKrO8VU+4lBS26OPWnar8Uz+67
 maaA/gKcX98WeAwDVIdauD1evkv9V8kofz18Firsbtw/EgOf1LyWJL1QVtckviVPzTmr
 FJnlE9FyuBXn3Sgg4qSnDiwGKGz6/BtYyxrd/kjlOa0YBWhvx6vVBLzURh9Cd/5PaUVe
 75EeD3rczl8FFwcV0+JjaR1DILoGTwVfCspVXDnwtKIRQBgmEPYUCmNSfHxqL2vejF90
 E+EOEVuEWo7itvcvxHg3Q3nASyF9Rvdi+h1PvKsUB9Hmc+Y3FWDyk1f/11iWxWv8KA5y Zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my14fv7wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 22:40:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309Me7AF026530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 22:40:07 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 14:40:07 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] rpmsg: glink: smem: Wrap driver context
Date:   Mon, 9 Jan 2023 14:39:57 -0800
Message-ID: <20230109224001.1706516-3-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
References: <20230109224001.1706516-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S51Z6nBS4a13u6ylmerCopeu_qajcnSu
X-Proofpoint-ORIG-GUID: S51Z6nBS4a13u6ylmerCopeu_qajcnSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090157
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
specifically targetting the SMEM implementation.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/remoteproc/qcom_common.h |  3 +-
 drivers/rpmsg/qcom_glink_smem.c  | 76 ++++++++++++++++++++------------
 include/linux/rpmsg/qcom_glink.h | 12 ++---
 3 files changed, 55 insertions(+), 36 deletions(-)

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
index 579bc4443f6d..703e63fa5a86 100644
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
@@ -179,45 +188,49 @@ static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
 
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
 	struct qcom_glink *glink;
-	struct device *dev;
+	struct qcom_glink_smem *smem;
 	u32 remote_pid;
 	__le32 *descs;
 	size_t size;
 	int ret;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
+	smem = kzalloc(sizeof(*smem), GFP_KERNEL);
+	if (!smem)
 		return ERR_PTR(-ENOMEM);
 
-	dev->parent = parent;
-	dev->of_node = node;
-	dev->release = qcom_glink_smem_release;
-	dev_set_name(dev, "%s:%pOFn", dev_name(parent->parent), node);
-	ret = device_register(dev);
+	smem->dev.parent = parent;
+	smem->dev.of_node = node;
+	smem->dev.release = qcom_glink_smem_release;
+	dev_set_name(&smem->dev, "%s:%pOFn", dev_name(parent->parent), node);
+	ret = device_register(&smem->dev);
 	if (ret) {
 		pr_err("failed to register glink edge\n");
-		put_device(dev);
+		put_device(&smem->dev);
 		return ERR_PTR(ret);
 	}
 
-	ret = of_property_read_u32(dev->of_node, "qcom,remote-pid",
+	ret = of_property_read_u32(smem->dev.of_node, "qcom,remote-pid",
 				   &remote_pid);
 	if (ret) {
-		dev_err(dev, "failed to parse qcom,remote-pid\n");
+		dev_err(&smem->dev, "failed to parse qcom,remote-pid\n");
 		goto err_put_dev;
 	}
 
-	rx_pipe = devm_kzalloc(dev, sizeof(*rx_pipe), GFP_KERNEL);
-	tx_pipe = devm_kzalloc(dev, sizeof(*tx_pipe), GFP_KERNEL);
+	smem->remote_pid = remote_pid;
+
+	rx_pipe = devm_kzalloc(&smem->dev, sizeof(*rx_pipe), GFP_KERNEL);
+	tx_pipe = devm_kzalloc(&smem->dev, sizeof(*tx_pipe), GFP_KERNEL);
 	if (!rx_pipe || !tx_pipe) {
 		ret = -ENOMEM;
 		goto err_put_dev;
@@ -226,20 +239,20 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	ret = qcom_smem_alloc(remote_pid,
 			      SMEM_GLINK_NATIVE_XPRT_DESCRIPTOR, 32);
 	if (ret && ret != -EEXIST) {
-		dev_err(dev, "failed to allocate glink descriptors\n");
+		dev_err(&smem->dev, "failed to allocate glink descriptors\n");
 		goto err_put_dev;
 	}
 
 	descs = qcom_smem_get(remote_pid,
 			      SMEM_GLINK_NATIVE_XPRT_DESCRIPTOR, &size);
 	if (IS_ERR(descs)) {
-		dev_err(dev, "failed to acquire xprt descriptor\n");
+		dev_err(&smem->dev, "failed to acquire xprt descriptor\n");
 		ret = PTR_ERR(descs);
 		goto err_put_dev;
 	}
 
 	if (size != 32) {
-		dev_err(dev, "glink descriptor of invalid size\n");
+		dev_err(&smem->dev, "glink descriptor of invalid size\n");
 		ret = -EINVAL;
 		goto err_put_dev;
 	}
@@ -252,31 +265,31 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	ret = qcom_smem_alloc(remote_pid, SMEM_GLINK_NATIVE_XPRT_FIFO_0,
 			      SZ_16K);
 	if (ret && ret != -EEXIST) {
-		dev_err(dev, "failed to allocate TX fifo\n");
+		dev_err(&smem->dev, "failed to allocate TX fifo\n");
 		goto err_put_dev;
 	}
 
 	tx_pipe->fifo = qcom_smem_get(remote_pid, SMEM_GLINK_NATIVE_XPRT_FIFO_0,
 				      &tx_pipe->native.length);
 	if (IS_ERR(tx_pipe->fifo)) {
-		dev_err(dev, "failed to acquire TX fifo\n");
+		dev_err(&smem->dev, "failed to acquire TX fifo\n");
 		ret = PTR_ERR(tx_pipe->fifo);
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
 
-	glink = qcom_glink_native_probe(dev,
+	glink = qcom_glink_native_probe(&smem->dev,
 					GLINK_FEATURE_INTENT_REUSE,
 					&rx_pipe->native, &tx_pipe->native,
 					false);
@@ -285,17 +298,22 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 		goto err_put_dev;
 	}
 
-	return glink;
+	smem->glink = glink;
+
+	return smem;
+
 
 err_put_dev:
-	device_unregister(dev);
+	device_unregister(&smem->dev);
 
 	return ERR_PTR(ret);
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
2.37.3

