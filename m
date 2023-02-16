Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0530B699356
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBPLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBPLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:40:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B41ADD1;
        Thu, 16 Feb 2023 03:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E5361F9D;
        Thu, 16 Feb 2023 11:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3CFC433EF;
        Thu, 16 Feb 2023 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676547615;
        bh=KfQe95F5R5pIIWdhzzdP5vS+mRvaXLlq2Xw25O4HEhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzakMt7lQ7cGxLebeZ8m8wF13H85lO12iPaf2P8Vwy+i+cp16XZDylLVZY80S++pv
         jkBlhn1O+vNrnQlP41xZU1O+YdAq+jaY58xqAu4F70Ob5BVcEVzHBSZ9AuqkuvZCDg
         0rDUJkQr6Um6J9ONuR4FJ7kmfTVDHqNlkclE9EYA=
Date:   Thu, 16 Feb 2023 12:40:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc:     Thinh.Nguyen@synopsys.com, balbi@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: gadget: Do not handle OS Descriptors config
 separately
Message-ID: <Y+4WHGNdWTZ5Hc6Y@kroah.com>
References: <1676331925-4771-1-git-send-email-quic_eserrao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676331925-4771-1-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 03:45:25PM -0800, Elson Roy Serrao wrote:
> Consider a multi-configuration composition in which the last
> configuration uses OS descriptors. Since this configuration will
> be sent first, the host may choose this config if it matches the
> choosing criteria and ignore the user configured order of the
> multi-config composition.

That is up to the host, so why is this an issue?

> Moreover linux based hosts do not re-order
> the received configurations based on their indices but process them
> in FIFO order.

s/linux/Linux/

> This may result in the host never choosing the user
> desired configuration because of the re-order caused by sending the
> OS descriptor config first. To avoid this, follow the user configured
> order and do not handle OS descriptor config separately.

I do not understand, what reordering is happening, and by whom?

> 
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>

What commit does this fix?

> ---
>  drivers/usb/gadget/composite.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index fa7dd6c..685003a 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -589,18 +589,9 @@ static int config_desc(struct usb_composite_dev *cdev, unsigned w_value)
>  	w_value &= 0xff;
>  
>  	pos = &cdev->configs;
> -	c = cdev->os_desc_config;
> -	if (c)
> -		goto check_config;
> -
>  	while ((pos = pos->next) !=  &cdev->configs) {
>  		c = list_entry(pos, typeof(*c), list);
>  
> -		/* skip OS Descriptors config which is handled separately */
> -		if (c == cdev->os_desc_config)
> -			continue;
> -
> -check_config:

This feels wrong, are you sure that this code isn't here for a reason?
How did you test this?

thanks,

greg k-h
