Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BAD725E08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbjFGMJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbjFGMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:08:29 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6631BEC;
        Wed,  7 Jun 2023 05:08:26 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686139705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uyF72a3yG09hh6hXJngvth5hjG1EY+SZikMQwCrSeCE=;
        b=huXraDsyHY5vwwdJ758i946FKjTZly9LWnpqdFKWI59jRDcb4XV+YLW4DqNnMHVC9j6Eu1
        oLrDJxgO4yNM+6oVAGE3SqrBHk9auWZ0AiTtAW73Zn9zhFUVajpRC/X+r3GOp3EZ9TlKUu
        2SI+f7nhE/mG770tZPrjx9aQXY0PJni611+6fCNXhjaN01DKEpP3aYhMNZU1I5TIvb7Fbr
        Cp1D8ySobPvwcGzAwxfZ2hys9wct9oheuA6pTGi2/LiLWaKUvjo8y3kONxOyPZolkshpsA
        FfylY6p2SBQ/JnekYg+HYknX9PaVm8vcztBsKFOzCX0qymn9U4SvN9I2xk21rQ==
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52693E000F;
        Wed,  7 Jun 2023 12:08:23 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Simon Horman <simon.horman@corigine.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next v4 4/5] net: altera_tse: explicitly disable autoscan on the regmap-mdio bus
Date:   Wed,  7 Jun 2023 15:59:40 +0200
Message-Id: <20230607135941.407054-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607135941.407054-1-maxime.chevallier@bootlin.com>
References: <20230607135941.407054-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the .autoscan flag to false on the regmap-mdio bus, to avoid using a
random uninitialized value. We don't want autoscan in this case as the
mdio device is a PCS and not a PHY.

Fixes: db48abbaa18e ("net: ethernet: altera-tse: Convert to mdio-regmap and use PCS Lynx")
Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3->V4 : No changes
V2->V3 : New patch

 drivers/net/ethernet/altera/altera_tse_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 215f9fb89c5b..2e15800e5310 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1288,6 +1288,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 	mrc.regmap = pcs_regmap;
 	mrc.parent = &pdev->dev;
 	mrc.valid_addr = 0x0;
+	mrc.autoscan = false;
 
 	/* Rx IRQ */
 	priv->rx_irq = platform_get_irq_byname(pdev, "rx_irq");
-- 
2.40.1

