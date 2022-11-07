Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4061EE2C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiKGJFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGJFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:05:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2109FD9;
        Mon,  7 Nov 2022 01:05:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3404AB80E84;
        Mon,  7 Nov 2022 09:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF6C433D6;
        Mon,  7 Nov 2022 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667811942;
        bh=jOVKgvmAFLLzJwu6tB2mvWc8Es7QRbg7ypmEseVvlFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7TKhikM8ZMz6J4u5ACj3S0hJmsQBbePwedLBnPraQ263s/JvDcux5/BPjt1Hnp99
         cyfoFgw9p8TqcS3HIIhziAPmNwN9qLr9C42jYzdcfRqIj18XQ9M8crxmzACM3KXLwk
         paHr/6p5oxoxLzPu35NVyFr+yAUKi96QeqBkpyz4=
Date:   Mon, 7 Nov 2022 10:05:39 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jiantao Zhang <water.zhangjiantao@huawei.com>
Cc:     "Xuetao (kirin)" <xuetao09@huawei.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "jakobkoschel@gmail.com" <jakobkoschel@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>,
        Suzhuangluan <suzhuangluan@hisilicon.com>
Subject: Re: [PATCH] USB: gadget: Fix CFI failure during usb config switch.
Message-ID: <Y2jKY9Nw1a0/951a@kroah.com>
References: <b4d5fcb42622441189ad0e6ca5b170c0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d5fcb42622441189ad0e6ca5b170c0@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 08:56:06AM +0000, Jiantao Zhang wrote:
> This reverts commit 0a55187a1ec8c

Please show the full hash for this line.

> 
> In the process of switching USB config from rndis to other config, if function gadget->ops->pullup() return an error,it will inevitably cause a CFI failure(Linux version 5.10.43).

Please wrap the line properly.

And CFI is not in 5.10, so why is this an issue?

> 
> analysis as follows:
> ======================================================
> (1) write /config/usb_gadget/g1/UDC "none"   (init.usb.configfs.rc:2)
> 
> gether_disconnect+0x2c/0x1f8     (dev->port_usb = NULL)
> rndis_disable+0x4c/0x74
> composite_disconnect+0x74/0xb0
> configfs_composite_disconnect+0x60/0x7c
> usb_gadget_disconnect+0x70/0x124
> usb_gadget_unregister_driver+0xc8/0x1d8
> gadget_dev_desc_UDC_store+0xec/0x1e4
> 
> in function usb_gadget_disconnect(),gadget->udc->driver->disconnect()
> will not be called when gadget->ops->pullup() return an error, therefore, pointer dev->port will not be set to NULL.
> 
> (2) rm /config/usb_gadget/g1/configs/b.1/f1    (init.usb.configfs.rc:8)
>     (f1 -> ../../../../usb_gadget/g1/functions/rndis.gs4)
> 
> rndis_deregister+0x28/0x54
> rndis_free+0x44/0x7c
> usb_put_function+0x14/0x1c
> config_usb_cfg_unlink+0xc4/0xe0
> configfs_unlink+0x124/0x1c8
> vfs_unlink+0x114/0x1dc
> 
> (3) rmdir /config/usb_gadget/g1/functions/rndis.gs4
>     (init.usb.configfs.rc:11)
> 
> CFI failure (target: [<ffffff814bc20c00>] 0000000068f50078):
> CPU: 2 PID: 1 Comm: init VIP: 00 Tainted: G   W  O   5.10.43 #1
> Call trace:
>  __cfi_slowpath+0x300/0x3bc
>  rndis_signal_disconnect+0x1e0/0x204
>  rndis_close+0x24/0x2c
>  eth_stop+0xd0/0x234           (if dev->port_usb != NULL, call rndis_close)
>  __dev_close_many+0x204/0x2d4
>  dev_close_many+0x48/0x2c8
>  rollback_registered_many+0x184/0xdac
>  unregister_netdevice_queue+0xf8/0x24c
>  rndis_free_inst+0x78/0xc8
>  rndis_attr_release+0x3c/0x84
>  config_item_release+0x6c/0x180
>  configfs_rmdir+0x7e0/0xca0
> 
> Since the rndis memory has been freed in step2, function rndis_close cannot be called here. In function eth_stop(), if pointer dev->port_usb is NULL, function rndis_close() will not be called. So, if
> gadget->ops->pullup() return an error in step1, a CFI failure will be
> caused here.
> ======================================================
> Through above analysis, i think gadget->udc->driver->disconnect() need to be called even if gadget->udc->driver->disconnect() return an error.


I really do not understand, sorry.  What does CFI have to do with
anything here?  What functions are mis-matched that CFI trips over it?

And by reverting this change, don't you now have the original problem
that this commit was trying to solve?

> 
> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> Signed-off-by: TaoXue <xuetao09@huawei.com>

No Fixes: tag?

No cc: stable?

thanks,

greg k-h
