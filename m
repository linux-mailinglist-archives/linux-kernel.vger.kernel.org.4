Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5168CB3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBGAeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjBGAen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:34:43 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EA238CDE1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:34:40 -0800 (PST)
Received: (qmail 677745 invoked by uid 1000); 6 Feb 2023 19:34:40 -0500
Date:   Mon, 6 Feb 2023 19:34:40 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Xin Zhao <xnzhao@google.com>
Cc:     gregkh@linuxfoundation.org, jakobkoschel@gmail.com,
        rdunlap@infradead.org, ira.weiny@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: dummyhcd: Fix use-after-free in
 dummy_free_request
Message-ID: <Y+GcoFKiAkrCoAsv@rowland.harvard.edu>
References: <20230206225258.2302954-1-xnzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206225258.2302954-1-xnzhao@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:52:58PM +0000, Xin Zhao wrote:
> DummyHCD assume when dummy_free_request is called, the request
> is already detached from request queues. It is correct in most
> cases.
> But when DummyHCD is detached from gadget configfs with pending
> requests and some requests are still in pending queue,
> dummy_free_request would free them directly.
> Later on, dummy_udc_stop would iterate pending queue to release
> the requests again.
> 
> Stacktrace for dummy_free_reqeust
> ```
> kfree(const void * x) (slub.c:4200)
> dummy_free_request(struct usb_ep * _ep, struct usb_request * _req) (dummy_hcd.c:691)
> usb_ep_free_request(struct usb_ep * ep, struct usb_request * req) (core.c:201)
> functionfs_unbind(struct ffs_data * ffs) (f_fs.c:1894)

That's the bug right there.  The kerneldoc for usb_ep_free_request() 
says "Caller guarantees the request is not queued".  So it looks like 
the real solution is to fix functionfs_unbind().

> ffs_func_unbind(struct usb_function * f) (f_fs.c:3614)
> purge_configs_funcs(struct gadget_info * gi) (configfs.c:1303)
> configfs_composite_unbind(struct usb_gadget * gadget) (configfs.c:1528)
> usb_gadget_remove_driver(struct usb_udc * udc) (core.c:1436)
> usb_gadget_unregister_driver(struct usb_gadget_driver * driver) (core.c:1585)
> unregister_gadget(struct gadget_info * gi) (configfs.c:281)
> gadget_dev_desc_UDC_store(struct config_item * item) (configfs.c:308)
> flush_write_buffer(struct file * file, struct configfs_buffer * buffer, size_t count) (file.c:251)
> ```
> 
> Stacktrace of use-after-free
> ```
> list_del_init(struct list_head * entry) (list.h:204)
> nuke(struct dummy * dum, struct dummy_ep * ep) (dummy_hcd.c:344)
> stop_activity(struct dummy * dum) (dummy_hcd.c:366)
> dummy_udc_stop(struct usb_gadget * g) (dummy_hcd.c:1032)
> usb_gadget_udc_stop(struct usb_udc * udc) (core.c:1141)
> usb_gadget_remove_driver(struct usb_udc * udc) (core.c:1437)
> usb_gadget_unregister_driver(struct usb_gadget_driver * driver) (core.c:1585)
> unregister_gadget(struct gadget_info * gi) (configfs.c:281)
> gadget_dev_desc_UDC_store(struct config_item * item) (configfs.c:308)
> flush_write_buffer(struct file * file, struct configfs_buffer * buffer, size_t count) (file.c:251)
> configfs_write_file(struct file * file)
> ```
> 
> Signed-off-by: Xin Zhao <xnzhao@google.com>
> ---
>  drivers/usb/gadget/udc/dummy_hcd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index 899ac9f9c279..afead69d7487 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -679,7 +679,11 @@ static void dummy_free_request(struct usb_ep *_ep, struct usb_request *_req)
>  	}
>  
>  	req = usb_request_to_dummy_request(_req);
> -	WARN_ON(!list_empty(&req->queue));
> +	if (!list_empty(&req->queue)) {
> +		WARN_ON(1);
> +		return;
> +	}

Once the bug in functionfs_unbind() is fixed, this change won't be 
necessary.

Alan Stern
