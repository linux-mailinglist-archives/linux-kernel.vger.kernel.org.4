Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4061ECB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKGIP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiKGIPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:15:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD6FB7FF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:15:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A50B660EE7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F231C433D6;
        Mon,  7 Nov 2022 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667808953;
        bh=sDAKw5K/VHEkLRudBsQgRtFT6FKfiF09ob6HSWj7wnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Po9jk6mqeJ1qjonTmaUVqECLpxtNzj6fm43gE1EO9fTCiHhLzs7f3126ej3kiEET3
         ngX91nBYTznrWwdN3d56m05OUj0ZZLjg9+blnRXsGSJjhSyQ7LY9mzFb0vMT5T9th1
         A7SZFkoxQbQ5Hd8E2opoyDQGxHelBH/oJYNiJSiU=
Date:   Mon, 7 Nov 2022 09:15:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: add timeout to send
Message-ID: <Y2i+tY2tZzQnUFKC@kroah.com>
References: <20221103155534.1966589-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103155534.1966589-1-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 05:55:34PM +0200, Alexander Usyskin wrote:
> When driver wakes up the firmware from the low power stand,
> it is sending a memory ready message.
> The send is done via synchronous/blocking function to ensure
> that firmware is in ready state. However firmware might be
> in unstable state and send might be block forever.
> To address this issue a timeout is added to blocking write command on
> the internal bus.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/misc/mei/bus-fixup.c | 19 +++++++++++--------
>  drivers/misc/mei/bus.c       |  9 +++++----
>  drivers/misc/mei/client.c    | 21 +++++++++++++++++----
>  drivers/misc/mei/client.h    |  2 +-
>  drivers/misc/mei/main.c      |  2 +-
>  drivers/misc/mei/mei_dev.h   |  2 +-
>  6 files changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 71fbf0bc8453..3174cad8a5cc 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -128,7 +128,7 @@ static int mei_osver(struct mei_cl_device *cldev)
>  	os_ver = (struct mei_os_ver *)fwcaps->data;
>  	os_ver->os_type = OSTYPE_LINUX;
>  
> -	return __mei_cl_send(cldev->cl, buf, size, 0, mode);
> +	return __mei_cl_send(cldev->cl, buf, size, 0, mode, 0);

Ick, adding another parameter to a function is not helpful here, what
does 0 mean unless you look it up?

> --- a/drivers/misc/mei/bus.c
> +++ b/drivers/misc/mei/bus.c
> @@ -29,11 +29,12 @@
>   * @length: buffer length
>   * @vtag: virtual tag
>   * @mode: sending mode
> + * @timeout: send timeout for blocking writes, 0 for infinite timeout

What units are these in?  Jiffies?  seconds?  hours?  Don't make us
guess :(

Why not write a function that is mei_cl_send_timeout() that has the new
option?  That way it's obvious that the other ones are blocking, right?

thanks,

greg k-h
