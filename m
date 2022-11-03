Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B044B617DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiKCNVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C3364EA;
        Thu,  3 Nov 2022 06:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A66AC61D2A;
        Thu,  3 Nov 2022 13:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB701C433D6;
        Thu,  3 Nov 2022 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667481679;
        bh=fHAYAcKTHAHMfr8wTX5ZxzqFaIsOxpKhIFHKEVZZEmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xOlETYsG0/wfqFDPYpj6x+nYNe3izo2U4hpyjJkUre1ow+rP86BhGxLhdJzpILXGj
         1lRi3GucGsRso7KCKhlC04zmtI6EO666UJv+HfyLxeZtK/nHdhgO1y+JRW7cCaMwNK
         n4Q3oKdG+4pknanmFvqpjseNZVGFRIfnd9Om75ow=
Date:   Thu, 3 Nov 2022 22:21:59 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb/usbip: fix uninitialized variables errors
Message-ID: <Y2PAd79kMEbt0HNf@kroah.com>
References: <cover.1667480280.git.skhan@linuxfoundation.org>
 <76654f2f1cc30b27be10ac9b177bb449a7ad7068.1667480280.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76654f2f1cc30b27be10ac9b177bb449a7ad7068.1667480280.git.skhan@linuxfoundation.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 07:12:42AM -0600, Shuah Khan wrote:
> Fix uninitialized variable errors reported by cppcheck. One example
> below.
> 
> usbip/stub_main.c:284:10: error: Uninitialized variables: priv.seqnum, priv.sdev, priv.urbs, priv.sgl, priv.num_urbs, priv.completed_urbs, priv.urb_status, priv.unlinking [uninitvar]
>   return priv;
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/usb/usbip/stub_main.c     | 2 +-
>  drivers/usb/usbip/stub_rx.c       | 4 ++--
>  drivers/usb/usbip/stub_tx.c       | 4 ++--
>  drivers/usb/usbip/usbip_event.c   | 2 +-
>  drivers/usb/usbip/vhci_hcd.c      | 2 +-
>  drivers/usb/usbip/vhci_rx.c       | 2 +-
>  drivers/usb/usbip/vhci_tx.c       | 4 ++--
>  drivers/usb/usbip/vudc_dev.c      | 2 +-
>  drivers/usb/usbip/vudc_rx.c       | 2 +-
>  drivers/usb/usbip/vudc_transfer.c | 4 ++--
>  10 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index e8c3131a8543..e1248b971218 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -277,7 +277,7 @@ static DRIVER_ATTR_WO(rebind);
>  
>  static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
>  {
> -	struct stub_priv *priv, *tmp;
> +	struct stub_priv *priv = NULL, *tmp;
>  
>  	list_for_each_entry_safe(priv, tmp, listhead, list) {

cppcheck is wrong here, the code is fine, and setting priv to NULL does
nothing.  If it was required, gcc would have hopefully caught it, and
the code would have never worked :)

So are you sure all of these changes are really needed?  Last time I
looked, cppcheck wasn't all that smart when it came to the kernel and
threw up huge numbers of false-positives, like this one.

thanks,

greg k-h
