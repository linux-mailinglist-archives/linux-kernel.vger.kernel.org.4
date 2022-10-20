Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1787E6067EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJTSIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJTSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:08:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1516199F70;
        Thu, 20 Oct 2022 11:07:36 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFBAea011347;
        Thu, 20 Oct 2022 18:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XOf6SZfBrUf2pe90IzBBGSsVWR7AkUG0Ulkw9JmNBqU=;
 b=AzoPDV1CsUvxAswQ7V5leSm89L/iwW2Pk8y3vWOrzQ6T5A/MWteph+5pejEU3pzAJGPU
 7dkOG3svmoA1KOGWAd31fFHMXNssZmXb+eRUBq3ieXTcIukJk9F0WlFerGMVMdeL7Y1H
 yuf38pNIjEuZnz/hqV4qcIn9Q+RytCBlKpGcev/vdkRaF6tpYYplJaQvDg5E9eYfnH55
 l4a98lIK08npgpchyxfl9lwQOmkkHjm/GJpS+KsdBPZSqirXiTzZWCXThYFeNEfLbmrT
 UoqIMRaio211O79EwJ3QiJ8jxqr/NEP3oyBuHKAUHcvbU6xeRxonhTz2xQQES14V3/nZ yQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kavfm2e55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:07:24 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29KI7OHV028576
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
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 16/17] ufs: core: mcq: Enable Multi Circular Queue
Date:   Thu, 20 Oct 2022 11:03:45 -0700
Message-ID: <4c7e03d7d99e305a8e5ae0547fa9648a2a910fe2.1666288432.git.quic_asutoshd@quicinc.com>
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
X-Proofpoint-GUID: KctCmLPHr_O4cfl2nnGGBpr7HiEbNFdD
X-Proofpoint-ORIG-GUID: KctCmLPHr_O4cfl2nnGGBpr7HiEbNFdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_09,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MCQ in the Host Controller.

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index aaade38..b39d35d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8327,6 +8327,12 @@ static void ufshcd_config_mcq(struct ufs_hba *hba)
 
 	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
 	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
+
+	/* Select MCQ mode */
+	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
+		      REG_UFS_MEM_CFG);
+	hba->mcq_enabled = true;
+
 	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
 		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
 		 hba->nr_queues[HCTX_TYPE_READ], hba->nr_queues[HCTX_TYPE_POLL],
-- 
2.7.4

