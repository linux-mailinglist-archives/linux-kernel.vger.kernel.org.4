Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BAC6CD777
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjC2KOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjC2KOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:14:09 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B1B40F1;
        Wed, 29 Mar 2023 03:14:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 945FD8107;
        Wed, 29 Mar 2023 10:14:06 +0000 (UTC)
Date:   Wed, 29 Mar 2023 13:14:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230329101405.GQ7501@atomide.com>
References: <20230323071051.2184-1-tony@atomide.com>
 <ZCQClBeEtSLu2X0U@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCQClBeEtSLu2X0U@kroah.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230329 09:19]:
> On Thu, Mar 23, 2023 at 09:10:47AM +0200, Tony Lindgren wrote:
> > -obj-$(CONFIG_SERIAL_CORE) += serial_core.o
> > +obj-$(CONFIG_SERIAL_CORE) += serial_base.o serial_core.o serial_ctrl.o serial_port.o
> 
> Why is this 3 new modules and not just all go into serial_base?  What's
> going to auto-load the other modules you created here?  Feels like this
> should all end up in the same .ko as they all depend on each other,
> right?

OK sure, I'll build them into serial_base. We now have uart_add_one_port()
and uart_remove_one_port() exported in serial_port so that ends up loading
the serial_base related modules.

> > +struct uart_port *serial_base_get_port(struct device *dev)
> > +{
> > +	struct serial_base_device *sbd;
> > +
> > +	if (!dev)
> > +		return NULL;
> > +
> > +	sbd = to_serial_base_device(dev);
> > +
> > +	/* Check in case serial_core_add_one_port() happened to fail */
> > +	if (!sbd->port->state) {
> 
> This is odd, how can it fail and then this function be called after that
> failure?

On uart_add_one_port(), runtime PM resume function in serial_port gets
called before the port registration has completed. Sounds like I need
to recheck this, maybe we can just enable runtime PM for serial_port
after registration has completed.

> > +/*
> > + * Find a registered serial core controller device if one exists. Returns
> > + * the first device matching the ctrl_id. Caller must hold port_mutex.
> > + */
> > +static struct device *serial_core_ctrl_find(struct uart_driver *drv,
> > +					    struct device *phys_dev,
> > +					    int ctrl_id)
> > +{
> > +	struct uart_state *state;
> > +	int i;
> > +
> > +	if (ctrl_id < 0)
> > +		return NULL;
> 
> Why is a negative number special here?

I think this can go, will check.

> > +	dev = serial_base_device_add(port, "port", ctrl_dev);
> 
> magic strings again :)
> 
> Do you really just want two different "types" of devices on this bus,
> controllers and ports?  If so, just do that, don't make the name magic
> here.
> 
> Then you can have:
> 	serial_base_port_add()
> 	serial_base_ctrl_add()
> 
> and one cleanup function will still work.

Yes two different types should do here, I'll take a look.

> Otherwise this looks good to me, thanks for doing all of this work.

OK great thanks,

Tony
