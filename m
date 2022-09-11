Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE545B4FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIKP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIKP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:27:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4591F60B;
        Sun, 11 Sep 2022 08:27:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x10so7815796ljq.4;
        Sun, 11 Sep 2022 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cEeD6rdorkMfZPWcdroJ4Ub+zOxt2tOhNzyuThs7z/4=;
        b=KfpIUzYZadeAR1u1Kxow0ZVLymF56Myv3hAnaLPT7dHYqNAz4nQ/ENA6porHhunsd+
         rEZ3sKjPVRkcobKv77VUs7yNwOvgmzgQiNdScl0WKOVi2A/3zQCijOInw5TJjLtxLCdO
         PaoKJ5Hkr0oteJ6flmDgQT29OEn2++6wkqRGMxBukHAbv8FaKybjGAgBCKVz0KdgreaS
         9gfTCaqmNIgpdC+bg2UIcPxBl6l6ihlnIicR6MuMpYCJGsAiKGsrSaGYyL2ccklIWkiz
         qorUIs5p4Mq7cnSeRZ2XSyLODdmIm8dLpjyal13R5eIUonF00nsHylBGVgUqpjlewqRc
         tg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cEeD6rdorkMfZPWcdroJ4Ub+zOxt2tOhNzyuThs7z/4=;
        b=yH1SD5Au0G9E1HZSh2QMD9GJxSEi1XktnzgjlBvYlkuaR1vOgaywyA+ooJ1z4ETYgf
         tkF8Jxg36SZvpyuKCJsG6bUdPv0x41Y59yzvL9u8voiZw909uyEpMvis2GvoAvXnLPch
         tte3A3sz7Ccua3kPu2EG5jAEA9j0PHxHRC+gVmQg0VoJLO1g/sKn2NAwbIPik1U5Fp0+
         lfyYKTaRNKA6/3NzwNqzCAAdC7kkv9Z0PXwOAXJG+KPfPq230HUoz0AkE/s8tlJx5Rgo
         0SirlubhTRePzkQkk69FSfRzcTAPkYAbCUNz3gmVzBW7MYGhizpN1mHltfSpVseOebCr
         q9ig==
X-Gm-Message-State: ACgBeo1wgqXJekpe1Uf087H8+TIERckkark7caPXpJo2Mggwyn/d6O2a
        hPhhGIQ5o9LWsv24Fu5mQbI=
X-Google-Smtp-Source: AA6agR6qLNl1f2idQ0gV4UETKo+F4FfRhSdYPoaZYjdxdjF7hrFhvnmYhGR/Bk4Cnp60lKWfuA6kaQ==
X-Received: by 2002:a2e:b819:0:b0:26a:a531:da36 with SMTP id u25-20020a2eb819000000b0026aa531da36mr6289664ljo.141.1662910048745;
        Sun, 11 Sep 2022 08:27:28 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25a0c000000b00498f3ebffb2sm645149lfn.25.2022.09.11.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 08:27:28 -0700 (PDT)
Date:   Sun, 11 Sep 2022 18:27:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] MIPS: Loongson32: Fix PHY-mode being left unspecified
Message-ID: <20220911152725.xp6kvrh7542bjep6@mobilestation>
References: <20220911072251.25024-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911072251.25024-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kelvin

On Sun, Sep 11, 2022 at 03:22:51PM +0800, Kelvin Cheung wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> commit 0060c8783330 ("net: stmmac: implement support for passive mode
> converters via dt") has changed the plat->interface field semantics from
> containing the PHY-mode to specifying the MAC-PCS interface mode. Due to
> that the loongson32 platform code will leave the phylink interface
> uninitialized with the PHY-mode intended by the means of the actual
> platform setup. The commit-author most likely has just missed the
> arch-specific code to fix. Let's mend the Loongson32 platform code then by
> assigning the PHY-mode to the phy_interface field of the STMMAC platform
> data.
> 

> Fixes: 0060c8783330 ("net: stmmac: implement support for passive mode converters via dt")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Your SoB tag should be here too right between mine SoB and TB
tags [1].

[1] Documentation/process/submitting-patches.rst, line 419 - 423.

-Sergey

> Tested-by: Keguang Zhang <keguang.zhang@gmail.com>

> ---
>  arch/mips/loongson32/common/platform.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> index 794c96c2a4cd..311dc1580bbd 100644
> --- a/arch/mips/loongson32/common/platform.c
> +++ b/arch/mips/loongson32/common/platform.c
> @@ -98,7 +98,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
>  	if (plat_dat->bus_id) {
>  		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
>  			     GMAC1_USE_UART0, LS1X_MUX_CTRL0);
> -		switch (plat_dat->interface) {
> +		switch (plat_dat->phy_interface) {
>  		case PHY_INTERFACE_MODE_RGMII:
>  			val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
>  			break;
> @@ -107,12 +107,12 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
>  			break;
>  		default:
>  			pr_err("unsupported mii mode %d\n",
> -			       plat_dat->interface);
> +			       plat_dat->phy_interface);
>  			return -ENOTSUPP;
>  		}
>  		val &= ~GMAC1_SHUT;
>  	} else {
> -		switch (plat_dat->interface) {
> +		switch (plat_dat->phy_interface) {
>  		case PHY_INTERFACE_MODE_RGMII:
>  			val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
>  			break;
> @@ -121,7 +121,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
>  			break;
>  		default:
>  			pr_err("unsupported mii mode %d\n",
> -			       plat_dat->interface);
> +			       plat_dat->phy_interface);
>  			return -ENOTSUPP;
>  		}
>  		val &= ~GMAC0_SHUT;
> @@ -131,7 +131,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
>  	plat_dat = dev_get_platdata(&pdev->dev);
>  
>  	val &= ~PHY_INTF_SELI;
> -	if (plat_dat->interface == PHY_INTERFACE_MODE_RMII)
> +	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII)
>  		val |= 0x4 << PHY_INTF_SELI_SHIFT;
>  	__raw_writel(val, LS1X_MUX_CTRL1);
>  
> @@ -146,9 +146,9 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata = {
>  	.bus_id			= 0,
>  	.phy_addr		= -1,
>  #if defined(CONFIG_LOONGSON1_LS1B)
> -	.interface		= PHY_INTERFACE_MODE_MII,
> +	.phy_interface		= PHY_INTERFACE_MODE_MII,
>  #elif defined(CONFIG_LOONGSON1_LS1C)
> -	.interface		= PHY_INTERFACE_MODE_RMII,
> +	.phy_interface		= PHY_INTERFACE_MODE_RMII,
>  #endif
>  	.mdio_bus_data		= &ls1x_mdio_bus_data,
>  	.dma_cfg		= &ls1x_eth_dma_cfg,
> @@ -186,7 +186,7 @@ struct platform_device ls1x_eth0_pdev = {
>  static struct plat_stmmacenet_data ls1x_eth1_pdata = {
>  	.bus_id			= 1,
>  	.phy_addr		= -1,
> -	.interface		= PHY_INTERFACE_MODE_MII,
> +	.phy_interface		= PHY_INTERFACE_MODE_MII,
>  	.mdio_bus_data		= &ls1x_mdio_bus_data,
>  	.dma_cfg		= &ls1x_eth_dma_cfg,
>  	.has_gmac		= 1,
> 
> base-commit: 727488e305b223ca69205ca5a3b99ace21bbbf5f
> -- 
> 2.34.1
> 
