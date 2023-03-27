Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1426C9EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjC0IyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjC0Ixu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:53:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137848683;
        Mon, 27 Mar 2023 01:49:16 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R0BBsr019100;
        Mon, 27 Mar 2023 08:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=hoSvzJOMWCvrDX95XzxhFDO4bi33I9EybMhwH2GNeJk=;
 b=I4yCOx94B3RwPknIfsfRuHl6Sx9h6UdGkxdsiw74EU76mbi1efDwhGoo4pwue8A9X/qT
 5qautsxmLRPpM5tx8PYaf03uzwTtcQ1Fd9UlZo6aRjiwsKWakExe7skf2dfQLOdnyU5b
 BvKCIB5LgskvYWXK5PQImjy7OJfVgsBZDbbAkCndyKx5yC1KWm26w6X8XAENnAdLOKGn
 PBZIhQn3pWMpHcUXBjv9XShIlWdAp/XZmCixKgBfIVbkl9BDiVAy6uSgFjkV9+WEOD0u
 VKClW5Nixa3bz5ej2cti6wqiMlE/pVRINQPhCNzwYv3vEfsRhZ2tmvIglDftPhpW7Kn1 zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsrauvtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 08:49:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R8mvJn030192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 08:48:57 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 01:48:53 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <bkumar@qti.qualcomm.com>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
Subject: [PATCH v2] misc: fastrpc: Pass proper scm arguments for secure map request
Date:   Mon, 27 Mar 2023 14:18:49 +0530
Message-ID: <1679906929-25711-1-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cG2DUzeN9Ipf1rgHEBxGZDOrTeKeCcCy
X-Proofpoint-ORIG-GUID: cG2DUzeN9Ipf1rgHEBxGZDOrTeKeCcCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270072
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes in v2:
 - Use u64 to represent bitmap instead of architecture-dependent
   "unsigned int"

 drivers/misc/fastrpc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a701132..998eb7c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -316,12 +316,14 @@ static void fastrpc_free_map(struct kref *ref)
 	if (map->table) {
 		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
 			struct qcom_scm_vmperm perm;
+			int vmid = map->fl->cctx->vmperms[0].vmid;
+			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS) | BIT(vmid);
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
+		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
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

