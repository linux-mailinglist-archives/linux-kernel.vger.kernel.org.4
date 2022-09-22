Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C810C5E63A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiIVNbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIVNbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:31:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E365D4DDC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:31:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1obMIE-0005Jr-0M; Thu, 22 Sep 2022 15:31:06 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1obMID-00072j-AZ; Thu, 22 Sep 2022 15:31:05 +0200
Date:   Thu, 22 Sep 2022 15:31:05 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/2] gpio: Add gpio latch driver
Message-ID: <20220922133105.GN986@pengutronix.de>
References: <20220914071306.3254881-1-s.hauer@pengutronix.de>
 <20220914071306.3254881-2-s.hauer@pengutronix.de>
 <20220914140310.5ffrnsy63piegdyr@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914140310.5ffrnsy63piegdyr@mobilestation>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:03:10PM +0300, Serge Semin wrote:
> > +				    unsigned int offset, bool val)
> > +{
> > +	int latch = offset / priv->n_latched_gpios;
> > +	int i;
> > +
> > +	assign_bit(offset, priv->shadow, val);
> > +
> 
> > +	for (i = 0; i < priv->n_latched_gpios; i++)
> > +		set(priv->latched_gpios->desc[i],
> > +		    test_bit(latch * priv->n_latched_gpios + i, priv->shadow));
> 
> -> duration?
> 
> > +
> > +	set(priv->clk_gpios->desc[latch], 1);
> 
> -> duration?
> 
> > +	set(priv->clk_gpios->desc[latch], 0);
> 
> I am pretty much sure there must be some duration between the actions
> above *. See for instance the tw and (tsu + th) timing requirements in
> the next edge-triggered flip-flops:
> https://www.ti.com/lit/ds/symlink/sn74lv74a.pdf?ts=1663163389954&ref_url=https%253A%252F%252Fwww.google.com%252F
> 
> The durations are normally small (ns or a bit smaller) but still need
> to be added anyway.
> 
> Note since the durations are device-specific an additional DT-property array
> with durations should be added too.

Do you think a fixed udelay(1) would be enough for now? Bigger delays
shouldn't be needed and smaller delays expand to udelay(1) anyway on
architectures not providing an architecture specific ndelay().

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
