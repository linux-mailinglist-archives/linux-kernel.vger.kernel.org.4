Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CBC72170A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjFDMuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:50:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694DAAB;
        Sun,  4 Jun 2023 05:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F018D614AB;
        Sun,  4 Jun 2023 12:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2F9C433EF;
        Sun,  4 Jun 2023 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883013;
        bh=st6rITNeMkA28xYwqynrWkwTwwzdBr6+2EomXGWAPSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbhxItIgU/jVbU7GQSr7P+Q6HQWm5kachurpeydFjzaklQKOe9vntZ//5Irpl0Vk+
         LSXcs6o2EsrdOAxe/TJ4HspcIukFEk+98O3mYrmxxZLiPkQlQn/lz4yIOOIWbWTRKl
         ERbQfxmCN9LwHV7Y8C8JflOjSjYSDQGKl7afXvnpizQVOcc3aNmvTQBUH2fmSIixnq
         03T0j48clRqylxk0eHCvxXTNcFaJ3xtMyRNsBi3JtHHQiCSoRPwnbFrtE6NLf+Rcg2
         T5x+0L3VId4q6MNl1OVJs7ouIQ4q4UGVi1zshV68urpl15Ghf4AS4cJqkj3h2xugPo
         QjXcXp8+1NoxA==
Date:   Sun, 4 Jun 2023 20:49:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som: add 20ms delay to ethernet
 regulator enable
Message-ID: <20230604124947.GL4199@dragon>
References: <20230529193311.1033939-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529193311.1033939-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:33:12PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> This commit is taken from Variscite linux kernel public git repository.
> Original patch author: Nate Drude <nate.d@variscite.com>
> See: https://github.com/varigit/linux-imx/blob/5.15-2.0.x-imx_var01/drivers/net/ethernet/freescale/fec_main.c#L3993-L4050
> 
> The ethernet phy reset was moved from the fec controller to the
> mdio bus, see for example: 0e825b32c033e1998d0ebaf247f5dab3c340e3bf
> 
> When the fec driver managed the reset, the regulator had time to
> settle during the fec phy reset before calling of_mdiobus_register,
> which probes the mii bus for the phy id to match the correct driver.
> 
> Now that the mdio bus controls the reset, the fec driver no longer has
> any delay between enabling the regulator and calling of_mdiobus_register.
> If the regulator voltage has not settled, the phy id will not be read
> correctly and the generic phy driver will be used.
> 
> The following call tree explains in more detail:
> 
> fec_probe
>   fec_reset_phy                               <- no longer introduces delay after migration to mdio reset
>   fec_enet_mii_init
>     of_mdiobus_register
>       of_mdiobus_register_phy
>         fwnode_mdiobus_register_phy
>           get_phy_device                      <- mii probe for phy id to match driver happens here
>           ...
>           fwnode_mdiobus_phy_device_register
>             phy_device_register
>               mdiobus_register_device
>                 mdio_device_reset             <- mdio reset assert / deassert delay happens here
> 
> Add a 20ms enable delay to the regulator to fix the issue.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
