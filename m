Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5BE70FD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjEXRxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXRxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:53:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99249A4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:53:15 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q1sfc-0000HV-6w; Wed, 24 May 2023 19:53:08 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q1sfb-0002aT-4A; Wed, 24 May 2023 19:53:07 +0200
Date:   Wed, 24 May 2023 19:53:07 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Eric Dumazet <edumazet@google.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v1 2/5] net: dsa: microchip: add an enum for
 regmap widths
Message-ID: <20230524175307.GB7074@pengutronix.de>
References: <20230524123220.2481565-1-o.rempel@pengutronix.de>
 <20230524123220.2481565-3-o.rempel@pengutronix.de>
 <9b1b2f17-0489-4adb-8e17-594a813c2dc9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b1b2f17-0489-4adb-8e17-594a813c2dc9@lunn.ch>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 07:03:38PM +0200, Andrew Lunn wrote:
> On Wed, May 24, 2023 at 02:32:17PM +0200, Oleksij Rempel wrote:
> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > 
> > It is not immediately obvious that this driver allocates, via the
> > KSZ_REGMAP_TABLE() macro, 3 regmaps for register access: dev->regmap[0]
> > for 8-bit access, dev->regmap[1] for 16-bit and dev->regmap[2] for
> > 32-bit access.
> > 
> > In future changes that add support for reg_fields, each field will have
> > to specify through which of the 3 regmaps it's going to go. Add an enum
> > now, to denote one of the 3 register access widths, and make the code go
> > through some wrapper functions for easier review and further
> > modification.
> 
> Given the patches in this series, it is not obvious why the wrapper is
> needed.
> 
> dev->regmap[KSZ_REGMAP_8] is just as readable as ksz_regmap_8(dev).
>
> Do future changes add extra parameters to ksz_regmap_8()?

As for me, it looks short. Less problems with line length restrictions.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
