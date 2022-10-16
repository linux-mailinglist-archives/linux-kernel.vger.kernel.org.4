Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF94600216
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJPRUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJPRUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:20:03 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4B42EF33
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:20:01 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 29GHIHZR025460;
        Sun, 16 Oct 2022 10:19:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PPS06212021;
 bh=C8YQKPWQX4S+/WaSnxZ9VpVIWtERex8NFF1ciCGBywU=;
 b=fA4CHHWJStTnuAyNXf8XwJaB/OuVayD9fWv+D3q7H72csVWPvfhWmLXpGHGHR0MeCAXc
 1RLzoGxuS2PF9Kor5J3LsUrl8CuWle0EfhbCJ9AvsECflWySVnOSD45A19YRzqFY0MtD
 kciFfv2GVJi/3V2S5egjKl7njbWCTJ7ApaiIdD0GQPh6t8XB+FQeqdLYTBSanhQEAa5q
 bbxRsLJPNoFuUB4kVXfckP1f7H4wgxgOFVLVLFA1+mPg9bscTrekELjr92ihGf3g7paB
 0AGorGigcV7UirS1KFrgQq1nL0XPyaQxjvyTAW9SjOwZws1TLptT6ERxhazrf7G6k/nX Vw== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3k7r548yvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 16 Oct 2022 10:19:11 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 16 Oct 2022 10:19:10 -0700
Received: from pek-ywang12-d1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sun, 16 Oct 2022 10:19:08 -0700
From:   <yaliang.wang@windriver.com>
To:     <tudor.ambarus@microchip.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <andy.yan@rock-chips.com>,
        <cyrille.pitchen@wedev4u.fr>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace gd25q256_default_init with gd25q256_post_bfpt
Date:   Mon, 17 Oct 2022 01:19:01 +0800
Message-ID: <20221016171901.1483542-2-yaliang.wang@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016171901.1483542-1-yaliang.wang@windriver.com>
References: <1dddc60f-44fd-df65-f491-be8379fe2380@microchip.com>
 <20221016171901.1483542-1-yaliang.wang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8zFNHauVAo8DVMlSMScXmppRDd2G3SgH
X-Proofpoint-ORIG-GUID: 8zFNHauVAo8DVMlSMScXmppRDd2G3SgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_13,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160106
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
be executed.

This is okay for 'D' generation of GD25Q256, because 'D' generation is
implementing the JESD216B standards, it has QER field defined in BFPT,
parsing the SFDP can properly set the quad_enable function. The 'E'
generation also implements the JESD216B standards, and it has the same
status register definitions as 'D' generation, parsing the SFDP to set
the quad_enable function should also work for 'E' generation.

However, the same thing can't apply to 'C' generation. 'C' generation
'GD25Q256C' implements the JESD216 standards, and it doesn't have the
QER field defined in BFPT, since it does have QE bit in status register
1, the quad_enable hook needs to be tweaked to properly set the
quad_enable function, this can be done in post_bfpt fixup hook.

Cc: stable@vger.kernel.org
Fixes: 047275f7de18 ("mtd: spi-nor: gigadevice: gd25q256: Init flash based on SFDP")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>
---
 drivers/mtd/spi-nor/gigadevice.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 119b38e6fc2a..5fc5d2b2d15e 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -8,19 +8,33 @@
 
 #include "core.h"
 
-static void gd25q256_default_init(struct spi_nor *nor)
+static int
+gd25q256_post_bfpt(struct spi_nor *nor,
+		   const struct sfdp_parameter_header *bfpt_header,
+		   const struct sfdp_bfpt *bfpt)
 {
 	/*
-	 * Some manufacturer like GigaDevice may use different
-	 * bit to set QE on different memories, so the MFR can't
-	 * indicate the quad_enable method for this case, we need
-	 * to set it in the default_init fixup hook.
+	 * GD25Q256 'C' generation 'GD25Q256C' implements the JESD216
+	 * standards, JESD216 doesn't define QER field in BFPT, but
+	 * the 'GD25Q256C' does have QE bit defined in status register
+	 * 1, this means parsing the BFPT can't properly set the
+	 * quad_enable function, so we need to tweak the quad_enable
+	 * function manually.
+	 *
+	 * GD25Q256 GENERATION|SFDP MAJOR VERSION|SFDP MINOR VERSION
+	 *      GD25Q256C     |SFDP_JESD216_MAJOR|SFDP_JESD216_MINOR
+	 *      GD25Q256D     |SFDP_JESD216_MAJOR|SFDP_JESD216B_MINOR
+	 *      GD25Q256E     |SFDP_JESD216_MAJOR|SFDP_JESD216B_MINOR
 	 */
-	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
+	if (bfpt_header->major == SFDP_JESD216_MAJOR &&
+	    bfpt_header->minor == SFDP_JESD216_MINOR)
+		nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
+
+	return 0;
 }
 
 static const struct spi_nor_fixups gd25q256_fixups = {
-	.default_init = gd25q256_default_init,
+	.post_bfpt = gd25q256_post_bfpt,
 };
 
 static const struct flash_info gigadevice_nor_parts[] = {
-- 
2.34.1

