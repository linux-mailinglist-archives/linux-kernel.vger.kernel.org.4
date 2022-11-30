Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36A763E20D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiK3Uaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiK3Uaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:30:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C135AE08;
        Wed, 30 Nov 2022 12:30:44 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUCLJBU020458;
        Wed, 30 Nov 2022 20:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ayT/B9TTsuGZyGZdPUqnbVMQKOPEfENgzDqXeHo/pjg=;
 b=mxKRvecoJSoxGoCSKVFPZLwdFlxWemcllmAAt374eiASfwrrRUQG7pTIsHsR02keucuK
 DluWqf90TMfCgLEofb7m8NgBD/CZ8UEm0kk6v5lDwiDYK92gt1YrWms2wLfkHEi2gbtL
 1T60Z1LArC41j2/W7vYsWNHxqwKpqHouPVge06OOosQ3wHkUcXN0gYJ3KiuXv5HEZNaq
 fniNOZOkajdffc922diOKdppasjhjrDyMATFJgsZlPFRCK7KZbKjH1pdnhtzKdBiwQX3
 sB7Ci2jpqyZf2aPthGCQIDazPcB1DBUCVGfk0ylbX45KXxJEl2JP6LtB8v84zIwGFCiE LQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5n1rw20x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:29:55 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AUKTsch003127
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:29:54 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 12:29:53 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 10/16] ufs: core: mcq: Use shared tags for MCQ mode
Date:   Wed, 30 Nov 2022 12:27:51 -0800
Message-ID: <47a0b862c6920b0c94299c33e298da4669b25163.1669839847.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669839847.git.quic_asutoshd@quicinc.com>
References: <cover.1669839847.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Px98wh-rlh316ZI0j0DVR-vFLxQ-CIUS
X-Proofpoint-ORIG-GUID: Px98wh-rlh316ZI0j0DVR-vFLxQ-CIUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable shared tags for MCQ. For UFS, this should
not have a huge performance impact. It however
simplifies the MCQ implementation and reuses most of
the existing code in the issue and completion path.
Also add multiple queue mapping to map_queue().

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c |  2 ++
 drivers/ufs/core/ufshcd.c  | 28 ++++++++++++++++------------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index a783dcd..cffec4c 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -280,6 +280,7 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 
 int ufshcd_mcq_init(struct ufs_hba *hba)
 {
+	struct Scsi_Host *host = hba->host;
 	struct ufs_hw_queue *hwq;
 	int ret, i;
 
@@ -315,6 +316,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	/* Give dev_cmd_queue the minimal number of entries */
 	hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
 
+	host->host_tagset = 1;
 	return 0;
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3210f6e..965e844 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2763,24 +2763,28 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
  */
 static void ufshcd_map_queues(struct Scsi_Host *shost)
 {
-	int i;
+	struct ufs_hba *hba = shost_priv(shost);
+	int i, queue_offset = 0;
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
+		map->queue_offset = queue_offset;
+		if (i == HCTX_TYPE_POLL && !is_mcq_supported(hba))
+			map->queue_offset = 0;
+
 		blk_mq_map_queues(map);
+		queue_offset += map->nr_queues;
 	}
 }
 
-- 
2.7.4

