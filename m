Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A86D4B92
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjDCPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjDCPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:16:27 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4F1CFDD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:16:26 -0700 (PDT)
Received: (qmail 328630 invoked by uid 1000); 3 Apr 2023 11:16:25 -0400
Date:   Mon, 3 Apr 2023 11:16:25 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in sisusb_send_bulk_msg/usb_submit_urb
Message-ID: <e59c73d3-248a-46cb-b5d8-6c78c67c55ad@rowland.harvard.edu>
References: <00000000000096e4f905f81b2702@google.com>
 <b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu>
 <7b1f757b-b626-5d49-354e-343e040b8762@suse.com>
 <f396acba-2241-4f62-98ff-ba97ea1a7139@rowland.harvard.edu>
 <97ea1633-3c9e-5042-4edc-8c52f668cc9e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ea1633-3c9e-5042-4edc-8c52f668cc9e@suse.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 04:51:26PM +0200, Oliver Neukum wrote:
> 
> 
> On 03.04.23 16:33, Alan Stern wrote:
> > On Mon, Apr 03, 2023 at 10:54:05AM +0200, Oliver Neukum wrote:
> > > 
> > > 
> > > On 30.03.23 17:34, Alan Stern wrote:
> 
> > >   If so, why do we have a generic matching code, although
> > > it is always insufficient?
> > 
> > (I assume you're referring to usb_match_device() and related routines.)
> > 
> > Not sufficient, perhaps, but necessary.  That is, in addition to
> > checking the available endpoints, we also have to make sure the device
> > has the right vendor ID, product ID, and so on to match the driver.
> 
> The thing is that if we also need to check in each driver, the criteria
> for matching devices are not sophisticated and strict enough

Why not?  Part of the check takes place in the core and part in the 
driver.  The fact that the checking is done in two parts doesn't mean it 
is unsophisticated or not strict enough.

In addition, one can argue that only the checking done in the core 
should be called "matching".  If the match succeeds then it is 
appropriate to try binding the device to the matching driver.  If the 
driver then refuses to accept the binding because (for example) the 
endpoints are wrong, it doesn't mean the match should have failed.  It 
means that the device is broken in some way and is therefore unusable.

> > > What is the purpose of a generic binding interface in sysfs if every probe()
> > > method blocks it? Allowing a generic probe looks like a misdesign under these
> > > circumstances. You'd really want to add IDs to drivers.
> > 
> > I really don't understand what you're asking.  If you're talking about
> > the "bind" and "unbind" files in /sys/bus/*/drivers/*/, they are there
> 
> Yes
> 
> > to allow manual binding and unbinding of devices.  Even though only one
> > driver is likely to bind to any particular device.  (Furthermore, all
> 
> They, however, allow binding drivers to arbitrary devices.

No.  The binding uses the normal matching and probing mechanism.  Here's 
the comment at the start of bind_store() in drivers/base/bus.c:

/*
 * Manually attach a device to a driver.
 * Note: the driver must want to bind to the device,
 * it is not possible to override the driver's id table.
 */

> Now, you can argue that this will not work. Then I'd say that the correct interface
> would be per device, not per driver as it is now and would retrigger
> a binding, as if the device were new.
> Or you say that if the administrator wants that, well, shoot
> yourself into the foot, the driver shall not check.

In view of the misunderstanding above, these comments are moot.

> > this was true even before we started being careful about checking
> > endpoints numbers and types.)
> > 
> > And we _do_ have IDs in drivers; that's what the .id_table member of
> > struct usb_driver is for.
> 
> Which is not exported through sysfs.

True, the built-in table is not exported (I guess we could add some sort 
of read-only view of it).  There is, however an additional dynamic ID 
table which _is_ managed through sysfs.

> So we export an interface that is not fully usable, not the one people
> really want. You almost never want to say that a device at a specific
> port is to be bound to a driver at one specific time.
> You want to either assign all devices with a new ID to a driver
> or unbind and reprobe a device.

The first can be done by adding a dynamic ID entry (or on a permanent 
basis by updating the driver's built-in table and rebuilding the 
driver's module), and the second can be done using the "unbind" and 
"bind" files.

Alan Stern
