Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825EE5B5C30
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiILO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiILO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:29:14 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0CD2E6BD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:29:12 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CEHhIl018755;
        Mon, 12 Sep 2022 14:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=5CSDurX/LkWrYdIrBK47ccXSKpG8h1aPp875pxBRZIg=;
 b=qRwFAGP0HyXPtZUsjEHZu6OhCOHvnjuaiHnk7tOc20qOK+ZVXOBF+CA/C48J2tAvquz7
 cyJVzwyEe4xmdTJI6H5gJE1O3kQ1U31kw8TYHKA5K8/r+iY8qWZglYPhUM5+wmFfJM/j
 jfq16lP0bnMhoLRb8VrCqqKYjQ/G0u4wga0lQhEPZ9TGTgZq2KJtEO/yocXNB5SgcaQN
 rIO/2dGoMeoHi5GXdiZqgf1UVRlji0V4oy7liN7z+pnvcC0idV68zCY1h7kmzWNuIFuc
 rvaKB4iIgodcoAL/FpKP/QbwGAQMFGBIgtRUIFebrYgdGQkkI1kmmMsNSD63FBSDvKxs 7g== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3jgft1t6fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Sep 2022 14:28:36 +0000
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 12 Sep 2022 07:28:35 -0700
Received: from pek-ywang12-d1.wrs.com (128.224.32.146) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 12 Sep 2022 07:28:33 -0700
From:   <yaliang.wang@windriver.com>
To:     <tudor.ambarus@microchip.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace gd25q256_default_init with gd25q256_post_bfpt
Date:   Mon, 12 Sep 2022 22:28:33 +0800
Message-ID: <20220912142833.1739547-1-yaliang.wang@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4NbF6lPPmABtnl3Pd5XiJ77569d5hyeN
X-Proofpoint-ORIG-GUID: 4NbF6lPPmABtnl3Pd5XiJ77569d5hyeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_10,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxlogscore=970 clxscore=1011 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120048
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaliang Wang <Yaliang.Wang@windriver.com>

When utilizing PARSE_SFDP to initialize the flash parameter, the
deprecated initializing method spi_nor_init_params_deprecated() and the
function spi_nor_manufacturer_init_params() within it will never be
executed, which results in the default_init hook function will also never
be executed. As we do have quad enable function defined in BFPT, the
post_bfpt hook will be the right place to tweak the function.

Cc: stable@vger.kernel.org
Fixes: 047275f7de18 ("mtd: spi-nor: gigadevice: gd25q256: Init flash based on SFDP")
Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 119b38e6fc2a..d9b2e36971ea 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -8,19 +8,22 @@
 
 #include "core.h"
 
-static void gd25q256_default_init(struct spi_nor *nor)
+static int
+gd25q256_post_bfpt(struct spi_nor *nor,
+			    const struct sfdp_parameter_header *bfpt_header,
+			    const struct sfdp_bfpt *bfpt)
 {
 	/*
 	 * Some manufacturer like GigaDevice may use different
 	 * bit to set QE on different memories, so the MFR can't
 	 * indicate the quad_enable method for this case, we need
-	 * to set it in the default_init fixup hook.
+	 * to set it in the post_bfpt fixup hook.
 	 */
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
 static const struct spi_nor_fixups gd25q256_fixups = {
-	.default_init = gd25q256_default_init,
+	.post_bfpt = gd25q256_post_bfpt,
 };
 
 static const struct flash_info gigadevice_nor_parts[] = {
-- 
2.34.1

