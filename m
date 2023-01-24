Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79E67A546
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjAXV55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAXV5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:57:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2D4A227;
        Tue, 24 Jan 2023 13:57:53 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OLutBc030745;
        Tue, 24 Jan 2023 21:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ZI+TubnYFE27O4dAS98WKcu4xk24oqGOmPu60iOZQVo=;
 b=ZmJo0NQBm0A45T7CNRyHmqBLUDDvWWElKZz6x0lD+C9FRANlpKfmoqArAbXsuuHYwBTz
 M5ebO1fvvakCjqip/bd68IJrgt4W8vKH78zwIi6j/KodvHhracx+oeCNzGAAFg28s6G+
 b19uKDGOrflc8HU6m9QdQZw5u0alM4XGpPbbwsAQOCVUDhidispEjXT/zQ65q5zT/j9k
 hjOpAp0f+qAMkHltZb8BMg5l3laG3Geh6YHflsxeL3ctHsmCl9+UD/EoJreKmRc5kzKs
 eBedIK2SvCEEH9Nhf3jNXV0kzPVR5GBM5NAjz0cqMlG7b4j3POX+q3vrgda69z3WWHqq bA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89dndxk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 21:57:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30OLvm2r023124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 21:57:48 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 13:57:48 -0800
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 2/2] bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state
Date:   Tue, 24 Jan 2023 14:57:24 -0700
Message-ID: <1674597444-24543-3-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1674597444-24543-1-git-send-email-quic_jhugo@quicinc.com>
References: <1674597444-24543-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lYmHPk-OgYu57HKWG_tjxGALMAbT1lu9
X-Proofpoint-ORIG-GUID: lYmHPk-OgYu57HKWG_tjxGALMAbT1lu9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_16,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=871 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If firmware loading fails, the controller's pm_state is updated to
MHI_PM_FW_DL_ERR unconditionally.  This can corrupt the pm_state as the
update is not done under the proper lock, and also does not validate
the state transition.  The firmware loading can fail due to a detected
syserr, but if MHI_PM_FW_DL_ERR is unconditionally set as the pm_state,
the handling of the syserr can break when it attempts to transition from
syserr detect, to syserr process.

By grabbing the lock, we ensure we don't race with some other pm_state
update.  By using mhi_try_set_pm_state(), we check that the transition
to MHI_PM_FW_DL_ERR is valid via the state machine logic.  If it is not
valid, then some other transition is occurring like syserr processing, and
we assume that will resolve the firmware loading error.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
---
 drivers/bus/mhi/host/boot.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 1c69fee..d2a19b07 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -391,6 +391,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 {
 	const struct firmware *firmware = NULL;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
 	const char *fw_name;
 	void *buf;
 	dma_addr_t dma_addr;
@@ -508,14 +509,18 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	}
 
 error_fw_load:
-	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-	wake_up_all(&mhi_cntrl->state_event);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (new_state == MHI_PM_FW_DL_ERR)
+		wake_up_all(&mhi_cntrl->state_event);
 }
 
 int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
 {
 	struct image_info *image_info = mhi_cntrl->fbc_image;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
 	int ret;
 
 	if (!image_info)
@@ -526,8 +531,11 @@ int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
 			       &image_info->mhi_buf[image_info->entries - 1]);
 	if (ret) {
 		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
-		mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-		wake_up_all(&mhi_cntrl->state_event);
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (new_state == MHI_PM_FW_DL_ERR)
+			wake_up_all(&mhi_cntrl->state_event);
 	}
 
 	return ret;
-- 
2.7.4

