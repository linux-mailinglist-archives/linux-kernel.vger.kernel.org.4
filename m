Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078DC646E30
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiLHLNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLHLNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:13:33 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0778D3F05B;
        Thu,  8 Dec 2022 03:13:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4E1EA8109;
        Thu,  8 Dec 2022 11:13:31 +0000 (UTC)
Date:   Thu, 8 Dec 2022 13:13:30 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/1] serial: core: Start managing serial
 controllers to enable runtime PM
Message-ID: <Y5HG2okzlqX+xfWv@atomide.com>
References: <20221207124305.49943-1-tony@atomide.com>
 <7f105ff9-cdc3-f98e-2557-812361faa94@linux.intel.com>
 <Y5G5Udw6FAEFdAYi@atomide.com>
 <3c87186b-336f-6884-a2c-6ee3c9d70@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c87186b-336f-6884-a2c-6ee3c9d70@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221208 10:48]:
> On Thu, 8 Dec 2022, Tony Lindgren wrote:
> 
> > * Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221208 09:12]:
> > > On Wed, 7 Dec 2022, Tony Lindgren wrote:
> > > > +	ret = serial_core_add_one_port(drv, port);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	mutex_lock(&port_mutex);
> > > > +
> > > > +	/* Inititalize a serial core controller device if needed */
> > > > +	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
> > > > +	if (!ctrl_dev) {
> > > > +		ctrl_dev = serial_core_ctrl_device_add(port);
> > > > +		if (!ctrl_dev)
> > > > +			goto err_remove_port;
> > > > +		allocated = true;
> > > > +	}
> > > > +
> > > > +	/* Initialize a serial core port device */
> > > > +	ret = serial_core_port_device_add(ctrl_dev, port);
> > > 
> > > How is ->port_dev supposed to work here?
> > > 
> > > ->port_dev is not set until in serial_core_port_device_add() but you made
> > > serial_core_add_one_port() call before that.
> > 
> > Hmm do you mean you want to call serial_core_add_one_port() later after
> > serial_core_port_device_add()?
> > 
> > Or are you seeing some uninitialized use of port->port_dev (and not
> > port->dev)?
> 
> With the other patch on top of this, yes, I did see uninitialized 
> port->port_dev already in serial_core_add_one_port()->uart_configure_port().
> While that could be solved by removing the pm_runtime_*() calls from 
> there, I think it's a generic problem because after 
> serial_core_add_one_port() the port can have anything happening on it, no?

OK. Sounds like it should get sorted out by moving the call to
serial_core_add_one_port() to happen after the devices are created.

Regards,

Tony
