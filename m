Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD470724E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjEQTgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjEQTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:36:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719391BF3;
        Wed, 17 May 2023 12:36:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HCVI0v008240;
        Wed, 17 May 2023 19:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=BR6pFapQ1GlQlU8zgCmhladtyz18dE5cn7Hkqf1mgI0=;
 b=eJFAV5EV8tdiCQ79aAANtvP594adyJ7q3KcDKKaU6IvFY6IW9rVkYY4F43U7aOzMBrq8
 y0+zLqz/m08ROwJHnPJ0rfQ964YqE2v19uoM0E1ZTd/5J9iSaemKWMfiTFAHjSNZUnZd
 J4KRV08BS4O7MOAgd2q3zn8FSdpXQK1BV9dldEcv3UI4E5WmV+0JcLhE9gaLbCF0RNrw
 hcOAud+lspJIo/ZKDMk6+oM5PFqlVfyXf4TqB1UYxQ64kUVfvYE/8po0/IiSynlJRRMD
 c/71BOXlmBH00PqcLG0fAVxcEx3+WdyKJpNkMUCw3+GLpsh4KCRVNYx9PVeJENaqcuKi RA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmt5gsqf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 19:36:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HJaB1K001822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 19:36:11 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 12:36:10 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <ogabbay@kernel.org>, <jacek.lawrynowicz@linux.intel.com>,
        <quic_pkanojiy@quicinc.com>, <stanislaw.gruszka@linux.intel.com>,
        <quic_carlv@quicinc.com>, <quic_ajitpals@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 4/5] accel/qaic: Grab ch_lock during QAIC_ATTACH_SLICE_BO
Date:   Wed, 17 May 2023 13:35:39 -0600
Message-ID: <20230517193540.14323-5-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517193540.14323-1-quic_jhugo@quicinc.com>
References: <20230517193540.14323-1-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7YpgJIkR8BHJJ7rnUMu_P_mVlLpjGBS8
X-Proofpoint-ORIG-GUID: 7YpgJIkR8BHJJ7rnUMu_P_mVlLpjGBS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>

During QAIC_ATTACH_SLICE_BO, we associate a BO to its DBC. We need to
grab the dbc->ch_lock to make sure that DBC does not goes away while
QAIC_ATTACH_SLICE_BO is still running.

Fixes: ff13be830333 ("accel/qaic: Add datapath")
Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/accel/qaic/qaic_data.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 8603e99a2a61..8ab26e64b231 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -924,8 +924,8 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 {
 	struct qaic_attach_slice_entry *slice_ent;
 	struct qaic_attach_slice *args = data;
+	int rcu_id, usr_rcu_id, qdev_rcu_id;
 	struct dma_bridge_chan	*dbc;
-	int usr_rcu_id, qdev_rcu_id;
 	struct drm_gem_object *obj;
 	struct qaic_device *qdev;
 	unsigned long arg_size;
@@ -969,12 +969,6 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 		goto unlock_dev_srcu;
 	}
 
-	dbc = &qdev->dbc[args->hdr.dbc_id];
-	if (dbc->usr != usr) {
-		ret = -EINVAL;
-		goto unlock_dev_srcu;
-	}
-
 	user_data = u64_to_user_ptr(args->data);
 
 	slice_ent = kzalloc(arg_size, GFP_KERNEL);
@@ -1006,9 +1000,16 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 		goto put_bo;
 	}
 
+	dbc = &qdev->dbc[args->hdr.dbc_id];
+	rcu_id = srcu_read_lock(&dbc->ch_lock);
+	if (dbc->usr != usr) {
+		ret = -EINVAL;
+		goto unlock_ch_srcu;
+	}
+
 	ret = qaic_prepare_bo(qdev, bo, &args->hdr);
 	if (ret)
-		goto put_bo;
+		goto unlock_ch_srcu;
 
 	ret = qaic_attach_slicing_bo(qdev, bo, &args->hdr, slice_ent);
 	if (ret)
@@ -1018,6 +1019,7 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 		dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, args->hdr.dir);
 
 	bo->dbc = dbc;
+	srcu_read_unlock(&dbc->ch_lock, rcu_id);
 	drm_gem_object_put(obj);
 	srcu_read_unlock(&qdev->dev_lock, qdev_rcu_id);
 	srcu_read_unlock(&usr->qddev_lock, usr_rcu_id);
@@ -1026,6 +1028,8 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 
 unprepare_bo:
 	qaic_unprepare_bo(qdev, bo);
+unlock_ch_srcu:
+	srcu_read_unlock(&dbc->ch_lock, rcu_id);
 put_bo:
 	drm_gem_object_put(obj);
 free_slice_ent:
-- 
2.40.1

