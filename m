Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8C465AA47
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjAAPF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAAPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:05:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89E4C77;
        Sun,  1 Jan 2023 07:05:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E43060DCF;
        Sun,  1 Jan 2023 15:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BE0C433D2;
        Sun,  1 Jan 2023 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672585552;
        bh=H/enneL0rRp4lwUmCHUJup6uIYXBeBZ/Ryo3CKNus4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=194sWSpskcjGaehygRIpIho5kNsNaf+Ut0S4jvvAleEju6UzZy5A+jnaWxR3SVTxr
         QZRkzJWzC9YfgizO+e1uuYc/Um7QYKi0PS7McgttXiqu1NKdU0tVtbHqOICNQqopNc
         dYS3LxHC7JCKLQKa/RTQLA4fNe2f9ZpAT5gY5ICA=
Date:   Sun, 1 Jan 2023 16:05:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget:  add WebUSB support
Message-ID: <Y7GhTY0qLcWgWHMw@kroah.com>
References: <Y7CR30YUj2znMDm7@rowland.harvard.edu>
 <Y7FxHDUQxoc9cmL6@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7FxHDUQxoc9cmL6@jo-einhundert>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 12:40:12PM +0100, Jó Ágila Bitsch wrote:
> There is a custom (non-USB IF) extension to the USB standard:
> 
> https://wicg.github.io/webusb/
> 
> This specification is published under the W3C Community Contributor
> Agreement, which in particular allows to implement the specification
> without any royalties.
> 
> The specification allows USB gadgets to announce an URL to landing
> page and describes a Javascript interface for websites to interact
> with the USB gadget, if the user allows it. It is currently
> supported by Chromium-based browsers, such as Chrome, Edge and
> Opera on all major operating systems including Linux.
> 
> This patch adds optional support for Linux-based USB gadgets
> wishing to expose such a landing page.
> 
> During device enumeration, a host recognizes that the announced
> USB version is at least 2.01, which means, that there are BOS
> descriptors available. The device than announces WebUSB support
> using a platform device capability. This includes a vendor code
> under which the landing page URL can be retrieved using a
> vendor-specific request.
> 
> Usage is modeled after os_desc descriptors:
> echo 1 > webusb/use
> echo "https://www.kernel.org" > webusb/landingPage
> 
> lsusb will report the device with the following lines:
>   Platform Device Capability:
>     bLength                24
>     bDescriptorType        16
>     bDevCapabilityType      5
>     bReserved               0
>     PlatformCapabilityUUID    {3408b638-09a9-47a0-8bfd-a0768815b665}
>       WebUSB:
>         bcdVersion    1.00
>         bVendorCode      0
>         iLandingPage     1 https://www.kernel.org
> 
> Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
> ---
>  Documentation/ABI/testing/configfs-usb-gadget |  13 ++
>  drivers/usb/gadget/composite.c                |  96 ++++++++++--
>  drivers/usb/gadget/configfs.c                 | 145 ++++++++++++++++++
>  include/linux/usb/composite.h                 |   6 +
>  include/uapi/linux/usb/ch9.h                  |  33 ++++
>  5 files changed, 283 insertions(+), 10 deletions(-)
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
