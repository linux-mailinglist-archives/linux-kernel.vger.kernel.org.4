Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1E73BF19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFWTzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjFWTzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 15:55:02 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A3D2718;
        Fri, 23 Jun 2023 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3yUvbEaHrJkA8XbZDfQ/ylYjxcIAanKTgTqlC0IpYvE=; b=MQKqpkPFfyHz70xQiCygxCrRfQ
        PKtLjCRhnnwwWlL0fc/94ba/Tg7QUFP16vx+WCv/qilHIV/gpOs1SfBhvJesRBXPtZNnDtIyIvvuM
        /Lco+SLjWfqY72z6DMoWrZW5l5PdlqUjG8IvWhZMni1kgN6gTLx4PkbfdN0DWgXbDPO8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCmra-00HO1V-PP; Fri, 23 Jun 2023 21:54:34 +0200
Date:   Fri, 23 Jun 2023 21:54:34 +0200
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
Message-ID: <6fcd887a-c731-4c31-bb43-e8d14071524e@lunn.ch>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-4-def0ab9ccee2@kernel.org>
 <52cdebe9-0f94-430d-93ff-11f26d2e3c5b@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52cdebe9-0f94-430d-93ff-11f26d2e3c5b@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:34:22PM +0200, Andrew Lunn wrote:
> > @@ -131,9 +131,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
> >  
> >  	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
> >  	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
> > -		phy = get_phy_device(bus, addr, is_c45);
> > +		phy = get_phy_device(bus, addr,
> > +				     is_c45 ? PHY_ACCESS_C45 : PHY_ACCESS_C22);
> >  	else
> > -		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
> > +		phy = phy_device_create(bus, addr, phy_id, PHY_ACCESS_C22,
> > +					NULL);
> 
> Documentation/devicetree/bindings/net/ethernet-phy.yaml says:
> 
>   compatible:
>     oneOf:
>       - const: ethernet-phy-ieee802.3-c22
>         description: PHYs that implement IEEE802.3 clause 22
>       - const: ethernet-phy-ieee802.3-c45
>         description: PHYs that implement IEEE802.3 clause 45
> 
> It would be nice to make this documentation more specific. It now
> refers to 'bus transaction', so maybe we want to append that to these
> lines?

Humm, looking at patch 9, maybe i got this wrong. Patch 9 seems to
suggest ethernet-phy-ieee802.3-c45 means c45 register space, and it is
upto the core to figure out how to access that register space, either
using c45 transactions, or C45 over C22.

	 Andrew
