Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3018A745B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGCLl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGCLly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:41:54 -0400
X-Greylist: delayed 3563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 04:41:51 PDT
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D23B8;
        Mon,  3 Jul 2023 04:41:51 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 98D0D12007C;
        Mon,  3 Jul 2023 12:45:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 98D0D12007C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688377544;
        bh=3lcw8s3d3UvEPY8znRwUXKFvaGN7VtyRTZvrKJ6AFgc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=QXxQ1Ex6M909KtJa9/KMc4+bRPWJrfISoCi8l4QIy2NmuwB61FhWcw2UK75NvToUD
         uvXqMscaHOuypYBDEEgPelgHyL7dg9sCBEybi2c3m7pFqFSTOVP5mYWaaZSmqq+6xz
         uXWgSfntx10jKeLdUZagwrOKIBKtbMGSLMgtDxCrowD0jhhzss5YYrvx2dfzVRzuV4
         fbnfQCvi4hh+w4HEvKjlAdukmk1N1s+jhI20URByccXdUvijFZBsffMQtslGHyXC2M
         uu36EV7gBBwwKjM6X+qGf2TwrYtxm6Wk3mFOe+QWJ23+mL+F1WodaxneTX6bjs5Mfj
         eR3LqzmkIDB0g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  3 Jul 2023 12:45:43 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 3 Jul 2023 12:45:42 +0300
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1 1/2] spi: amlogic-spifc-a1: implement adjust_op_size()
Date:   Mon, 3 Jul 2023 12:45:17 +0300
Message-ID: <20230703094518.53755-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230703094518.53755-1-mmkurbanov@sberdevices.ru>
References: <20230703094518.53755-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178391 [Jul 03 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: MMKurbanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/03 07:50:00 #21557756
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enhancement eliminates the need for a loop in the
amlogic_spifc_a1_exec_op() function and allows the SPI core to
dynamically divide transactions into appropriately sized chunks.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/spi/spi-amlogic-spifc-a1.c | 64 +++++++++++-------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index 3c4224c38399..0c21917e4caf 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -240,61 +240,44 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
 {
 	struct amlogic_spifc_a1 *spifc =
 		spi_controller_get_devdata(mem->spi->controller);
-	size_t off, nbytes = op->data.nbytes;
-	u32 cmd_cfg, addr_cfg, dummy_cfg, dmode;
+	size_t data_size = op->data.nbytes;
 	int ret;
 
 	amlogic_spifc_a1_user_init(spifc);
+	amlogic_spifc_a1_set_cmd(spifc, SPIFC_A1_USER_CMD(op));
 
-	cmd_cfg = SPIFC_A1_USER_CMD(op);
-	amlogic_spifc_a1_set_cmd(spifc, cmd_cfg);
+	if (op->addr.nbytes)
+		amlogic_spifc_a1_set_addr(spifc, op->addr.val,
+					  SPIFC_A1_USER_ADDR(op));
 
-	if (op->addr.nbytes) {
-		addr_cfg = SPIFC_A1_USER_ADDR(op);
-		amlogic_spifc_a1_set_addr(spifc, op->addr.val, addr_cfg);
-	}
-
-	if (op->dummy.nbytes) {
-		dummy_cfg = SPIFC_A1_USER_DUMMY(op);
-		amlogic_spifc_a1_set_dummy(spifc, dummy_cfg);
-	}
-
-	if (!op->data.nbytes)
-		return amlogic_spifc_a1_request(spifc, false);
-
-	dmode = ilog2(op->data.buswidth);
-	off = 0;
-
-	do {
-		size_t block_size = min_t(size_t, nbytes, SPIFC_A1_BUFFER_SIZE);
-
-		amlogic_spifc_a1_set_cmd(spifc, cmd_cfg);
+	if (op->dummy.nbytes)
+		amlogic_spifc_a1_set_dummy(spifc, SPIFC_A1_USER_DUMMY(op));
 
-		if (op->addr.nbytes)
-			amlogic_spifc_a1_set_addr(spifc, op->addr.val + off,
-						  addr_cfg);
-
-		if (op->dummy.nbytes)
-			amlogic_spifc_a1_set_dummy(spifc, dummy_cfg);
+	if (!data_size) {
+		ret = amlogic_spifc_a1_request(spifc, false);
+	} else {
+		u32 mode = ilog2(op->data.buswidth);
 
 		writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
 
 		if (op->data.dir == SPI_MEM_DATA_IN)
-			ret = amlogic_spifc_a1_read(spifc,
-						    op->data.buf.in + off,
-						    block_size, dmode);
+			ret = amlogic_spifc_a1_read(spifc, op->data.buf.in,
+						    data_size, mode);
 		else
-			ret = amlogic_spifc_a1_write(spifc,
-						     op->data.buf.out + off,
-						     block_size, dmode);
-
-		nbytes -= block_size;
-		off += block_size;
-	} while (nbytes != 0 && !ret);
+			ret = amlogic_spifc_a1_write(spifc, op->data.buf.out,
+						     data_size, mode);
+	}
 
 	return ret;
 }
 
+static int amlogic_spifc_a1_adjust_op_size(struct spi_mem *mem,
+					   struct spi_mem_op *op)
+{
+	op->data.nbytes = min_t(u32, op->data.nbytes, SPIFC_A1_BUFFER_SIZE);
+	return 0;
+}
+
 static void amlogic_spifc_a1_hw_init(struct amlogic_spifc_a1 *spifc)
 {
 	u32 regv;
@@ -314,6 +297,7 @@ static void amlogic_spifc_a1_hw_init(struct amlogic_spifc_a1 *spifc)
 
 static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
 	.exec_op = amlogic_spifc_a1_exec_op,
+	.adjust_op_size = amlogic_spifc_a1_adjust_op_size,
 };
 
 static int amlogic_spifc_a1_probe(struct platform_device *pdev)
-- 
2.40.0

