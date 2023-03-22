Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B8C6C53FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCVSqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCVSqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:46:17 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D19059E59
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:46:04 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6EBAB5FD3E;
        Wed, 22 Mar 2023 21:45:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679510758;
        bh=rVtVHS3YbcTr4exAe5aUDPpvfNLxMi2NgaBzD0hJtkI=;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
        b=cmNVA/O5C1NVFgyexdnp+OOdABIBGzbys02plXb0EjUgKtFozxdkfVzG9zLs16WR5
         BsDm1Ai5iKya/Py+xGP0fiefb0ajDtIqzMdjE/cbJQUeuzWFFcbZajrGe7vfPt/u4j
         Ze0/KQll445prTsaFh0JAdlUD3KFYhCh3wc+OuS86VMVRL5FIM/KIJNUIliCeWqPhU
         TG2rfabA/1YuF3Fbrw4wxLfszRw0vUTL5hIvi6FBs/i7sQNU6Tcw5LbQ8US5iZ13nb
         KmIEmJqmGwZSSGPhF5H71bWPsXokRiWewwBpjLJBbEDDUn69QTgYk/WCU0Ybf5ps9N
         gjeqj6iSL2mMg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Mar 2023 21:45:56 +0300 (MSK)
Message-ID: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
Date:   Wed, 22 Mar 2023 21:42:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
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
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in command
 word
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/22 14:20:00 #20991698
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valid mask is 0x3FFF, without this patch the following problems were
found:

1) [    0.938914] Could not find a valid ONFI parameter page, trying
                  bit-wise majority to recover it
   [    0.947384] ONFI parameter recovery failed, aborting

2) Read with disabled ECC mode was broken.

Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index a28574c00900..074e14225c06 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -280,7 +280,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
 
 	if (raw) {
 		len = mtd->writesize + mtd->oobsize;
-		cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
+		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
 		writel(cmd, nfc->reg_base + NFC_REG_CMD);
 		return;
 	}
@@ -544,7 +544,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	if (ret)
 		goto out;
 
-	cmd = NFC_CMD_N2M | (len & GENMASK(5, 0));
+	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
@@ -568,7 +568,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
 	if (ret)
 		return ret;
 
-	cmd = NFC_CMD_M2N | (len & GENMASK(5, 0));
+	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
-- 
2.35.0
