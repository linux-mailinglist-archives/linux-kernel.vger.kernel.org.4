Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875A685FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 07:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBAGir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 01:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBAGiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 01:38:46 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6A3010AB6;
        Tue, 31 Jan 2023 22:38:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id ABB2B8154;
        Wed,  1 Feb 2023 06:38:43 +0000 (UTC)
Date:   Wed, 1 Feb 2023 08:38:42 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <Y9oI8m132aQOeSed@atomide.com>
References: <20230116080002.47315-1-tony@atomide.com>
 <Y9jo9bTnmejWYoH2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9jo9bTnmejWYoH2@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230131 10:10]:
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
> 
> Looking better, but why is this new device a platform device?  That
> feels odd, you should never have a platform device hanging off of a
> non-platform device, right?

No special need for it to be a platform device. It just is easy to set
up, and for my test case the serial port physical device is also a
platform device.

What's your preference here?

> What does the sysfs tree look like now with this patch applied?

Below are two examples of what's in sysfs.

Regards,

Tony

8< -----------------
On arm64 with two physical 8250 devices I have:

# ls -l /sys/devices/platform/serial8250/
total 0
lrwxrwxrwx    1 root     root             0 Jan  1  1970 driver -> ../../../bus/platform/drivers/serial8250
-rw-r--r--    1 root     root          4096 Jan  1  1970 driver_override
-r--r--r--    1 root     root          4096 Jan  1  1970 modalias
drwxr-xr-x    2 root     root             0 Jan  1  1970 power
drwxr-xr-x    5 root     root             0 Jan  1  1970 serial-ctrl.0.auto
lrwxrwxrwx    1 root     root             0 Jan  1  1970 subsystem -> ../../../bus/platform
drwxr-xr-x    4 root     root             0 Jan  1  1970 tty
-rw-r--r--    1 root     root          4096 Jan  1  1970 uevent

# ls -l /sys/devices/platform/serial8250/serial-ctrl*
total 0
lrwxrwxrwx    1 root     root             0 Jan  1  1970 driver -> ../../../../bus/platform/drivers/serial-ctrl
-rw-r--r--    1 root     root          4096 Jan  1  1970 driver_override
-r--r--r--    1 root     root          4096 Jan  1  1970 modalias
drwxr-xr-x    2 root     root             0 Jan  1  1970 power
drwxr-xr-x    3 root     root             0 Jan  1  1970 serial-port.1.auto
drwxr-xr-x    3 root     root             0 Jan  1  1970 serial-port.4.auto
lrwxrwxrwx    1 root     root             0 Jan  1  1970 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Jan  1  1970 uevent

On x86_64 qemu with one port I have:

# ls -l /sys/devices/pnp0/00:04/
total 0
lrwxrwxrwx    1 root     root             0 Feb  1 06:13 driver -> ../../../bus/pnp/drivers/serial
lrwxrwxrwx    1 root     root             0 Feb  1 06:13 firmware_node -> ../../LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/device:01/PNP0501:00
-r--r--r--    1 root     root          4096 Feb  1 06:13 id
-r--r--r--    1 root     root          4096 Feb  1 06:13 options
-rw-r--r--    1 root     root          4096 Feb  1 06:13 resources
drwxr-xr-x    3 root     root             0 Feb  1 06:12 serial-ctrl.0.auto
lrwxrwxrwx    1 root     root             0 Feb  1 06:13 subsystem -> ../../../bus/pnp
drwxr-xr-x    3 root     root             0 Feb  1 06:12 tty
-rw-r--r--    1 root     root          4096 Feb  1 06:12 uevent

# ls -l /sys/devices/pnp0/00:04/serial-ctrl.0.auto/
total 0
lrwxrwxrwx    1 root     root             0 Feb  1 06:13 driver -> ../../../../bus/platform/drivers/serial-ctrl
-rw-r--r--    1 root     root          4096 Feb  1 06:13 driver_override
-r--r--r--    1 root     root          4096 Feb  1 06:13 modalias
drwxr-xr-x    2 root     root             0 Feb  1 06:12 serial-port.1.auto
lrwxrwxrwx    1 root     root             0 Feb  1 06:13 subsystem -> ../../../../bus/platform
-rw-r--r--    1 root     root          4096 Feb  1 06:12 uevent
