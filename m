Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765B65BCA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiISK5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiISK5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:57:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFFE71;
        Mon, 19 Sep 2022 03:54:29 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J6Asgl024618;
        Mon, 19 Sep 2022 10:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=szSyf/2tC+auA/OTvQr3j+RCEdfxlkRfmtAhj0CEsms=;
 b=Zv3qhF5urViDyt+eWZaZrtW/7qwvxfEAZ6bVTXDdhVcih0z+XQ45NX5l8V6R5LMlCzvu
 JguUOrE7pOpIA8ZcjJg+gzkz02ZV/mpojM0VhJW44IGUfiZU39FdxzWP0fv8EpB3Az1X
 pGtdtj8OVC0nzlai8/ARTW9s/PZd6zPkycynr9V1+79gDlBwxct4XIotANpX3gLYBPXt
 nNNdOdxqU3WQohWTRq9ZVy4mM02HpeCpLpIMwzcnK1XK/Mv95IuIuhU4nYUUkK/WMshk
 JfGar4OS38ZKW/3hODghHXEvOhMMl3p8R0DfhA4iklyuz1ndwrqUZMMyGJGI7QGmqQa/ Jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn70nm964-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 10:54:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JAsNGO000703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 10:54:23 GMT
Received: from deesin-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 03:54:20 -0700
From:   Deepak Kumar Singh <quic_deesin@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <arnaud.pouliquen@foss.st.com>,
        <swboyd@chromium.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
Subject: [PATCH V5 2/2] rpmsg: ctrl: Add lock to rpmsg_ctrldev_remove
Date:   Mon, 19 Sep 2022 16:24:00 +0530
Message-ID: <1663584840-15762-3-git-send-email-quic_deesin@quicinc.com>
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
X-Proofpoint-GUID: FZeMHd9suSf0SfHsBg3moRupKMeFnGYN
X-Proofpoint-ORIG-GUID: FZeMHd9suSf0SfHsBg3moRupKMeFnGYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=917 impostorscore=0 priorityscore=1501 spamscore=0
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

Call to rpmsg_ctrldev_ioctl() and rpmsg_ctrldev_remove() must be synchronized.
In present code rpmsg_ctrldev_remove() is not protected with lock, therefore
new char device creation can succeed through rpmsg_ctrldev_ioctl() call. At the
same time call to rpmsg_ctrldev_remove() function for ctrl device removal will
free associated rpdev device. As char device creation already succeeded, user
space is free to issue open() call which maps to rpmsg_create_ept() in kernel.
rpmsg_create_ept() function tries to reference rpdev which has already been
freed through rpmsg_ctrldev_remove(). Issue is predominantly seen in aggressive
reboot tests where rpmsg_ctrldev_ioctl() and rpmsg_ctrldev_remove() can race with
each other.

Adding lock in rpmsg_ctrldev_remove() avoids any new char device creation
through rpmsg_ctrldev_ioctl() while remove call is already in progress.

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

