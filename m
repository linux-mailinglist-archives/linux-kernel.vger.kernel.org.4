Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3862B667EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbjALTL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbjALTL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:11:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB616415;
        Thu, 12 Jan 2023 10:57:25 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CGqbXK027771;
        Thu, 12 Jan 2023 18:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=cQm2U1q502g6Yr9fnWRt8DD8p5GyX9bIcxc64fn4N6s=;
 b=mNmCdYTXsxttRUW3MDr+0v2ygnVFGR6xE5BSahc4+llbtD9SzQcuVMbIRVHTIeSbPQ3V
 +Q6iDYeb//hU4xTHlT5m28XlckcjdbchA1v0eyJqtaTd4lNsom2fOwhWGSZ9U+c6IreE
 g3ETmuugSn1igfV9nqGGH+YQqkHxIyzFcJEJkEJst+wzO1vOfJiZy3O0iUiuGn/U7BxZ
 fbyinxRaBS+u1jeYy7PNGiuxLwWQPK0yTbikurMt8vzZvP9xLBYrGXfd8x3GoXKDRchB
 xuQ+lTPmiPtyFBroHzue3t1wujojB+6sT96LEOsnfIAulbrBdG+elPLcHtBvMTrTb35V wQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2d751m5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 18:23:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CINTeA018400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 18:23:29 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 10:23:25 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: fastrpc: Pass bitfield into qcom_scm_assign_mem
Date:   Thu, 12 Jan 2023 10:23:12 -0800
Message-ID: <20230112182313.521467-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H4XarJlSs1ZSe7NjxnCEIKB3jt0lwIFA
X-Proofpoint-GUID: H4XarJlSs1ZSe7NjxnCEIKB3jt0lwIFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The srcvm parameter of qcom_scm_assign_mem is a pointer to a bitfield of
VMIDs. The  bitfield is updated with which VMIDs have permissions
after the qcom_scm_assign_mem call. This makes it simpler for clients to
make qcom_scm_assign_mem calls later, they always pass in same srcvm
bitfield and do not need to closely track whether memory was originally
shared. 

When restoring permissions to HLOS, fastrpc is incorrectly using the
first VMID directly -- neither the BIT nor the other possible VMIDs the
memory was already assigned to.  We already have a field intended for
this purpose: "perms" in the struct fastrpc_channel_ctx, but it was
never used. Start using the perms field.
 
Cc: Abel Vesa <abel.vesa@linaro.org>
Cc: Vamsi Krishna Gattupalli <quic_vgattupa@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: e90d91190619 ("misc: fastrpc: Add support to secure memory map")
Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

 drivers/misc/fastrpc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c9902a1dcf5d..0f1329f35d89 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -321,7 +321,7 @@ static void fastrpc_free_map(struct kref *ref)
 			perm.vmid = QCOM_SCM_VMID_HLOS;
 			perm.perm = QCOM_SCM_PERM_RWX;
 			err = qcom_scm_assign_mem(map->phys, map->size,
-				&(map->fl->cctx->vmperms[0].vmid), &perm, 1);
+				&map->fl->cctx->perms, &perm, 1);
 			if (err) {
 				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 						map->phys, map->size, err);
@@ -788,10 +788,8 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		 * If subsystem VMIDs are defined in DTSI, then do
 		 * hyp_assign from HLOS to those VM(s)
 		 */
-		unsigned int perms = BIT(QCOM_SCM_VMID_HLOS);
-
 		map->attr = attr;
-		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &perms,
+		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &fl->cctx->perms,
 				fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
 			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
@@ -1258,10 +1256,9 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
-			unsigned int perms = BIT(QCOM_SCM_VMID_HLOS);
-
 			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
-							(u64)fl->cctx->remote_heap->size, &perms,
+							(u64)fl->cctx->remote_heap->size,
+							&fl->cctx->perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
 				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
@@ -1309,7 +1306,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		perm.perm = QCOM_SCM_PERM_RWX;
 		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 						(u64)fl->cctx->remote_heap->size,
-						&(fl->cctx->vmperms[0].vmid), &perm, 1);
+						&fl->cctx->perms, &perm, 1);
 		if (err)
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
@@ -1899,7 +1896,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		perm.vmid = QCOM_SCM_VMID_HLOS;
 		perm.perm = QCOM_SCM_PERM_RWX;
 		err = qcom_scm_assign_mem(buf->phys, buf->size,
-			&(fl->cctx->vmperms[0].vmid), &perm, 1);
+			&fl->cctx->perms, &perm, 1);
 		if (err) {
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 					buf->phys, buf->size, err);

base-commit: ffe9e52965a6396bb935fee5ea80567e0cd2d68a
-- 
2.39.0

