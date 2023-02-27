Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060536A3FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjB0LCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjB0LCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:02:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9978B20D22;
        Mon, 27 Feb 2023 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677495718; x=1709031718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DCAwh44v3dpEcmwP85zem/AILU4rZ+BTE1TOGKnxNQw=;
  b=m9hlkbOwn0bhcxRakY8duxyoOuOMcJqILhX/Jk5TixIAvD6QuuGENiBb
   yUUZaiEC4qcTrUcA46gyyBfiLHtkhcLLDPmkCnD1j9rbKwzjpu6o1mALl
   rk6EwR0mp6ZuB5oMtnyrDd7uyjs2MrbDNcxo6+OftqrB+cvimQFgAxhCT
   TOU8DSmiGZQGDNckz3qszzeVX7H+DDtblAixozbnXEXZKYqBuoiI/SjR8
   FMMUNPY/xX7F2ChA373iUZn38uDS/ZldHWvWFC7Dm7zD6YAqnY8Qw1ie2
   OFP7jAsZNu6bJwXv+yDXmDlAssn/sbnPV8WsMi6MoJkXJuPLh87ZWIBgB
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,331,1669100400"; 
   d="scan'208";a="202692672"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 03:59:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 03:59:40 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 03:59:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] clk: at91: clk-sam9x60-pll: fix return value check
Date:   Mon, 27 Feb 2023 12:59:31 +0200
Message-ID: <20230227105931.2812412-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sam9x60_frac_pll_compute_mul_frac() can't return zero. Remove the check
against zero to reflect this.

Fixes: 43b1bb4a9b3e ("clk: at91: clk-sam9x60-pll: re-factor to support plls with multiple outputs")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index d757003004cb..0882ed01d5c2 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -668,7 +668,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 
 		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core, FCORE_MIN,
 							parent_rate, true);
-		if (ret <= 0) {
+		if (ret < 0) {
 			hw = ERR_PTR(ret);
 			goto free;
 		}
-- 
2.34.1

