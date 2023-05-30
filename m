Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F4715A67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjE3JkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjE3JkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:40:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2769EA3;
        Tue, 30 May 2023 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685439599; x=1716975599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0m1WdlpCymQ4W+Yto3Q078jszfReeoWsXUkNYrYgCKc=;
  b=jJ6j2w9rHeyxhdn7eu7H6NoiAupU5tJh0SA63FT2b6+1JtrmTuhNmE1F
   DnjW2O1c8MJmOBkpkQBZ3p421+QgZ4ZiOFZ3UNcOx3zAwTPrilSWGHvfc
   yOLgMrgLj0OcWNFkUbjHa40ppcFdcS1VYqWUZ5y0/rguHqQNm9ARI4D1Q
   arN8lo4pcqS3RG+53OFKd2n8JpUUFlIA+IibGxrLZOXAEUEzFsRr99kf1
   7YWW2mr0Cd6elI8UZDywOntBhkjJYfRf9LNlEuUgodndeCNx31q/EjkY5
   KCa55zVXUPKVLnlWXrv9Bae0sJN9Bkn4xYx7U+G4WLqY8q4rLORq4wAlN
   A==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="217919005"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 02:39:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 02:39:51 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 02:39:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <luca.ceresoli@bootlin.com>, <nm@ti.com>, <kristo@kernel.org>,
        <ssantosh@kernel.org>, <michal.simek@xilinx.com>
CC:     <aford173@gmail.com>, <mike.looijmans@topic.nl>,
        <robert.hancock@calian.com>, <shawn.guo@linaro.org>,
        <fabio.estevam@freescale.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/8] clk: si5341: return error if one synth clock registration fails
Date:   Tue, 30 May 2023 12:39:08 +0300
Message-ID: <20230530093913.1656095-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530093913.1656095-1-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case devm_clk_hw_register() fails for one of synth clocks the probe
continues. Later on, when registering output clocks which have as parents
all the synth clocks, in case there is registration failure for at least
one synth clock the information passed to clk core for registering output
clock is not right: init.num_parents is fixed but init.parents may contain
an array with less parents.

Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk-si5341.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 0e528d7ba656..6dca3288c894 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1553,7 +1553,7 @@ static int si5341_probe(struct i2c_client *client)
 	struct clk_init_data init;
 	struct clk *input;
 	const char *root_clock_name;
-	const char *synth_clock_names[SI5341_NUM_SYNTH];
+	const char *synth_clock_names[SI5341_NUM_SYNTH] = { NULL };
 	int err;
 	unsigned int i;
 	struct clk_si5341_output_config config[SI5341_MAX_NUM_OUTPUTS];
@@ -1705,6 +1705,7 @@ static int si5341_probe(struct i2c_client *client)
 		if (err) {
 			dev_err(&client->dev,
 				"synth N%u registration failed\n", i);
+			goto free_clk_names;
 		}
 	}
 
@@ -1782,16 +1783,17 @@ static int si5341_probe(struct i2c_client *client)
 		goto cleanup;
 	}
 
+free_clk_names:
 	/* Free the names, clk framework makes copies */
 	for (i = 0; i < data->num_synth; ++i)
 		 devm_kfree(&client->dev, (void *)synth_clock_names[i]);
 
-	return 0;
-
 cleanup:
-	for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
-		if (data->clk[i].vddo_reg)
-			regulator_disable(data->clk[i].vddo_reg);
+	if (err) {
+		for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
+			if (data->clk[i].vddo_reg)
+				regulator_disable(data->clk[i].vddo_reg);
+		}
 	}
 	return err;
 }
-- 
2.34.1

