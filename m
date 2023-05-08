Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E486FB1A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjEHNfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjEHNfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:35:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F07530E73;
        Mon,  8 May 2023 06:35:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6F0548111;
        Mon,  8 May 2023 13:35:04 +0000 (UTC)
Date:   Mon, 8 May 2023 16:35:03 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v10 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230508133503.GX14287@atomide.com>
References: <20230508110339.38699-1-tony@atomide.com>
 <ZFjm3/aKHNKch1lA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFjm3/aKHNKch1lA@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230508 12:11]:
> On Mon, May 08, 2023 at 02:03:35PM +0300, Tony Lindgren wrote:
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
> Sorry, I'm on vacation. But just brief comments below.
> In general looks good to me.

OK have a nice vacation :)

> > -obj-$(CONFIG_SERIAL_CORE) += serial_core.o
> > +obj-$(CONFIG_SERIAL_CORE) += serial_base.o
> > +serial_base-objs := serial_core.o serial_base_bus.o serial_ctrl.o serial_port.o
> 
> 'objs' is for user space tools, kernel should use 'y'

Oh OK.

> > +static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm, NULL,
> > +				 serial_port_runtime_resume, NULL);
> 
> Maybe
> 
> static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
> 				 NULL, serial_port_runtime_resume, NULL);
> 
> for better logical split?

Sure.

Thanks,

Tony
