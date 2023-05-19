Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3838C709F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjESSuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjESSuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:50:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DF1E72
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:50:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q05BC-0000rT-Ex; Fri, 19 May 2023 20:50:18 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q05B9-00025q-TE; Fri, 19 May 2023 20:50:15 +0200
Date:   Fri, 19 May 2023 20:50:15 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v4 1/2] net: dsa: microchip: ksz8: Make flow
 control, speed, and duplex on CPU port configurable
Message-ID: <20230519185015.GA18246@pengutronix.de>
References: <20230519124700.635041-1-o.rempel@pengutronix.de>
 <20230519124700.635041-2-o.rempel@pengutronix.de>
 <20230519143004.luvz73jiyvnqxk4y@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519143004.luvz73jiyvnqxk4y@skbuf>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Fri, May 19, 2023 at 05:30:04PM +0300, Vladimir Oltean wrote:
> On Fri, May 19, 2023 at 02:46:59PM +0200, Oleksij Rempel wrote:
> > +void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
> > +			      unsigned int mode, phy_interface_t interface,
> > +			      struct phy_device *phydev, int speed, int duplex,
> > +			      bool tx_pause, bool rx_pause)
> > +{
> > +	/* If the port is the CPU port, apply special handling. Only the CPU
> > +	 * port is configured via global registers.
> > +	 */
> > +	if (dev->cpu_port == port)
> > +		ksz8_cpu_port_link_up(dev, speed, duplex, tx_pause, rx_pause);
> > +}
> 
> I'm sorry, but this is also baking in assumptions related to the
> topology of the tree (that the xMII port is used as a CPU port).
> The ksz8 driver may make this assumption in other places too,
> but I don't want to make it even worse to fix. Is the
> !dev->info->internal_phy[port] condition not enough here?

Thank you for your feedback. I see your point. 

We need to remember that the KSZ switch series has different types of
ports. Specifically, for the KSZ8 series, there's a unique port. This
port is unique because it's the only one that can be configured with
global registers, and it is only one supports tail tagging. This special
port is already referenced in the driver by "dev->cpu_port", so I continued
using it in my patch.

It is important to note that while this port has an xMII interface, it
is not the only port that could have an xMII interface. Therefore, using
"dev->info->internal_phy" may not be the best way to identify this port,
because there can be ports that are not global/cpu, have an xMII
interface, but don't have an internal PHY.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
