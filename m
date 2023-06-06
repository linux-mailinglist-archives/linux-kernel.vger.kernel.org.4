Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2693E723BBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjFFI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbjFFI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:28:46 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9BA1BC7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:27:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:a3e8:6562:a823:d832])
        by laurent.telenet-ops.be with bizsmtp
        id 5kT42A00H1Tjf1k01kT4vb; Tue, 06 Jun 2023 10:27:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q6S1b-004GxN-Ly;
        Tue, 06 Jun 2023 10:27:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q6S1w-00Awvw-EK;
        Tue, 06 Jun 2023 10:27:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] net: stmmac: Fix build without PCS_LYNX
Date:   Tue,  6 Jun 2023 10:27:01 +0200
Message-Id: <7b36ac43778b41831debd5c30b5b37d268512195.1686039915.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If STMMAC_ETH=y, but PCS_LYNX=n (e.g. shmobile_defconfig):

    arm-linux-gnueabihf-ld: drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o: in function `stmmac_mdio_unregister':
    stmmac_mdio.c:(.text+0xfbc): undefined reference to `lynx_pcs_destroy'

As pcs_lynx is used only on dwmac_socfpga, fix this by adding a check
for PCS_LYNX to the cleanup path in the generic driver.

Fixes: 5d1f3fe7d2d54d04 ("net: stmmac: dwmac-sogfpga: use the lynx pcs driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index c784a6731f08e108..53ed59d732210814 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -665,7 +665,7 @@ int stmmac_mdio_unregister(struct net_device *ndev)
 	if (priv->hw->xpcs)
 		xpcs_destroy(priv->hw->xpcs);
 
-	if (priv->hw->lynx_pcs)
+	if (IS_ENABLED(CONFIG_PCS_LYNX) && priv->hw->lynx_pcs)
 		lynx_pcs_destroy(priv->hw->lynx_pcs);
 
 	mdiobus_unregister(priv->mii);
-- 
2.34.1

