Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF9749A30
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGFLEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjGFLD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:03:58 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C034CDC;
        Thu,  6 Jul 2023 04:03:54 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7A45F120088;
        Thu,  6 Jul 2023 14:03:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7A45F120088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688641431;
        bh=UVco8VzyFBkwCrFbrNr3zvNQFq8LFyScUlUs8ACcKXA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=p2YlJ6Aoa0sC+8Cgcts6rpg87g+FtFo/BR1u5OqQKiR2BFZyjwFVZjN4hnMPPL9nv
         LSNuQMnYdsvV5QvxJvhl+nVpB+xa4VJ7BfEPunOQLRXYWuhJqUaxQ13GGSLTipRRMO
         RZzYQIFFIftzSrPZS+U6LwZ4s6XvNbV8xiuCd68603XbOFMp7f7Bl/8BK4lg15aMF3
         58LZ1oIRdh4Cqj2tPmtbVumscRe4ieYNIRqJdtJpVBB/jYhF72Lg17AMK74Qw7m+Nu
         sq7aKCZeRUxO81SEI2926sJCAR1ByxQrAfdmW0HFrDwLrwHIYsnqgPI8ghQmA33KG3
         vvCCqug0aiIQg==
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
Subject: [PATCH v2 2/2] spi: amlogic-spifc-a1: add support for max_speed_hz
Date:   Thu, 6 Jul 2023 14:03:31 +0300
Message-ID: <20230706110331.19794-3-mmkurbanov@sberdevices.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
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

This patch sets the clock rate (spi_transfer->max_speed_hz) from the
amlogic_spifc_a1_exec_op().

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/spi/spi-amlogic-spifc-a1.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index a92e4fc23396..605e9e40455c 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -107,6 +107,7 @@ struct amlogic_spifc_a1 {
 	struct clk *clk;
 	struct device *dev;
 	void __iomem *base;
+	u32 curr_speed_hz;
 };
 
 static int amlogic_spifc_a1_request(struct amlogic_spifc_a1 *spifc, bool read)
@@ -235,6 +236,21 @@ static int amlogic_spifc_a1_write(struct amlogic_spifc_a1 *spifc,
 	return amlogic_spifc_a1_request(spifc, false);
 }
 
+static int amlogic_spifc_a1_set_freq(struct amlogic_spifc_a1 *spifc, u32 freq)
+{
+	int ret;
+
+	if (freq == spifc->curr_speed_hz)
+		return 0;
+
+	ret = clk_set_rate(spifc->clk, freq);
+	if (ret)
+		return ret;
+
+	spifc->curr_speed_hz = freq;
+	return 0;
+}
+
 static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
 				    const struct spi_mem_op *op)
 {
@@ -243,6 +259,10 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
 	size_t data_size = op->data.nbytes;
 	int ret;
 
+	ret = amlogic_spifc_a1_set_freq(spifc, mem->spi->max_speed_hz);
+	if (ret)
+		return ret;
+
 	amlogic_spifc_a1_user_init(spifc);
 	amlogic_spifc_a1_set_cmd(spifc, SPIFC_A1_USER_CMD(op));
 
-- 
2.40.0

