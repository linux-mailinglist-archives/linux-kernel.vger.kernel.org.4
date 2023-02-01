Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24518685E19
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjBADtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjBADti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:49:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A3A4A234;
        Tue, 31 Jan 2023 19:49:37 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3113kI1t024246;
        Wed, 1 Feb 2023 03:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=JcCIHDfuDcoy82yr9+l+/CQD0svHVsowsivVXmN4LDg=;
 b=Y0ghalFqvbUBrV035XbYnT4Tkdja1dbfUIMRnQ5BTpqxXxJtItSIFIcb1FPsnKxdq6Ys
 nbkSiq/ipVm+joCQUrNef+yRY4Al0Kj7XKt7DBH3j4z2UzDXWuDWCqtFHEAsncj6Yk7X
 LqIe9CqRxAMAZ8eTiHtw79RwxeAUnJomppT7LQV3RQa7FZKwc946LvnMis/Px3k0OYdl
 fqoG97ibH7eORJRfpTZS00udZVmUu0c+Z89RkCaoIoDTXDGg6bzTuWBO7UDii5N/eLrx
 SuBz/Lt58ULlm7poOoxGHyLHwvI9socSyW8ZYpe4jV9cWYie4ZnxNbLvLMCya4wueXGI Rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3netx4jx3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 03:49:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3113nMZf027163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 03:49:22 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 19:49:22 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
CC:     Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mani@kernel.org>
Subject: [PATCH] scsi: ufs: core: Limit DMA alignment check
Date:   Tue, 31 Jan 2023 19:49:17 -0800
Message-ID: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OdkWvvL26pc4wj4pBnlA087zk9PBrDow
X-Proofpoint-GUID: OdkWvvL26pc4wj4pBnlA087zk9PBrDow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010031
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The three DMA memory regions allocated for the host memory space is
documented to require alignment of 128, 1024 and 1024 respectively, but
the returned address is checked for PAGE_SIZE alignment.

In the case these allocations are serviced by e.g. the Arm SMMU, the
size and alignment will be determined by its supported page sizes. In
most cases SZ_4K and a few larger sizes are available.

In the typical configuration this does not cause problems, but in the
event that the system PAGE_SIZE is increased beyond 4k, it's no longer
reasonable to expect that the allocation will be PAGE_SIZE aligned.

Limit the DMA alignment check to the actual alignment requirements
written in the comments in the code, to avoid the UFS core refusing to
initialize with such configuration.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ec732e4bbbf4..d7f3f1ba9d12 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3724,12 +3724,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 
 	/*
 	 * UFSHCI requires UTP command descriptor to be 128 byte aligned.
-	 * make sure hba->ucdl_dma_addr is aligned to PAGE_SIZE
-	 * if hba->ucdl_dma_addr is aligned to PAGE_SIZE, then it will
-	 * be aligned to 128 bytes as well
 	 */
 	if (!hba->ucdl_base_addr ||
-	    WARN_ON(hba->ucdl_dma_addr & (PAGE_SIZE - 1))) {
+	    WARN_ON(hba->ucdl_dma_addr & (128 - 1))) {
 		dev_err(hba->dev,
 			"Command Descriptor Memory allocation failed\n");
 		goto out;
@@ -3745,7 +3742,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 						   &hba->utrdl_dma_addr,
 						   GFP_KERNEL);
 	if (!hba->utrdl_base_addr ||
-	    WARN_ON(hba->utrdl_dma_addr & (PAGE_SIZE - 1))) {
+	    WARN_ON(hba->utrdl_dma_addr & (1024 - 1))) {
 		dev_err(hba->dev,
 			"Transfer Descriptor Memory allocation failed\n");
 		goto out;
@@ -3769,7 +3766,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 						    &hba->utmrdl_dma_addr,
 						    GFP_KERNEL);
 	if (!hba->utmrdl_base_addr ||
-	    WARN_ON(hba->utmrdl_dma_addr & (PAGE_SIZE - 1))) {
+	    WARN_ON(hba->utmrdl_dma_addr & (1024 - 1))) {
 		dev_err(hba->dev,
 		"Task Management Descriptor Memory allocation failed\n");
 		goto out;
-- 
2.25.1

