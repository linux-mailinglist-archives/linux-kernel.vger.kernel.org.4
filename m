Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABB6DEBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDLGVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDLGV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:21:26 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F3129
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:21:24 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 03AF45FD63;
        Wed, 12 Apr 2023 09:21:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681280483;
        bh=yOrNA4RDuoM2vY5YhSP/eGA0DmXdgsqQqlqaL/M6BtI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=SmeasOpRVy5aK9D7zQO00XNQdh/v8N9hvNJ2Zj0L995muidQCpGzGjWGdqdtdt4KD
         GoM+st3GB75u96nvynvGqdmcCzYVgGePL46Z55tt7LYKE3J+lDhPeBv/4DncerKkTP
         Y1/wJ3GFslOsHrhGLC/wS6w8/pg6roJQwAFJfdIo2lCyo0ky3p+1a1HUrg1i3itj/i
         ek9GaBfFEtZiu0sDwxoh0Phh5eHCcLvP1jTGRzw/mcounSc+4+AgF/FAVVW7YJwGKh
         0bhEE3QWKl6gZ6I1WW9gzHEPLoagteTuCzYvGKxi969Yt9nqvs+0gABPK1h23JX/UG
         qe8haXiN1aXOg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 12 Apr 2023 09:21:22 +0300 (MSK)
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
Subject: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
Date:   Wed, 12 Apr 2023 09:16:58 +0300
Message-ID: <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/12 04:12:00 #21090163
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This NAND reads only few user's bytes in ECC mode (not full OOB), so
fill OOB buffer with zeroes to not return garbage from previous reads
to user.
Otherwise 'nanddump' utility prints something like this for just erased
page:

...
0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
  OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
  OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
  OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index f84a10238e4d..f2f2472cb511 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_chip *nand,
 static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
 				   int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	u8 *oob_buf = nand->oob_poi;
 	int ret;
 
+	memset(oob_buf, 0, mtd->oobsize);
+
 	ret = meson_nfc_read_page_sub(nand, page, 1);
 	if (ret)
 		return ret;
@@ -881,6 +884,8 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
 	u8 *oob_buf = nand->oob_poi;
 	int ret, i;
 
+	memset(oob_buf, 0, mtd->oobsize);
+
 	ret = meson_nfc_read_page_sub(nand, page, 0);
 	if (ret)
 		return ret;
-- 
2.35.0

