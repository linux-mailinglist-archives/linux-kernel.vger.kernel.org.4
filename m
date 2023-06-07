Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B71725DFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbjFGMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjFGMIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:08:19 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921E1BD5;
        Wed,  7 Jun 2023 05:08:17 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686139695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zDOmdelsTF8Z6hYisJ6LU6CbovJMoLnJ7YdYJmDf1ok=;
        b=DBOeENL1aunjzqB9GnjIuX+NQpbFPAUgX9U+zqJRBmOJxQGc3aLUl/x4yyNnyA690SBdsT
        fam6eB4E74ikXWnKneFeZPBdZrRCANi7s9PH7c0FWqcZH0cHTe8CJz1RF01/C0CE2/R9VA
        1DNMpqioOz63xeQNMQ7bvPttk78uEDN4jFs27talQoWIv2XSz1mwGISQwhHHokvoI7V23v
        TzE+M1fHhUwA8RcIdjhwKAk/D0q4YnDxGjsWd70t4sYyrQsrQJPgqcp5X76RO/9E52rNUN
        b1PGPonop4DMBh2o4mt27FHFm7zQGDDg9b018BjLUdHqKPNf4HyVKITkegFcEQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CF07E0009;
        Wed,  7 Jun 2023 12:08:11 +0000 (UTC)
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
        Feiyang Chen <chenfeiyang@loongson.cn>
Subject: [PATCH net-next v4 0/5] Followup fixes for the dwmac and altera lynx conversion
Date:   Wed,  7 Jun 2023 15:59:36 +0200
Message-Id: <20230607135941.407054-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.40.1
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

Hello everyone,

Here's yet another version of the cleanup series for the TSE PCS replacement
by PCS Lynx. It includes Kconfig fixups, some missing initialisations
and a slight rework suggested by Russell for the dwmac cleanup sequence,
along with more explicit zeroing of local structures as per MAciej's
review.

V3->V4 :
 - Zero mdio_regmap_config objects
 - Make regmap config more local in dwmac_socfpga
V2->V3 :
 - Fix uninitialized .autoscan field for mdio regmap configuration in
   both altera_tse and dwmac_socfpga
V1->V2 : 
 - Fix a Kconfig inconsistency
 - rework the dwmac_socfpga cleanup sequence

Maxime Chevallier (5):
  net: altera-tse: Initialize local structs before using it
  net: altera_tse: Use the correct Kconfig option for the PCS_LYNX
    dependency
  net: stmmac: make the pcs_lynx cleanup sequence specific to
    dwmac_socfpga
  net: altera_tse: explicitly disable autoscan on the regmap-mdio bus
  net: dwmac_socfpga: initialize local data for mdio regmap
    configuration

 drivers/net/ethernet/altera/Kconfig           |  2 +-
 drivers/net/ethernet/altera/altera_tse_main.c |  3 ++
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 -
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 29 ++++++++++++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  3 --
 5 files changed, 26 insertions(+), 12 deletions(-)

-- 
2.40.1

