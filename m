Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6173B673D48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjASPSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjASPR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:17:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE882996
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:17:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E3A261B53
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAA2C433F0;
        Thu, 19 Jan 2023 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674141476;
        bh=d+RJax+gn4iXgWIKUImZxLaGkCJ5L1Iboau8yyzzzoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RstmJ0otBERnHgKaLfZmAkGg1CCZYd56wwtN40ndpz9lrPOBCMIOFK0CJYHfOmfso
         jc3mcT/BcLQShASUz3WUg/Z3vIokxDEnAY70iKfutYE4SC/aE7ClvHFkairLaXiNX8
         pB3vIyr8m2N79vEUrntQW9d/xfLWYhM83obdtkZg=
Date:   Thu, 19 Jan 2023 16:17:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
Message-ID: <Y8lfHKz08EVeNa5o@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:16PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> It's possible for the host to set the multiport flag, but pass in
> 0 multiports, which results in:
> 
> BUG: KASAN: slab-out-of-bounds in init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
> Write of size 8 at addr ffff888001cc24a0 by task swapper/1
> 
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0-rc1-140273-gaab0bb9fbaa1-dirty #588
> Call Trace:
>  init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
>  virtcons_probe+0x1a3/0x5b0 drivers/char/virtio_console.c:2042
>  virtio_dev_probe+0x2b9/0x500 drivers/virtio/virtio.c:263
>  call_driver_probe drivers/base/dd.c:515
>  really_probe+0x1c9/0x5b0 drivers/base/dd.c:601
>  really_probe_debug drivers/base/dd.c:694
>  __driver_probe_device+0x10d/0x1f0 drivers/base/dd.c:754
>  driver_probe_device+0x68/0x150 drivers/base/dd.c:786
>  __driver_attach+0xca/0x200 drivers/base/dd.c:1145
>  bus_for_each_dev+0x108/0x190 drivers/base/bus.c:301
>  driver_attach+0x30/0x40 drivers/base/dd.c:1162
>  bus_add_driver+0x325/0x3c0 drivers/base/bus.c:618
>  driver_register+0xf3/0x1d0 drivers/base/driver.c:171
> ...
> 
> Add a suitable sanity check.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/virtio_console.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 6a821118d553..f4fd5fe7cd3a 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1843,6 +1843,9 @@ static int init_vqs(struct ports_device *portdev)
>  	int err;
>  
>  	nr_ports = portdev->max_nr_ports;
> +	if (use_multiport(portdev) && nr_ports < 1)
> +		return -EINVAL;
> +
>  	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
>  
>  	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
> -- 
> 2.39.0
> 

Why did I only get a small subset of these patches?

And why is the whole thread not on lore.kernel.org?

And the term "hardening" is marketing fluff.   Just say, "properly parse
input" or something like that, as what you are doing is fixing
assumptions about the data here, not causing anything to be more (or
less) secure.

But, this still feels wrong.  Why is this happening here, in init_vqs()
and not in the calling function that already did a bunch of validation
of the ports and the like?  Are those checks not enough?  if not, fix it
there, don't spread it out all over the place...

thanks,

greg k-h
