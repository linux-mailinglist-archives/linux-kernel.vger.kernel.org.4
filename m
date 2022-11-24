Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFF637D14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKXPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKXPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:37:12 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9481113FF6;
        Thu, 24 Nov 2022 07:37:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C667A80AF;
        Thu, 24 Nov 2022 15:37:08 +0000 (UTC)
Date:   Thu, 24 Nov 2022 17:37:07 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <Y3+PoxJNJm0Pe+Xm@atomide.com>
References: <20220615062455.15490-1-tony@atomide.com>
 <Yrmfr3GfXYhclKXA@kroah.com>
 <Yrm1HaUtjTMcSIE+@atomide.com>
 <562c1505-d3bc-6422-9598-15c399e6fbba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <562c1505-d3bc-6422-9598-15c399e6fbba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Jiri Slaby <jirislaby@kernel.org> [221124 06:53]:
> Hi,
> 
> I am returning to v2, as I managed to read only v3 and only now. But here
> was already the point below.
> 
> On 27. 06. 22, 15:48, Tony Lindgren wrote:
> > > > Considering the above, let's improve the serial core layer so we can
> > > > manage the serial port controllers better. Let's register the controllers
> > > > with the serial core layer in addition to the serial ports.
> > > 
> > > Why can't controllers be a device as well?
> > 
> > The controllers are devices already probed by the serial port drivers.
> > What's missing is mapping the ports (as devices based on the comments
> > above) to the controller devices. I don't think we need another struct
> > device for the serial controller in addition to the serial port driver
> > device and it's child port devices.
> 
> To be honest, I don't like the patch (even v3). We have uart_state which I
> already hate and now we have another structure holding *some* other info
> about a serial device (apart from uart_port). It's mess already and hard to
> follow, esp. to newcomers.

Yup the serial code sure is hard to follow..

> AFAIU, what Greg suggests would be:
> 
> PCI/platform/acpi/whatever struct dev
>   -> serial controller 1 struct dev
>      -> serial port 1 struct dev (tty_port instance exists for this)
>      -> serial port 2 struct dev (tty_port instance exists for this)
>      -> ...
>   -> serial controller 2 struct dev
>      -> serial port 1 struct dev (tty_port instance exists for this)
>      -> serial port 2 struct dev (tty_port instance exists for this)
>      -> ...

Oh you want the serial controller struct device as a child of the
hardware controller struct device. Yeah that makes sense to put it there.

I was kind of thinking we want the port devices be direct children of
the hardware struct device, but I guess there is no such need.

> And you are objecting that mostly (or in all cases?), there will never be
> "serial controller 2"?

I'm was not aware of the need for multiple serial port controllers
connected to a single hardware controller struct device. Is there an
example for that somewhere?

Not that multiple serial controller struct devices matters with your
suggestion, just wondering.

> But given your description, I believe you need it anyway -- side note: does
> really the PM layer/or you need it or would you be fine with "serial port N"
> dev children? But provided you don't have the controller, you work around it
> by struct serial_controller. So what's actually the point of the workaround
> instead of sticking to proper driver model? With the workaround you seem you
> have to implement all the binding, lookup and such yourself anyway. And that
> renders the serial even worse :P. Let's do the reverse instead.

To me it seems your suggestion actually makes things easier for runtime
PM :)

We can just enable runtime PM for the serial controller struct device
without tinkering with the parent hardware controller struct device.

> The only thing I am not sure about, whether tty_port should be struct dev
> too -- and if it should have serial port 1 as a parent. But likely so. And
> then with pure tty (i.e. tty_driver's, not uart_driver's), it would have
> PCI/platform/acpi/whatever as a parent directly.

That seems like a separate set of patches, no? Or is there some need right
now to have some child struct device as a direct child of the hardware
controller struct device?

> In sum, the above structure makes perfect sense to me. There has only been
> noone to do the real work yet. And having tty_port was a hard prerequisite
> for this to happen. And that happened long time ago. All this would need a
> lot of work initially¹⁾, but it paid off a lot in long term.
> 
> ¹⁾I know what I am writing about -- I converted HID. After all, the core was
> only 1000 lines patch (cf 85cdaf524b7d) + patches to convert all the drivers
> incrementally (like 8c19a51591).

Cool, thanks for your suggestions.

Regards,

Tony
