Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A335B80D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiINF0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiINFZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:25:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9830562;
        Tue, 13 Sep 2022 22:25:48 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E4V0E6018305;
        Wed, 14 Sep 2022 05:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=2ODHA0/Bsfqk0WjywQN7UbEvA7iK3s+RsjvJ7Jg3QSQ=;
 b=Y3p8qT/U9KCGDIy1oklNJYBmzeSwJDkjcroZQp1yVL8oVP7zgHJ8uX6a8pz2jFlVeoTU
 oA5NEb6kxQADZ0tkw9CZY+Gd18JUjaaNnjVH6DJRyxVrjauPYpj+m8XEG866fEgO7O4s
 y/YZ5kE1dzmwsEOQVaOPT3xUmqdXk71PgtYrJUfu8BLedsLpmOb3h3QFDjHJpcgN/2GH
 z96ME99lgI6J/yuCbjlO3vo1Z5OwbLbkewYF8QJoFldTuHAzh0vrCAl+mc56RIZOT69Z
 kdylyD0TtbCIs2wtyu24450lwJFZNiuuMjV5aW5dq4UTPFlCAPAgOP+O10fzfiR6h5N4 6w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxys1cbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 05:25:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E5PhGO028526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 05:25:43 GMT
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 22:25:39 -0700
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: [PATCH V3 3/3] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Date:   Wed, 14 Sep 2022 10:55:02 +0530
Message-ID: <1663133102-10671-4-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663133102-10671-1-git-send-email-quic_deesin@quicinc.com>
References: <1663133102-10671-1-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8LtGdvdWcqFW2jJ2eYnavo5OybGA_Abn
X-Proofpoint-GUID: 8LtGdvdWcqFW2jJ2eYnavo5OybGA_Abn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_02,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140025
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
to get/set the low level transport signals.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
---
 drivers/rpmsg/rpmsg_char.c | 60 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 4f21891..1eb6e9d 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -23,6 +23,7 @@
 #include <linux/rpmsg.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
+#include <linux/termios.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/rpmsg.h>
 
@@ -68,6 +69,8 @@ struct rpmsg_eptdev {
 	struct sk_buff_head queue;
 	wait_queue_head_t readq;
 
+	u32 rsigs;
+	bool sig_pending;
 };
 
 int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
@@ -107,7 +110,22 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	skb_queue_tail(&eptdev->queue, skb);
 	spin_unlock(&eptdev->queue_lock);
 
-	/* wake up any blocking processes, waiting for new data */
+	wake_up_interruptible(&eptdev->readq);
+
+	return 0;
+}
+
+static int rpmsg_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable)
+{
+	struct rpmsg_eptdev *eptdev = priv;
+
+	if (enable)
+		eptdev->rsigs = TIOCM_DSR | TIOCM_CTS;
+	else
+		eptdev->rsigs = 0;
+	
+	eptdev->sig_pending = true;
+
 	wake_up_interruptible(&eptdev->readq);
 
 	return 0;
@@ -144,6 +162,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EINVAL;
 	}
 
+	ept->flow_cb = rpmsg_flow_cb;
 	eptdev->ept = ept;
 	filp->private_data = eptdev;
 	mutex_unlock(&eptdev->ept_lock);
@@ -164,6 +183,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 		eptdev->ept = NULL;
 	}
 	mutex_unlock(&eptdev->ept_lock);
+	eptdev->sig_pending = false;
 
 	/* Discard all SKBs */
 	skb_queue_purge(&eptdev->queue);
@@ -277,6 +297,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	if (eptdev->sig_pending)
+		mask |= EPOLLPRI;
+
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
 
 	return mask;
@@ -287,14 +310,35 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 {
 	struct rpmsg_eptdev *eptdev = fp->private_data;
 
-	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
-		return -EINVAL;
-
-	/* Don't allow to destroy a default endpoint. */
-	if (eptdev->default_ept)
-		return -EINVAL;
+	bool set;
+	u32 val;
+	int ret;
+	
+	switch (cmd) {
+	case TIOCMGET:
+		eptdev->sig_pending = false;
+		ret = put_user(eptdev->rsigs, (int __user *)arg);
+		break;
+	case TIOCMSET:
+		ret = get_user(val, (int __user *)arg);
+		if (ret)
+			break;
+		set = (val & (TIOCM_DTR | TIOCM_RTS)) ? true : false;
+		ret = rpmsg_set_flow_control(eptdev->ept, set);
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
-- 
2.7.4

