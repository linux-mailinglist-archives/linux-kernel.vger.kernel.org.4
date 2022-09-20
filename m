Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601265BECA5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiITSQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITSQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:16:07 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1B24E4F387
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:16:05 -0700 (PDT)
Received: (qmail 191387 invoked by uid 1000); 20 Sep 2022 14:16:04 -0400
Date:   Tue, 20 Sep 2022 14:16:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     balbi@kernel.org, andriy.shevchenko@linux.intel.com,
        jakobkoschel@gmail.com, quic_wcheng@quicinc.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: kernel v5.19 warn in usb_ep_queue
Message-ID: <YyoDZNZX2ggSuaFE@rowland.harvard.edu>
References: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:12:04AM +0800, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver 5.19.0-rc4-00208-g69cb6c6556ad,
> the following crash was triggered.
> 
> HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
> git tree: upstream
> 
> kernel config: https://pastebin.com/KecL2gaG
> C reproducer: https://pastebin.com/wLDJ9cnP
> console output: https://pastebin.com/t0r8EwTw
> 
> Basically, in the c reproducer, we use the gadget module to emulate
> the process of attaching a usb device (vendor id: 0xbaf, product id:
> 0x121, with function: midi and ms_null).
> To reproduce this crash, we utilize a third-party library to emulate
> the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> Just clone this repository, make install it, and compile the c
> reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
> trick.
> 
> It seems that an error state in struct usb_ep trigger such kernel warning.
> 
> The crash report is as follow:
> 
> ```
> ------------[ cut here ]------------
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 3442 at drivers/usb/gadget/udc/core.c:283
> usb_ep_queue+0x16b/0x3b0 drivers/usb/gadget/udc/core.c:283
> Modules linked in:
> CPU: 3 PID: 3442 Comm: file-storage Not tainted
> 5.19.0-rc4-00208-g69cb6c6556ad #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:usb_ep_queue+0x16b/0x3b0 drivers/usb/gadget/udc/core.c:283
> Code: 46 05 0f 92 c3 31 ff 89 de e8 f1 e9 49 fd 84 db 0f 85 16 01 00
> 00 e8 c4 e8 49 fd 44 89 e0 5b 5d 41 5c 41 5d c3 e8 b5 e8 49 fd <0f> 0b
> 41 bc 94 ff ff ff e9 73 ff ff ff e8 a3 e8 49 fd 65 8b 1d cc
> RSP: 0018:ffffc9000490fd00 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff888110e0d580
> RDX: 0000000000000000 RSI: ffff888110e0d580 RDI: 0000000000000002
> RBP: ffff88810ae84158 R08: ffffffff83fb31eb R09: 0000000000000000
> R10: 0000000000000001 R11: ffffed10221c1ab0 R12: 0000000000000cc0
> R13: ffff888111843f10 R14: ffff888111843f10 R15: ffff88811084e000
> FS: 0000000000000000(0000) GS:ffff88811a980000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f841985e020 CR3: 000000010d19a000 CR4: 0000000000350ee0
> Call Trace:
> <TASK>
> start_transfer.isra.0+0x26/0x100
> drivers/usb/gadget/function/f_mass_storage.c:527
> start_out_transfer.isra.0+0xf0/0x1b0
> drivers/usb/gadget/function/f_mass_storage.c:560
> get_next_command drivers/usb/gadget/function/f_mass_storage.c:2249 [inline]
> fsg_main_thread+0x377/0x6fc0 drivers/usb/gadget/function/f_mass_storage.c:2572
> kthread+0x2ef/0x3a0 kernel/kthread.c:376
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> </TASK>

Can you please try to recreate this bug after applying the diagnostic 
patch below?  I'd like to see what output it produces in the kernel log.

Alan Stern


Index: usb-devel/drivers/usb/gadget/function/f_mass_storage.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/function/f_mass_storage.c
+++ usb-devel/drivers/usb/gadget/function/f_mass_storage.c
@@ -415,6 +415,7 @@ static void bulk_in_complete(struct usb_
 	struct fsg_common	*common = ep->driver_data;
 	struct fsg_buffhd	*bh = req->context;
 
+	dev_info(&common->gadget->dev, "Bulk in complete %p\n", bh);
 	if (req->status || req->actual != req->length)
 		DBG(common, "%s --> %d, %u/%u\n", __func__,
 		    req->status, req->actual, req->length);
@@ -431,6 +432,7 @@ static void bulk_out_complete(struct usb
 	struct fsg_common	*common = ep->driver_data;
 	struct fsg_buffhd	*bh = req->context;
 
+	dev_info(&common->gadget->dev, "Bulk out complete %p\n", bh);
 	dump_msg(common, "bulk-out", req->buf, req->actual);
 	if (req->status || req->actual != bh->bulk_out_intended_length)
 		DBG(common, "%s --> %d, %u/%u\n", __func__,
@@ -547,6 +549,7 @@ static bool start_in_transfer(struct fsg
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_SENDING;
+	dev_info(&common->gadget->dev, "Bulk in start %p\n", bh);
 	if (start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq))
 		bh->state = BUF_STATE_EMPTY;
 	return true;
@@ -557,6 +560,7 @@ static bool start_out_transfer(struct fs
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_RECEIVING;
+	dev_info(&common->gadget->dev, "Bulk out start %p\n", bh);
 	if (start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq))
 		bh->state = BUF_STATE_FULL;
 	return true;
@@ -2310,10 +2314,12 @@ reset:
 
 		/* Disable the endpoints */
 		if (fsg->bulk_in_enabled) {
+			dev_info(&fsg->gadget->dev, "Disable bulk in A\n");
 			usb_ep_disable(fsg->bulk_in);
 			fsg->bulk_in_enabled = 0;
 		}
 		if (fsg->bulk_out_enabled) {
+			dev_info(&fsg->gadget->dev, "Disable bulk out A\n");
 			usb_ep_disable(fsg->bulk_out);
 			fsg->bulk_out_enabled = 0;
 		}
@@ -2333,6 +2339,7 @@ reset:
 	rc = config_ep_by_speed(common->gadget, &(fsg->function), fsg->bulk_in);
 	if (rc)
 		goto reset;
+	dev_info(&fsg->gadget->dev, "Enable bulk in\n");
 	rc = usb_ep_enable(fsg->bulk_in);
 	if (rc)
 		goto reset;
@@ -2343,6 +2350,7 @@ reset:
 				fsg->bulk_out);
 	if (rc)
 		goto reset;
+	dev_info(&fsg->gadget->dev, "Enable bulk out\n");
 	rc = usb_ep_enable(fsg->bulk_out);
 	if (rc)
 		goto reset;
@@ -2392,10 +2400,12 @@ static void fsg_disable(struct usb_funct
 
 	/* Disable the endpoints */
 	if (fsg->bulk_in_enabled) {
+		dev_info(&fsg->gadget->dev, "Disable bulk in B\n");
 		usb_ep_disable(fsg->bulk_in);
 		fsg->bulk_in_enabled = 0;
 	}
 	if (fsg->bulk_out_enabled) {
+		dev_info(&fsg->gadget->dev, "Disable bulk out B\n");
 		usb_ep_disable(fsg->bulk_out);
 		fsg->bulk_out_enabled = 0;
 	}

