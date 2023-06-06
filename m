Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0279B723BD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjFFIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbjFFIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:31:23 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66086170C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:30:24 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:a3e8:6562:a823:d832])
        by baptiste.telenet-ops.be with bizsmtp
        id 5kVL2A0121Tjf1k01kVLNE; Tue, 06 Jun 2023 10:29:36 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q6S48-004ISO-MB;
        Tue, 06 Jun 2023 10:29:20 +0200
Date:   Tue, 6 Jun 2023 10:29:20 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexis.lothore@bootlin.com,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
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
Subject: Re: [PATCH net-next 1/2] net: stmmac: Add PCS_LYNX as a dependency
 for the whole driver
In-Reply-To: <20230606064914.134945-2-maxime.chevallier@bootlin.com>
Message-ID: <889297a0-88c3-90df-7752-efa00184859@linux-m68k.org>
References: <20230606064914.134945-1-maxime.chevallier@bootlin.com> <20230606064914.134945-2-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Maxime,

On Tue, 6 Jun 2023, Maxime Chevallier wrote:
> Although pcs_lynx is only used on dwmac_socfpga for now, the cleanup
> path is in the generic driver, and triggers build issues for other
> stmmac variants. Make sure we build pcs_lynx in all cases too, as for
> XPCS.

That seems suboptimal to me, as it needlesly increases kernel size for
people who do not use dwmac_socfpga.  Hence I made an alternative patch:
https://lore.kernel/org/7b36ac43778b41831debd5c30b5b37d268512195.1686039915.git.geert+renesas@glider.be

> Fixes: 5d1f3fe7d2d5 ("net: stmmac: dwmac-sogfpga: use the lynx pcs driver")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> drivers/net/ethernet/stmicro/stmmac/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 5583f0b055ec..fa956f2081a5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -5,6 +5,7 @@ config STMMAC_ETH
> 	depends on PTP_1588_CLOCK_OPTIONAL
> 	select MII
> 	select PCS_XPCS
> +	select PCS_LYNX
> 	select PAGE_POOL
> 	select PHYLINK
> 	select CRC32
> @@ -160,7 +161,6 @@ config DWMAC_SOCFPGA
> 	select MFD_SYSCON
> 	select MDIO_REGMAP
> 	select REGMAP_MMIO
> -	select PCS_LYNX
> 	help
> 	  Support for ethernet controller on Altera SOCFPGA

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
