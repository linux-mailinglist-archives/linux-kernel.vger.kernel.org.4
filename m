Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2525B5ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiILRGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiILRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:06:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F0B19C20;
        Mon, 12 Sep 2022 10:06:10 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CFkBDR032690;
        Mon, 12 Sep 2022 17:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=A2j0MRKCtFKOt7VutTqnUdXi2BId9g8TnNi5kcZ+Ync=;
 b=HIvsDp68QlNPxDl9VYky+9jTYHhBYMg9HUw1hZZkKf6+9m9SnytHXbz6/FeOWNFo1ekW
 gZEaJ14jwptLmVN204c765iztfGB2F9E/YHDKS1LwEEcWA2HkcolA531gEE0H7EEkhKW
 BmQ6ew9iwYvsqNbSsE9fnwSi48dA3NuDpjLUnBgE/jHuqFu8lmmx/r9pbRWonK7GjKen
 W8uA3egLvHeADmDuJM90qIpZORsO0TXEIEdupaagLiU+td213sSqQmZ+tmzh3CiXiDQ2
 REOBXMbsOGBuTLUa+nkSTfMaXknxgm+df1olq+uf2OEuXVZS2CpV8J9I8AWXLvvqr9cJ rg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgkve5k14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 17:06:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CH6548018140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 17:06:05 GMT
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 10:06:03 -0700
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: [PATCH V3 1/2] rpmsg: glink: Add lock to avoid race when rpmsg device is released
Date:   Mon, 12 Sep 2022 22:35:35 +0530
Message-ID: <1663002336-11809-2-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663002336-11809-1-git-send-email-quic_deesin@quicinc.com>
References: <1663002336-11809-1-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: w2deRUdGRb09rEaS-t0sxJ74axCtAAm0
X-Proofpoint-GUID: w2deRUdGRb09rEaS-t0sxJ74axCtAAm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_12,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120058
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

