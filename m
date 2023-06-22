Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8173A022
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjFVL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjFVLz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:55:59 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B161172C;
        Thu, 22 Jun 2023 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=chq/0WFUGMcJxHzwHjN+29QiZq5EhUi5n3GREJ64QVs=; b=WPkIO3BJW3qj80J3BvBPQPaMl3
        SGIqsHqpMC70S/ksn6IwogvFTrfKEYJOe2+MRNCUCSO0vJ3I3D3idY2NwF0adOh2GAZIr17vI4PfS
        a6KdnuOXizlZzCDvW2/WBkpBCZtNrzKyi+QFe9LQBx/2Km/Wkk2D7lZ17wxBmJRQPrnoSNYNPUKGR
        IRP82ZAsK3rIEW9akTLlC/u0BOqMdjj9GPWUo518qjLqsNVLgBBDd5XOHtEgWUEwkOyv2uwxBt0Fv
        cDOiYrnZPeD7iMYS46DDJ5ADyeI/9IoKetZ46DQiJrnM9resrzFZqbgCxZ1rb8kleUoPLKulaNKqA
        UD16ezzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35498)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qCIuo-0004AX-OJ; Thu, 22 Jun 2023 12:55:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qCIum-0000Pu-9A; Thu, 22 Jun 2023 12:55:52 +0100
Date:   Thu, 22 Jun 2023 12:55:52 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <ZJQ2yBX16gAg+n0L@shell.armlinux.org.uk>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621191302.1405623-1-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:12:56PM +0200, Pawel Dembicki wrote:
> +	/* This driver does not make use of the speed, duplex, pause or the
> +	 * advertisement in its mac_config, so it is safe to mark this driver
> +	 * as non-legacy.
> +	 */
> +	config->legacy_pre_march2020 = false;

Great stuff, thanks!

> +static void vsc73xx_phylink_mac_config(struct dsa_switch *ds, int port,
> +				       unsigned int mode,
> +				       const struct phylink_link_state *state)
> +{
> +	struct vsc73xx *vsc = ds->priv;

Nit: normally have a blank line between function variable declarations
and the rest of the function body.

>  	/* Special handling of the CPU-facing port */
>  	if (port == CPU_PORT) {
>  		/* Other ports are already initialized but not this one */
> @@ -775,104 +803,92 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
>  			      VSC73XX_ADVPORTM_ENA_GTX |
>  			      VSC73XX_ADVPORTM_DDR_MODE);
>  	}
> +}
>  
> -	/* This is the MAC confiuration that always need to happen
> -	 * after a PHY or the CPU port comes up or down.
> -	 */
> -	if (!phydev->link) {
> -		int maxloop = 10;
> +static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int port,
> +					  unsigned int mode,
> +					  phy_interface_t interface)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	u32 val;
>  
> -		dev_dbg(vsc->dev, "port %d: went down\n",
> -			port);
> +	int maxloop = VSC73XX_TABLE_ATTEMPTS;

Reverse christmas-tree for variable declarations, and there shouldn't
be a blank line between them. In any case, I don't think you need
"maxloop" if you adopt my suggestion below.

>  
> -		/* Disable RX on this port */
> -		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> -				    VSC73XX_MAC_CFG,
> -				    VSC73XX_MAC_CFG_RX_EN, 0);
> +	dev_dbg(vsc->dev, "port %d: went down\n",
> +		port);
>  
> -		/* Discard packets */
> -		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
> -				    VSC73XX_ARBDISC, BIT(port), BIT(port));
> +	/* Disable RX on this port */
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +			    VSC73XX_MAC_CFG,
> +			    VSC73XX_MAC_CFG_RX_EN, 0);
> +
> +	/* Discard packets */
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
> +			    VSC73XX_ARBDISC, BIT(port), BIT(port));
>  
> -		/* Wait until queue is empty */
> +	/* Wait until queue is empty */
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
> +		     VSC73XX_ARBEMPTY, &val);
> +	while (!(val & BIT(port))) {
> +		msleep(1);
>  		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
>  			     VSC73XX_ARBEMPTY, &val);
> -		while (!(val & BIT(port))) {
> -			msleep(1);
> -			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
> -				     VSC73XX_ARBEMPTY, &val);
> -			if (--maxloop == 0) {
> -				dev_err(vsc->dev,
> -					"timeout waiting for block arbiter\n");
> -				/* Continue anyway */
> -				break;
> -			}
> +		if (--maxloop == 0) {
> +			dev_err(vsc->dev,
> +				"timeout waiting for block arbiter\n");
> +			/* Continue anyway */
> +			break;
>  		}
> +	}

