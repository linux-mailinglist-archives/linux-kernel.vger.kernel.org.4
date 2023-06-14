Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3350712132
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbjEZHfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbjEZHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:35:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725C0E51
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:35:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q2RyL-0005lZ-Dw; Fri, 26 May 2023 09:34:49 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q2RyJ-002u6l-7M; Fri, 26 May 2023 09:34:47 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q2RyI-002nuF-8Z; Fri, 26 May 2023 09:34:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: [PATCH net-next v2 4/5] net: dsa: microchip: ksz8: Prepare ksz8863_smi for regmap register access validation
Date:   Fri, 26 May 2023 09:34:44 +0200
Message-Id: <20230526073445.668430-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526073445.668430-1-o.rempel@pengutronix.de>
References: <20230526073445.668430-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares the ksz8863_smi part of ksz8 driver to utilize the
regmap register access validation feature.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz8863_smi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
index 2af807db0b45..fd6e2e69a42a 100644
--- a/drivers/net/dsa/microchip/ksz8863_smi.c
+++ b/drivers/net/dsa/microchip/ksz8863_smi.c
@@ -104,6 +104,7 @@ static const struct regmap_config ksz8863_regmap_config[] = {
 		.cache_type = REGCACHE_NONE,
 		.lock = ksz_regmap_lock,
 		.unlock = ksz_regmap_unlock,
+		.max_register = U8_MAX,
 	},
 	{
 		.name = "#16",
@@ -113,6 +114,7 @@ static const struct regmap_config ksz8863_regmap_config[] = {
 		.cache_type = REGCACHE_NONE,
 		.lock = ksz_regmap_lock,
 		.unlock = ksz_regmap_unlock,
+		.max_register = U8_MAX,
 	},
 	{
 		.name = "#32",
@@ -122,11 +124,14 @@ static const struct regmap_config ksz8863_regmap_config[] = {
 		.cache_type = REGCACHE_NONE,
 		.lock = ksz_regmap_lock,
 		.unlock = ksz_regmap_unlock,
+		.max_register = U8_MAX,
 	}
 };
 
 static int ksz8863_smi_probe(struct mdio_device *mdiodev)
 {
+	struct device *ddev = &mdiodev->dev;
+	const struct ksz_chip_data *chip;
 	struct regmap_config rc;
 	struct ksz_device *dev;
 	int ret;
@@ -136,9 +141,15 @@ static int ksz8863_smi_probe(struct mdio_device *mdiodev)
 	if (!dev)
 		return -ENOMEM;
 
+	chip = device_get_match_data(ddev);
+	if (!chip)
+		return -EINVAL;
+
 	for (i = 0; i < __KSZ_NUM_REGMAPS; i++) {
 		rc = ksz8863_regmap_config[i];
 		rc.lock_arg = &dev->regmap_mutex;
+		rc.wr_table = chip->wr_table;
+		rc.rd_table = chip->rd_table;
 		dev->regmap[i] = devm_regmap_init(&mdiodev->dev,
 						  &regmap_smi[i], dev,
 						  &rc);
-- 
2.39.2

