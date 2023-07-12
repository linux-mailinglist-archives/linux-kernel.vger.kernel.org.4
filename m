Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33CC750B78
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGLO4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjGLOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:55:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2A7BB;
        Wed, 12 Jul 2023 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BINkZ1i4PKbO0+fsSVwUWsXVzisxjT4/2QKSssOySGM=; b=QFjAs1WzTxEUF8chDYKA9DlGDT
        sJN8HV/wvVUFJ/zD7PJtGdfq1i92ZgHRlm5fg55/irDCuSja/uKzralkXH7VLBsgLEZmnQe4zgYlU
        lN19WBy4XwBfRdY19J53pq29mtBpk2kvNWYzpny1Epr9p1/GdmI8IsU8isimR/DqV40A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qJbFo-0019Hu-Gx; Wed, 12 Jul 2023 16:55:44 +0200
Date:   Wed, 12 Jul 2023 16:55:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Daniel Machon <daniel.machon@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC RESEND v1 pinctrl-next 0/1] add blink and activity
 functions to SGPIO
Message-ID: <39b297b0-5266-4f4b-ade6-8ccb95e90411@lunn.ch>
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
 <64ae73ce.050a0220.fe1a6.4b8a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64ae73ce.050a0220.fe1a6.4b8a@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:59:10AM +0200, Christian Marangi wrote:
> On Tue, Jul 11, 2023 at 07:22:49PM -0700, Colin Foster wrote:
> > Preface (new for resend):
> > 
> > This is a resend of a patch I'd sent a couple years back. At that time,
> > I was told to wait for hardware-offloaded LEDS. It looks like that time
> > has finally come, so I've changed this from PATCH down to an RFC to make
> > sure this is the right approach for the framework.
> > 
> > Ocelot chips (VSC7511, VSC7512, VSC7513, VSC7514) have support for
> > hardware-offloaded LEDs based on network activity. This is currenty
> > managed by way of pinctrl-microchip-sgpio (and this current patch).
> > 
> > The purpose of this resend is two-fold. First, to come up with an idea
> > of how this pinctrl-microchip-sgpio module can fit in with the new
> > hardware-offloaded netdev triggers Christian Marangi recently added. Is
> > this something that should be in the pinctrl module itself? Or should
> > there be a drivers/net/ethernet/mscc/ocelot_leds.c module that I should
> > add?
> >
> 
> I'm a bit out of the loop on what magic OEM did to make LED work on
> ocelot but I feel an ocelot_leds submodule is needed.
> 
> To correctly supports the hw many API needs to be defined and for switch
> I would stick with how things are done with qca8k, codewise and DT wise
> (with how LEDs are defined in DT)
> 
> Ideally the feature for MAC will be generilized and added to the DSA ops
> struct, so having things in the DSA driver would make the migration
> easier.

`ocelot` is a bit of an odd device, since it is both a DSA device for
felix and seville and a pure switchdev device for ocelot.

You need some integration with the switch driver, because i expect
only the switch driver has the knowledge of how LEDs are mapped to
struct netdev and ports. And in order to offload blinking you need
that mapping.

I have some WIP patches to add a generalized DSA interface for LEDs,
and support for mv88e6xxx. I would also like to move qca8k over to
that. So it could be that felix and seville would use that. Ocelot
would need to do it slightly different, but i expect it is just a
layer on top of some shared code, much like the rest of ocelot.

Having pinmux in the middle is interesting. I've no idea how that will
work, but i've not looked at it.

      Andrew
