Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4970A56B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 06:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjETE4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 00:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjETE4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 00:56:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3751E40
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:56:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q0Edo-0006g0-0z; Sat, 20 May 2023 06:56:28 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q0Edj-0004Jg-I9; Sat, 20 May 2023 06:56:23 +0200
Date:   Sat, 20 May 2023 06:56:23 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Simon Horman <simon.horman@corigine.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v4 1/2] net: dsa: microchip: ksz8: Make flow
 control, speed, and duplex on CPU port configurable
Message-ID: <20230520045623.GB18246@pengutronix.de>
References: <20230519124700.635041-1-o.rempel@pengutronix.de>
 <20230519124700.635041-1-o.rempel@pengutronix.de>
 <20230519124700.635041-2-o.rempel@pengutronix.de>
 <20230519124700.635041-2-o.rempel@pengutronix.de>
 <20230519232802.ae34asc4zgfmv3u4@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519232802.ae34asc4zgfmv3u4@skbuf>
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

On Sat, May 20, 2023 at 02:28:02AM +0300, Vladimir Oltean wrote:
> > +	/* This hardware only supports SPEED_10 and SPEED_100. For SPEED_10
> > +	 * we need to set the SW_10_MBIT bit. Otherwise, we can leave it 0.
> > +	 */
> > +	if (speed == SPEED_10)
> > +		ctrl |= SW_10_MBIT;
> > +
> > +	ksz_rmw8(dev, REG_SW_CTRL_4, SW_HALF_DUPLEX | SW_FLOW_CTRL |
> > +		 SW_10_MBIT, ctrl);
> 
> REG_SW_CTRL_4 ... S_REPLACE_VID_CTRL ... dev->info->regs[P_XMII_CTRL_1] ...
> at some point we will need one more consolidation effort here, since we
> have at least 3 ways of reaching the same register.

Agree, the register access is a bit messy now. Your idea about the
regfield API sounds good. We should try it.

Should i convert this patch to use dev->info->regs?

> >  	.mirror_del = ksz8_port_mirror_del,
> >  	.get_caps = ksz8_get_caps,
> > +	.phylink_mac_link_up = ksz8_phylink_mac_link_up,
> 
> Another future consolidation to consider: since all ksz_dev_ops now
> provide .phylink_mac_link_up(), the "if" condition here is no longer
> necessary:
> 
> static void ksz_phylink_mac_link_up(struct dsa_switch *ds, int port,
> 				    unsigned int mode,
> 				    phy_interface_t interface,
> 				    struct phy_device *phydev, int speed,
> 				    int duplex, bool tx_pause, bool rx_pause)
> {
> 	struct ksz_device *dev = ds->priv;
> 
> 	if (dev->dev_ops->phylink_mac_link_up)
> 		dev->dev_ops->phylink_mac_link_up(dev, port, mode, interface,
> 						  phydev, speed, duplex,
> 						  tx_pause, rx_pause);
> }
> 
> which reminds me of the fact that I also had a patch to remove
> dev->dev_ops->phylink_mac_config():
> https://patchwork.kernel.org/project/netdevbpf/patch/20230316161250.3286055-5-vladimir.oltean@nxp.com/
> 
> I give up with that patch set now, since there's zero reviewer interest.
> If you want and you think it's useful, you might want to adapt it for
> KSZ8873.

Sounds good. I'll take it in to my mainlining queue for KSZ8873.

> >  	.config_cpu_port = ksz8_config_cpu_port,
> >  	.enable_stp_addr = ksz8_enable_stp_addr,
> >  	.reset = ksz8_reset_switch,
> > -- 
> > 2.39.2
> > 
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> 

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
