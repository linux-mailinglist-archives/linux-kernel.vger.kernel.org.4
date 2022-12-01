Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FB63F07D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiLAM3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLAM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:29:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A09AC190;
        Thu,  1 Dec 2022 04:29:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7FBDB81F10;
        Thu,  1 Dec 2022 12:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB251C433D6;
        Thu,  1 Dec 2022 12:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669897738;
        bh=Gr2FvS1mhvh5ynkST3Bf0Qv+fAkMpmLHnaLhGS+sctA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob6TzdLJsyOxJ8KCRZRWs0Arw/uGBAtwVzlLVhaL4vt5tQbNfCD58bMsMwwcM0TKo
         iY+VVXToz47Mzgr27C0dSZzChOoz8HXqpMIouvVeWWBrrK9HxDGxJxRO+8xa6n18ww
         osDcX9gXz+5BaobFzO7/EaXvhLVZPoJJtBow0R9E=
Date:   Thu, 1 Dec 2022 13:28:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Szymon Heidrich <szymon.heidrich@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent buffer overflow in UVC Gadget setup handler
Message-ID: <Y4ieBScmqVbZMrf9@kroah.com>
References: <20221201122141.8739-1-szymon.heidrich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201122141.8739-1-szymon.heidrich@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 01:21:41PM +0100, Szymon Heidrich wrote:
> Setup function uvc_function_setup permits control transfer
> requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
> data stage handler for OUT transfer uses memcpy to copy req->actual
> bytes to uvc_event->data.data array of size 60. This may result
> in an overflow of 4 bytes.
> 
> Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>
> ---
>  drivers/usb/gadget/function/f_uvc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

What commit id does this fix?  Is it needed for stable kernels?

thanks,

greg k-h
