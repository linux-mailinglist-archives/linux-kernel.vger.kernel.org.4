Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F5715A69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjE3JkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjE3JkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:40:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A3F0;
        Tue, 30 May 2023 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685439602; x=1716975602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eULxRW5HiZYtKwH0qN2snrG4MCmtG1cxN6q/9u0F8p4=;
  b=hTVqjvR2ukbezJJIEWi+nYafV2tQY+O1RpAM+3xlyv+EGbNUWAe7p2t2
   pEb2b/7hZxzCpA2XYIFYAhvisg25zfAfBTi3Uaq7Bgv0YMbj/rtSypSYv
   PrpQOM5z/OLM1C3bozAR4NoovylJYfHtqs1p/ZoKqqlol1YjHQ0p2QiK1
   YOvWgmYY/NAG+yClDO5Y+ntB/WIvCVuAf9AOaDBMlZJEBNxGx0rFuv1ff
   8ow1kEzkLNem3sQDxM2gdAh/XTVjLRVbjo7MwKOZOQuqgBes1tpKVBxnn
   NayLh6rz3wOCKASCrhODe+ZbHHK9FIQKLO78HRxfZ+DrniGQcYy4yuYmz
   w==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="227558620"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 02:40:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 02:40:01 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 02:39:57 -0700
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
Subject: [PATCH 5/8] clk: si5341: free unused memory on probe failure
Date:   Tue, 30 May 2023 12:39:10 +0300
Message-ID: <20230530093913.1656095-6-claudiu.beznea@microchip.com>
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

Pointers from synth_clock_names[] should be freed at the end of probe
either on probe success or failure path.

Fixes: b7bbf6ec4940 ("clk: si5341: Allow different output VDD_SEL values")
Fixes: 9b13ff4340df ("clk: si5341: Add sysfs properties to allow checking/resetting device faults")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/clk-si5341.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index b2cf7edc8b30..c7d8cbd22bac 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1744,7 +1744,7 @@ static int si5341_probe(struct i2c_client *client)
 		if (err) {
 			dev_err(&client->dev,
 				"output %u registration failed\n", i);
-			goto cleanup;
+			goto free_clk_names;
 		}
 		if (config[i].always_on)
 			clk_prepare(data->clk[i].hw.clk);
@@ -1754,7 +1754,7 @@ static int si5341_probe(struct i2c_client *client)
 			data);
 	if (err) {
 		dev_err(&client->dev, "unable to add clk provider\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	if (initialization_required) {
@@ -1762,11 +1762,11 @@ static int si5341_probe(struct i2c_client *client)
 		regcache_cache_only(data->regmap, false);
 		err = regcache_sync(data->regmap);
 		if (err < 0)
-			goto cleanup;
+			goto free_clk_names;
 
 		err = si5341_finalize_defaults(data);
 		if (err < 0)
-			goto cleanup;
+			goto free_clk_names;
 	}
 
 	/* wait for device to report input clock present and PLL lock */
@@ -1775,21 +1775,19 @@ static int si5341_probe(struct i2c_client *client)
 	       10000, 250000);
 	if (err) {
 		dev_err(&client->dev, "Error waiting for input clock or PLL lock\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	/* clear sticky alarm bits from initialization */
 	err = regmap_write(data->regmap, SI5341_STATUS_STICKY, 0);
 	if (err) {
 		dev_err(&client->dev, "unable to clear sticky status\n");
-		goto cleanup;
+		goto free_clk_names;
 	}
 
 	err = sysfs_create_files(&client->dev.kobj, si5341_attributes);
-	if (err) {
+	if (err)
 		dev_err(&client->dev, "unable to create sysfs files\n");
-		goto cleanup;
-	}
 
 free_clk_names:
 	/* Free the names, clk framework makes copies */
-- 
2.34.1

