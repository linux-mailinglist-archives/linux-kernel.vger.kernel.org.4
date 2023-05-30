Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE57715A77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjE3JlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjE3Jkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:40:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC36EA;
        Tue, 30 May 2023 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685439622; x=1716975622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nxrrZgHgB/r7B5X5lLa7hKpzs6DxYZu4C3x1MeJ23Yc=;
  b=e2j1C+8Ovonc0fF0beuVcwoAhChnhp4Y4A9XXCyUpyTQulZZTu7LnCDN
   lGfPcC8RAiHMLIv2gZyPiT7k/NqzPHhf6Odq9qBDigGBUP+Flzd+XsdN2
   F3VEztRfallxTK5GRngQ09VK35JbqtKoHHpjdjsljFz7RGD4X+W32fSwt
   c4bQUPHxcxPW0tqiugI//VypOkaDzHmJD0jlGDg7wfBIR2Ucu73AXoeFm
   CZ9yo7VpH9aeT3ansNd+rffjc8BzTGZGmkOIFYZgV0jDyCxKqBMBhFl2b
   hBDAlNBDh6453W5y53Awt5grcJ68DLwQcKDfgC84QUdob00BF461Ctwxv
   w==;
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="213686540"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 02:40:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 02:40:10 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 30 May 2023 02:40:06 -0700
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
Subject: [PATCH 7/8] clk: ti: clkctrl: check return value of kasprintf()
Date:   Tue, 30 May 2023 12:39:12 +0300
Message-ID: <20230530093913.1656095-8-claudiu.beznea@microchip.com>
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

kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: 852049594b9a ("clk: ti: clkctrl: convert subclocks to use proper names also")
Fixes: 6c3090520554 ("clk: ti: clkctrl: Fix hidden dependency to node name")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/ti/clkctrl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index b6fce916967c..8c40f10280b7 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -258,6 +258,9 @@ static const char * __init clkctrl_get_clock_name(struct device_node *np,
 	if (clkctrl_name && !legacy_naming) {
 		clock_name = kasprintf(GFP_KERNEL, "%s-clkctrl:%04x:%d",
 				       clkctrl_name, offset, index);
+		if (!clock_name)
+			return NULL;
+
 		strreplace(clock_name, '_', '-');
 
 		return clock_name;
@@ -586,6 +589,10 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	if (clkctrl_name) {
 		provider->clkdm_name = kasprintf(GFP_KERNEL,
 						 "%s_clkdm", clkctrl_name);
+		if (!provider->clkdm_name) {
+			kfree(provider);
+			return;
+		}
 		goto clkdm_found;
 	}
 
-- 
2.34.1

