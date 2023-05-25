Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0189710A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbjEYLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbjEYLF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:05:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C0F132
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:05:52 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PAEwP6030373;
        Thu, 25 May 2023 11:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=EiUyoewa5hZFq14dAG4x+ZjQ/Ju95hT9AR0Yxo1ACGU=;
 b=kxA72LFU0TpyoBTskvj+g/R8nWiWh1Rl5sNHp3XB/LE6+xNmTHlHtNSRPK6E7URAm4/x
 XUhXuetMonDut0HdUz0Ib+WkjY4e1Fd7sfjE464WMx9MjhsaXtfs1bwuLfFCaAfiPpcf
 D74WOVcNCCBQQ8v2H7Rxv5otHBEMTJ421VMpCfDJ9NdIDczaRnieyMqhx9nMQcsETPgg
 YcBphmUjTKEH1xKa0/2O+ZL9VyJUQHThNi+dtNsZflrtl0x48R6ftxbnVST1itceCg8W
 8cBkR3HX7RiPYerQYQtY9/7191BEg250iD316V+cv6VnRfMTC4mGbncdxThnFGG3ldHV 8Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsqqj9s9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:05:34 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34PB5U5v020340;
        Thu, 25 May 2023 11:05:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qpq9m8hjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 25 May 2023 11:05:30 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PB5USR020334;
        Thu, 25 May 2023 11:05:30 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34PB5TwA020332;
        Thu, 25 May 2023 11:05:30 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 1326112010CA; Thu, 25 May 2023 16:35:29 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH] mtd: spinand: gigadevice: add support for GD5F2GQ5xExxH
Date:   Thu, 25 May 2023 16:35:26 +0530
Message-Id: <20230525110526.21998-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MmcUh4iC3BSe1ro-XDVqmk7DSVZ9U2xG
X-Proofpoint-ORIG-GUID: MmcUh4iC3BSe1ro-XDVqmk7DSVZ9U2xG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=860 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250091
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2Gb SLC NAND flash with 4b/512b on-die ECC capability.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 6b043e24855f..cfd7c3b26dc4 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -501,6 +501,16 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5xExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x22),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
-- 
2.17.1

