Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565A06067E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJTSHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJTSGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:06:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459512A359;
        Thu, 20 Oct 2022 11:06:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KBFK0s018062;
        Thu, 20 Oct 2022 18:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fCskb5uWMStgb4Iq7AzKu6RrfrqtasutOCyu35tcGWw=;
 b=XOeebDtoH0L9Mo1Dyi07wwIetmdZY83LCRM0AxMwGmZ7FQvD4TR2urVQkR2u3s54j/3Y
 JFDp6hxMimXp8P3OgbHxXzat8Dke8ubG1Xg394kIcNAXddTPBUkN0nqmoTd9A7ujjYDA
 tnKN71ntytqCzRaikEXpOFEpbbSSBT0mwrfeLZ0ejz5NBKtKMVA1pKecZ6U2LNovfa+V
 rI6i1TbfJl1RRdTJoQk2L6ykPM4kDQxsWV4oP2rZ0R+5+v853O7Ej6Pz21nfSviM/6sS
 cyJZookueik3EwQhKd5Z0ilW0EeODESi9PPVMJpA9xWfehKYSn4tNZFDmFdp7PZRg2cq EA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kawde2c8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:06:23 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29KI6NpG023069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:06:23 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 11:06:22 -0700
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
Subject: [PATCH v3 10/17] ufs: core: mcq: Use shared tags for MCQ mode
Date:   Thu, 20 Oct 2022 11:03:39 -0700
Message-ID: <2fea9d4f0b8dfc2e2c82d176f0c928b0525d8110.1666288432.git.quic_asutoshd@quicinc.com>
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
X-Proofpoint-GUID: IseQCigRACMqosva5_WnKgd6Z1Cm4hMv
X-Proofpoint-ORIG-GUID: IseQCigRACMqosva5_WnKgd6Z1Cm4hMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_09,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable shared taggs for MCQ. For UFS, this should
not have a huge performance impact. It however
simplifies the MCQ implementation and reuses most of
the existing code in the issue and completion path.
Also add multiple queue mapping to map_queue().

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c |  2 ++
 drivers/ufs/core/ufshcd.c  | 31 +++++++++++++++++--------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 213e398..10a50eb 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -367,6 +367,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 {
 	int ret, i;
 	struct ufs_hw_queue *hwq;
+	struct Scsi_Host *host = hba->host;
 
 	ret = ufshcd_mcq_config_nr_queues(hba);
 	if (ret)
@@ -400,6 +401,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	/* Give dev_cmd_queue the minimal number of entries */
 	hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
 
+	host->host_tagset = 1;
 	return 0;
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b254dc5..87201dd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2728,25 +2728,28 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
  */
 static int ufshcd_map_queues(struct Scsi_Host *shost)
 {
-	int i, ret;
+	int i, queue_offset = 0;
+	struct ufs_hba *hba = shost_priv(shost);
+
+	if (!is_mcq_supported(hba)) {
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = 1;
+		hba->nr_queues[HCTX_TYPE_READ] = 0;
+		hba->nr_queues[HCTX_TYPE_POLL] = 1;
+		hba->nr_hw_queues = 1;
+	}
 
 	for (i = 0; i < shost->nr_maps; i++) {
 		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
 
-		switch (i) {
-		case HCTX_TYPE_DEFAULT:
-		case HCTX_TYPE_POLL:
-			map->nr_queues = 1;
-			break;
-		case HCTX_TYPE_READ:
-			map->nr_queues = 0;
+		map->nr_queues = hba->nr_queues[i];
+		if (!map->nr_queues)
 			continue;
-		default:
-			WARN_ON_ONCE(true);
-		}
-		map->queue_offset = 0;
-		ret = blk_mq_map_queues(map);
-		WARN_ON_ONCE(ret);
+		map->queue_offset = queue_offset;
+		if (i == HCTX_TYPE_POLL && !is_mcq_supported(hba))
+			map->queue_offset = 0;
+
+		blk_mq_map_queues(map);
+		queue_offset += map->nr_queues;
 	}
 
 	return 0;
-- 
2.7.4

