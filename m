Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33A66079F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjAFUKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjAFUKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:10:10 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E6784091;
        Fri,  6 Jan 2023 12:10:09 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7AFA1C0000E5;
        Fri,  6 Jan 2023 12:10:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7AFA1C0000E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035809;
        bh=Je0b6vbxzSyApfV57XdMzbBAJ1OOxv2L5PniIWRhOb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIkHd96clSQEmxDCYtME2IZM4/bQh4OVa9WI5jipic9lQxUqn89pKNRCFUhsCFaa7
         9ge+SieN2xiWGdy9s3thRUlVRvJO56llhxvTZany8GVlJjwSZKjxk+2K/me88D0CJu
         bqambiYVxLut4VLalRL3o3NLaF3N7yopSmN67o8k=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 7916F18041CAC6;
        Fri,  6 Jan 2023 12:10:09 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 74787101B33; Fri,  6 Jan 2023 12:10:09 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] spi: bcm63xx-hsspi: Add clock gate disable option support
Date:   Fri,  6 Jan 2023 12:08:04 -0800
Message-Id: <20230106200809.330769-13-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230106200809.330769-1-william.zhang@broadcom.com>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SPI device such as Broadcom ISI based voice daughtercard
requires SPI clock running even when chip select is deasserted. By
default the controller turn off or gate the clock when cs is not active
to save power.

This change adds an option to support such device and keep the clock
running when flag brcm,no-clk-gate is present in the SPI device node or
when the SPI device driver clear the GATE_CLK_SSOFF flag in the device
controller data field.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 drivers/spi/spi-bcm63xx-hsspi.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 58f2b495c13c..be4ca01f332a 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -23,6 +23,13 @@
 #include <linux/reset.h>
 #include <linux/pm_runtime.h>
 
+/* Broadcom Legacy SPI device driver flags */
+#define SPIDEV_CONTROLLER_STATE_SET		BIT(31)
+#define SPIDEV_CONTROLLER_STATE_GATE_CLK_SSOFF	BIT(29)
+
+#define spidev_ctrl_data(spi)			\
+	((u32)((uintptr_t)(spi)->controller_data))
+
 #define HSSPI_GLOBAL_CTRL_REG			0x0
 #define GLOBAL_CTRL_CS_POLARITY_SHIFT		0
 #define GLOBAL_CTRL_CS_POLARITY_MASK		0x000000ff
@@ -120,11 +127,40 @@ struct bcm63xx_hsspi {
 static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 				  struct spi_device *spi, int hz);
 
+static inline int bcm63xx_hsspi_dev_no_clk_gate(struct spi_device *spi)
+{
+	u32 ctrl_data = 0;
+
+	/* check spi device dn first */
+	if (of_property_read_bool(spi->dev.of_node, "brcm,no-clk-gate"))
+		return 1;
+
+	/* check spi dev controller data for legacy device support */
+	ctrl_data = spidev_ctrl_data(spi);
+	return ((ctrl_data & SPIDEV_CONTROLLER_STATE_SET) &&
+		!(ctrl_data & SPIDEV_CONTROLLER_STATE_GATE_CLK_SSOFF));
+}
+
 static size_t bcm63xx_hsspi_max_message_size(struct spi_device *spi)
 {
 	return HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN;
 }
 
+static void bcm63xx_hsspi_restore_clk_gate(struct bcm63xx_hsspi *bs,
+				       struct spi_device *spi)
+{
+	u32 reg = 0;
+
+	/* check if clk gate setting was previously turned off */
+	if (bcm63xx_hsspi_dev_no_clk_gate(spi)) {
+		mutex_lock(&bs->bus_mutex);
+		reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
+		reg |= GLOBAL_CTRL_CLK_GATE_SSOFF;
+		__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
+		mutex_unlock(&bs->bus_mutex);
+	}
+}
+
 static int bcm63xx_hsspi_wait_cmd(struct bcm63xx_hsspi *bs)
 {
 	unsigned long limit;
@@ -354,6 +390,12 @@ static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
 	reg &= ~GLOBAL_CTRL_CLK_POLARITY;
 	if (spi->mode & SPI_CPOL)
 		reg |= GLOBAL_CTRL_CLK_POLARITY;
+
+	if (bcm63xx_hsspi_dev_no_clk_gate(spi))
+		reg &= ~GLOBAL_CTRL_CLK_GATE_SSOFF;
+	else
+		reg |= GLOBAL_CTRL_CLK_GATE_SSOFF;
+
 	__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
 	mutex_unlock(&bs->bus_mutex);
 }
@@ -485,6 +527,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	if (bcm63xx_check_msg_prependable(master, msg, &t_prepend)) {
 		status = bcm63xx_hsspi_do_prepend_txrx(spi, &t_prepend);
 		msg->actual_length += (t_prepend.len + bs->prepend_cnt);
+		bcm63xx_hsspi_restore_clk_gate(bs, spi);
 		goto msg_done;
 	}
 
@@ -543,6 +586,9 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
 	}
 
+	/* restore the default clk gate setting in case spidev turn it off */
+	bcm63xx_hsspi_restore_clk_gate(bs, spi);
+
 msg_done:
 	msg->status = status;
 	spi_finalize_current_message(master);
-- 
2.37.3

