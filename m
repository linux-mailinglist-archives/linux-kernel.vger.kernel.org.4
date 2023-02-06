Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8822068C7BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBFUh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjBFUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:37:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFFC30F4;
        Mon,  6 Feb 2023 12:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675715871; x=1707251871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CS/vfAX5/Ot+oMAZ0EEUA8Xr6RUbaTmuRhID/hDbHrM=;
  b=V29em4zNrFSFOAk9yoacmCcL6xfq8/rLV1lLmjCGpjvzKEOUmaX0/Kks
   jECCO30dUY+MglF9uy+Ft9ivVQKUsUwFbu/VdQN59zA9D+x0yzhgm4yZr
   9NzOHAWnoRoaX7+yuvTqgUoR8PtQj4Tsh4MBXHb1zyrKu+TGqZXi2q8lG
   LMuNdGKauh739zINhKJLqXfU93is0OKZT0N0v3u+MCIltw4YpvcyiWk5P
   PWYd4UWKVb+bbMVFPNGmzOvBh+acLFODdxc3VhTrOtwZTAB73ivo2UoyY
   48WK3qui38uTaLPKSHDjn/5O5YFLVGdDh+YLaC2GuVh/QcTmGE6F684E7
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669100400"; 
   d="scan'208";a="199188691"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2023 13:37:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 13:37:48 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 13:37:46 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>,
        <andy.shevchenko@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] pinctrl: ocelot: Fix alt mode for ocelot
Date:   Mon, 6 Feb 2023 21:37:20 +0100
Message-ID: <20230206203720.1177718-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.38.0
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

In case the driver was trying to set an alternate mode for gpio
0 or 32 then the mode was not set correctly. The reason is that
there is computation error inside the function ocelot_pinmux_set_mux
because in this case it was trying to shift to left by -1.
Fix this by actually shifting the function bits and not the position.

Fixes: 4b36082e2e09 ("pinctrl: ocelot: fix pinmuxing for pins after 31")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 29e4a6282a641..1dcbd0937ef5a 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1204,7 +1204,7 @@ static int ocelot_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	regmap_update_bits(info->map, REG_ALT(0, info, pin->pin),
 			   BIT(p), f << p);
 	regmap_update_bits(info->map, REG_ALT(1, info, pin->pin),
-			   BIT(p), f << (p - 1));
+			   BIT(p), (f >> 1) << p);
 
 	return 0;
 }
-- 
2.38.0

