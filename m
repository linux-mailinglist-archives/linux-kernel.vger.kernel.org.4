Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0B973CCA8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjFXUQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 16:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFXUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 16:16:07 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86010F;
        Sat, 24 Jun 2023 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=N2h8eJ/ReHq64edfbJNGzDGuxo/YlTqsyvD++t/O8kM=; b=Fbf0Y8Pc92k5LqbvKHJmsjl6kd
        rsKTwXFdgylgqeUBz7+ht8yTvyO29ALoRnHkQ0TXbNwzJzPb2Rh7ZwTT0quAdrLmyLygkBuWJD9Ki
        nxYajzyTEQyZJpnLwWkL8ZNQhrGHLkpJ/rxScu6bq59m9TGR3zakaJBz9PQxAI3iJ0gY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qD9fb-00HRgN-8z; Sat, 24 Jun 2023 22:15:43 +0200
Date:   Sat, 24 Jun 2023 22:15:43 +0200
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
Subject: Re: [PATCH net-next v2 07/10] net: phy: add support for C45-over-C22
 transfers
Message-ID: <52859948-9812-4b0b-ae5f-7e174926d5c4@lunn.ch>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-7-def0ab9ccee2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v2-7-def0ab9ccee2@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
>  {
> -	int val;
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int phy_addr = phydev->mdio.addr;
> +	bool check_rc = true;
> +	int ret;

Although __phy_read_mmd() is exported as a GPL symbol, it is not in
fact used outside of this file. I think we can easily change it
signature.

> +	switch (phydev->access_mode) {

Have access_mode passed in as a parameter. It then becomes a generic
low level helper.

The function which is really exported and expected to by used by PHY
drivers is:

int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
{
	int ret;

	phy_lock_mdio_bus(phydev);
	ret = __phy_read_mmd(phydev, devad, regnum);
	phy_unlock_mdio_bus(phydev);

	return ret;
}
EXPORT_SYMBOL(phy_read_mmd);

This can easily pass phydev->access_mode as a parameter.

> +static int phy_probe_mmd_read(struct mii_bus *bus, int prtad, int devad,
> +			      u16 regnum, bool c45_over_c22)
> +{

What i don't like is this bool c45_over_c22. Why have both the enum
for the three access modes, and this bool. Pass an access mode.

> +	int ret;
> +
> +	if (!c45_over_c22)
> +		return mdiobus_c45_read(bus, prtad, devad, regnum);
> +
> +	mutex_lock(&bus->mdio_lock);
> +
> +	ret = __phy_mmd_indirect(bus, prtad, devad, regnum);
> +	if (ret)
> +		goto out;
> +
> +	ret = __mdiobus_read(bus, prtad, MII_MMD_DATA);

And then this just uses the generic low level __phy_read_mmd().

    Andrew
