Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710716C2A56
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCUGTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCUGTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:19:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C873629E0B;
        Mon, 20 Mar 2023 23:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED10AB812A1;
        Tue, 21 Mar 2023 06:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40726C433EF;
        Tue, 21 Mar 2023 06:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679379572;
        bh=o6gdPjxvDO2lUysJD4btv0gnfbX3M+bVFjVrGrkuHPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1595sKLeoRMkXVLlNvYTFYhoktp7jhdB08keut33OLupIBX6dVmh75rtGh/97GDl
         lmwvoWYQRzTL2ONelkDEfYT/kmOx2j5Q6G67hoxLLKFBzDT/cxgv84J73WbXa6TPMO
         t1Ak4r+F/E3UFVA0QIgwiVj2LhlmXyI/B87BCiOQ=
Date:   Tue, 21 Mar 2023 07:19:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, JC Kuo <jckuo@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>
Subject: Re: [PATCH v2] usb: xhci: tegra: fix sleep in atomic call
Message-ID: <ZBlMcZA71BKs1oYo@kroah.com>
References: <20230321023636.771729-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321023636.771729-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:36:36AM +0800, Haotien Hsu wrote:
> From: Wayne Chang <waynec@nvidia.com>
> 
> When we set the OTG port to Host mode, we observed the following splat:
> [  167.057718] BUG: sleeping function called from invalid context at
> include/linux/sched/mm.h:229
> [  167.057872] Workqueue: events tegra_xusb_usb_phy_work
> [  167.057954] Call trace:
> [  167.057962]  dump_backtrace+0x0/0x210
> [  167.057996]  show_stack+0x30/0x50
> [  167.058020]  dump_stack_lvl+0x64/0x84
> [  167.058065]  dump_stack+0x14/0x34
> [  167.058100]  __might_resched+0x144/0x180
> [  167.058140]  __might_sleep+0x64/0xd0
> [  167.058171]  slab_pre_alloc_hook.constprop.0+0xa8/0x110
> [  167.058202]  __kmalloc_track_caller+0x74/0x2b0
> [  167.058233]  kvasprintf+0xa4/0x190
> [  167.058261]  kasprintf+0x58/0x90
> [  167.058285]  tegra_xusb_find_port_node.isra.0+0x58/0xd0
> [  167.058334]  tegra_xusb_find_port+0x38/0xa0
> [  167.058380]  tegra_xusb_padctl_get_usb3_companion+0x38/0xd0
> [  167.058430]  tegra_xhci_id_notify+0x8c/0x1e0
> [  167.058473]  notifier_call_chain+0x88/0x100
> [  167.058506]  atomic_notifier_call_chain+0x44/0x70
> [  167.058537]  tegra_xusb_usb_phy_work+0x60/0xd0
> [  167.058581]  process_one_work+0x1dc/0x4c0
> [  167.058618]  worker_thread+0x54/0x410
> [  167.058650]  kthread+0x188/0x1b0
> [  167.058672]  ret_from_fork+0x10/0x20
> 
> The function tegra_xusb_padctl_get_usb3_companion eventually calls
> tegra_xusb_find_port and this in turn calls kasprintf which might sleep
> and so cannot be called from an atomic context.
> 
> Fix this by moving the call to tegra_xusb_padctl_get_usb3_companion to
> the tegra_xhci_id_work function where it is really needed.
> 
> Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 1ff22f675930..8dbce2cdb7e4 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -2,7 +2,7 @@
>  /*
>   * NVIDIA Tegra xHCI host controller driver
>   *
> - * Copyright (c) 2014-2020, NVIDIA CORPORATION. All rights reserved.
> + * Copyright (c) 2014-2020,2023, NVIDIA CORPORATION. All rights reserved.
>   * Copyright (C) 2014 Google, Inc.
>   */
>  
> @@ -1360,6 +1360,10 @@ static void tegra_xhci_id_work(struct work_struct *work)
>  
>  	mutex_unlock(&tegra->lock);
>  
> +	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(
> +							tegra->padctl,
> +							tegra->otg_usb2_port);
> +
>  	if (tegra->host_mode) {
>  		/* switch to host mode */
>  		if (tegra->otg_usb3_port >= 0) {
> @@ -1474,9 +1478,6 @@ static int tegra_xhci_id_notify(struct notifier_block *nb,
>  	}
>  
>  	tegra->otg_usb2_port = tegra_xusb_get_usb2_port(tegra, usbphy);
> -	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(
> -							tegra->padctl,
> -							tegra->otg_usb2_port);
>  
>  	tegra->host_mode = (usbphy->last_event == USB_EVENT_ID) ? true : false;
>  
> -- 
> 2.25.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
