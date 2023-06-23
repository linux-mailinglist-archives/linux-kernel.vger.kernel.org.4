Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5377073BDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjFWRmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFWRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:42:22 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39F1FDF;
        Fri, 23 Jun 2023 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ZE2GYYoocwBgPjiLb1xYgZs2emqro7KMYGivmEkTqsg=; b=PPJxEbV3jnNL1xyMrUuyW43bvW
        VKkbtREhlPWT7zMINq9RDtkkNeXi3ZIUhuOeMwx9F82bBNfA2xg17/d13smRiZ6REzKVBr4BmwG59
        zV66JV5WfY7lypmJFve7v4QSs/p+A7ijlUHiIs6sH+/vd26ltwUhMdtibDBKmfXixn5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCknQ-00HNdT-UT; Fri, 23 Jun 2023 19:42:08 +0200
Date:   Fri, 23 Jun 2023 19:42:08 +0200
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
Subject: Re: [PATCH net-next v2 06/10] net: phy: print an info if a broken
 C45 bus is found
Message-ID: <af166ce6-b9b2-44e0-9f45-2b2aa001fd6b@lunn.ch>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-6-def0ab9ccee2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v2-6-def0ab9ccee2@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 12:29:15PM +0200, Michael Walle wrote:
> If there is an PHY which gets confused by C45 transactions on the MDIO
> bus, print an info together with the PHY identifier of the offending
> one.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> 
> ---
> I wasn't sure if this should be phydev_dbg() or phydev_info(). I mainly
> see this as an info to a user why some PHYs might not be probed (or
> c45-over-c22 is used later).

The information is useful to the DT writer, not the 'user'. I would
assume the DT writer has a bit more kernel knowledge and can debug
prints on. So i would suggest phydev_dbg().

> @@ -617,10 +617,10 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
>   */
>  void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
>  {
> +	struct phy_device *phydev;
>  	int i;
>  
>  	for (i = 0; i < PHY_MAX_ADDR; i++) {
> -		struct phy_device *phydev;
>  		u32 oui;

It is not clear why you changed the scope of phydev. I guess another
version used phydev_info(), where as now you have dev_info()?

	Andrew

>  
>  		phydev = mdiobus_get_phy(bus, i);
> @@ -633,6 +633,11 @@ void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
>  			break;
>  		}
>  	}
> +
> +	if (bus->prevent_c45_access)
> +		dev_info(&bus->dev,
> +			 "Detected broken PHY (ID %08lx). Disabling C45 bus transactions.\n",
> +			 (unsigned long)phydev->phy_id);
>  }
>  
>  /**
> 
> -- 
> 2.39.2
> 
