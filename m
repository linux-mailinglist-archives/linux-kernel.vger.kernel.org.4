Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39B16F3690
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjEATQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjEATQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:16:48 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1F0CF2717
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:16:46 -0700 (PDT)
Received: (qmail 313863 invoked by uid 1000); 1 May 2023 15:16:45 -0400
Date:   Mon, 1 May 2023 15:16:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] memory leak in class_create
Message-ID: <ba18f241-72ef-4d10-acaf-5fc34edbd695@rowland.harvard.edu>
References: <00000000000077472605faa4aad5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000077472605faa4aad5@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 09:53:45AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    22b8cc3e78f5 Merge tag 'x86_mm_for_6.4' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16fc7958280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5046ebeca744dd40
> dashboard link: https://syzkaller.appspot.com/bug?extid=e7afd76ad060fa0d2605
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599a2b4280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14eb395fc80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3ad2088c196b/disk-22b8cc3e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/61919a5b89c6/vmlinux-22b8cc3e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a7adb5503ac8/bzImage-22b8cc3e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88810af67080 (size 96):
>   comm "kworker/0:2", pid 4402, jiffies 4294950769 (age 14.190s)
>   hex dump (first 32 bytes):
>     bf 03 9b 85 ff ff ff ff 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81544e14>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
>     [<ffffffff82b65445>] kmalloc include/linux/slab.h:559 [inline]
>     [<ffffffff82b65445>] kzalloc include/linux/slab.h:680 [inline]
>     [<ffffffff82b65445>] class_create+0x25/0x90 drivers/base/class.c:261
>     [<ffffffff831f7a80>] init_usb_class drivers/usb/core/file.c:91 [inline]
>     [<ffffffff831f7a80>] usb_register_dev+0x290/0x3d0 drivers/usb/core/file.c:179
>     [<ffffffff832cffc4>] usblp_probe+0x4e4/0x750 drivers/usb/class/usblp.c:1208
>     [<ffffffff831f39a9>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
>     [<ffffffff82b62d7d>] call_driver_probe drivers/base/dd.c:579 [inline]
>     [<ffffffff82b62d7d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
>     [<ffffffff82b63141>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:800
>     [<ffffffff82b6324a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
>     [<ffffffff82b6343b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:958
>     [<ffffffff82b60191>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
>     [<ffffffff82b63962>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1030
>     [<ffffffff82b618fa>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
>     [<ffffffff82b5def3>] device_add+0x993/0xc60 drivers/base/core.c:3625
>     [<ffffffff831f0a89>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
>     [<ffffffff832033a1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238
>     [<ffffffff831f3080>] usb_probe_device+0x60/0x140 drivers/usb/core/driver.c:293

There is definitely a memory leak in usb_register_dev()'s error pathways 
-- it doesn't call destroy_usb_class() -- but I don't think that is the 
cause of this bug.  Let's try some diagnostics.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 22b8cc3e78f5

Index: usb-devel/drivers/usb/core/file.c
===================================================================
--- usb-devel.orig/drivers/usb/core/file.c
+++ usb-devel/drivers/usb/core/file.c
@@ -209,6 +209,8 @@ int usb_register_dev(struct usb_interfac
 		retval = PTR_ERR(intf->usb_dev);
 	}
 	up_write(&minor_rwsem);
+	dev_info(&intf->dev, "Post class create: refcount %d\n",
+			atomic_read(&usb_class->kref.refcount.refs));
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_register_dev);
@@ -242,6 +244,8 @@ void usb_deregister_dev(struct usb_inter
 
 	intf->usb_dev = NULL;
 	intf->minor = -1;
+	dev_info(&intf->dev, "Pre class destroy: refcount %d\n",
+			atomic_read(&usb_class->kref.refcount.refs));
 	destroy_usb_class();
 }
 EXPORT_SYMBOL_GPL(usb_deregister_dev);
