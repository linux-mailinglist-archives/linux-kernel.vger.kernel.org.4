Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E126067F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJTSIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiJTSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:08:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32791132DF5;
        Thu, 20 Oct 2022 11:07:42 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KHU63x010876;
        Thu, 20 Oct 2022 18:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=aayNG3H1C+iIeSaIKuwV8OaEYw5fWM3xjdAI9tCEGR4=;
 b=maCJNMy9CU74S7XDU9G6AoR+ikZqGKaDGgQ3PXvDssAwF3v9q8hC8hZCXsGPOoboIZy1
 JRldTFMjKEE1Albt8+j/5tC2eirF8BcmFSYwRBotM8vhQ2SsK2mIpnEhqSeQaIynfufh
 E9zzR1eJASf5GSDqDYD1VfIjAhE2Z5UnD50xrIam1/rQAdunQX4/BkzWcGblm9M+tIvj
 6SC/EhyRJrjJ4LJtypGJNK05LCkaPXBxfV8alyXKTYarsrw/A0WlvSyJxGT9EsFj1kbm
 YHWfsjAL1aXCeFxFUdd7RH+DFJhMRRKn7HnypXIrMcyvCXJqNo5NZPkPz1QcaGlme43K gw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kb2c615sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:07:25 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29KI7OYC002678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:07:24 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 11:07:23 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        <quic_richardp@quicinc.com>,
        "Asutosh Das" <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 17/17] ufs: qcom-host: Enable multi circular queue capability
Date:   Thu, 20 Oct 2022 11:03:46 -0700
Message-ID: <4d21c867708a9d37e53293510d81013088d01c39.1666288432.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1666288432.git.quic_asutoshd@quicinc.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FVo9cwELH1MTYTQRm78xxQwb9PTzD4dh
X-Proofpoint-ORIG-GUID: FVo9cwELH1MTYTQRm78xxQwb9PTzD4dh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_09,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MCQ for Qualcomm UFS controllers

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 36c40210..b740299 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -853,6 +853,7 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
 	hba->caps |= UFSHCD_CAP_CRYPTO;
 	hba->caps |= UFSHCD_CAP_AGGR_POWER_COLLAPSE;
 	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
+	hba->caps |= UFSHCD_CAP_MCQ_EN;
 
 	if (host->hw_ver.major >= 0x2) {
 		host->caps = UFS_QCOM_CAP_QUNIPRO |
-- 
2.7.4

