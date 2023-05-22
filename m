Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897D570BE8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjEVMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjEVMjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:39:23 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4D11A1;
        Mon, 22 May 2023 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/G5DexSSkcSg3Y2YZMRQ2lnxwKx9OswZztzvdpONTRs=; b=NDVTPdrURD5Os9ENbe99JcYLDy
        Spd+1Ny789rc+HZiXQONF1GoqYAn2eKT43C7UiZ4Duio0q9Zm212oK2yr25tDDCt3Bv0k3UbjCXnH
        Rv9HsMJWO3q4XI0Bjv1NVFJZnsHciDaaUJHI0mN6A8Tk2Vk2+QfvIkqbbroibHjD/qYI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q14oB-00DXfc-N0; Mon, 22 May 2023 14:38:39 +0200
Date:   Mon, 22 May 2023 14:38:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ramon.nordin.rodriguez@ferroamp.se, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 3/6] net: phy: microchip_t1s: update LAN867x
 PHY supported revision number
Message-ID: <f417ba86-4d48-44e9-8bf0-aa15c466a9f2@lunn.ch>
References: <20230522113331.36872-1-Parthiban.Veerasooran@microchip.com>
 <20230522113331.36872-4-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522113331.36872-4-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -#define PHY_ID_LAN867X 0x0007C160
> +#define PHY_ID_LAN867X_REVB1 0x0007C162

>  static struct phy_driver microchip_t1s_driver[] = {
>  	{
> -		PHY_ID_MATCH_MODEL(PHY_ID_LAN867X),
> -		.name               = "LAN867X",
> +		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
> +		.name               = "LAN867X Rev.B1",
>  		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
> -		.config_init        = lan867x_config_init,
> +		.config_init        = lan867x_revb1_config_init,
>  		.read_status        = lan867x_read_status,
>  		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
>  		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
> @@ -124,7 +124,7 @@ static struct phy_driver microchip_t1s_driver[] = {
>  module_phy_driver(microchip_t1s_driver);
>  
>  static struct mdio_device_id __maybe_unused tbl[] = {
> -	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN867X) },
> +	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
>  	{ }
>  };

Maybe i asked this last time...

What versions actually exist? The old entry would match 0x0007C16X, so
0x0007C160 and 0x0007C161, 0x0007C162, if those actually exist. Now
you are narrowing it down to just 0x0007C162.

It would be good to comment on this in the commit message, that
0x0007C160 and 0x0007C161 never escaped the testing facility and hence
don't need to be supported.

	Andrew
