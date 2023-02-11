Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA06692DDA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 04:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBKD21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 22:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBKD2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 22:28:25 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1FD1A977;
        Fri, 10 Feb 2023 19:28:24 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A5C63C0000F6;
        Fri, 10 Feb 2023 19:28:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A5C63C0000F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1676086103;
        bh=FOS/o6Bd4XVI+urrzvmsMM/X8nx8Xd6gYweRl6pibQk=;
        h=From:To:Cc:Subject:Date:From;
        b=BupMRpOFs1kxHZCDv52lqnGDanN6N2ckliKVlCmMEL3NFXaM9dPR8SgfprjsCHJ1l
         P7NPdWEHMn6UIonNXn0jEstR0oCcEeatPjIK3HdmgdqNkPhbOVogbSS6/IeUqEXvh3
         RBI5f90CsX2LHjfGiocpPn4W0yAH43fOXVJuPTgo=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 635A518041CAC6;
        Fri, 10 Feb 2023 19:28:23 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 8359C101B62; Fri, 10 Feb 2023 19:28:13 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, anand.gore@broadcom.com, jonas.gorski@gmail.com,
        joel.peshkin@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm63xx-hsspi: bcmbca-hsspi: fix _be16 type usage
Date:   Fri, 10 Feb 2023 19:27:59 -0800
Message-Id: <20230211032759.72967-1-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
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

sparse tool report warnings: drivers/spi/spi-bcm63xx-hsspi.c:197:31:
sparse: sparse: cast from restricted __be16.

The controller requires big endian 16 bit data. Define an intermediate
u16 value and use __be16 piointer dereferncing for the data to avoid
directly casting to u16 and sparse warning.

Fixes: 85a84a616999 ("spi: bcm63xx-hsspi: Endianness fix for ARM based SoC")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302110438.sQwQnU54-lkp@intel.com/

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

 drivers/spi/spi-bcm63xx-hsspi.c | 10 ++++++----
 drivers/spi/spi-bcmbca-hsspi.c  |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 1e9e906d297c..68093c045e0b 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -350,7 +350,7 @@ static int bcm63xx_hsspi_do_prepend_txrx(struct spi_device *spi,
 {
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
 	unsigned int chip_select = spi->chip_select;
-	u16 opcode = 0;
+	u16 opcode = 0, val;
 	const u8 *tx = t->tx_buf;
 	u8 *rx = t->rx_buf;
 	u32 reg = 0;
@@ -401,7 +401,8 @@ static int bcm63xx_hsspi_do_prepend_txrx(struct spi_device *spi,
 		memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN + bs->prepend_cnt, tx,
 			    t->len);
 
-	__raw_writew((u16)cpu_to_be16(opcode | t->len), bs->fifo);
+	*(__be16 *)(&val) = cpu_to_be16(opcode | t->len);
+	__raw_writew(val, bs->fifo);
 	/* enable interrupt */
 	if (bs->wait_mode == HSSPI_WAIT_MODE_INTR)
 		__raw_writel(HSSPI_PINGx_CMD_DONE(0), bs->regs + HSSPI_INT_MASK_REG);
@@ -468,7 +469,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
 	unsigned int chip_select = spi->chip_select;
-	u16 opcode = 0;
+	u16 opcode = 0, val;
 	int pending = t->len;
 	int step_size = HSSPI_BUFFER_LEN;
 	const u8 *tx = t->tx_buf;
@@ -511,7 +512,8 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 			tx += curr_step;
 		}
 
-		__raw_writew((u16)cpu_to_be16(opcode | curr_step), bs->fifo);
+		*(__be16 *)(&val) = cpu_to_be16(opcode | curr_step);
+		__raw_writew(val, bs->fifo);
 
 		/* enable interrupt */
 		if (bs->wait_mode == HSSPI_WAIT_MODE_INTR)
diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index d58033251c02..e255241319ab 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -252,7 +252,7 @@ static int bcmbca_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t,
 {
 	struct bcmbca_hsspi *bs = spi_master_get_devdata(spi->master);
 	unsigned int chip_select = spi->chip_select;
-	u16 opcode = 0;
+	u16 opcode = 0, val;
 	int pending = t->len;
 	int step_size = HSSPI_BUFFER_LEN;
 	const u8 *tx = t->tx_buf;
@@ -292,7 +292,9 @@ static int bcmbca_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t,
 			memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN, tx, curr_step);
 			tx += curr_step;
 		}
-		__raw_writew((u16)cpu_to_be16(opcode | curr_step), bs->fifo);
+
+		*(__be16 *)(&val) = cpu_to_be16(opcode | curr_step);
+		__raw_writew(val, bs->fifo);
 
 		/* enable interrupt */
 		if (bs->wait_mode == HSSPI_WAIT_MODE_INTR)
-- 
2.37.3

