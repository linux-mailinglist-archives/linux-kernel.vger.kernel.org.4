Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF56745B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGCLl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCLly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:41:54 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5EEC;
        Mon,  3 Jul 2023 04:41:51 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id BEC651204F9;
        Mon,  3 Jul 2023 12:45:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BEC651204F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688377545;
        bh=wRrn6iFZ9wvY6EzviQOv3A+7Kxncor6/Mip9AQNivGs=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=qlJ8LqLVZI7V75BuBRdc2Ts/lhLBHonx/zyV9YbrVjgIRpk6XNJR6KF7wrHocIqyA
         8Pl6yyBTZRalMxo6FvHdAFMQl2a+r7uksM+RPs4WSvxUJFJrl7QxfOzTbc3zNNviHQ
         TLcV6T/DqNrgtuiBqjTDxYudWtc+peqNfXWw8QQDzyey6LvRaEMou5JIk6YbjRtWVc
         /GFkv9pjb3CXhCiSkh9L64BhYhLfYE9cxyklR2gkUuaomQgvEZtH3kBffB+wuLLArE
         lvB14BhyOagI3489Sg/6Sbsec/BzgSY2QPDHxCWDrvM8mMZHHKBnkk4UsaY74RQ9MI
         m5lSJQdS2jYDg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  3 Jul 2023 12:45:44 +0300 (MSK)
Received: from CAB-WSD-0004828.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 3 Jul 2023 12:45:43 +0300
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1 2/2] spi: amlogic-spifc-a1: add support for max_speed_hz
Date:   Mon, 3 Jul 2023 12:45:18 +0300
Message-ID: <20230703094518.53755-3-mmkurbanov@sberdevices.ru>
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

This patch sets the clock rate (spi_transfer->max_speed_hz) from the
amlogic_spifc_a1_exec_op().

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/spi/spi-amlogic-spifc-a1.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index 0c21917e4caf..7ef2a0448990 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -107,6 +107,7 @@ struct amlogic_spifc_a1 {
 	struct clk *clk;
 	struct device *dev;
 	void __iomem *base;
+	u32 curr_speed_hz;
 };
 
 static int amlogic_spifc_a1_request(struct amlogic_spifc_a1 *spifc, bool read)
@@ -235,6 +236,20 @@ static int amlogic_spifc_a1_write(struct amlogic_spifc_a1 *spifc,
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
+	if (!ret)
+		spifc->curr_speed_hz = freq;
+
+	return ret;
+}
+
 static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
 				    const struct spi_mem_op *op)
 {
@@ -243,6 +258,10 @@ static int amlogic_spifc_a1_exec_op(struct spi_mem *mem,
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

