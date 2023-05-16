Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F671705925
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEPUxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEPUxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:53:14 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4748759CB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:53:13 -0700 (PDT)
Received: (qmail 847804 invoked by uid 1000); 16 May 2023 16:53:12 -0400
Date:   Tue, 16 May 2023 16:53:12 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: hide unused usbfs_notify_suspend/resume functions
Message-ID: <d6be8f99-30dc-4528-9cba-34c0ee25929f@rowland.harvard.edu>
References: <20230516202103.558301-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516202103.558301-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:17:42PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The declaration is in an #ifdef, which causes warnings when building
> with 'make W=1' and without CONFIG_PM:
> 
> drivers/usb/core/devio.c:742:6: error: no previous prototype for 'usbfs_notify_suspend'
> drivers/usb/core/devio.c:747:6: error: no previous prototype for 'usbfs_notify_resume'
> 
> Use the same #ifdef check around the function definitions to avoid
> the warnings and slightly shrink the USB core.
> 
> Fixes: 7794f486ed0b ("usbfs: Add ioctls for runtime power management")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/core/devio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index e501a03d6c70..1622ad35428d 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -738,6 +738,7 @@ static int driver_resume(struct usb_interface *intf)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
>  /* The following routines apply to the entire device, not interfaces */
>  void usbfs_notify_suspend(struct usb_device *udev)
>  {
> @@ -756,6 +757,7 @@ void usbfs_notify_resume(struct usb_device *udev)
>  	}
>  	mutex_unlock(&usbfs_mutex);
>  }
> +#endif
>  
>  struct usb_driver usbfs_driver = {
>  	.name =		"usbfs",
> -- 
> 2.39.2
> 
