Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271E6D48F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjDCOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjDCOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:33:12 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 02F45D4F83
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:33:03 -0700 (PDT)
Received: (qmail 326274 invoked by uid 1000); 3 Apr 2023 10:33:03 -0400
Date:   Mon, 3 Apr 2023 10:33:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in sisusb_send_bulk_msg/usb_submit_urb
Message-ID: <f396acba-2241-4f62-98ff-ba97ea1a7139@rowland.harvard.edu>
References: <00000000000096e4f905f81b2702@google.com>
 <b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu>
 <7b1f757b-b626-5d49-354e-343e040b8762@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b1f757b-b626-5d49-354e-343e040b8762@suse.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:54:05AM +0200, Oliver Neukum wrote:
> 
> 
> On 30.03.23 17:34, Alan Stern wrote:
> > Reference: https://syzkaller.appspot.com/bug?extid=23be03b56c5259385d79
> > 
> > The sisusbvga driver just assumes that the endpoints it uses will be
> > present, without checking.  I don't know anything about this driver, so
> > the fix below may not be entirely correct.
> 
> Hi,
> 
> this patch by itself looks good to me.
> 
> But the need for it is problematic. Do we have any vendor specific driver
> that could get away without an equivalent to this patch without showing
> an equivalent bug?

Probably not.  Which is why adding this checking infrastructure to the 
USB core seems like a good idea, even though implementing it in each of 
the vendor-specific drivers may take quite a while.

>  If so, why do we have a generic matching code, although
> it is always insufficient?

(I assume you're referring to usb_match_device() and related routines.)

Not sufficient, perhaps, but necessary.  That is, in addition to 
checking the available endpoints, we also have to make sure the device 
has the right vendor ID, product ID, and so on to match the driver.

> What is the purpose of a generic binding interface in sysfs if every probe()
> method blocks it? Allowing a generic probe looks like a misdesign under these
> circumstances. You'd really want to add IDs to drivers.

I really don't understand what you're asking.  If you're talking about 
the "bind" and "unbind" files in /sys/bus/*/drivers/*/, they are there 
to allow manual binding and unbinding of devices.  Even though only one 
driver is likely to bind to any particular device.  (Furthermore, all 
this was true even before we started being careful about checking 
endpoints numbers and types.)

And we _do_ have IDs in drivers; that's what the .id_table member of 
struct usb_driver is for.

Alan Stern
