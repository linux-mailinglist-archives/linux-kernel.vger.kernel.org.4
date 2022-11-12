Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8276626791
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiKLHD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiKLHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:03:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638E12AB2;
        Fri, 11 Nov 2022 23:03:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C04E60683;
        Sat, 12 Nov 2022 07:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C83C433D6;
        Sat, 12 Nov 2022 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668236632;
        bh=/+to0Gh4O5nsONZJk5OVV5iB6xyt7ICC+Zhr3qxgs4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKqE10ANUszhscv98lenpTm5T+qjg7os7jvUQKqDvyp5kfOLA/t9NMwtxdu8PfFQl
         Rt1Cngv+PGZniHIFpWPBVdjWYaTX1cGIqQ8QUkVFyzwmQkAQZ2EsE5mvLMSSC1Ydip
         0IWboI+w0I0a0q42NeY6LAJP4w2/akxkubE95o98=
Date:   Sat, 12 Nov 2022 08:03:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jiantao zhang <water.zhangjiantao@huawei.com>
Cc:     stern@rowland.harvard.edu, jakobkoschel@gmail.com,
        geert+renesas@glider.be, colin.i.king@gmail.com,
        =?utf-8?B?6Jab5rab?= <xuetao09@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?6JSh5Lqa5Lic?= <caiyadong@huawei.com>,
        =?utf-8?B?5b6Q5rW35rSL?= <xuhaiyang5@hisilicon.com>,
        suzhuangluan@hisilicon.com
Subject: Re: [PATCH v2] USB: gadget: Fix use-after-free during usb config
 switch
Message-ID: <Y29FVs//ZewilMi+@kroah.com>
References: <20221112030433.4945-1-xuetao09@huawei.com>
 <27f1534f-a985-06e9-b94f-ba60167e74d2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f1534f-a985-06e9-b94f-ba60167e74d2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 11:12:46AM +0800, jiantao zhang wrote:
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
> (1) write /config/usb_gadget/g1/UDC "none" (init.usb.configfs.rc:2)
> 
> gether_disconnect+0x2c/0x1f8 (dev->port_usb = NULL)
> rndis_disable+0x4c/0x74
> composite_disconnect+0x74/0xb0
> configfs_composite_disconnect+0x60/0x7c
> usb_gadget_disconnect+0x70/0x124
> usb_gadget_unregister_driver+0xc8/0x1d8
> gadget_dev_desc_UDC_store+0xec/0x1e4
> 
> In function usb_gadget_disconnect(),The ->disconnect() callback will
> not be called when gadget->ops->pullup() return an error, therefore,
> pointer dev->port will not be set to NULL. If pointer dev->port_usb
> is not null, it will cause an exception of use-after-free in step3.
> 
> (2) rm /config/usb_gadget/g1/configs/b.1/f1 (init.usb.configfs.rc:8)
> (f1 -> ../../../../usb_gadget/g1/functions/rndis.gs4)
> 
> rndis_deregister+0x28/0x54 (kfree(params))
> rndis_free+0x44/0x7c (kfree(rndis))
> usb_put_function+0x14/0x1c
> config_usb_cfg_unlink+0xc4/0xe0
> configfs_unlink+0x124/0x1c8
> vfs_unlink+0x114/0x1dc
> 
> (3) rmdir /config/usb_gadget/g1/functions/rndis.gs4
> (init.usb.configfs.rc:11)
> 
> Call trace:
> panic+0x1fc/0x3d0
> die+0x29c/0x2a8
> do_page_fault+0xa8/0x46c
> do_mem_abort+0x3c/0xac
> el1_sync_handler+0x40/0x78
> 0xffffff801138f880 (params->resp_avail is an illegal func pointer)
> rndis_close+0x28/0x34 (->rndis_indicate_status_msg->params->resp_avail)
> eth_stop+0x74/0x110 (if dev->port_usb != NULL, call rndis_close)
> __dev_close_many+0x134/0x194
> dev_close_many+0x48/0x194
> rollback_registered_many+0x118/0x814
> unregister_netdevice_queue+0xe0/0x168
> unregister_netdev+0x20/0x30
> gether_cleanup+0x1c/0x38
> rndis_free_inst+0x2c/0x58
> rndis_attr_release+0xc/0x14
> kref_put+0x74/0xb8
> config_item_put+0x14/0x1c
> configfs_rmdir+0x314/0x374
> 
> In step3,function pointer params->resp_avail() is a wild pointer
> becase pointer params has been freed in step2.
> 
> Free mem stack(in step2):
> usb_put_function -> rndis_free -> rndis_deregister -> kfree(params)
> 
> use-after-free stack(in step3):
> eth_stop -> rndis_close -> rndis_signal_disconnect ->
> rndis_indicate_status_msg -> params->resp_avail()
> 
> In function eth_stop(), if pointer dev->port_usb is NULL, function
> rndis_close() will not be called.
> If gadget->ops->pullup() return an error in step1,dev->port_usb will
> not be set to null. So, a panic will be caused in step3.
> =======================================================================
> 
> Fixes:<0a55187a1ec8c> (USB: gadget core: Issue ->disconnect()
> callback from usb_gadget_disconnect())
> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> Signed-off-by: TaoXue <xuetao09@huawei.com>
> ---
> V1 -> V2: V1 will affect the original function, V2 just move the
> callback after "if" statement, so that the original function will not be
> affected.
> And fixed formatting issues.
> 
> drivers/usb/gadget/udc/core.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index c63c0c2cf649..bf9878e1a72a 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -734,13 +734,13 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
> }
> ret = gadget->ops->pullup(gadget, 0);
> - if (!ret) {
> + if (!ret)
> gadget->connected = 0;
> - mutex_lock(&udc_lock);
> - if (gadget->udc->driver)
> - gadget->udc->driver->disconnect(gadget);
> - mutex_unlock(&udc_lock);
> - }
> +
> + mutex_lock(&udc_lock);
> + if (gadget->udc->driver)
> + gadget->udc->driver->disconnect(gadget);
> + mutex_unlock(&udc_lock);
> out:
> trace_usb_gadget_disconnect(gadget, ret);
> 
> -- 
> 2.17.1
> 
> .
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