I know you're only moving this code, but I think it would be good to
_first_ have a patch that fixes this polling function:

	int ret, err;
...
		ret = read_poll_timeout(vsc73xx_read, err,
					err < 0 || (val & BIT(port)),
					1000, 10000, false,
					vsc, VSC73XX_BLOCK_ARBITER, 0,
					VSC73XX_ARBEMPTY, &val);
		if (ret != 0)
			dev_err(vsc->dev,
				"timeout waiting for block arbiter\n");
		else if (err < 0)
			dev_err(vsc->dev,
				"error reading arbiter\n");

This avoids the issue that on the last iteration, the code reads the
register, test it, find the condition that's being waiting for is
false, _then_ waits and end up printing the error message - that last
wait is rather useless, and as the arbiter state isn't checked after
waiting, it could be that we had success during the last wait.

> +static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
> +					unsigned int mode,
> +					phy_interface_t interface,
> +					struct phy_device *phydev,
> +					int speed, int duplex,
> +					bool tx_pause, bool rx_pause)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	u32 val;
>  
> +	switch (speed) {
> +	case SPEED_1000:
>  		/* Set up default for internal port or external RGMII */
> -		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
> +		if (interface == PHY_INTERFACE_MODE_RGMII)
>  			val = VSC73XX_MAC_CFG_1000M_F_RGMII;
>  		else
>  			val = VSC73XX_MAC_CFG_1000M_F_PHY;
> -		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> -	} else if (phydev->speed == SPEED_100) {
> -		if (phydev->duplex == DUPLEX_FULL) {
> -			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
> -			dev_dbg(vsc->dev,
> -				"port %d: 100 Mbit full duplex mode\n",
> -				port);
> -		} else {
> -			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
> -			dev_dbg(vsc->dev,
> -				"port %d: 100 Mbit half duplex mode\n",
> -				port);
> -		}
> -		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> -	} else if (phydev->speed == SPEED_10) {
> -		if (phydev->duplex == DUPLEX_FULL) {
> +		break;
> +	case SPEED_100:
> +	case SPEED_10:
> +		if (duplex == DUPLEX_FULL)
>  			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
> -			dev_dbg(vsc->dev,
> -				"port %d: 10 Mbit full duplex mode\n",
> -				port);
> -		} else {
> +		else
>  			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
> -			dev_dbg(vsc->dev,
> -				"port %d: 10 Mbit half duplex mode\n",
> -				port);
> -		}
> -		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> -	} else {
> -		dev_err(vsc->dev,
> -			"could not adjust link: unknown speed\n");
> +		break;
>  	}

Do the dev_dbg() add anything useful over what phylink prints when the
link comes up?

I don't think moving to a switch() statement for this is a good idea.
Given that "val" may be uninitialised, I suspect the following may be
a better solution:

	if (speed == SPEED_1000 || speed == SPEED_100 || speed == SPEED_10) {
		if (speed == SPEED_1000) {
			...
		} else {
			...
		}

		... set VSC73XX_BLOCK_ANALYZER and call
		vsc73xx_adjust_enable_port ...
	}

However, looking at the definitions of the various macros, it seems we
can do a little better by not using the VSC73XX_MAC_CFG_*M_[FH]_*
definitions:

		if (speed == SPEED_1000) {
			val = VSC73XX_MAC_CFG_GIGA_MODE |
			      VSC73XX_MAC_CFG_TX_IPG_1000M;

			if (interface == PHY_INTERFACE_MODE_RGMII)
				val |= VSC73XX_MAC_CFG_CLK_SEL_1000M;
			else
				val |= VSC73XX_MAC_CFG_CLK_SEL_EXT;
		} else {
			val = VSC73XX_MAC_CFG_TX_IPG_100_10M |
			      VSC73XX_MAC_CFG_CLK_SEL_EXT;
		}

		if (duplex == DUPLEX_FULL)
			val |= VSC73XX_MAC_CFG_FDX;

Now, this reveals a question: when operating in RGMII mode, why do we
need VSC73XX_MAC_CFG_CLK_SEL_1000M for 1G, and
VSC73XX_MAC_CFG_CLK_SEL_EXT for 10M and 100M, whereas "PHY" mode always
uses CLK_SEL_EXT ?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
