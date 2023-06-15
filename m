Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C10A731408
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245680AbjFOJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245580AbjFOJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:33:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED4026B0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:33:56 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F8P3NM006680;
        Thu, 15 Jun 2023 09:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=GLpzsJcKyUDHvjSzNRle4HJAV06lwhJVDoZ6sTtkRXg=;
 b=IJJZ5Js6gb8pBffwf2yDAdKS6HkB+bH81/2rpzBFjN5OQizYmSV/TvV6MKCB+cGW073h
 1oF5+GNI4MSvS/Yee1viFPv5dSLg8e4IN5QPt4tL9k5uPzqz3INK9TV+UjP/IwdWQ+MZ
 txBTn92G6DC5uv5K7NPGs+7fbMQoNR5q3WBKu4jb3yTVptgCtXbiIJUQJPEidRZop2UE
 SjEbwCgkq7C8uGHEkPscYqI2sAKGy6IHeGpV3GtVxqFU/HhEXTNQIq5ET1doTsSl2lnF
 484Q07l/738cV/ISDgHohkmFaP6/NAUeP4Hzey1CCBLVZTwTQ6j8AOkGxU2J+PA1KLd7 EQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7faea0xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:33:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35F9XdXg009521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:33:39 GMT
Received: from hu-ajainp-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 15 Jun 2023 02:33:36 -0700
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Anvesh Jain P <quic_ajainp@quicinc.com>,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        Vagdhan Kumar <quic_vagdhank@quicinc.com>
Subject: [PATCH] iommu: export iommu_set_default_translated function
Date:   Thu, 15 Jun 2023 15:03:08 +0530
Message-ID: <20230615093308.24989-1-quic_ajainp@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QbhkyLbaLgfmV02yj--GH6bd89dyqRAe
X-Proofpoint-GUID: QbhkyLbaLgfmV02yj--GH6bd89dyqRAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=903
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

export iommu_set_default_translated function to be used by other modules.

Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b..1b4a5db58d66 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2730,6 +2730,7 @@ void iommu_set_default_translated(bool cmd_line)
 		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
 	iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 }
+EXPORT_SYMBOL_GPL(iommu_set_default_translated);
 
 bool iommu_default_passthrough(void)
 {

base-commit: b6dad5178ceaf23f369c3711062ce1f2afc33644
-- 
2.17.1

