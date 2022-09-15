Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158FC5B97C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIOJo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIOJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:44:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A49CE1B;
        Thu, 15 Sep 2022 02:44:47 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EN0qx1026143;
        Thu, 15 Sep 2022 09:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=W3zY9QLNPWEAB8o9Gg6uFxsBfJVYFRPkCf7CJNbWhIg=;
 b=Ixg/8E/v+b3nQVulmN0UBDIf0v1LvJXqXV0mb5oTs704oyQ4xmdTc1agw1wsxPX6ZOFu
 EaDzqcNUGGI7Biw0qD+cZhgmwLB8AWJnK6LXS3l1o26fN6nBdYzlgp/SNb6IDwDXPHEs
 gG9YuaV0wSi0Bi+9eQHmIUJUjeVqjsmzh3DNPW4QgkmdQ6biu925Q76FXpOWmTU4s2Da
 EF6EhNAl57S4ZRKeK2E+Ou8DNZq2A/A6hzlTKJd4Le/hyMYOhmkHr6i8+GiGtUVag39l
 5eXnjDSk/l8Mnm5YOc3yZFZKQL5B2u0BwNGnMHdPMsgxka2tExqaotQ5Q+7GpRHDHAV3 vQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxyvnxht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 09:44:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28F9ieNj027904
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 09:44:40 GMT
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 15 Sep 2022 02:44:37 -0700
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: [PATCH V4 2/2] rpmsg: ctrl: Add lock to rpmsg_ctrldev_remove
Date:   Thu, 15 Sep 2022 15:14:13 +0530
Message-ID: <1663235055-3081-3-git-send-email-quic_deesin@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663235055-3081-1-git-send-email-quic_deesin@quicinc.com>
References: <1663235055-3081-1-git-send-email-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AaacIgswq14N5rlTHFr63vN2WdEYfYOZ
X-Proofpoint-ORIG-GUID: AaacIgswq14N5rlTHFr63vN2WdEYfYOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=941 clxscore=1015 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150053
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call to rpmsg_ctrldev_ioctl() and rpmsg_ctrldev_remove() must be synchronized.
In present code rpmsg_ctrldev_remove() is not protected with lock, therefore
new char device creation can succeed through rpmsg_ctrldev_ioctl() call. At the
same time call to rpmsg_ctrldev_remove() funtion for ctrl device removal will
free associated rpdev device. As char device creation already succeeded, user
space is free to issue open() call which maps to rpmsg_create_ept() in kernel.
rpmsg_create_ept() function tries to reference rpdev which has already been
freed through rpmsg_ctrldev_remove(). Issue is predominantly seen in aggressive
reboot tests where rpmsg_ctrldev_ioctl() and rpmsg_ctrldev_remove() can race with
each other.

Adding lock in rpmsg_ctrldev_remove() avoids any new char device creation
throught rpmsg_ctrldev_ioctl() while remove call is already in progress.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
---
 drivers/rpmsg/rpmsg_ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index 107da70..4332538 100644
--- a/drivers/rpmsg/rpmsg_ctrl.c
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -194,10 +194,12 @@ static void rpmsg_ctrldev_remove(struct rpmsg_device *rpdev)
 	struct rpmsg_ctrldev *ctrldev = dev_get_drvdata(&rpdev->dev);
 	int ret;
 
+	mutex_lock(&ctrldev->ctrl_lock);
 	/* Destroy all endpoints */
 	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
 	if (ret)
 		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
+	mutex_unlock(&ctrldev->ctrl_lock);
 
 	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
 	put_device(&ctrldev->dev);
-- 
2.7.4

