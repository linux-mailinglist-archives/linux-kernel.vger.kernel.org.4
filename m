Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39C76E2AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDNT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDNT6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:58:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F72C5FEE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:58:06 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EJdXuc021989;
        Fri, 14 Apr 2023 19:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Vrcfvt9x8T5MFxz8wXlheMih/OgiUoUTTitEpMWhXKY=;
 b=biWphi4/JTjtILopmOLuqkwCIG6H1f2K/OJ5rO5KGpCKlB544xenh3LTBNObCHqlEO7h
 YhuIijSmU3KrIL+I2nMy84x01ZZfhCmJEbN+37J5ioox/gGttyeDcQGAoU+OTvb2Thet
 xmKwL+cyFENHejXL+vFxq9GsV8k6z7wE+oQC32NLSPpbxlHYcLH6IEM5Pu9ObxNPWnOH
 TdT4V2g4Mlwwb8kAGSiW4sbsLZEsv6vPRdCv3mDitGzJWN3MnMVGwxB4MzRVtc7kuDsh
 XcbNx4gV0/EA0CT6OrCT03AEzgUMAoGOuXhESiWT7ny4ZZNsVUzYmYF5hS9+aVhZj08G qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py1wphkwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 19:57:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EJvrxT018035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 19:57:53 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 14 Apr 2023 12:57:52 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <mhi@lists.linux.dev>, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 2/2] accel/qaic: Add MHI_QUIRK_SOC_HW_VERSION_UNRELIABLE
Date:   Fri, 14 Apr 2023 13:57:19 -0600
Message-ID: <1681502239-3781-3-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1681502239-3781-1-git-send-email-quic_jhugo@quicinc.com>
References: <1681502239-3781-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DWiybZF9ExOTxQE6FjklzwxBfywXBoXB
X-Proofpoint-ORIG-GUID: DWiybZF9ExOTxQE6FjklzwxBfywXBoXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_12,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AIC100 does not initialize the SOC_HW_VERSION MHI register as expected.
Some instances of AIC100 are observed to have 0xFFFFFFFF in this register
which makes the controller think that the link is down and return an error
up to MHI. This results in a failed initialization.

Allow these cards to initialize by advertisting
MHI_QUIRK_SOC_HW_VERSION_UNRELIABLE in the MHI controller.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
---
 drivers/accel/qaic/mhi_controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 5036e58..2c85063 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -400,6 +400,7 @@ static struct mhi_controller_config aic100_config = {
 	.event_cfg = aic100_events,
 	.use_bounce_buf = false,
 	.m2_no_db = false,
+	.quirks = MHI_QUIRK_SOC_HW_VERSION_UNRELIABLE,
 };
 
 static int mhi_read_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr, u32 *out)
-- 
2.7.4

