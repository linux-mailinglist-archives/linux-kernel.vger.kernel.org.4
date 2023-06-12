Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4D72C953
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbjFLPGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbjFLPGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:06:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635E1191;
        Mon, 12 Jun 2023 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kk0d/2tWj4khyjB2Eu1F5L42SpysC7oftRAedyBPmVY=; b=SPtEPNISbPVbX11EIBaAy7aniA
        Py5rr49UE5fAF8pkMj6ziXGm1dcsf6hQaPTw/ewWV8GX14LVy1fNBFAu3V29b070t98BPiW8MjxwF
        Q1MuPfH/Ba2e1ZTC1U7aXgD65ss+YRTvClUk94tAMRs/ui5PWMcE5zZahrybJX3oREcmUL+ZrhEi3
        iOAL7vcIAzhKWdHH+00ZvR8+ROwzdboNTXP+2tLatSvajAF6AIOqE19XKm2ljMmm+gBkRgTy4ISKb
        nhBBuSWx/kkEgFaoTC9mlXZDWRV9nOnnPZfixFYT0Aluw86NkvMXIrG14ZVDs/TDZyK+VcFlpVltV
        oeJX6HaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39544)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q8j7p-0005vC-VU; Mon, 12 Jun 2023 16:06:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q8j7n-00053s-VL; Mon, 12 Jun 2023 16:06:31 +0100
Date:   Mon, 12 Jun 2023 16:06:31 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        hkallweit1@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH] net: phy: Add sysfs attribute for PHY c45 identifiers.
Message-ID: <ZIc0d48xURaZzZc/@shell.armlinux.org.uk>
References: <20230611152743.2158-1-zhaojh329@gmail.com>
 <20230612140426.1648-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612140426.1648-1-zhaojh329@gmail.com>
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

On Mon, Jun 12, 2023 at 10:04:26PM +0800, Jianhui Zhao wrote:
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 17d0d0555a79..81a4bc043ee2 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -541,8 +541,10 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
>  
>  			if ((phydrv->phy_id & phydrv->phy_id_mask) ==
>  			    (phydev->c45_ids.device_ids[i] &
> -			     phydrv->phy_id_mask))
> +			     phydrv->phy_id_mask)) {
> +				phydev->phy_id = phydev->c45_ids.device_ids[i];
>  				return 1;
> +			}
>  		}
>  		return 0;
>  	} else {
> 
> How about modifying it like this?

No - there are C45 PHYs where the ID in each MMD are different. 88x3310
is one such example. If we're going to report any of them, we should
report all of them.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
