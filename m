Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EAE70297C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjEOJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbjEOJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:49:49 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418991AD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:49:48 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A1E125FD20;
        Mon, 15 May 2023 12:49:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684144186;
        bh=Vz83jCy0spHA1ZRural7ddOQ1iT++4tUqhV7Ue23lk4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=qcn0IQfHKcGxRJrBonclWUzFGa4XbN3UU6+FFP2AsksiDymQ6qNyJELtmB+wp36eq
         PGVeFzgUnZww1VpOhjHQc58e5YFXfAN5i8YvvR4CIUctnyZ1aY4dVrn4aGRuy0NQfd
         m12CbKfAW7nSCh8ufHe4Hct5q1juezSISYESH0Nbt8QI243gw1FewU8wrF5fZ+YVAi
         lTjuvjuIfvhtsNSDqqR8z+GT+Qb4/2WO/sIIfYliAHUQ9QPFWwmd5Dz09Bm1II3kbW
         nDBgUSxU1tD1iqMAjGKSpGg4GvssvSm0RyiHy2X3nvvkVeqZqUnoQSXqFXVO08SkuM
         +nqn2DBNfqqKQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 May 2023 12:49:46 +0300 (MSK)
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
Subject: [PATCH v4 3/5] mtd: rawnand: meson: always read whole OOB bytes
Date:   Mon, 15 May 2023 12:44:37 +0300
Message-ID: <20230515094440.3552094-4-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/15 04:03:00 #21308474
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 8526a6b87720..a31106c943d7 100644
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

