Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563BD68EF82
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjBHNIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBHNIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:08:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225524617A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:08:47 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pPkBd-00076h-JJ; Wed, 08 Feb 2023 14:08:33 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1pPkBa-0004lY-O4; Wed, 08 Feb 2023 14:08:30 +0100
Date:   Wed, 8 Feb 2023 14:08:30 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Wei Fang <wei.fang@nxp.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Arun.Ramadoss@microchip.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/9] net: phy: add
 genphy_c45_ethtool_get/set_eee() support
Message-ID: <20230208130830.GA19895@pengutronix.de>
References: <20230208103211.2521836-1-o.rempel@pengutronix.de>
 <20230208103211.2521836-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208103211.2521836-6-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:32:07AM +0100, Oleksij Rempel wrote:
> Add replacement for phy_ethtool_get/set_eee() functions.
> 
> Current phy_ethtool_get/set_eee() implementation is great and it is
> possible to make it even better:
> - this functionality is for devices implementing parts of IEEE 802.3
>   specification beyond Clause 22. The better place for this code is
>   phy-c45.c
> - currently it is able to do read/write operations on PHYs with
>   different abilities to not existing registers. It is better to
>   use stored supported_eee abilities to avoid false read/write
>   operations.
> - the eee_active detection will provide wrong results on not supported
>   link modes. It is better to validate speed/duplex properties against
>   supported EEE link modes.
> - it is able to support only limited amount of link modes. We have more
>   EEE link modes...
> 
> By refactoring this code I address most of this point except of the last
> one. Adding additional EEE link modes will need more work.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
  
> +/**
> + * genphy_c45_eee_is_active - get EEE supported and status
> + * @phydev: target phy_device struct
> + * @data: ethtool_eee data

I forgot to update this comment.

> + *
> + * Description: it reports the possible state of EEE functionality.
> + */
> +int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
> +			     unsigned long *lp, bool *is_enabled)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp_adv) = {};
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp_lp) = {};
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
> +	bool eee_enabled, eee_active;
> +	int ret;
> +
> +	ret = genphy_c45_read_eee_adv(phydev, tmp_adv);
> +	if (ret)
> +		return ret;
> +
> +	ret = genphy_c45_read_eee_lpa(phydev, tmp_lp);
> +	if (ret)
> +		return ret;
> +
> +	eee_enabled = !linkmode_empty(tmp_adv);
> +	linkmode_and(common, tmp_adv, tmp_lp);
> +	if (eee_enabled && !linkmode_empty(common))i

and linkmode_empty() can be replaced with linkmode_intersects()

I'll wait if more comments will come and make a new version tomorrow.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
