Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBD702979
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjEOJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbjEOJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:49:48 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C7DA7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:49:44 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 915EE5FD16;
        Mon, 15 May 2023 12:49:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684144181;
        bh=Dmj6MVlJqsj8zojvHjdvVHURJoWIYhagZNM7JaN5Dds=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Uf/IsyLUdE2c+v5zkfr9jL/h4IMMipF+j4vKH5XLB675lh5wbPAcDL2sN8H3UJLtp
         xlpIzpPQTpsqwkFr7iVB2tU8JB6Bm3v6gTiF2Emg1kI27sWm+or+dg2kOie66s6sSM
         nrMUu76TljNs6mZocS7M/ybbzUAqeJ+DqVdk8F7GDKmK+H3MpPO2676qvGwO6U0wF+
         kBaCR6iRUe98WX1HlfeDgMKl6NckIRQzd9yLp8zXmym2w8Bdz6zFcXqk8TaGgt+mr2
         KX51MxCd7d/0UQY8C8zC8EkLWsJ7AxpQTZm0Mtl+sH1rOyVuH1UYyphQSd3KhzuaZ8
         /GaTuToSVdESg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 May 2023 12:49:41 +0300 (MSK)
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
Subject: [PATCH v4 1/5] mtd: rawnand: meson: fix command sequence for read/write
Date:   Mon, 15 May 2023 12:44:35 +0300
Message-ID: <20230515094440.3552094-2-AVKrasnov@sberdevices.ru>
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

This fixes read/write functionality by:
1) Changing NFC_CMD_RB_INT bit value.
2) Adding extra NAND_CMD_STATUS command on each r/w request.
3) Adding extra idle commands during r/w request.
4) Adding extra NAND_CMD_READ0 on each read request.

Without this patch driver works unstable, for example there are a lot
of ECC errors.

Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Suggested-by: Liang Yang <liang.yang@amlogic.com>
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 074e14225c06..2f4d8c84186b 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -37,7 +37,7 @@
 #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
 #define NFC_CMD_SCRAMBLER_DISABLE	0
 #define NFC_CMD_SHORTMODE_DISABLE	0
-#define NFC_CMD_RB_INT		BIT(14)
+#define NFC_CMD_RB_INT ((0xb << 10) | BIT(18) | BIT(16))
 
 #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
 
@@ -392,7 +392,7 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
 	}
 }
 
-static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
+static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms, int cmd_read0)
 {
 	u32 cmd, cfg;
 	int ret = 0;
@@ -407,17 +407,29 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
 
 	reinit_completion(&nfc->completion);
 
+	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
+	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	meson_nfc_cmd_idle(nfc, 5);
+
 	/* use the max erase time as the maximum clock for waiting R/B */
-	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
-		| nfc->param.chip_select | nfc->timing.tbers_max;
+	cmd = NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	meson_nfc_cmd_idle(nfc, 2);
 
 	ret = wait_for_completion_timeout(&nfc->completion,
 					  msecs_to_jiffies(timeout_ms));
 	if (ret == 0)
-		ret = -1;
+		return -1;
 
-	return ret;
+	if (!cmd_read0)
+		return 0;
+
+	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
+	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	meson_nfc_drain_cmd(nfc);
+	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
+
+	return 0;
 }
 
 static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
@@ -623,7 +635,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
 	if (in) {
 		nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
 		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
-		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
+		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max), 1);
 	} else {
 		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
 	}
@@ -669,7 +681,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
 
 	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
-	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
+	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max), 0);
 
 	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
 
@@ -952,7 +964,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 			break;
 
 		case NAND_OP_WAITRDY_INSTR:
-			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
+			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms, 1);
 			if (instr->delay_ns)
 				meson_nfc_cmd_idle(nfc, delay_idle);
 			break;
-- 
2.35.0

