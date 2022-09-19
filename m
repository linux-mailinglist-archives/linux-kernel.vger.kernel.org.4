Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7B5BCA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiISK50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiISK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:57:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D112A;
        Mon, 19 Sep 2022 03:54:26 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J7rSSO019184;
        Mon, 19 Sep 2022 10:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=A2j0MRKCtFKOt7VutTqnUdXi2BId9g8TnNi5kcZ+Ync=;
 b=jC363IHXqBNlpIC9G44S78I6Y3+cAC8SyyH0C3N+JUma3bDmrxwXTP9k+WjRbYWQOsUv
 eSgWIjJ6Rnw4rWPT6RJCp3z4OV2w0H59iCEWsZ1i19XChwytpC97rsXWbIzpCMWQV20j
 zCc8tpeiHKDPX9xgHYP32eE9BMafTdfWp9Et6sDCM7V4jU7Xch8mRtv85jARXa8d+qbK
 Ws091wEciiyncPsdaXEyTTZN5MJG1nt+V9fl0zb6QjNe9ziDH+wnQiexgufbbtMXtx7q
 hkNdTrwUySmyoXSn+OR8EbkKZ4PJ1MkL3TASLuuolJNN3qAgraEeFSWw4taY4i0HD0rB OQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn70nm95v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 10:54:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JAsKon015953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 10:54:20 GMT
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 03:54:16 -0700
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: [PATCH V5 1/2] rpmsg: char: Add lock to avoid race when rpmsg device is released
Date:   Mon, 19 Sep 2022 16:23:59 +0530
Message-ID: <1663584840-15762-2-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663584840-15762-1-git-send-email-quic_deesin@quicinc.com>
References: <1663584840-15762-1-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b_pGjVhjBzDL88dZOgg62tr6d4OL8lVu
X-Proofpoint-ORIG-GUID: b_pGjVhjBzDL88dZOgg62tr6d4OL8lVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209190073
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When remote host goes down glink char device channel is freed and
associated rpdev is destroyed through rpmsg_chrdev_eptdev_destroy(),
At the same time user space apps can still try to open/poll rpmsg
char device which will result in calling rpmsg_create_ept()/rpmsg_poll().
These functions will try to reference rpdev which has already been freed
through rpmsg_chrdev_eptdev_destroy().

File operation functions and device removal function must be protected
with lock. This patch adds existing ept lock in remove function as well.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
---
 drivers/rpmsg/rpmsg_char.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 4f21891..5500dc0 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -75,6 +75,7 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
 
 	mutex_lock(&eptdev->ept_lock);
+	eptdev->rpdev = NULL;
 	if (eptdev->ept) {
 		rpmsg_destroy_ept(eptdev->ept);
 		eptdev->ept = NULL;
@@ -126,6 +127,11 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 	}
 
+	if (!eptdev->rpdev) {
+		mutex_unlock(&eptdev->ept_lock);
+		return -ENETRESET;
+	}
+
 	get_device(dev);
 
 	/*
@@ -277,7 +283,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	mutex_lock(&eptdev->ept_lock);
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
+	mutex_unlock(&eptdev->ept_lock);
 
 	return mask;
 }
-- 
2.7.4

