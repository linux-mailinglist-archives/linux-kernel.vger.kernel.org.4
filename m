Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247076C2F15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCUKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCUKeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:34:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6F30B28;
        Tue, 21 Mar 2023 03:33:49 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L7cKno029817;
        Tue, 21 Mar 2023 10:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9YNn0GvTOWUriUJfRXqCWTiMNG5e3zQlxzQtEIl/lzc=;
 b=VADFsHCIGZIzTIHFBSC1bjAHduy9xgKmJraiwlLWhbuYIRm3znw0NYiQ92lG9Yw9exkX
 9b/I9GJKGODud2OeCKsAMEkySLuvwc3M3PIFbDGkWVV3HXq4VISlk3pIy/ryP/zk+iZO
 bCeDPyjHlMrMq9XYMerA19d+Q9LuWNz/x4XI53ruKvSiCR7lVqOcGJHpx813dE8f1bzY
 oqvxaYOlVEHpN1eKunL/JPFNHWDCz5N+0FfZgKjeGc+vQ/FdDkr21kpNZqSvFzFlNutX
 7zeWuyTFlwBCwqnKkLt00jAAR83umdo+CA48n/0wduOuDk0qcIotCcj2hCRdZ82zeffs dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3peg57v1gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 10:33:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32LAXBG4006394
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 10:33:11 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Mar 2023 03:33:07 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <bkumar@qti.qualcomm.com>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
Subject: [PATCH v1] misc: fastrpc: Pass proper scm arguments for secure map request
Date:   Tue, 21 Mar 2023 16:02:59 +0530
Message-ID: <1679394779-2658-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qcc0-ZtQNdKBqq2-NFwM6kaEJ22Nef38
X-Proofpoint-GUID: qcc0-ZtQNdKBqq2-NFwM6kaEJ22Nef38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_07,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a map request is made with securemap attribute, the memory
ownership needs to be reassigned to new VMID to allow access
from protection domain. Currently only DSP VMID is passed to
the reassign call which is incorrect as only a combination of
HLOS and DSP VMID is allowed for memory ownership reassignment
and passing only DSP VMID will cause assign call failure.

Also pass proper restoring permissions to HLOS as the source
permission will now carry both HLOS and DSP VMID permission.

Change is also made to get valid physical address from
scatter/gather for this allocation request.

Fixes: e90d91190619 ("misc: fastrpc: Add support to secure memory map")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a701132..77a5930 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -316,12 +316,14 @@ static void fastrpc_free_map(struct kref *ref)
 	if (map->table) {
 		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
 			struct qcom_scm_vmperm perm;
+			int vmid = map->fl->cctx->vmperms[0].vmid;
+			unsigned int src_perms = BIT(QCOM_SCM_VMID_HLOS) | BIT(vmid);
 			int err = 0;
 
 			perm.vmid = QCOM_SCM_VMID_HLOS;
 			perm.perm = QCOM_SCM_PERM_RWX;
 			err = qcom_scm_assign_mem(map->phys, map->size,
-				&map->fl->cctx->perms, &perm, 1);
+				&src_perms, &perm, 1);
 			if (err) {
 				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 						map->phys, map->size, err);
@@ -787,8 +789,12 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		goto map_err;
 	}
 
-	map->phys = sg_dma_address(map->table->sgl);
-	map->phys += ((u64)fl->sctx->sid << 32);
+	if (attr & FASTRPC_ATTR_SECUREMAP) {
+		map->phys = sg_phys(map->table->sgl);
+	} else {
+		map->phys = sg_dma_address(map->table->sgl);
+		map->phys += ((u64)fl->sctx->sid << 32);
+	}
 	map->size = len;
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -798,9 +804,15 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		 * If subsystem VMIDs are defined in DTSI, then do
 		 * hyp_assign from HLOS to those VM(s)
 		 */
+		unsigned int src_perms = BIT(QCOM_SCM_VMID_HLOS);
+		struct qcom_scm_vmperm dst_perms[2] = {0};
+
+		dst_perms[0].vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms[0].perm = QCOM_SCM_PERM_RW;
+		dst_perms[1].vmid = fl->cctx->vmperms[0].vmid;
+		dst_perms[1].perm = QCOM_SCM_PERM_RWX;
 		map->attr = attr;
-		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &fl->cctx->perms,
-				fl->cctx->vmperms, fl->cctx->vmcount);
+		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
 		if (err) {
 			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
 					map->phys, map->size, err);
-- 
2.7.4

