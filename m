Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A073701BA7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 07:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjENFl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 01:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjENFlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 01:41:25 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 968C52129;
        Sat, 13 May 2023 22:41:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 634638106;
        Sun, 14 May 2023 05:41:23 +0000 (UTC)
Date:   Sun, 14 May 2023 08:41:22 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v11 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230514054122.GH14287@atomide.com>
References: <20230511065355.47525-1-tony@atomide.com>
 <2023051332-pretended-spoiler-61fc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023051332-pretended-spoiler-61fc@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230513 11:10]:
> On Thu, May 11, 2023 at 09:53:51AM +0300, Tony Lindgren wrote:
> > We want to enable runtime PM for serial port device drivers in a generic
> > way. To do this, we want to have the serial core layer manage the
> > registered physical serial controller devices.
> > 
> > To do this, let's set up a struct bus and struct device for the serial
> > core controller as suggested by Greg and Jiri. The serial core controller
> > devices are children of the physical serial port device. The serial core
> > controller device is needed to support multiple different kind of ports
> > connected to single physical serial port device.
> > 
> > Let's also set up a struct device for the serial core port. The serial
> > core port instances are children of the serial core controller device.
> > 
> > With the serial core port device we can now flush pending TX on the
> > runtime PM resume as suggested by Johan.
> 
> Much better, thanks!
> 
> One thing jumps out at me though, you are passing around "raw" struct
> device pointers as the serial port structure, why?
> 
> Shouldn't:
> 
> > @@ -563,7 +564,8 @@ struct uart_port {
> >  	unsigned int		minor;
> >  	resource_size_t		mapbase;		/* for ioremap */
> >  	resource_size_t		mapsize;
> > -	struct device		*dev;			/* parent device */
> > +	struct device		*dev;			/* serial port physical parent device */
> > +	struct device		*port_dev;		/* serial core port device */
> 
> port_dev here be something like "struct serial_port" (or some better
> name)?  That way you enforce the type being passed around to the serial
> code in this change which will help catch any type mistakes.
> 
> Yes, this structure can just be a "wrapper" around 'struct device' but
> at least it's a unique type.

Good idea thanks, will change.

> Or am I missing why this was done this way?

No reason to keep it as struct device.

Regards,

Tony
