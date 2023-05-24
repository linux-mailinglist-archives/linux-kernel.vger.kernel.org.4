Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C170FD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjEXR4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjEXR4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:56:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDD119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:56:29 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q1sip-0000nx-Ee; Wed, 24 May 2023 19:56:27 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q1sio-0002iZ-TK; Wed, 24 May 2023 19:56:26 +0200
Date:   Wed, 24 May 2023 19:56:26 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Eric Dumazet <edumazet@google.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v1 4/5] net: dsa: microchip: ksz8: Prepare
 ksz8863_smi for regmap register access validation
Message-ID: <20230524175626.GC7074@pengutronix.de>
References: <20230524123220.2481565-1-o.rempel@pengutronix.de>
 <20230524123220.2481565-5-o.rempel@pengutronix.de>
 <584bb123-28c7-4d56-bad7-efcc2c343ecb@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <584bb123-28c7-4d56-bad7-efcc2c343ecb@lunn.ch>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 06:59:28PM +0200, Andrew Lunn wrote:
> On Wed, May 24, 2023 at 02:32:19PM +0200, Oleksij Rempel wrote:
> > This patch prepares the ksz8863_smi part of ksz8 driver to utilize the
> > regmap register access validation feature.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/net/dsa/microchip/ksz8863_smi.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
> > index 2af807db0b45..303a4707c759 100644
> > --- a/drivers/net/dsa/microchip/ksz8863_smi.c
> > +++ b/drivers/net/dsa/microchip/ksz8863_smi.c
> > @@ -104,6 +104,7 @@ static const struct regmap_config ksz8863_regmap_config[] = {
> >  		.cache_type = REGCACHE_NONE,
> >  		.lock = ksz_regmap_lock,
> >  		.unlock = ksz_regmap_unlock,
> > +		.max_register = BIT(8) - 1,
> 
> Maybe SZ_256 - 1 is more readable?

It is the same way used in other regmap_config in this driver.

As for me, U8_MAX is probably more understandable way, since addressing
since is 8bit.

> >  	},
> >  	{
> >  		.name = "#16",
> > @@ -113,6 +114,7 @@ static const struct regmap_config ksz8863_regmap_config[] = {
> >  		.cache_type = REGCACHE_NONE,
> >  		.lock = ksz_regmap_lock,
> >  		.unlock = ksz_regmap_unlock,
> > +		.max_register = BIT(8) - 2,
> 
> - 2?
> 
> Is this the 16 bit regmap? So it has 1/2 the number of registers of
> the 8 bit regmap? So i would of thought it should be BIT(7)-1, or
> SZ_128-1 ?

Sorry, it is a typo.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
