Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C955C5C03E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIUQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiIUQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:17:26 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B65BEAA3D6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:02:31 -0700 (PDT)
Received: (qmail 224768 invoked by uid 1000); 21 Sep 2022 12:01:20 -0400
Date:   Wed, 21 Sep 2022 12:01:20 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     balbi@kernel.org, andriy.shevchenko@linux.intel.com,
        jakobkoschel@gmail.com, quic_wcheng@quicinc.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: kernel v5.19 warn in usb_ep_queue
Message-ID: <Yys1UHJ/+XoKyR6Y@rowland.harvard.edu>
References: <CAB7eexKe2YtpYHy0Ohyr-SXLAWUjErJGLSspSUCeEL=CWyZSKw@mail.gmail.com>
 <YyoDZNZX2ggSuaFE@rowland.harvard.edu>
 <CAB7eexKT341KugNjfEKKVzFNoDJcECh5Ni2mpKSTyp7MqYjAsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexKT341KugNjfEKKVzFNoDJcECh5Ni2mpKSTyp7MqYjAsA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:00:41PM +0800, Rondreis wrote:
> Thanks for your reply!
> I applied this patch in v5.19 and the reproducer just attached
> a composite device with network and mass storage functions.
> The output of the kernel is as follows:

> [ 1558.868398][ T7423] configfs-gadget gadget.1: Enable bulk in
> [ 1558.868675][ T7423] configfs-gadget gadget.1: Enable bulk out
> [ 1558.868957][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
> [ 1558.952998][   T24] cdc_eem 2-1:1.0 usb1: register 'cdc_eem' at
> usb-dummy_hcd.1-1, CDC EEM Device, 72:47:e4:74:0b:8e
> [ 1558.968402][   T24] usb-storage 2-1:1.1: USB Mass Storage device detected
> [ 1558.976267][   T24] scsi host2: usb-storage 2-1:1.1
> [ 1560.028547][ T7470] cdc_eem 2-1:1.0 usb1: unregister 'cdc_eem'
> usb-dummy_hcd.1-1, CDC EEM Device
> [ 1560.078980][ T7470] configfs-gadget gadget.1: Bulk out complete
> ffff8881279f0b00
> [ 1560.080226][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
> [ 1560.080617][ T7470] configfs-gadget gadget.1: Disable bulk in B
> [ 1560.080820][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
> [ 1560.081456][ T7470] configfs-gadget gadget.1: Disable bulk out B
> [ 1560.081950][ T7423] configfs-gadget gadget.1: Bulk out start ffff8881279f0b00
> [ 1560.083056][ T7423] ------------[ cut here ]------------
> [ 1560.083386][ T7423] WARNING: CPU: 0 PID: 7423 at
> drivers/usb/gadget/udc/core.c:283 usb_ep_queue+0x9b/0x3b0

Okay, that's not what I expected.  Can you try the same thing with 
updated patch below?

Alan Stern


Index: usb-devel/drivers/usb/gadget/function/f_mass_storage.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/function/f_mass_storage.c
+++ usb-devel/drivers/usb/gadget/function/f_mass_storage.c
@@ -367,6 +367,7 @@ static void __raise_exception(struct fsg
 {
 	unsigned long		flags;
 
+	dev_info(&common->gadget->dev, "Raise exception %d %p\n", new_state, arg);
 	/*
 	 * Do nothing if a higher-priority exception is already in progress.
 	 * If a lower-or-equal priority exception is in progress, preempt it
@@ -415,6 +416,7 @@ static void bulk_in_complete(struct usb_
 	struct fsg_common	*common = ep->driver_data;
 	struct fsg_buffhd	*bh = req->context;
 
+	dev_info(&common->gadget->dev, "Bulk in complete %p\n", bh);
 	if (req->status || req->actual != req->length)
 		DBG(common, "%s --> %d, %u/%u\n", __func__,
 		    req->status, req->actual, req->length);
@@ -431,6 +433,7 @@ static void bulk_out_complete(struct usb
 	struct fsg_common	*common = ep->driver_data;
 	struct fsg_buffhd	*bh = req->context;
 
+	dev_info(&common->gadget->dev, "Bulk out complete %p\n", bh);
 	dump_msg(common, "bulk-out", req->buf, req->actual);
 	if (req->status || req->actual != bh->bulk_out_intended_length)
 		DBG(common, "%s --> %d, %u/%u\n", __func__,
@@ -547,6 +550,7 @@ static bool start_in_transfer(struct fsg
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_SENDING;
+	dev_info(&common->gadget->dev, "Bulk in start %p\n", bh);
 	if (start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq))
 		bh->state = BUF_STATE_EMPTY;
 	return true;
@@ -557,6 +561,8 @@ static bool start_out_transfer(struct fs
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_RECEIVING;
+	dev_info(&common->gadget->dev, "Bulk out start %p\n", bh);
+	dump_stack();
 	if (start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq))
 		bh->state = BUF_STATE_FULL;
 	return true;
@@ -2310,12 +2316,15 @@ reset:
 
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
+			dev_info(&fsg->gadget->dev, "Disable bulk out A finished\n");
 		}
 
 		common->fsg = NULL;
@@ -2333,6 +2342,7 @@ reset:
 	rc = config_ep_by_speed(common->gadget, &(fsg->function), fsg->bulk_in);
 	if (rc)
 		goto reset;
+	dev_info(&fsg->gadget->dev, "Enable bulk in\n");
 	rc = usb_ep_enable(fsg->bulk_in);
 	if (rc)
 		goto reset;
@@ -2343,6 +2353,7 @@ reset:
 				fsg->bulk_out);
 	if (rc)
 		goto reset;
+	dev_info(&fsg->gadget->dev, "Enable bulk out\n");
 	rc = usb_ep_enable(fsg->bulk_out);
 	if (rc)
 		goto reset;
@@ -2392,12 +2403,15 @@ static void fsg_disable(struct usb_funct
 
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
+		dev_info(&fsg->gadget->dev, "Disable bulk out B finished\n");
 	}
 
 	__raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE, NULL);

