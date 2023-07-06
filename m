Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C072749A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjGFLEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGFLD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:03:58 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C053E102;
        Thu,  6 Jul 2023 04:03:54 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 55462100094;
        Thu,  6 Jul 2023 14:03:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 55462100094
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688641431;
        bh=SGIJBC0n19GmJT9M+H1cDdnLT3K7y9Ikj99S/1SgLyM=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=a2amjQQB5xlF0NF498q+9dtnraXBrsSqUur2f3if+dIP3ljXyEDUvnXewRtvcRLTZ
         wFihdOfIC4y+7pDKQGNqFsrV57brF2Pj50Anrnh4LPcpQlupvqr2Lrotku5qcVq7K0
         mfQ3hTguCZn6wnJysWncf3B4CFxGdnA9Tn/Vodm93XQmoBiVsc5PG5rCZoSF3Ci6au
         uA+TpEKxm1BBO/gv0I5PlVp+KAbo37TQjE8u9WK08fJaZd20z7AN22LEqfWIzKCCmd
         m3tsFxLjwkHjz+u6ARYbf1uA1u1VH0hvtbH1kT1NaCGS1lqJaMlWUZjoJve1uScLXC
         cyR4BXv7eP9sA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu,  6 Jul 2023 14:03:51 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 14:03:43 +0300
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v2 1/2] spi: amlogic-spifc-a1: implement adjust_op_size()
Date:   Thu, 6 Jul 2023 14:03:30 +0300
Message-ID: <20230706110331.19794-2-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
References: <20230706110331.19794-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178468 [Jul 06 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: MMKurbanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/05 14:57:00 #21566867
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
 drivers/spi/spi-amlogic-spifc-a1.c | 66 +++++++++++-------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index 3c4224c38399..a92e4fc23396 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -72,7 +72,7 @@
 
 #define SPIFC_A1_USER_DBUF_ADDR_REG	0x248
 
-#define SPIFC_A1_BUFFER_SIZE		512
+#define SPIFC_A1_BUFFER_SIZE		512U
 
 #define SPIFC_A1_MAX_HZ			200000000
 #define SPIFC_A1_MIN_HZ			1000000
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
+	if (data_size) {
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
+	} else {
+		ret = amlogic_spifc_a1_request(spifc, false);
+	}
 
 	return ret;
 }
 
+static int amlogic_spifc_a1_adjust_op_size(struct spi_mem *mem,
+					   struct spi_mem_op *op)
+{
+	op->data.nbytes = min(op->data.nbytes, SPIFC_A1_BUFFER_SIZE);
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

