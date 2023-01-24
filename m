Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B3C67A5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjAXWdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjAXWdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:33:21 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvacalvio01.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785EE530E8;
        Tue, 24 Jan 2023 14:33:07 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1B79DC0000E8;
        Tue, 24 Jan 2023 14:33:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1B79DC0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599587;
        bh=J1uqvs80rFu4ZJ4yuFFt4i7aXR50M8kpaFeq7uY4yfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETTpjJFxHsLLLvrL2EDCEKfYaye/YncGW6BVONuFREHze7Ps9oSP2ssnobUwfl+TE
         kPGM2JyZ8g18SQ2FS4aY8zpouS3LwVFfMSczymkK9EFCn5nCF4VnBbSfNC2UkFSTb1
         JgiFUckzc8/5cT0AkzTq8H5tsFtiBOlKNJp78t4I=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 19FA618041CAC6;
        Tue, 24 Jan 2023 14:33:07 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 5ED65101B55; Tue, 24 Jan 2023 14:33:00 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/14] spi: bcm63xx-hsspi: Handle cs_change correctly
Date:   Tue, 24 Jan 2023 14:12:11 -0800
Message-Id: <20230124221218.341511-9-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230124221218.341511-1-william.zhang@broadcom.com>
References: <20230124221218.341511-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel SPI interface includes the cs_change flag that alters how
the CS behaves.

If we're in the middle of transfers, it tells us to unselect the
CS momentarily since the target device requires that.

If we're at the end of a transfer, it tells us to keep the CS
selected, perhaps because the next transfer is likely targeted
to the same device.

We implement this scheme in the HSSPI driver in this change.

Prior to this change, the CS would toggle momentarily if cs_change
was set for the last transfer. This can be ignored by some or
most devices, but the Microchip TPM2 device does not ignore it.

With the change, the behavior is corrected and the 'glitch' is
eliminated.

Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v2:
- Fix unused variable ‘reg’ compile warning

 drivers/spi/spi-bcm63xx-hsspi.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 55cbe7deba08..696e14abba2d 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -338,7 +338,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	int status = -EINVAL;
 	int dummy_cs;
-	u32 reg;
+	bool restore_polarity = true;
 
 	mutex_lock(&bs->msg_mutex);
 	/* This controller does not support keeping CS active during idle.
@@ -367,16 +367,29 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 
 		spi_transfer_delay_exec(t);
 
-		if (t->cs_change)
+		/*
+		 * cs_change rules:
+		 * (1) cs_change = 0 && last_xfer = 0:
+		 *     Do not touch the CS. On to the next xfer.
+		 * (2) cs_change = 1 && last_xfer = 0:
+		 *     Set cs = false before the next xfer.
+		 * (3) cs_change = 0 && last_xfer = 1:
+		 *     We want CS to be deactivated. So do NOT set cs = false,
+		 *     instead just restore the original polarity. This has the
+		 *     same effect of deactivating the CS.
+		 * (4) cs_change = 1 && last_xfer = 1:
+		 *     We want to keep CS active. So do NOT set cs = false, and
+		 *     make sure we do NOT reverse polarity.
+		 */
+		if (t->cs_change && !list_is_last(&t->transfer_list, &msg->transfers))
 			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
+
+		restore_polarity = !t->cs_change;
 	}
 
-	mutex_lock(&bs->bus_mutex);
-	reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
-	reg &= ~GLOBAL_CTRL_CS_POLARITY_MASK;
-	reg |= bs->cs_polarity;
-	__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
-	mutex_unlock(&bs->bus_mutex);
+	bcm63xx_hsspi_set_cs(bs, dummy_cs, false);
+	if (restore_polarity)
+		bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
 
 	mutex_unlock(&bs->msg_mutex);
 	msg->status = status;
-- 
2.37.3

