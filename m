Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFE6AFD30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCHDBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCHDBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:01:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE91A3375;
        Tue,  7 Mar 2023 19:01:19 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3282mgvO011303;
        Wed, 8 Mar 2023 03:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=3XXnDnblTu0EK4aaQgq7s0zMJDrtKcirk7Sy688Cgf4=;
 b=esaq0YQCJI7NASfm2N97ByyEGI7MQJhz+yUM8E24+kA/uOY+4oH34WWBEztb2nGQBCeo
 ei9E419dbaTbFIAOxLyHFd0aWtOE7Ope2vTrd59+UVxEfBQJBHgggu0Mttyy6mUtuuUS
 0bKo93qL6y5RZ1XzuHjEIPBmZC96Qql/+jvKX+tj6ctDJ3sU7paAhDS8tFLfh+B5+Hdf
 MshFN9+WBTf9nE0gX61BGDiFZ+LYb1w4Ylk+l9jkD0e7kgkG82bK71xQs0UmgpLLE2EL
 m4Iwxb/nKkT+E62bi1/8xqYsvxdVjcfB8f/09RBmm4Cvm7SOV/1OxcaVFsOb/ejHKD95 bA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fmm0a0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 03:01:05 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328314qL018168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 03:01:04 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 7 Mar 2023 19:01:03 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] scsi: ufs: mcq: Use active_reqs to check busy in clock scaling
Date:   Tue, 7 Mar 2023 19:00:09 -0800
Message-ID: <e8d303eff0713a3e5f3c3725cdf6e5c5d3de2b01.1678244386.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HEjOp2cq81wtiGcYwWl7XfVrTCJJYVnS
X-Proofpoint-ORIG-GUID: HEjOp2cq81wtiGcYwWl7XfVrTCJJYVnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi Circular Queue doesn't use outstanding_reqs.
But the ufs clock scaling functions use outstanding_reqs to
determine if there're requests pending. When MCQ is enabled
this check always returns false.

Hence use active_reqs to check if there're pending requests.

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 172d25fef740..c6b35123c83b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1500,7 +1500,7 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	scaling->window_start_t = curr_t;
 	scaling->tot_busy_t = 0;
 
-	if (hba->outstanding_reqs) {
+	if (scaling->active_reqs) {
 		scaling->busy_start_t = curr_t;
 		scaling->is_busy_started = true;
 	} else {
@@ -2118,7 +2118,7 @@ static void ufshcd_clk_scaling_update_busy(struct ufs_hba *hba)
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	hba->clk_scaling.active_reqs--;
-	if (!hba->outstanding_reqs && scaling->is_busy_started) {
+	if (!scaling->active_reqs && scaling->is_busy_started) {
 		scaling->tot_busy_t += ktime_to_us(ktime_sub(ktime_get(),
 					scaling->busy_start_t));
 		scaling->busy_start_t = 0;
-- 
2.7.4

