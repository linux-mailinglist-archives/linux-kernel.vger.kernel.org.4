Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB6D615BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiKBFQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBFQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:16:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675126486;
        Tue,  1 Nov 2022 22:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29CF4B82076;
        Wed,  2 Nov 2022 05:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D2DC433D6;
        Wed,  2 Nov 2022 05:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667366160;
        bh=hHwSE7lfppAEnznnhdf0n+Vgc9ey1TfjLM03Cs/kL/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=19Zg+4QIHgNvvDJMN0oykhLkMZ1D7saEZkJlEGtd4AoKvG8fEraGHvWAgqA+w0cNc
         J+rzptGH7f0iufK7vRWfcUBwKmKI5PO33If6SiUWkgY+Tem4f4twbd7dz5Ai6yuyHe
         ha4qeVV68IwapAaJ70DOYG5LhlJcOmlA9qmjIjms=
Date:   Wed, 2 Nov 2022 06:16:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daewoong Kim <daewoong00.kim@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: pass usb_get_status() 'type' argument to
 usb_control_msg()
Message-ID: <Y2H9Rk0OlwLgTC1j@kroah.com>
References: <20221102025930.GA2163061@marvel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102025930.GA2163061@marvel>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:58:14PM +0900, Daewoong Kim wrote:
> In the commit 2e43f0fe379c
> ("usb: core: add a 'type' parameter to usb_get_status()"), the 'type'
> parameter was added. It should be passed to usb_control_msg() as an
> argument.
> 
> Signed-off-by: Daewoong Kim <daewoong00.kim@gmail.com>
> ---
>  drivers/usb/core/message.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 4d59d927ae3e..a81f23d81480 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1150,7 +1150,7 @@ int usb_get_status(struct usb_device *dev, int recip, int type, int target,
>  		return -ENOMEM;
>  
>  	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> -		USB_REQ_GET_STATUS, USB_DIR_IN | recip, USB_STATUS_TYPE_STANDARD,
> +		USB_REQ_GET_STATUS, USB_DIR_IN | recip, type,

This shows that since 2017, no one has actually used the type field.
And there is only one caller that sets it to anything other than this
value.  But no one even uses that!

So let's remove the one caller that is not working, and just leave this
as-is and maybe make this even simpler by removing the type field as no
one seems to need it.

thanks,

greg k-h
