Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B171932E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjFAGZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFAGZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:25:27 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68EDD188;
        Wed, 31 May 2023 23:24:54 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(767:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 01 Jun 2023 14:24:38 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 1 Jun
 2023 14:24:37 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 1 Jun 2023 14:24:37 +0800
From:   <cy_huang@richtek.com>
To:     <sre@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <cy_huang@richtek.com>,
        <chiaen_wu@richtek.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: rt9467: Make charger-enable control as logic level
Date:   Thu, 1 Jun 2023 14:24:36 +0800
Message-ID: <1685600676-25124-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

The current coding make 'charger-enable-gpio' control as real hardware
level. This conflicts with the default binding example. For driver
behavior, no need to use real hardware level, just logic level is
enough. This change can make this flexibility keep in dts gpio active
level about this pin.

Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

  This change is from our customer. They use the default binding
example as the dts config. By default, this configurethe
charger-enable-gpio to real harware level high and disable battery charging
with external hardware pin.

The last patch I sent is to fix the binding example. But refer to the
discussion, the correct way is to change the gpio control coding as logic level,
not real hardware level.
https://lore.kernel.org/lkml/1685522813-14481-1-git-send-email-cy_huang@richtek.com/
---
 drivers/power/supply/rt9467-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index ea33693..b0b9ff8 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -1192,7 +1192,7 @@ static int rt9467_charger_probe(struct i2c_client *i2c)
 	i2c_set_clientdata(i2c, data);
 
 	/* Default pull charge enable gpio to make 'CHG_EN' by SW control only */
-	ceb_gpio = devm_gpiod_get_optional(dev, "charge-enable", GPIOD_OUT_LOW);
+	ceb_gpio = devm_gpiod_get_optional(dev, "charge-enable", GPIOD_OUT_HIGH);
 	if (IS_ERR(ceb_gpio))
 		return dev_err_probe(dev, PTR_ERR(ceb_gpio),
 				     "Failed to config charge enable gpio\n");
-- 
2.7.4

