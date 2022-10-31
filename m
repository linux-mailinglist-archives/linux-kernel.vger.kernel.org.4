Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F556136D1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiJaMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiJaMq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:46:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A3F59B;
        Mon, 31 Oct 2022 05:46:40 -0700 (PDT)
X-UUID: 4c2ba30807c348b8bb80ca325cea4ea4-20221031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0eyPwIID5QTj89ySOKRfQtfyf9Um1CmzCups6XoDQNc=;
        b=GqCl7f9mh0Oy5KQWzuF8l/zeDd648Tb7sPd951Dbhvsgyla2NgY9ROGcC919saKOUEFNsz/2BRnlwuiaDGIe0VWWJBdCuB/l6N5sdthKbrcVsuOIdCb/0MJ0MSLFTTF6tKdR/V0FYH9YaVjXLgmCqe/wWfOLhN/S8L44da5k764=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:24768b0c-6e17-4c87-9457-21404d6a9ab5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:24768b0c-6e17-4c87-9457-21404d6a9ab5,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:3cce2981-3116-4fbc-b86b-83475c3df513,B
        ulkID:22103120463714YYF5YR,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4c2ba30807c348b8bb80ca325cea4ea4-20221031
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 920886206; Mon, 31 Oct 2022 20:46:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 31 Oct 2022 20:46:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 Oct 2022 20:46:35 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>
Subject: [PATCH] mtd: spi-nor: Fix the number of bytes for the dummy cycles
Date:   Mon, 31 Oct 2022 20:46:33 +0800
Message-ID: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of bytes used by spi_nor_spimem_check_readop() may be
incorrect for the dummy cycles. Since nor->read_dummy is not initialized
before spi_nor_spimem_adjust_hwcaps().

We use both mode and wait state clock cycles instead of nor->read_dummy.

Fixes: 0e30f47232ab ("mtd: spi-nor: add support for DTR protocol")
Co-developed-by: Bayi Cheng <bayi.cheng@mediatek.com>
Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 drivers/mtd/spi-nor/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 6c921eb3fadb..8b9c318a0ad4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1914,7 +1914,8 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 	spi_nor_spimem_setup_op(nor, &op, read->proto);
 
 	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
+			  op.dummy.buswidth / 8;
 	if (spi_nor_protocol_is_dtr(nor->read_proto))
 		op.dummy.nbytes *= 2;
 
-- 
2.18.0

