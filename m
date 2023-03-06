Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9D6AB68F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCFGuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCFGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:50:11 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F6D7F949;
        Sun,  5 Mar 2023 22:49:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A34328027;
        Mon,  6 Mar 2023 06:49:28 +0000 (UTC)
Date:   Mon, 6 Mar 2023 08:49:27 +0200
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
Subject: Re: [PATCH v5 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230306064927.GA7501@atomide.com>
References: <20230116080002.47315-1-tony@atomide.com>
 <ZADJm+co4goPgr7u@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADJm+co4goPgr7u@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230302 16:07]:
> On Mon, Jan 16, 2023 at 09:59:58AM +0200, Tony Lindgren wrote:
> > We want to enable runtime PM for serial port device drivers in a generic
> > way. To do this, we want to have the serial core layer manage the
> > registered physical serial controller devices.
> > 
> > To do this, let's set up a struct device for the serial core controller
> > as suggested by Greg and Jiri. The serial core controller devices are
> > children of the physical serial port device. The serial core controller
> > device is needed to support multiple different kind of ports connected
> > to single physical serial port device.
> > 
> > Let's also set up a struct device for the serial core port. The serial
> > core port instances are children of the serial core controller device.
> > 
> > With the serial core port device we can now flush pending TX on the
> > runtime PM resume as suggested by Johan.
> 
> A side note. Perhaps it makes sense to also clean up documentation somehow
> related to this change. For example, I found that
> Documentation/firmware-guide/acpi/enumeration.rst has this:
> 
>   "Note that standard UARTs are not busses so there is no struct uart_device,
>    although some of them may be represented by struct serdev_device."

OK good point, will update that for the next version.

FYI, I replaced the serial core platform bus with just struct device and
bus, need to clean-up a bit before posting though.

Regards,

Tony
