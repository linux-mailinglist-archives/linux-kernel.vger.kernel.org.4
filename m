Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180FC5B7316
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiIMPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiIMO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:59:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1764F12759;
        Tue, 13 Sep 2022 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663079351; x=1694615351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4JmDRlnwM3eagYZBbdfsG68lq5CHJB8sXvup6gdh2I4=;
  b=eKW1ijCESRTFAMIuBia6+WP+IjEUjFZZdrVo6eQ5F4wBpG9aGcomwKzS
   LfzQ+vRc9tOoJgTkXDD6Eeps4DZO2oOD/ntqpPa7gPAddc4sNx/l2jZE3
   3LmVJ45Bf3BYM8zSfDDyMspcL7FpZv8JEZNURQQ7wu0xacKPkjIqMAl+I
   gMbsEH1nSfYByiezSq8cX4rbum9YtAppRF81QL4EbeYWgrAJgk8oIpuzU
   Z5frMqjb9U+eBHiDgmmWnxS/VHAKP0YF5Fa5ip39bFDlVg40vs5kw0HgI
   H1S1DUN7mvTS3jZCKDHgGKCbQAcuYL0cpqEeQZrH5ShcvA596hgkRg+GS
   w==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="180313694"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 07:25:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 07:25:53 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 07:25:48 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <sergiu.moga@microchip.com>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 13/14] clk: at91: sama5d2: Add Generic Clocks for UART/USART
Date:   Tue, 13 Sep 2022 17:22:05 +0300
Message-ID: <20220913142205.162399-14-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913142205.162399-1-sergiu.moga@microchip.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the generic clocks for UART/USART in the sama5d2 driver to allow them
to be registered in the Common Clock Framework.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---


v1 -> v2:
- Added R-b tag


v2 -> v3:
- Nothing


 drivers/clk/at91/sama5d2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index cfd0f5e23b99..84156dc52bff 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -120,6 +120,16 @@ static const struct {
 	struct clk_range r;
 	int chg_pid;
 } sama5d2_gck[] = {
+	{ .n = "flx0_gclk",   .id = 19, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "flx1_gclk",   .id = 20, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "flx2_gclk",   .id = 21, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "flx3_gclk",   .id = 22, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "flx4_gclk",   .id = 23, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart0_gclk",  .id = 24, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart1_gclk",  .id = 25, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart2_gclk",  .id = 26, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart3_gclk",  .id = 27, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart4_gclk",  .id = 28, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
 	{ .n = "sdmmc0_gclk", .id = 31, .chg_pid = INT_MIN, },
 	{ .n = "sdmmc1_gclk", .id = 32, .chg_pid = INT_MIN, },
 	{ .n = "tcb0_gclk",   .id = 35, .chg_pid = INT_MIN, .r = { .min = 0, .max = 83000000 }, },
-- 
2.34.1

