Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB564750A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLHRkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 12:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLHRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:40:19 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DC4877DA6D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 09:40:17 -0800 (PST)
Received: (qmail 734591 invoked by uid 1000); 8 Dec 2022 12:40:17 -0500
Date:   Thu, 8 Dec 2022 12:40:17 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com>,
        WeitaoWang-oc@zhaoxin.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, khalid.masum.92@gmail.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in __usb_hcd_giveback_urb (2)
Message-ID: <Y5IhgenNzQXzbWqT@rowland.harvard.edu>
References: <0000000000002fc8dc05ef267a9f@google.com>
 <Y49h3MX8iXEO/na+@rowland.harvard.edu>
 <cac60598-5080-5876-d28d-e8caab8b9b0f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac60598-5080-5876-d28d-e8caab8b9b0f@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 03:36:45PM +0100, Oliver Neukum wrote:
> On 06.12.22 16:38, Alan Stern wrote:
> 
> Hi,
> 
> > Oliver:
> > 
> > This looks like a bug in the anchor API.
> 
> Yes, it does.
> > On Tue, Dec 06, 2022 at 02:43:41AM -0800, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    ef4d3ea40565 afs: Fix server->active leak in afs_put_server
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=100b244d880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=8e7e79f8a1e34200
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=712fd0e60dda3ba34642
> > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/ef790e7777cd/disk-ef4d3ea4.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/2ed3c6bc9230/vmlinux-ef4d3ea4.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/f1dbd004fa88/bzImage-ef4d3ea4.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com
> > > 
> > > xpad 3-1:179.65: xpad_irq_in - usb_submit_urb failed with result -19
> > > xpad 3-1:179.65: xpad_irq_out - usb_submit_urb failed with result -19
> > > ==================================================================
> > > BUG: KASAN: use-after-free in register_lock_class+0x8d2/0x9b0 kernel/locking/lockdep.c:1338

> > >   __wake_up+0xf8/0x1c0 kernel/sched/wait.c:156
> > >   __usb_hcd_giveback_urb+0x3a0/0x530 drivers/usb/core/hcd.c:1674
> 
> 
> > This is the call to usb_anchor_resume_wakeups().  The call is made after
> > the completion handler callback.  Evidently the xpad driver deallocated
> > the anchor during that time window.  This can happen if the driver is
> > just waiting for its last URB to complete before freeing all its memory.
> 
> Yes, complete() had run.
> > 
> > I don't know what the best solution is.  It may be necessary to refcount
> > anchors somehow.
> 
> Then we cannot embed them anymore. Many drivers would need a lot of changes.
> xpad included.

It's hard to tell what's really going on.  Looking at 
xpad_stop_output(), you see that it doesn't do anything if xpad->type is 
XTYPE_UNKNOWN.  Is that what happened here?

I can't figure out where the underlying race is.  Maybe it's not 
directly connected with anchors after all.

> As far as I can tell the order we decrease use_count is correct. But:
> 
> 6ec4147e7bdbd (Hans de Goede             2013-10-09 17:01:41 +0200 1674)        usb_anchor_resume_wakeups(anchor);
> 94dfd7edfd5c9 (Ming Lei                  2013-07-03 22:53:07 +0800 1675)        atomic_dec(&urb->use_count);
> 
> Do we need to guarantee memory ordering here?

I don't think we need to do anything more.  usb_kill_urb() is careful to 
wait for completion handlers to finish, and we already have 
smp_mb__after_atomic() barriers in the appropriate places to ensure 
proper memory ordering.

Alan Stern
