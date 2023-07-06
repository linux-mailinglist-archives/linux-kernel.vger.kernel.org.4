Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C174A611
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGFVnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGFVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:43:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6901FF7;
        Thu,  6 Jul 2023 14:42:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366LXVql009263;
        Thu, 6 Jul 2023 21:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NG6ZBkBrzZbuDvIirQPnHenO/FvyuxYx3kz6+WGyraM=;
 b=P25HytVPTYT5X+IP/dNk7Q4YmFZ1waAtR9rQGMzr8Pcjn7eIkqBkkIxD7yYl8mhhSBHH
 CCRlYeIv+VYFUgTn9rhfs5AnXzrImruT5pcz3y1hzGspgPQsyCqt7kn5Gp/wHThyMWG/
 kd5eF5Xw4p4C3dqgrePgLWSXGb+5Y5gDH5mU0QThi7kvZK2sopbWlZk0qJyxcIKQDGTZ
 +TRXzzGCzZyGuLK6VqtYqbYcft/KyfwHy4dfi4ZVjxSydIenOGdjcG7XDlfb8nND8C/U
 eX9A0n0G0Vm/fV3qNM6l5r0PynCwyk+Xvq49pfzRDCOJcPUYSO8dr8OP4bgv55AtzYlh rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rntctsg19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 21:42:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366LgdTk017762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 21:42:39 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 14:42:35 -0700
From:   Sarannya S <quic_sarannya@quicinc.com>
To:     <quic_bjorande@quicinc.com>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Sarannya S <quic_sarannya@quicinc.com>,
        "Bjorn Andersson" <andersson@kernel.org>
Subject: [PATCH V9 3/3] rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support
Date:   Fri, 7 Jul 2023 03:11:38 +0530
Message-ID: <1688679698-31274-4-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688679698-31274-1-git-send-email-quic_sarannya@quicinc.com>
References: <1688679698-31274-1-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wiiuVh4uZ9stepSFfBkhMnvzAa6xnqgk
X-Proofpoint-ORIG-GUID: wiiuVh4uZ9stepSFfBkhMnvzAa6xnqgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <quic_clew@quicinc.com>

Add RPMSG_GET_OUTGOING_FLOWCONTROL and RPMSG_SET_INCOMING_FLOWCONTROL
IOCTL support for rpmsg char device nodes to get/set the low level
transport signals.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
---
 drivers/rpmsg/rpmsg_char.c | 54 ++++++++++++++++++++++++++++++++++++++++------
 include/uapi/linux/rpmsg.h | 10 +++++++++
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index a271fce..09833ad 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -52,6 +52,8 @@ static DEFINE_IDA(rpmsg_minor_ida);
  * @readq:	wait object for incoming queue
  * @default_ept: set to channel default endpoint if the default endpoint should be re-used
  *              on device open to prevent endpoint address update.
+ * remote_flow_restricted: to indicate if the remote has requested for flow to be limited
+ * remote_flow_updated: to indicate if the flow control has been requested
  */
 struct rpmsg_eptdev {
 	struct device dev;
@@ -68,6 +70,8 @@ struct rpmsg_eptdev {
 	struct sk_buff_head queue;
 	wait_queue_head_t readq;
 
+	bool remote_flow_restricted;
+	bool remote_flow_updated;
 };
 
 int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
@@ -116,6 +120,18 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	return 0;
 }
 
+static int rpmsg_ept_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable)
+{
+	struct rpmsg_eptdev *eptdev = priv;
+
+	eptdev->remote_flow_restricted = enable;
+	eptdev->remote_flow_updated = true;
+
+	wake_up_interruptible(&eptdev->readq);
+
+	return 0;
+}
+
 static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 {
 	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
@@ -152,6 +168,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EINVAL;
 	}
 
+	ept->flow_cb = rpmsg_ept_flow_cb;
 	eptdev->ept = ept;
 	filp->private_data = eptdev;
 	mutex_unlock(&eptdev->ept_lock);
@@ -172,6 +189,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 		eptdev->ept = NULL;
 	}
 	mutex_unlock(&eptdev->ept_lock);
+	eptdev->remote_flow_updated = false;
 
 	/* Discard all SKBs */
 	skb_queue_purge(&eptdev->queue);
@@ -285,6 +303,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	if (eptdev->remote_flow_updated)
+		mask |= EPOLLPRI;
+
 	mutex_lock(&eptdev->ept_lock);
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
 	mutex_unlock(&eptdev->ept_lock);
@@ -297,14 +318,35 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 {
 	struct rpmsg_eptdev *eptdev = fp->private_data;
 
-	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
-		return -EINVAL;
+	bool set;
+	int ret;
 
-	/* Don't allow to destroy a default endpoint. */
-	if (eptdev->default_ept)
-		return -EINVAL;
+	switch (cmd) {
+	case RPMSG_GET_OUTGOING_FLOWCONTROL:
+		eptdev->remote_flow_updated = false;
+		ret = put_user(eptdev->remote_flow_restricted, (int __user *)arg);
+		break;
+	case RPMSG_SET_INCOMING_FLOWCONTROL:
+		if (arg > 1) {
+			ret = -EINVAL;
+			break;
+		}
+		set = !!arg;
+		ret = rpmsg_set_flow_control(eptdev->ept, set, eptdev->chinfo.dst);
+		break;
+	case RPMSG_DESTROY_EPT_IOCTL:
+		/* Don't allow to destroy a default endpoint. */
+		if (eptdev->default_ept) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
+		break;
+	default:
+		ret = -EINVAL;
+	}
 
-	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
+	return ret;
 }
 
 static const struct file_operations rpmsg_eptdev_fops = {
diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
index 1637e68..f0c8da2 100644
--- a/include/uapi/linux/rpmsg.h
+++ b/include/uapi/linux/rpmsg.h
@@ -43,4 +43,14 @@ struct rpmsg_endpoint_info {
  */
 #define RPMSG_RELEASE_DEV_IOCTL	_IOW(0xb5, 0x4, struct rpmsg_endpoint_info)
 
+/**
+ * Get the flow control state of the remote rpmsg char device.
+ */
+#define RPMSG_GET_OUTGOING_FLOWCONTROL _IOR(0xb5, 0x5, int)
+
+/**
+ * Set the flow control state of the local rpmsg char device.
+ */
+#define RPMSG_SET_INCOMING_FLOWCONTROL _IOR(0xb5, 0x6, int)
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

