Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E832F629DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiKOPpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKOPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:45:28 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B314F1127
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:45:26 -0800 (PST)
Received: (qmail 173854 invoked by uid 1000); 15 Nov 2022 10:45:25 -0500
Date:   Tue, 15 Nov 2022 10:45:25 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     jiantao zhang <water.zhangjiantao@huawei.com>
Cc:     gregkh@linuxfoundation.org, jakobkoschel@gmail.com,
        geert+renesas@glider.be, colin.i.king@gmail.com,
        =?utf-8?B?6Jab5rab?= <xuetao09@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>
Subject: Re: [PATCH v3] USB: gadget: Fix use-after-free during usb config
 switch
Message-ID: <Y3O0FbIjiGCIzct4@rowland.harvard.edu>
References: <20221115065404.6067-1-xuetao09@huawei.com>
 <d3393e2f-a79c-d2c1-f752-71bd21a7ddbf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3393e2f-a79c-d2c1-f752-71bd21a7ddbf@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:52:02PM +0800, jiantao zhang wrote:
> In the process of switching USB config from rndis to other config,
> if the hardware does not support the ->pullup callback, or the
> hardware encounters a low probability fault, both of them may cause
> the ->pullup callback to fail, which will then cause a system panic
> (use after free).
> 
> The gadget drivers sometimes need to be unloaded regardless of the
> hardware's behavior.
> 
> Analysis as follows:
> =======================================================================
> (1) write /config/usb_gadget/g1/UDC "none"
> 
> gether_disconnect+0x2c/0x1f8
> rndis_disable+0x4c/0x74
> composite_disconnect+0x74/0xb0
> configfs_composite_disconnect+0x60/0x7c
> usb_gadget_disconnect+0x70/0x124
> usb_gadget_unregister_driver+0xc8/0x1d8
> gadget_dev_desc_UDC_store+0xec/0x1e4
> 
> (2) rm /config/usb_gadget/g1/configs/b.1/f1
> 
> rndis_deregister+0x28/0x54
> rndis_free+0x44/0x7c
> usb_put_function+0x14/0x1c
> config_usb_cfg_unlink+0xc4/0xe0
> configfs_unlink+0x124/0x1c8
> vfs_unlink+0x114/0x1dc
> 
> (3) rmdir /config/usb_gadget/g1/functions/rndis.gs4
> 
> panic+0x1fc/0x3d0
> do_page_fault+0xa8/0x46c
> do_mem_abort+0x3c/0xac
> el1_sync_handler+0x40/0x78
> 0xffffff801138f880
> rndis_close+0x28/0x34
> eth_stop+0x74/0x110
> dev_close_many+0x48/0x194
> rollback_registered_many+0x118/0x814
> unregister_netdev+0x20/0x30
> gether_cleanup+0x1c/0x38
> rndis_attr_release+0xc/0x14
> kref_put+0x74/0xb8
> configfs_rmdir+0x314/0x374
> 
> If gadget->ops->pullup() return an error, function rndis_close() will be
> called, then it will causes a use-after-free problem.
> =======================================================================
> 
> Fixes: 0a55187a1ec8 ("USB: gadget core: Issue ->disconnect() callback from
> usb_gadget_disconnect()")
> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> Signed-off-by: TaoXue <xuetao09@huawei.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

It looks like you accidentally typed a ' ' character at the start of the 
second line of the patch, the line that says:

	ret = gadget->ops->pullup(gadget, 0);

This would explain why Greg said the patch was corrupted.

Alan Stern

> V2 -> V3: Solved the format issues of Fixes and backtraces.
> V1 -> V2: V1 will affect the original function, V2 just move the callback
> after "if" statement, so that the original function will not be affected.
> And fixed formatting issues.
> 
>  drivers/usb/gadget/udc/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index c63c0c2cf649..bf9878e1a72a 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -734,13 +734,13 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
>  	}
>   	ret = gadget->ops->pullup(gadget, 0);
> -	if (!ret) {
> +	if (!ret)
>  		gadget->connected = 0;
> -		mutex_lock(&udc_lock);
> -		if (gadget->udc->driver)
> -			gadget->udc->driver->disconnect(gadget);
> -		mutex_unlock(&udc_lock);
> -	}
> +
> +	mutex_lock(&udc_lock);
> +	if (gadget->udc->driver)
> +		gadget->udc->driver->disconnect(gadget);
> +	mutex_unlock(&udc_lock);
>   out:
>  	trace_usb_gadget_disconnect(gadget, ret);
> -- 
> 2.17.1
> 
