Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34DF685F29
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBAFrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBAFrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:47:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82853E4E;
        Tue, 31 Jan 2023 21:47:12 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114hO3U026858;
        Wed, 1 Feb 2023 05:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UQ2fZFq0Pklcd/k3eCwtkMhcSV2DJzYmghTurlDizyI=;
 b=cXOBvp40POhSH4Ql/DTbd4zMN9dvlro0PdRa1ceivX6kKsMWcxipVIesZ4LhjaNNlIg8
 z634Bi7mb329tT5QJb8M+I465kP7iZutcXaDs/Yy+6BPsIxIVTUvOIRhIkJ4q6UM36Gg
 GFZ247mpgFz895qo6aAjGo3v3SlX3lNADhZAWBBJh5tRQcNLTfk0QQTacgNRCWMjVECy
 omQmiFzGRHmKFgicUjPmfuon3UGV7MaTzQX/ORJoFLgnxHN0Xao9K7f6sIG30JveKszk
 PeuaIW2+0S9WxmJkXxnfblgSOxWQhI3fy4gmTYyo1HwppWLGkPvX5bGwzLF7ptmjHf+N Zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfbyq0smt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 05:47:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3115l8uY011002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 05:47:08 GMT
Received: from hu-satyap-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 21:47:08 -0800
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2] remoteproc: sysfs/debugfs: fix race while updating recovery flag
Date:   Tue, 31 Jan 2023 21:46:08 -0800
Message-ID: <20230201054609.14575-1-quic_satyap@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fvvROxJiFUqxZy8HiSydQXQb8CzWycFT
X-Proofpoint-GUID: fvvROxJiFUqxZy8HiSydQXQb8CzWycFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302010048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
v1 -> v2:
- addressed comments from Mukesh Ojha
  1. take & release lock only while updating recovery flag
  2. update debugfs

 drivers/remoteproc/remoteproc_debugfs.c | 4 ++++
 drivers/remoteproc/remoteproc_sysfs.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index b86c1d09c70c..2c44d375024e 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -226,10 +226,14 @@ rproc_recovery_write(struct file *filp, const char __user *user_buf,
 
 	if (!strncmp(buf, "enabled", count)) {
 		/* change the flag and begin the recovery process if needed */
+		mutex_lock(&rproc->lock);
 		rproc->recovery_disabled = false;
+		mutex_unlock(&rproc->lock);
 		rproc_trigger_recovery(rproc);
 	} else if (!strncmp(buf, "disabled", count)) {
+		mutex_lock(&rproc->lock);
 		rproc->recovery_disabled = true;
+		mutex_unlock(&rproc->lock);
 	} else if (!strncmp(buf, "recover", count)) {
 		/* begin the recovery process without changing the flag */
 		rproc_trigger_recovery(rproc);
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 8c7ea8922638..628e0de9a132 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -50,10 +50,14 @@ static ssize_t recovery_store(struct device *dev,
 
 	if (sysfs_streq(buf, "enabled")) {
 		/* change the flag and begin the recovery process if needed */
+		mutex_lock(&rproc->lock);
 		rproc->recovery_disabled = false;
+		mutex_unlock(&rproc->lock);
 		rproc_trigger_recovery(rproc);
 	} else if (sysfs_streq(buf, "disabled")) {
+		mutex_lock(&rproc->lock);
 		rproc->recovery_disabled = true;
+		mutex_unlock(&rproc->lock);
 	} else if (sysfs_streq(buf, "recover")) {
 		/* begin the recovery process without changing the flag */
 		rproc_trigger_recovery(rproc);
-- 
2.38.1

