Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FBD680266
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjA2Wvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjA2Wvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:51:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F94204;
        Sun, 29 Jan 2023 14:51:42 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30TMigc6021440;
        Sun, 29 Jan 2023 22:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=06UAkjv2IQRsahvZGsFUmQxlW+avpP/PI5OpkRrwtG4=;
 b=GnvvsbxR4SmJN7PnVeItVpLRck3ebSKSBdTFxuixm9k+w/+0u+5VmA8zdptXYtyU7IBH
 jCYNwiQQH27j188fgLSlZrc8JhYrf87Eh5q54auqIIxJPJYvXXnqApj3w7C6dCY8AR9K
 bFkiFtrS2cmROelVIlx8dwQL302Ai3MgbB9uE4KQchzpS20M1rUKq2GteJZZOO4TNsgE
 mXMPUJioI/uxXQN2OfWy4pymAycj4hrGqYR8zEhvqexDJsbRqcpxaFUltQZQO3yJSuJu
 Ng8UCSyUMjANApCV/55wjS1seNXx9y7q05uIYurwZGIA7k1purf7bgfE1I1DH5xUTGMN Qg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvvu2ajc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 22:51:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30TMpcoB029252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Jan 2023 22:51:38 GMT
Received: from hu-satyap-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 14:51:38 -0800
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH] remoteproc: sysfs: fix race while updating recovery flag
Date:   Sun, 29 Jan 2023 14:51:06 -0800
Message-ID: <20230129225106.10606-1-quic_satyap@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z8nN0swIQBXRgLgv8Ihe2m89wHk5fivW
X-Proofpoint-ORIG-GUID: z8nN0swIQBXRgLgv8Ihe2m89wHk5fivW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_13,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301290227
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple clients try to update the recovery flag, it is
possible that, race condition would lead to undesired results
as updates to recovery flag isn't protected by any mechanism
today. To avoid such issues, take remoteproc mutex lock before
updating recovery flag and release the lock once done.

Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 8c7ea8922638..ec37176e1589 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -48,16 +48,21 @@ static ssize_t recovery_store(struct device *dev,
 {
 	struct rproc *rproc = to_rproc(dev);
 
+	mutex_lock(&rproc->lock);
 	if (sysfs_streq(buf, "enabled")) {
 		/* change the flag and begin the recovery process if needed */
 		rproc->recovery_disabled = false;
+		mutex_unlock(&rproc->lock);
 		rproc_trigger_recovery(rproc);
 	} else if (sysfs_streq(buf, "disabled")) {
 		rproc->recovery_disabled = true;
+		mutex_unlock(&rproc->lock);
 	} else if (sysfs_streq(buf, "recover")) {
 		/* begin the recovery process without changing the flag */
+		mutex_unlock(&rproc->lock);
 		rproc_trigger_recovery(rproc);
 	} else {
+		mutex_unlock(&rproc->lock);
 		return -EINVAL;
 	}
 
-- 
2.38.1

