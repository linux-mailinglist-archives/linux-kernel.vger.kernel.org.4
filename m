Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C373A6605BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjAFRdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjAFRd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:33:27 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 69A8773E0C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:33:24 -0800 (PST)
Received: (qmail 557466 invoked by uid 1000); 6 Jan 2023 12:33:23 -0500
Date:   Fri, 6 Jan 2023 12:33:23 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+2a0e7abd24f1eb90ce25@syzkaller.appspotmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Oliver Neukum <oneukum@suse.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mailhol.vincent@wanadoo.fr,
        mkl@pengutronix.de, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in __usbnet_read_cmd/usb_submit_urb
Message-ID: <Y7hbY2ttx4ZLkKNY@rowland.harvard.edu>
References: <00000000000008f1d405f1999228@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000008f1d405f1999228@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 06:52:45AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1b929c02afd3 Linux 6.2-rc1
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=128acc94480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=19062640e84d2e8f
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a0e7abd24f1eb90ce25
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.

I don't know why not; the bug is easily repeatable.

> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/22dc9b4a71a2/disk-1b929c02.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3a88668bf3ce/vmlinux-1b929c02.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3ff0c2e45492/bzImage-1b929c02.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2a0e7abd24f1eb90ce25@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 3-1: BOGUS control dir, pipe 80003d80 doesn't match bRequestType c0
> WARNING: CPU: 1 PID: 2386 at drivers/usb/core/urb.c:411 usb_submit_urb+0x14a3/0x1880 drivers/usb/core/urb.c:411

> Call Trace:
>  <TASK>
>  usb_start_wait_urb+0x101/0x4b0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  __usbnet_read_cmd+0xb9/0x390 drivers/net/usb/usbnet.c:2010
>  usbnet_read_cmd+0x92/0xf0 drivers/net/usb/usbnet.c:2068
>  pl_vendor_req drivers/net/usb/plusb.c:60 [inline]

This is obviously a bug in plusb.c.  The code is:

static inline int
pl_vendor_req(struct usbnet *dev, u8 req, u8 val, u8 index)
{
	return usbnet_read_cmd(dev, req,
				USB_DIR_IN | USB_TYPE_VENDOR |
				USB_RECIP_DEVICE,
				val, index, NULL, 0);
}

Since the transfer length is 0 this should be a write, not a read.  The 
USB_DIR_IN value shouldn't be present, and the call should be to 
usbnet_write_cmd().

There's a similar mistake in __usbnet_read_cmd().  The routine tests for 
zero-length transfers, but when it finds one it merely avoids allocating 
a transfer buffer instead of warning about a programming bug.

Alan Stern
