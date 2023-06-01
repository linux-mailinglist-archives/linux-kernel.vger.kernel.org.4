Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C519719325
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjFAGYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjFAGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:23:54 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C36101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:23:51 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 975415FD70;
        Thu,  1 Jun 2023 09:23:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685600629;
        bh=Q8CW0l91q7Th3XcNDlwzoNWNnWO9BZjhfFIJhYfFY5Y=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=n6h/JboeFGivZeMmfptLF1Yojq836TdKOmTDWUGHvktQGtmoNpS46uAFA8lda+VXm
         M5k2YrIXjos5DVNRJZiVR40THbMQ3ndT5YZuxtlxcennsjGvCmFt/kF4b6SgC2fB4Y
         r6kS5nWRosna4QicZH2S02vxk+QkAvfFFUvdu0FmFZwXjljNfll3AmxN++GwcWFwrg
         scEETeunJ0nieXS+r0kHROmElgHP2GpK9AhrxcZueRl7G4mOJe0XqACJZsiu014NTA
         1Tw2Np1un1jNbgaPt4G0jdERNyD63dXF4fC56ev7GG2MdMjRl5sl3m5NlWpqq92u3z
         ftlY+PG0ucqGA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Jun 2023 09:23:49 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in polling mode
Date:   Thu, 1 Jun 2023 09:18:45 +0300
Message-ID: <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/01 03:13:00 #21393813
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support of waiting for command completion in sofyware polling
mode. It is needed when ready/busy pin is not implemented in hardware.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 53 ++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 9dd4a676497b..82a629025adc 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -179,6 +179,7 @@ struct meson_nfc {
 	u32 info_bytes;
 
 	unsigned long assigned_cs;
+	bool use_polling;
 };
 
 enum {
@@ -392,32 +393,38 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
 	}
 }
 
-static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
+static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)
 {
-	u32 cmd, cfg;
-	int ret = 0;
+	struct meson_nfc *nfc = nand_get_controller_data(nand);
 
-	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
-	meson_nfc_drain_cmd(nfc);
-	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
+	if (nfc->use_polling) {
+		return nand_soft_waitrdy(nand, timeout_ms);
+	} else {
+		u32 cmd, cfg;
+		int ret = 0;
 
-	cfg = readl(nfc->reg_base + NFC_REG_CFG);
-	cfg |= NFC_RB_IRQ_EN;
-	writel(cfg, nfc->reg_base + NFC_REG_CFG);
+		meson_nfc_cmd_idle(nfc, nfc->timing.twb);
+		meson_nfc_drain_cmd(nfc);
+		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
 
-	reinit_completion(&nfc->completion);
+		cfg = readl(nfc->reg_base + NFC_REG_CFG);
+		cfg |= NFC_RB_IRQ_EN;
+		writel(cfg, nfc->reg_base + NFC_REG_CFG);
 
-	/* use the max erase time as the maximum clock for waiting R/B */
-	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
-		| nfc->param.chip_select | nfc->timing.tbers_max;
-	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+		reinit_completion(&nfc->completion);
 
-	ret = wait_for_completion_timeout(&nfc->completion,
-					  msecs_to_jiffies(timeout_ms));
-	if (ret == 0)
-		ret = -1;
+		/* use the max erase time as the maximum clock for waiting R/B */
+		cmd = NFC_CMD_RB | NFC_CMD_RB_INT
+			| nfc->param.chip_select | nfc->timing.tbers_max;
+		writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
-	return ret;
+		ret = wait_for_completion_timeout(&nfc->completion,
+						  msecs_to_jiffies(timeout_ms));
+		if (ret == 0)
+			return -ETIMEDOUT;
+
+		return 0;
+	}
 }
 
 static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
@@ -623,7 +630,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
 	if (in) {
 		nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
 		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
-		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
+		meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tR_max));
 	} else {
 		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
 	}
@@ -669,7 +676,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
 
 	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
-	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
+	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
 
 	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
 
@@ -952,7 +959,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 			break;
 
 		case NAND_OP_WAITRDY_INSTR:
-			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
+			meson_nfc_queue_rb(nand, instr->ctx.waitrdy.timeout_ms);
 			if (instr->delay_ns)
 				meson_nfc_cmd_idle(nfc, delay_idle);
 			break;
@@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	nfc->use_polling = of_property_read_bool(dev->of_node, "polling");
+
 	writel(0, nfc->reg_base + NFC_REG_CFG);
 	ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);
 	if (ret) {
-- 
2.35.0

