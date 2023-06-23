Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376B273AFA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjFWE7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjFWE7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:59:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F01BCA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:59:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N4fCEo013342;
        Fri, 23 Jun 2023 04:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/JxhzUPDuAy9we7oDTakzdyrNayH9Q7H8mJUGrAzzn4=;
 b=pLTU/Xk4fpKPwmvoU4xttocCE6OaPD9LoEA5enxYOPuG2jbNMyA/4QIsdM63hQSKRx5M
 TYlxB1A5AJ9avqoH5jkOFcPLRS6nqwzbfVcMP+oZrZEVArXlTaEOfUIO+jLgBpOtlIr5
 CC1TfndcLaPKQ+wUKMELdAdR+3c3He0jrQtDyJyeX2mxuj0tBXBY+7ysZjahXzE6JCfU
 e0RAGK3Sv6/UCJCR++Zq4YhgFMFeCn1OTPZi4g8ZoSugIA1pG1IF8Ccfo88z+txXeN//
 lNpP2FRNP6yB2Ex0PrgkPZKWmwafsnsT/UCUmKADYj0X0q9z7F/3A6UgsVGP8KfsZ0r6 oA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc6b2bva1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 04:59:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35N4x6n7009975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 04:59:06 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 22 Jun 2023 21:59:02 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <quic_sridsn@quicinc.com>, <ddrokosov@sberdevices.ru>,
        <gch981213@gmail.com>, <mmkurbanov@sberdevices.ru>,
        <quic_mdalam@quicinc.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] mtd: spinand: add support for ESMT F50D2G41KA
Date:   Fri, 23 Jun 2023 10:27:56 +0530
Message-ID: <20230623045757.30055-3-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230623045757.30055-1-quic_sridsn@quicinc.com>
References: <20230623045757.30055-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QaMt0-4-9cyBXZNcRdo7f4_0xgQSgSzs
X-Proofpoint-GUID: QaMt0-4-9cyBXZNcRdo7f4_0xgQSgSzs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=851 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for ESMT F50D2G41KA. This is 2Gb SLC NAND flash
with 8b/512b on-die ECC capability.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/spi/esmt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 1a3ffb982335..31c439a557b1 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -121,6 +121,15 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+	SPINAND_INFO("F50D2G41KA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 };
 
 static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
-- 
2.17.1

