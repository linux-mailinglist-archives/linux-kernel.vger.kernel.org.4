Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC897261C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjFGN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjFGN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15FF1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD6E6355A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859C2C433EF;
        Wed,  7 Jun 2023 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686146206;
        bh=bZhwvYa05FtutRjZRtFZn41GMyv24CmHT6uPZylAuVU=;
        h=From:To:Cc:Subject:Date:From;
        b=D5AMwlgUa9w6w4Pupuocx+TfI7PB91MRhjSx1a/NTAWH2kYakHlyb8Wz01rVyXZw2
         Bx3Uxhdn0DKDTqQ2E2EfADvNY5pzcZ5SafvK1uD/F9fD6G14UKXStVvRw//yGP1t6r
         E5hsecjdLS5j2uE51Xn02etZUibWI6tQvaeu98SF/i8i5R4BFye1/V1LoJz9slB+PB
         5NzmkaqlVkdUIxz90gI7Scg/AX8lR8zIKkifGtCf5dQ7DKGUBdZMMnulBnpfsYgW1X
         krsJQiXhaLLxRGvjMa8U+E10R3cSRLSDvxRhWu0PrSQ4ZJDuarPJp3s6lwx2ac1UPH
         GlroLJmvOsgFA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bhadram Varka <vbhadram@nvidia.com>,
        Samin Guo <samin.guo@starfivetech.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] stmmac: fix pcs_lynx link failure
Date:   Wed,  7 Jun 2023 15:56:32 +0200
Message-Id: <20230607135638.1341101-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The mdio code in stmmac now directly links into both the lynx_pcs and
the xpcs device drivers, but the lynx_pcs dependency is only enforced
for the altera variant of stmmac, which is the one that actually uses it.

Building stmmac for a non-altera platform therefore causes a link
failure:

arm-linux-gnueabi-ld: drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o: in function `stmmac_mdio_unregister':
stmmac_mdio.c:(.text+0x1418): undefined reference to `lynx_pcs_destroy'

I've tried to come up with a patch that moves this dependency back into
the dwmac-socfpga.c file, but there was no easy and obvious way to
do this. It also seems that this would not be a proper solution, but
instead there should be a real abstraction for pcs drivers that lets
device drivers handle this transparently.

As the lynx_pcs driver is tiny, it appears that we can just avoid the
link error by always forcing it to be built when the stmmac driver
is, even for non-altera platforms. This matches what we already do
for the xpcs variant that is used by the intel and tegra variants of
stmmac.

Fixes: 5d1f3fe7d2d54 ("net: stmmac: dwmac-sogfpga: use the lynx pcs driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 5583f0b055ec7..fa956f2081a53 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -5,6 +5,7 @@ config STMMAC_ETH
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select MII
 	select PCS_XPCS
+	select PCS_LYNX
 	select PAGE_POOL
 	select PHYLINK
 	select CRC32
@@ -160,7 +161,6 @@ config DWMAC_SOCFPGA
 	select MFD_SYSCON
 	select MDIO_REGMAP
 	select REGMAP_MMIO
-	select PCS_LYNX
 	help
 	  Support for ethernet controller on Altera SOCFPGA
 
-- 
2.39.2

