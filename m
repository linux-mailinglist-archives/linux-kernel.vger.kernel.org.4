Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8655D6FDC63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjEJLOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjEJLNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:13:46 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82191FEB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:13:45 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1BFD45FD28;
        Wed, 10 May 2023 14:13:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683717224;
        bh=pDgBDoAKjg6vj7ErjpVUqQO/7LJNM4Rbiw1rV81IA2I=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=D5IjbeTUTO5iE1NbyyeAPb7mEeEsZufkvCkVZxiZDqxefDo3L/a7zFiqkwqFkpRV3
         cFMsORQhsE2BaFLrYxLzEJQv7u5xhm4CIwKoPELxmLu0vrQtZPFcJSLgDAjO/VhMCB
         Yibr7IRFnECeoUw22G3xItZzhdfeBXASZPfWZOjAr0bmg2LSwtai95gUwRo4gp8QMW
         t2zDnEAVGXWytKjOZWmbia+dRm5H8x3MOLBHWEsd4s5LR7aRrPFLAcBcvIvWS+Rs9u
         8GxwlupMj0WosxGC37O3d/thbwvGqIOVS6MDv+eYzXUXbtSFsBMr1L9aMDa0SLFy+T
         pznDj5aQOmQfA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 10 May 2023 14:13:43 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/6] mtd: rawnand: meson: always read whole OOB bytes
Date:   Wed, 10 May 2023 14:08:31 +0300
Message-ID: <20230510110835.26115-4-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
References: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/10 09:03:00 #21252424
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes size of read access to OOB area by reading all bytes of
OOB (free bytes + ECC engine bytes).

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index d7c81408cfa2..331377a2c5dc 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -755,6 +755,30 @@ static int __meson_nfc_read_oob(struct nand_chip *nand, int page,
 	u32 oob_bytes;
 	u32 page_size;
 	int ret;
+	int i;
+
+	/* Read ECC codes and user bytes. */
+	for (i = 0; i < nand->ecc.steps; i++) {
+		u32 ecc_offs = nand->ecc.size * (i + 1) +
+			       NFC_OOB_PER_ECC(nand) * i;
+
+		ret = nand_read_page_op(nand, page, 0, NULL, 0);
+		if (ret)
+			return ret;
+
+		/* Use temporary buffer, because 'nand_change_read_column_op()'
+		 * seems work with some alignment, so we can't read data to
+		 * 'oob_buf' directly.
+		 */
+		ret = nand_change_read_column_op(nand, ecc_offs, meson_chip->oob_buf,
+						 NFC_OOB_PER_ECC(nand), false);
+		if (ret)
+			return ret;
+
+		memcpy(oob_buf + i * NFC_OOB_PER_ECC(nand),
+		       meson_chip->oob_buf,
+		       NFC_OOB_PER_ECC(nand));
+	}
 
 	oob_bytes = meson_nfc_get_oob_bytes(nand);
 
-- 
2.35.0

