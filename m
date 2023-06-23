Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13D73BBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjFWPle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjFWPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:41:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B02120
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:41:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qCiuF-0005nd-N4; Fri, 23 Jun 2023 17:41:03 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qCiuE-0007FL-Eg; Fri, 23 Jun 2023 17:41:02 +0200
Date:   Fri, 23 Jun 2023 17:41:02 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH] media: tc358746: select CONFIG_GENERIC_PHY
Message-ID: <20230623154102.gjyorfxpzvbnfa4y@pengutronix.de>
References: <20230623152318.2276816-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623152318.2276816-1-arnd@kernel.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

thanks for the patch.

On 23-06-23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The tc358746 driver selects CONFIG_GENERIC_PHY_MIPI_DPHY and links to
> that, but this fails when CONFIG_GENERIC_PHY is disabled, because Kbuild
> then never enters the drivers/phy directory for building object files:
> 
> ERROR: modpost: "phy_mipi_dphy_get_default_config_for_hsclk" [drivers/media/i2c/tc358746.ko] undefined!
> 
> Add an explicit 'select GENERIC_PHY' here to ensure that the directory
> is entered, and add another dependency on that symbol so make it
> more obvious what is going on if another driver has the same problem,
> as this will produce a Kconfig warning.
> 
> Fixes: 80a21da360516 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  drivers/media/i2c/Kconfig | 1 +
>  drivers/phy/Kconfig       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index cf675ac4b1326..226454b6a90dd 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -1305,6 +1305,7 @@ config VIDEO_TC358746
>  	select VIDEO_V4L2_SUBDEV_API
>  	select MEDIA_CONTROLLER
>  	select V4L2_FWNODE
> +	select GENERIC_PHY
>  	select GENERIC_PHY_MIPI_DPHY
>  	select REGMAP_I2C
>  	help
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index f46e3148d286d..8dba9596408f2 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -18,6 +18,7 @@ config GENERIC_PHY
>  
>  config GENERIC_PHY_MIPI_DPHY
>  	bool
> +	depends on GENERIC_PHY
>  	help
>  	  Generic MIPI D-PHY support.
>  
> -- 
> 2.39.2
> 
> 
