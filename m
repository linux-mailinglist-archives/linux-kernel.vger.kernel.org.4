Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0042C693BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBMBXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBMBXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:23:36 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CE847EB4E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:23:34 -0800 (PST)
Received: (qmail 891888 invoked by uid 1000); 12 Feb 2023 20:23:34 -0500
Date:   Sun, 12 Feb 2023 20:23:34 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+mRFUws3dOpU8qS@rowland.harvard.edu>
References: <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+k6ehYLWa0cmbvb@moria.home.lan>
 <Y+lJxCLpwMGuq0sP@rowland.harvard.edu>
 <Y+lROV3Ii+WbmZCh@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+lROV3Ii+WbmZCh@moria.home.lan>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 03:51:05PM -0500, Kent Overstreet wrote:
> On Sun, Feb 12, 2023 at 03:19:16PM -0500, Alan Stern wrote:
> > I'll revise the patch to use the device's name for the class.  While it 
> > may not be globally unique, it should be sufficiently specific.
> > 
> > (Device names are often set after the device is initialized.  Does 
> > lockdep mind if a lock_class_key's name is changed after it has been 
> > registered?)
> 
> The device name should _not_ be something dynamic, it should be
> something easily tied back to a source code location - i.e. related to
> the driver name, not the device name.
> 
> That's how people read and use lockdep reports!
> 
> Do it exactly the same way mutex_init() does it, just lift it up a level
> to a wrapper around device_initialize() - stringify the pointer to the
> mutex (embedded in struct device, embedded in what-have-you driver code)
> and use that.

I really don't think that's a good idea here.  When you've got a bus 
containing multiple devices, typically all those device structures are 
created by the same line of code.  So knowing the source code location 
won't tell you _which_ device structure is involved in the locking 
cycle or what driver it's using.  By contrast, knowing the device name 
would.

Furthermore, to the extent that the device's name identifies what kind 
of device it is, the name would tell you what where the structure was 
created and which driver it is using.

For example, knowing that a struct device was initialized in line 2104 
of drivers/usb/core/message.c tells you only that the device is a USB 
interface.  It doesn't tell you which USB interface.  But knowing that 
the device's name is 1-7:1.1 not only tells me that the device is a USB 
interface, it also allows me to do:

$ ls -l /sys/bus/usb/devices/1-7:1.1/driver
lrwxrwxrwx. 1 root root 0 Feb 12 19:56 /sys/bus/usb/devices/1-7:1.1/driver -> ../../../../../../bus/usb/drivers/usbhid/

telling me that the device is some sort of HID device.  Probably my 
laptop's touchpad (which could easily be verified).  Even without direct 
interaction with the system, searching through the kernel log would give 
me this information.

> > At this stage, converting would be most impractical.  And I don't think 
> > it's really needed.
> 
> They do make you deal with lock restarts; unwinding typical stateful
> kernel code is not necessarily super practical :)
> 
> Anyways, it sounds like the lockdep-class-per-driver approach will get
> you more information, that's certainly a reasonable approach for now.

Thanks for the review and suggestions.

Alan Stern
