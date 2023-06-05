Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B1721DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjFEGQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEGQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:16:13 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D817DB;
        Sun,  4 Jun 2023 23:16:09 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 716BD5FD15;
        Mon,  5 Jun 2023 09:16:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685945766;
        bh=knbIn8sgeJrLUQJlKWQNrWneQ8bifk2QzuAqk/RVJh0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=JcrASE0H46Hg6zUOeQKL8OGaNW6C5/blcsv+FXm/0orAfzL4Co6JQZsDmH95mHV55
         QiueNtCAh8IT6wDWOz5MxaaMFUq5B13ufyRz62Xivgbx4CVmndKfTc9/72mSbAqevu
         VTV2O5QaWc4MLBSa5kCDp/N5dihr986GalRAGaHCCayZDV+uDNxlqRL9q4Zyaaej17
         NuId1zDeY8dVWJ4glHsATaMZW1mIz5Y+G1qZMrDAgkrNbO6zIeba/CqVpgJhtsPbHY
         BqNVClLkpuKgbekKWOcmnQ2UV4gEhFCFeTVbL1Lh872eHhXODsHmvljX3+ucr6KAUI
         K99vpzVuit6ow==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  5 Jun 2023 09:16:03 +0300 (MSK)
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
        <stable@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] mtd: rawnand: meson: fix ready/busy command
Date:   Mon, 5 Jun 2023 09:10:48 +0300
Message-ID: <20230605061048.485622-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/05 01:06:00 #21433300
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the ready/busy command value.

Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Cc: stable@vger.kernel.org
Suggested-by: Liang Yang <liang.yang@amlogic.com>
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 074e14225c06..9dd4a676497b 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -37,7 +37,7 @@
 #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
 #define NFC_CMD_SCRAMBLER_DISABLE	0
 #define NFC_CMD_SHORTMODE_DISABLE	0
-#define NFC_CMD_RB_INT		BIT(14)
+#define NFC_CMD_RB_INT		((0xb << 10) | BIT(18) | BIT(16))
 
 #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
 
-- 
2.35.0

