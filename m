Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E029565A8A5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 03:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjAACmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 21:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAACmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 21:42:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281F2BE2;
        Sat, 31 Dec 2022 18:42:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86C99B8095A;
        Sun,  1 Jan 2023 02:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2CDC433EF;
        Sun,  1 Jan 2023 02:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672540948;
        bh=qspE9MzGgz3oAvmnfeccSq6EP7mLLKALL1ZRK9gU2yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvvPsoYcShCMP8bE1zMEOWRLNE2qX5PHs9JrJy6gREDguKLXOhx834BcUH2ksoyBs
         Y0U3O4wauVtsr/kMh0nFm1o7bVFDfeKYbK0HtA1Zt3P1grpovpgYPeNmbKJUICi6ug
         LCs3fqsUR42th/8m2D2msFZDygxJPqe4G0p7+cJkxYHYmH80bxELd3FGUQPu8tnxIX
         EIwbnt3lrVAfafM5sf3VjtCE3ghVFCs+s2QSAa/yI45v1XdO+V/VOah3pBTvnF5qTa
         BnoLLtJdUDc5b1/Gj0HS8CYpENC2oGYLJkf4dMxegJ1hVq/fgPbNoEgImMyyx8jDej
         ODseAZcTrDF+Q==
Date:   Sun, 1 Jan 2023 10:42:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     wei.fang@nxp.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Frank.Li@nxp.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8dxl: Disable hibernation mode of
 AR8031 for EQOS
Message-ID: <20230101024220.GM6112@T480>
References: <20221216011434.967813-1-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216011434.967813-1-wei.fang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 09:14:34AM +0800, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The hibernation mode of AR8031 PHY defaults to be enabled after hardware
> reset. When the cable is unplugged, the PHY will enter hibernation mode
> after about 10 senconds and the PHY clocks will be stopped to save
> power. However, due to the design of EQOS, the mac needs the RX_CLK of
> PHY for software reset to complete. Otherwise the software reset of EQOS
> will be failed and do not work correctly. The only way is to disable
> hibernation mode of AR8031 PHY for EQOS, the "qca,disable-hibernation-mode"
> property is used for this purpose and has already been submitted to the
> upstream, for more details please refer to the below link:
> https://lore.kernel.org/netdev/20220818030054.1010660-2-wei.fang@nxp.com/
> 
> This issue is easy to reproduce, just unplug the cable and "ifconfig eth0
> down", after about 10 senconds, then "ifconfig eth0 up", you will see
> failure log on the serial port. The log is shown as following:
> root@imx8dxlevk:~#
> [34.941970] imx-dwmac 5b050000.ethernet eth0: Link is Down
> root@imx8dxlevk:~# ifconfig eth0 down
> [35.437814] imx-dwmac 5b050000.ethernet eth0: FPE workqueue stop
> [35.507913] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
> [35.518613] imx-dwmac 5b050000.ethernet eth0: configuring for phy/rgmii-id link mode
> root@imx8dxlevk:~# ifconfig eth0 up
> [71.143044] imx-dwmac 5b050000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> [71.215855] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
> [72.230417] imx-dwmac 5b050000.ethernet: Failed to reset the dma
> [72.236512] imx-dwmac 5b050000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
> [72.245258] imx-dwmac 5b050000.ethernet eth0: __stmmac_open: Hw setup failed
> SIOCSIFFLAGS: Connection timed out
> 
> After applying this patch, the software reset of EQOS will be
> successful. And the log is shown as below.
> root@imx8dxlevk:~# ifconfig eth0 up
> [96.114344] imx-dwmac 5b050000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> [96.171466] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
> [96.188883] imx-dwmac 5b050000.ethernet eth0: No Safety Features support found
> [96.196221] imx-dwmac 5b050000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
> [96.204846] imx-dwmac 5b050000.ethernet eth0: registered PTP clock
> [96.225558] imx-dwmac 5b050000.ethernet eth0: FPE workqueue start
> [96.236858] imx-dwmac 5b050000.ethernet eth0: configuring for phy/rgmii-id link mode
> [96.249358] 8021q: adding VLAN 0 to HW filter on device eth0
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>

I updated the subject prefix like below to make it clear this is
an imx8dxl-evk board change.

  arm64: dts: imx8dxl-evk: ...

Applied, thanks!

Shawn
