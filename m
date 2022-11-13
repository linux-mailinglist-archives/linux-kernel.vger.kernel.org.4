Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6F626EA8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 10:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiKMJM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 04:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 04:12:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E311C3A;
        Sun, 13 Nov 2022 01:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668330744; x=1699866744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uldxEetAwx1p9WOcOe/kKGthIwO8v4ywlMbj0CLYCSU=;
  b=K3QndspvDxdw4z4isBrjAfnhWx6sCH0pUWysjdlA57UAeMU7ug7UWmwt
   6GxSCxxkByjFn+sgGef5eiYnfy/JWgp5L1bnDmfnXDNRhTH2j5AV11KIA
   hYmEEXIwwpF5wKb7zaZpLbhf+lgijEcqdBaAxqz173LXgQ80JO2e5lik1
   OuZP1ibqqL3Qbays5yMoB1gm93tKVr9ufUeftQ6B6uhcYHfdtSOebdYbG
   jbbeNtF/JKTl1TauUUEghA+vVGmKhGu/Xr1d3OO4PvkzzYM/BFhFWjeaL
   oAey/R1fDAKK1r1mLWrKrjEmbrBRcPLPzJGZrWtHDKU/rtnZjGIH5BxYp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="311801630"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="311801630"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 01:12:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="615922753"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="615922753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2022 01:12:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ou92H-00BbUQ-2o;
        Sun, 13 Nov 2022 11:12:17 +0200
Date:   Sun, 13 Nov 2022 11:12:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     jiantao zhang <water.zhangjiantao@huawei.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        jakobkoschel@gmail.com, geert+renesas@glider.be,
        colin.i.king@gmail.com, =?utf-8?B?6Jab5rab?= <xuetao09@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?6JSh5Lqa5Lic?= <caiyadong@huawei.com>,
        =?utf-8?B?5b6Q5rW35rSL?= <xuhaiyang5@hisilicon.com>
Subject: Re: [PATCH v2] USB: gadget: Fix use-after-free during usb config
 switch
Message-ID: <Y3C08ftGoOSFSPg/@smile.fi.intel.com>
References: <20221112030433.4945-1-xuetao09@huawei.com>
 <cc99f08d-4e2f-120c-fd37-03809c92e819@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc99f08d-4e2f-120c-fd37-03809c92e819@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 04:14:27PM +0800, jiantao zhang wrote:
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
> (1) write /config/usb_gadget/g1/UDC "none"   (init.usb.configfs.rc:2)
> 
> gether_disconnect+0x2c/0x1f8           (dev->port_usb = NULL)
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
> (2) rm /config/usb_gadget/g1/configs/b.1/f1   (init.usb.configfs.rc:8)
>     (f1 -> ../../../../usb_gadget/g1/functions/rndis.gs4)
> 
> rndis_deregister+0x28/0x54        (kfree(params))
> rndis_free+0x44/0x7c              (kfree(rndis))
> usb_put_function+0x14/0x1c
> config_usb_cfg_unlink+0xc4/0xe0
> configfs_unlink+0x124/0x1c8
> vfs_unlink+0x114/0x1dc
> 
> (3) rmdir /config/usb_gadget/g1/functions/rndis.gs4
>     (init.usb.configfs.rc:11)
> 
> Call trace:
> panic+0x1fc/0x3d0
> die+0x29c/0x2a8
> do_page_fault+0xa8/0x46c
> do_mem_abort+0x3c/0xac
> el1_sync_handler+0x40/0x78
> 0xffffff801138f880    (params->resp_avail is an illegal func pointer)
> rndis_close+0x28/0x34 (->rndis_indicate_status_msg->params->resp_avail)
> eth_stop+0x74/0x110   (if dev->port_usb != NULL, call rndis_close)
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

Please, read the Submitting Patches document on how to provide backtraces in
the commit messages and update yours accordingly.

> In step3,function pointer params->resp_avail() is a wild pointer
> becase pointer params has been freed in step2.
> 
> Free mem stack(in step2):
>     usb_put_function -> rndis_free -> rndis_deregister -> kfree(params)
> 
> use-after-free stack(in step3):
>     eth_stop -> rndis_close -> rndis_signal_disconnect ->
>     rndis_indicate_status_msg -> params->resp_avail()
> 
> In function eth_stop(), if pointer dev->port_usb is NULL, function
> rndis_close() will not be called.
> If gadget->ops->pullup() return an error in step1,dev->port_usb will
> not be set to null. So, a panic will be caused in step3.
> =======================================================================

> Fixes:<0a55187a1ec8c> (USB: gadget core: Issue ->disconnect()
> callback from usb_gadget_disconnect())

This is malformed tag. Please, read the Submitting Patches document and fix
this accordingly.

> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> Signed-off-by: TaoXue <xuetao09@huawei.com>
> ---
>  V1 -> V2: V1 will affect the original function, V2 just move the callback
> after "if" statement, so that the original function will  not be affected.
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
> 

-- 
With Best Regards,
Andy Shevchenko


