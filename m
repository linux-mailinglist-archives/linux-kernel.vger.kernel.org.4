Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A46EEF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbjDZHln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbjDZHl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:41:28 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E492C3C0F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:41:22 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 3F91B5FD70;
        Wed, 26 Apr 2023 10:41:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682494881;
        bh=xgygLRvIYd3IRnvHIRUpBMCLTyo8M38NjtWHI+zK1UU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=PlU34A31TwYma7B9D+ANgFoWCGsTfidr/nzaNxtdZDZrcEtlfds0fktQk5HCz2AwS
         /QaapES99fgKuoKZuMcubaGV3jX54Mfvm5eoELguj80YfFQBNsJsRWQ21NpyHfGcsn
         U4EHtgeui+pTChayUSVRVC5eZBSZRQLtVJwibcMDqIbBzN0gMSn9EdFOXELbZAhiPH
         vvlGzRWMWOlMTjuPxrb7sFmLnrcFE2lOJVe0GjKi4+Ot8UXkco3vSCqGteRunPbEp2
         R3Rjmx3y1jWKOwJ8iR2HP9IJL0bQZ3ZjjcVzRzZy8SlFM+TuuuFDk+KEQ3Y5isBiYV
         x6/TjQvh5Wrdw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 10:41:21 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] mtd: rawnand: meson: remove unneeded bitwise OR with zeroes
Date:   Wed, 26 Apr 2023 10:36:30 +0300
Message-ID: <20230426073632.3905682-5-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230426073632.3905682-1-AVKrasnov@sberdevices.ru>
References: <20230426073632.3905682-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/26 04:45:00 #21166225
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

Both operations have no effect.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ef0fe88773be..3737024c33d6 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -624,12 +624,12 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
 	cmd0 = in ? NAND_CMD_READ0 : NAND_CMD_SEQIN;
 	nfc->cmdfifo.rw.cmd0 = cs | NFC_CMD_CLE | cmd0;
 
-	addrs[0] = cs | NFC_CMD_ALE | 0;
+	addrs[0] = cs | NFC_CMD_ALE;
 	if (mtd->writesize <= 512) {
 		cmd_num--;
 		row_start = 1;
 	} else {
-		addrs[1] = cs | NFC_CMD_ALE | 0;
+		addrs[1] = cs | NFC_CMD_ALE;
 		row_start = 2;
 	}
 
-- 
2.35.0

