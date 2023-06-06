Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041F67245B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbjFFOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjFFOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:21:53 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619A5E78;
        Tue,  6 Jun 2023 07:21:52 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686061311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VThXr8NXS8rFWvl2CAIgnRHShKVVcGIlkBbj131gSq4=;
        b=KBZSce67wV7oZbGwh6FkegmgSjVTEZ+VfIHehNbLzs58XAQKjrV7g4U6pDBFAmbQoejj/3
        xWxFWDomkt+7vF8JvcBDQ6dhUrS9a4pVIMU1Sy3EzdyQpApeyozudKbOyNC7VXvj64w6jp
        c5U23wtx3uustnF1wuEYOiCUOyMgNHb/UB0viT+0gLUxO5RGslyP7ePYmfgn7QkyDwo5O+
        xiEV7kCStqhVYjoru+WqHAwPhgG+jCfIrn/yq2tMRDegIktqWrz0M30mLeNdSbyVKUuxxl
        PvJE+z/UjHjF2vbXCuHxAMy404VvcHiZr+34pEdJ8vcUmxtAi2jkgJ/CEZqYmQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EC4CC000C;
        Tue,  6 Jun 2023 14:21:48 +0000 (UTC)
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
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v2 1/3] net: altera-tse: Initialize the regmap_config struct before using it
Date:   Tue,  6 Jun 2023 16:21:42 +0200
Message-Id: <20230606142144.308675-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606142144.308675-1-maxime.chevallier@bootlin.com>
References: <20230606142144.308675-1-maxime.chevallier@bootlin.com>
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

The regmap_config needs to be zeroed before using it. This will cause
spurious errors at probe time as config->pad_bits is containing random
uninitialized data.

Fixes: db48abbaa18e ("net: ethernet: altera-tse: Convert to mdio-regmap and use PCS Lynx")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V1->V2: No change

 drivers/net/ethernet/altera/altera_tse_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index d866c0f1b503..df509abcd378 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1255,6 +1255,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_netdev;
 
+	memset(&pcs_regmap_cfg, 0, sizeof(pcs_regmap_cfg));
 	/* SGMII PCS address space. The location can vary depending on how the
 	 * IP is integrated. We can have a resource dedicated to it at a specific
 	 * address space, but if it's not the case, we fallback to the mdiophy0
-- 
2.40.1

