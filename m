Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8687C673D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjASPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjASPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:20:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B382D4A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:20:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B66DF61C1E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A6CC433F0;
        Thu, 19 Jan 2023 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674141650;
        bh=Z93Mar8UW12+jdRSu1d1fZyY1H/c6Y49D8CTkfdzgSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEcAfPBm/7BVmv/yV865KTwPnKS5UGMl1qdsOR8KJ3rDL2pc52tEBsXD2CXJz2m5x
         VLLZ/zfEEBXJNFVj+0qP0nbXmi7h6AZ4lLhRK91qBWmMrVQqemGuGn17/aPClEyE60
         WBgDaw4IMYW4W4JgLmjwwW14n3Qt+Puypnj07mUE=
Date:   Thu, 19 Jan 2023 16:20:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y8lfz8C5uvx2w4fC@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:17PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The ADD_PORT operation reads and sanity checks the port id multiple
> times from the untrusted host. This is not safe because a malicious
> host could change it between reads.
> 
> Read the port id only once and cache it for subsequent uses.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/virtio_console.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index f4fd5fe7cd3a..6599c2956ba4 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1563,10 +1563,13 @@ static void handle_control_message(struct virtio_device *vdev,
>  	struct port *port;
>  	size_t name_size;
>  	int err;
> +	unsigned id;
>  
>  	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
>  
> -	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +	/* Make sure the host cannot change id under us */
> +	id = virtio32_to_cpu(vdev, READ_ONCE(cpkt->id));

Why READ_ONCE()?

And how can it change under us?  Is the message still under control of
the "host"?  If so, that feels wrong as this is all in kernel memory,
not userspace memory right?

If you are dealing with memory from a different process that you do not
trust, then you need to copy EVERYTHING at once.  Don't piece-meal copy
bits and bobs in all different places please.  Do it once and then parse
the local structure properly.

Otherwise this is going to be impossible to actually maintain over
time...

thanks,

greg k-h
