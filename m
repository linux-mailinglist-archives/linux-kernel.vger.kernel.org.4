Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B18273BDDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjFWRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjFWRey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:34:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3786F2701;
        Fri, 23 Jun 2023 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Zc0pviPRoqlN0cN6TV+6Rt9skeFLXDyuOF3LOxVbwzY=; b=cH5aPWaEQ3Ue/RSs66k9jgPZdH
        jWAECdkbd8oLhP90xTpGfsjlUhG2SbM74YRZ41+4apP9G3dyxR/0uG4+8ZaNZ/ChLTTkHgNGzRXY8
        6X9JOZLQhIWVHKKHMUmT4kZaXX/Z5fRhPtgvnDEcjXXXmb7dic8gO2/3NKk5TBJmAlqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCkfu-00HNYx-Bx; Fri, 23 Jun 2023 19:34:22 +0200
Date:   Fri, 23 Jun 2023 19:34:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/10] net: phy: replace is_c45 with
 phy_accces_mode
Message-ID: <52cdebe9-0f94-430d-93ff-11f26d2e3c5b@lunn.ch>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-4-def0ab9ccee2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v2-4-def0ab9ccee2@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -131,9 +131,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  
>  	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
>  	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
> -		phy = get_phy_device(bus, addr, is_c45);
> +		phy = get_phy_device(bus, addr,
> +				     is_c45 ? PHY_ACCESS_C45 : PHY_ACCESS_C22);
>  	else
> -		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
> +		phy = phy_device_create(bus, addr, phy_id, PHY_ACCESS_C22,
> +					NULL);

Documentation/devicetree/bindings/net/ethernet-phy.yaml says:

  compatible:
    oneOf:
      - const: ethernet-phy-ieee802.3-c22
        description: PHYs that implement IEEE802.3 clause 22
      - const: ethernet-phy-ieee802.3-c45
        description: PHYs that implement IEEE802.3 clause 45

It would be nice to make this documentation more specific. It now
refers to 'bus transaction', so maybe we want to append that to these
lines?

> -static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
> +static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr,
> +				       enum phy_access_mode mode)

> +/**
> + * enum phy_access_mode - PHY register access mode definitions
> + *
> + * @PHY_ACCESS_C22: use 802.3 c22 MDIO transactions
> + * @PHY_ACCESS_C45: use 802.3 c45 MDIO transactions
> + */
> +enum phy_access_mode {
> +	PHY_ACCESS_C22,
> +	PHY_ACCESS_C45,
> +};

Was the change from bool to enum enough to make the compiler warn when
passed the wrong type? i.e. a true/false? not PHY_ACCESS_C22 and
PHY_ACCESS_C45? Maybe we could set these enum values to 22 and 45?
true/false would then not match, and we get some sort of error, like
-EIO from the switch statement?

>  /**
>   * struct phy_device - An instance of a PHY
>   *
> @@ -539,8 +550,8 @@ struct macsec_ops;
>   * @devlink: Create a link between phy dev and mac dev, if the external phy
>   *           used by current mac interface is managed by another mac interface.
>   * @phy_id: UID for this device found during discovery
> - * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
> - * @is_c45:  Set to true if this PHY uses clause 45 addressing.
> + * @access_mode:  MDIO access mode of the PHY.
> + * @c45_ids: 802.3-c45 Device Identifiers if it's an C45 PHY.
>   * @is_internal: Set to true if this PHY is internal to a MAC.
>   * @is_pseudo_fixed_link: Set to true if this PHY is an Ethernet switch, etc.
>   * @is_gigabit_capable: Set to true if PHY supports 1000Mbps
> @@ -637,8 +648,9 @@ struct phy_device {
>  
>  	u32 phy_id;
>  
> +	enum phy_access_mode access_mode;
> +

This enum might not pad too well between a u32 and struct? If you put
it after the bitfields, or maybe next to the enum phy_state the
compiler might make both a u16 and put them together?

	 Andrew
