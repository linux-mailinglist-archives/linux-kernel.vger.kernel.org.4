Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7866C4FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjCVPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCVPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:44:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C133121961;
        Wed, 22 Mar 2023 08:44:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 02261807A;
        Wed, 22 Mar 2023 15:44:55 +0000 (UTC)
Date:   Wed, 22 Mar 2023 17:44:54 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v8 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230322154454.GN7501@atomide.com>
References: <20230322111255.29827-1-tony@atomide.com>
 <ZBsUmkqKnP/jrNjv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsUmkqKnP/jrNjv@smile.fi.intel.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230322 14:45]:
> On Wed, Mar 22, 2023 at 01:12:51PM +0200, Tony Lindgren wrote:
> > +	device_initialize(&sbd->dev);
> > +	sbd->dev.parent = parent_dev;
> > +	sbd->dev.bus = &serial_base_bus_type;
> > +	sbd->dev.release = &serial_base_release;
> > +
> > +	if (str_has_prefix(name, "ctrl")) {
> > +		id = port->ctrl_id;
> > +	} else {
> > +		id = port->line;
> > +		sbd->port = port;
> > +	}
> > +
> > +	err = dev_set_name(&sbd->dev, "%s.%s.%d", name, dev_name(port->dev), id);
> > +	if (err)
> > +		goto err_free_dev;
> > +
> > +	err = device_add(&sbd->dev);
> > +	if (err)
> > +		goto err_put_device;
> > +
> > +	return &sbd->dev;
> > +
> > +err_put_device:
> > +	put_device(&sbd->dev);
> 
> > +	kfree_const(sbd->dev.kobj.name);
> 
> This is double free if not const, right?
> At least that's how I read kobject_cleanup() implementation.
> 
> Sorry I haven't paid attention to this earlier.

Thanks for spotting that, will drop it. Looks like we have the name
allocated by kobject_set_name_vargs(), and then kobject_cleanup()
frees it.

> ...
> 
> > +/*
> > + * Serial core port device driver
> > + */
> 
> Put it on one line for now?

Sure, will do.

Thanks,

Tony
