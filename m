Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5E6C0BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjCTIKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCTIKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26525BB8E;
        Mon, 20 Mar 2023 01:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B514361265;
        Mon, 20 Mar 2023 08:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8C9C4339C;
        Mon, 20 Mar 2023 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679299800;
        bh=UpyOnbmz84P/0j1392CDgxerKpDK7NnKKNJvKX27NIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9d8qt3EgAKEeQxrvjJZHsgkoKw58zCiciKWvivUs4y7houYJJT1O15v2y7LRcSaM
         o+1nRgmuRJ+lfPuAzlEurX90LGIUME88kIvZVKoclR2lGGOVfL+w2NZWAfC3r1/1o0
         yqKs3dxQTAAkl5kpRbsL5b2pQcs8bPgc0ote8GGE=
Date:   Mon, 20 Mar 2023 09:09:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, JC Kuo <jckuo@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>
Subject: Re: [PATCH] usb: xhci: tegra: fix sleep in atomic call
Message-ID: <ZBgU0GtLAVdaBQQ1@kroah.com>
References: <20230320074028.186282-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320074028.186282-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:40:28PM +0800, Haotien Hsu wrote:
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
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>

What commit id does this fix?  And does it need to be backported to
older kernels?

> ---
>  drivers/usb/host/xhci-tegra.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 1ff22f675930..af0185bacc70 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -2,7 +2,7 @@
>  /*
>   * NVIDIA Tegra xHCI host controller driver
>   *
> - * Copyright (c) 2014-2020, NVIDIA CORPORATION. All rights reserved.
> + * Copyright (c) 2014-2023, NVIDIA CORPORATION. All rights reserved.

Please submit copyright updates separately, showing that there really
was copyright updates during those years as that is independent of this
fix and does not need to be backported anywhere.

thanks,

greg k-h
