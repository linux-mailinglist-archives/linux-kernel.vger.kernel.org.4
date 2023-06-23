Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001FF73BB90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjFWPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjFWPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:23:57 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DD5D719B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:23:54 -0700 (PDT)
Received: (qmail 753372 invoked by uid 1000); 23 Jun 2023 11:23:53 -0400
Date:   Fri, 23 Jun 2023 11:23:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lkp@intel.com, netdev@vger.kernel.org, nogikh@google.com,
        oneukum@suse.com, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, troels@connectedcars.dk
Subject: Re: [syzbot] [usb?] WARNING in usbnet_start_xmit/usb_submit_urb
Message-ID: <0f685f2f-06df-4cf2-9387-34f5e3c8b7b7@rowland.harvard.edu>
References: <000000000000a56e9105d0cec021@google.com>
 <000000000000e298cd05fecc07d4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e298cd05fecc07d4@google.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 06:32:22AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 45bf39f8df7f05efb83b302c65ae3b9bc92b7065
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Tue Jan 31 20:49:04 2023 +0000
> 
>     USB: core: Don't hold device lock while reading the "descriptors" sysfs file
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124b5877280000
> start commit:   692b7dc87ca6 Merge tag 'hyperv-fixes-signed-20230619' of g..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=114b5877280000
> console output: https://syzkaller.appspot.com/x/log.txt?x=164b5877280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
> dashboard link: https://syzkaller.appspot.com/bug?extid=63ee658b9a100ffadbe2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1760094b280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1359cdf3280000
> 
> Reported-by: syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com
> Fixes: 45bf39f8df7f ("USB: core: Don't hold device lock while reading the "descriptors" sysfs file")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

The bisection result is wrong, but the issue still needs to be fixed.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.4-rc7

Index: usb-devel/drivers/net/usb/usbnet.c
===================================================================
--- usb-devel.orig/drivers/net/usb/usbnet.c
+++ usb-devel/drivers/net/usb/usbnet.c
@@ -1775,6 +1775,9 @@ usbnet_probe (struct usb_interface *udev
 	} else if (!info->in || !info->out)
 		status = usbnet_get_endpoints (dev, udev);
 	else {
+		u8		ep_addrs[3] = {
+			info->in + USB_DIR_IN, info->out + USB_DIR_OUT, 0};
+
 		dev->in = usb_rcvbulkpipe (xdev, info->in);
 		dev->out = usb_sndbulkpipe (xdev, info->out);
 		if (!(info->flags & FLAG_NO_SETINT))
@@ -1784,6 +1787,8 @@ usbnet_probe (struct usb_interface *udev
 		else
 			status = 0;
 
+		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
+			status = -EINVAL;
 	}
 	if (status >= 0 && dev->status)
 		status = init_status (dev, udev);
