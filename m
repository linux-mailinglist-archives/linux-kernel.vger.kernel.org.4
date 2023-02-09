Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90696911C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBIUEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjBIUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:04:18 -0500
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E76369537;
        Thu,  9 Feb 2023 12:04:15 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id EC495C0000F7;
        Thu,  9 Feb 2023 12:04:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com EC495C0000F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675973055;
        bh=Nl3Rqte+uOd9RA7nIr+QM1PaDO3xyBvfLRKXChuaiKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J87q7HmFuH2OXHmWN6s6oU79YZJ176E+3Ht/bK8drD7Wc/kVTqfMcyKmFkJxiwauF
         H+mZBQd6h+5xouZU7wDP6YthN83WPyBHLtk6jdWqCUS1D9hKdKE+BRLnVUPz2iEyoe
         rIJ5x/4vw+RMjLDR/S2jTV+wNK/9KjW+bzH0sBIs=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id AF54618041CAC6;
        Thu,  9 Feb 2023 12:04:14 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id ACECA101B61; Thu,  9 Feb 2023 12:04:14 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     f.fainelli@gmail.com, dregan@mail.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        jonas.gorski@gmail.com, William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/15] spi: bcm63xx-hsspi: Handle cs_change correctly
Date:   Thu,  9 Feb 2023 12:02:40 -0800
Message-Id: <20230209200246.141520-10-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230209200246.141520-1-william.zhang@broadcom.com>
References: <20230209200246.141520-1-william.zhang@broadcom.com>
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

(no changes since v3)

Changes in v3:
- Use the cs_change and cs_off logic from SPI core
spi_transfer_one_message function

Changes in v2:
- Fix unused variable ‘reg’ compile warning

 drivers/spi/spi-bcm63xx-hsspi.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 55cbe7deba08..af51488659b8 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -219,7 +219,8 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	unsigned long limit;
 
 	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
-	bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
+	if (!t->cs_off)
+		bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
 
 	if (tx && rx)
 		opcode = HSSPI_OP_READ_WRITE;
@@ -338,7 +339,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	int status = -EINVAL;
 	int dummy_cs;
-	u32 reg;
+	bool keep_cs = false;
 
 	mutex_lock(&bs->msg_mutex);
 	/* This controller does not support keeping CS active during idle.
@@ -367,16 +368,28 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 
 		spi_transfer_delay_exec(t);
 
-		if (t->cs_change)
-			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
+		/* use existing cs change logic from spi_transfer_one_message */
+		if (t->cs_change) {
+			if (list_is_last(&t->transfer_list, &msg->transfers)) {
+				keep_cs = true;
+			} else {
+				if (!t->cs_off)
+					bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
+
+				spi_transfer_cs_change_delay_exec(msg, t);
+
+				if (!list_next_entry(t, transfer_list)->cs_off)
+					bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
+			}
+		} else if (!list_is_last(&t->transfer_list, &msg->transfers) &&
+			   t->cs_off != list_next_entry(t, transfer_list)->cs_off) {
+			bcm63xx_hsspi_set_cs(bs, spi->chip_select, t->cs_off);
+		}
 	}
 
-	mutex_lock(&bs->bus_mutex);
-	reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
-	reg &= ~GLOBAL_CTRL_CS_POLARITY_MASK;
-	reg |= bs->cs_polarity;
-	__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
-	mutex_unlock(&bs->bus_mutex);
+	bcm63xx_hsspi_set_cs(bs, dummy_cs, false);
+	if (status || !keep_cs)
+		bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
 
 	mutex_unlock(&bs->msg_mutex);
 	msg->status = status;
-- 
2.37.3

