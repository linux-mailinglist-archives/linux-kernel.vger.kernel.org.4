Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168B972479A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbjFFPZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjFFPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:25:10 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB18E42;
        Tue,  6 Jun 2023 08:25:08 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686065106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Iit6gZbgWQgXudNIuixMsiN76MK5PGWY3YFp5VdyDpA=;
        b=XeGZwldPR2714FTtaZenBKRtzxVmV+mtS7QhTam1rdaeSpRJwNJltf2ZkFBbdw9wWYGxLB
        dlz4hHwdzyP9jJemIpgR3dkXsqwH4YSBg7nvg0nH+j72C2mqlWEDGnnImWs6GAbuzmvhyu
        /Bpb20Hp9KXqKAlO0ryQvJ8iyj36N3luZwTkk+olYpfRwm0KuDjT2E8MzKo/PPCA6qOgEI
        Tz8Qol51MpUTm3lU9d/bHdN08hEQLP42SVy28A17sxxr75NhTmmVtfIRXAK2xNEWehIQtg
        FTjPzLEfI/n92wEpZ95/A6GerR/5BuRJBhNK/tfQXlQYQ5yNaMgBMuo4oZbR+w==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D60BFF80F;
        Tue,  6 Jun 2023 15:25:02 +0000 (UTC)
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
Subject: [PATCH net-next v3 0/5] Followup fixes for the dwmac and altera lynx conversion
Date:   Tue,  6 Jun 2023 17:24:56 +0200
Message-Id: <20230606152501.328789-1-maxime.chevallier@bootlin.com>
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

Here's another version of the cleanup series for the TSE PCS replacement
by PCS Lynx. It includes Kconfig fixups, some missing initialisations
and a slight rework suggested by Russell for the dwmac cleanup sequence.

V2->V3 :
 - Fix uninitialized .autoscan field for mdio regmap configuration in
   both altera_tse and dwmac_socfpga
V1->V2 : 
 - Fix a Kconfig inconsistency
 - rework the dwmac_socfpga cleanup sequence

Maxime Chevallier (5):
  net: altera-tse: Initialize the regmap_config struct before using it
  net: altera_tse: Use the correct Kconfig option for the PCS_LYNX
    dependency
  net: stmmac: make the pcs_lynx cleanup sequence specific to
    dwmac_socfpga
  net: altera_tse: explicitly disable autoscan on the regmap-mdio bus
  net: dwmac_socfpga: explicitly disable autoscan on the regmap-mdio bus

 drivers/net/ethernet/altera/Kconfig               |  2 +-
 drivers/net/ethernet/altera/altera_tse_main.c     |  2 ++
 drivers/net/ethernet/stmicro/stmmac/common.h      |  1 -
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c   | 15 ++++++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  3 ---
 5 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.40.1

