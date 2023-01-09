Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E60663411
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbjAIWiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbjAIWi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:38:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573CF58C;
        Mon,  9 Jan 2023 14:38:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309MbkGu032609;
        Mon, 9 Jan 2023 22:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=KHkX2qla0WMOOX/Cuolafu0c+RlMeR7/ZIVBb5MV4Ko=;
 b=jya0sKnHJkQ5JI8Q/oitsEKrmKpov4SpaPWC2EUDY5kOCjS77IqJnmbJiNabQIMPyQOR
 K7gRbtcdIcXUMqYZwP6DwlRWjZNKEPx6429JtdK3IJuPzy8PC7axRjdPOHwdzUqb82TB
 zrcrJgDm9J2B9dqlOvjQyB2tULpZDu8yisJR9JxZkcD0D3reFv2oDnJ+N5d3AMvsIEAM
 bUZ/lZ/x0IBJe8IXfUAapBD86/uttwORG+yzviAkS+PZf+HqLIu/qtZu7PUiYt66pylF
 IIw/90Jx1EJb64/nbDA0ZLD9dwbOMWOxDSxqe6eudV3vM/1i0jyainw9NtCfv31onYYv +Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0q28gk67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 22:38:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309McNRa024995
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 22:38:23 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 14:38:23 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Chris Lew <quic_clew@quicinc.com>
Subject: [PATCH] rpmsg: glink: Release driver_override
Date:   Mon, 9 Jan 2023 14:38:18 -0800
Message-ID: <20230109223818.1706292-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PuYziX5vupY8zLrEIGuaYFJ_z57zMPZ8
X-Proofpoint-GUID: PuYziX5vupY8zLrEIGuaYFJ_z57zMPZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090157
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon termination of the rpmsg_device, driver_override needs to be freed
to avoid leaking the potentially assigned string.

Fixes: 42cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")
Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 8620eea1dc8a..046271e439c5 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1454,6 +1454,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 {
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
@@ -1697,6 +1698,7 @@ static void qcom_glink_device_release(struct device *dev)
 
 	/* Release qcom_glink_alloc_channel() reference */
 	kref_put(&channel->refcount, qcom_glink_channel_release);
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
-- 
2.37.3

