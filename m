Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912E872765E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjFHEwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFHEwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:52:41 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A46626BF;
        Wed,  7 Jun 2023 21:52:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6A8B05FD74;
        Thu,  8 Jun 2023 07:52:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686199958;
        bh=GYtnAFGzVIKIFmc2XJJv/gZaWIiwjNzXEEwtgsJHPVg=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=bhqbbLMNNXfKM0GKI0nW5ePmL7xzrBxXpJXzfSfxDLWB+wq1td2pYBum1VgUqVByT
         Sz5KwmDxtwVEcYDv709vzldv/gQ55kgruHxzk6qlVi6ZoVU2Mv7qRm+lOsf3PTnwPS
         nBz5qlv0KLHWxcJbhpy9Hj1Js5jsH/X/uviaNeAx6JSxyIlF+CG+s7Z99ggRlD5x2Y
         COONcirzEZ4B9OYQ2R2LAh3LXYBATbn+gRi+4MVTpFlDZUqdO/QqcYRq+kBMSpeCNt
         D46XH8LEzKF3z66LrJVRPEWE72kbf0/M3/oSj2cvsX98VA8CtN3TIZD4PwnF2O5Sfg
         iBAaVyr1A+OIw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  8 Jun 2023 07:52:38 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] mtd: rawnand: meson: waiting w/o wired ready/busy pin
Date:   Thu, 8 Jun 2023 07:47:28 +0300
Message-ID: <20230608044728.1328506-3-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230608044728.1328506-1-AVKrasnov@sberdevices.ru>
References: <20230608044728.1328506-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/08 00:23:00 #21457426
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no wired ready/busy pin, classic way to wait for command
completion is to use function 'nand_soft_waitrdy()'. Meson NAND has
special command which allows to wait for NAND_STATUS_READY bit without
reading status in a software loop (as 'nand_soft_waitrdy()' does). To
use it send this command along with NAND_CMD_STATUS, then wait for an
interrupt, and after interrupt send NAND_CMD_READ0. So this feature
allows to use interrupt driven waiting without wired ready/busy pin.

Suggested-by: Liang Yang <liang.yang@amlogic.com>
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 77 +++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 074e14225c06..9f05e113b4ea 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -38,6 +38,7 @@
 #define NFC_CMD_SCRAMBLER_DISABLE	0
 #define NFC_CMD_SHORTMODE_DISABLE	0
 #define NFC_CMD_RB_INT		BIT(14)
+#define NFC_CMD_RB_INT_NO_PIN	((0xb << 10) | BIT(18) | BIT(16))
 
 #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
 
@@ -179,6 +180,7 @@ struct meson_nfc {
 	u32 info_bytes;
 
 	unsigned long assigned_cs;
+	bool no_rb_pin;
 };
 
 enum {
@@ -392,7 +394,42 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
 	}
 }
 
-static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
+static int meson_nfc_wait_no_rb_pin(struct meson_nfc *nfc, int timeout_ms,
+				    bool need_cmd_read0)
+{
+	u32 cmd, cfg;
+
+	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
+	meson_nfc_drain_cmd(nfc);
+	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
+
+	cfg = readl(nfc->reg_base + NFC_REG_CFG);
+	cfg |= NFC_RB_IRQ_EN;
+	writel(cfg, nfc->reg_base + NFC_REG_CFG);
+
+	reinit_completion(&nfc->completion);
+	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
+	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+
+	/* use the max erase time as the maximum clock for waiting R/B */
+	cmd = NFC_CMD_RB | NFC_CMD_RB_INT_NO_PIN | nfc->timing.tbers_max;
+	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+
+	if (!wait_for_completion_timeout(&nfc->completion,
+					 msecs_to_jiffies(timeout_ms)))
+		return -ETIMEDOUT;
+
+	if (need_cmd_read0) {
+		cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
+		writel(cmd, nfc->reg_base + NFC_REG_CMD);
+		meson_nfc_drain_cmd(nfc);
+		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
+	}
+
+	return 0;
+}
+
+static int meson_nfc_wait_rb_pin(struct meson_nfc *nfc, int timeout_ms)
 {
 	u32 cmd, cfg;
 	int ret = 0;
@@ -420,6 +457,27 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
 	return ret;
 }
 
+static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms,
+			      bool need_cmd_read0)
+{
+	if (nfc->no_rb_pin) {
+		/* This mode is used when there is no wired R/B pin.
+		 * It works like 'nand_soft_waitrdy()', but instead of
+		 * polling NAND_CMD_STATUS bit in the software loop,
+		 * it will wait for interrupt - controllers checks IO
+		 * bus and when it detects NAND_CMD_STATUS on it, it
+		 * raises interrupt. After interrupt, NAND_CMD_READ0 is
+		 * sent as terminator of the ready waiting procedure if
+		 * needed (for all cases except page programming - this
+		 * is reason of 'need_cmd_read0' flag).
+		 */
+		return meson_nfc_wait_no_rb_pin(nfc, timeout_ms,
+						need_cmd_read0);
+	} else {
+		return meson_nfc_wait_rb_pin(nfc, timeout_ms);
+	}
+}
+
 static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
 {
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
@@ -623,7 +681,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
 	if (in) {
 		nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
 		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
-		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
+		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max), true);
 	} else {
 		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
 	}
@@ -669,7 +727,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
 
 	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
-	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
+	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max), false);
 
 	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
 
@@ -952,7 +1010,8 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 			break;
 
 		case NAND_OP_WAITRDY_INSTR:
-			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
+			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms,
+					   true);
 			if (instr->delay_ns)
 				meson_nfc_cmd_idle(nfc, delay_idle);
 			break;
@@ -1248,6 +1307,7 @@ meson_nfc_nand_chip_init(struct device *dev,
 	struct mtd_info *mtd;
 	int ret, i;
 	u32 tmp, nsels;
+	u32 nand_rb_val = 0;
 
 	nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
 	if (!nsels || nsels > MAX_CE_NUM) {
@@ -1287,6 +1347,15 @@ meson_nfc_nand_chip_init(struct device *dev,
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = dev;
 
+	ret = of_property_read_u32(np, "nand-rb", &nand_rb_val);
+	if (ret == -EINVAL)
+		nfc->no_rb_pin = true;
+	else if (ret)
+		return ret;
+
+	if (nand_rb_val)
+		return -EINVAL;
+
 	ret = nand_scan(nand, nsels);
 	if (ret)
 		return ret;
-- 
2.35.0

