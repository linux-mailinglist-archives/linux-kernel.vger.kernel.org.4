Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD186B6391
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 07:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCLGw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 01:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLGwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 01:52:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D48053D93;
        Sat, 11 Mar 2023 22:52:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA49560A3B;
        Sun, 12 Mar 2023 06:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4737C4339B;
        Sun, 12 Mar 2023 06:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678603943;
        bh=k1TxaSwAKQxw+AsnSrIWcYO5UwHIt/wD7Uhbv8/IEBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9PGZbINCnq78MvyRU+lzUqOggKKd95Xwxsu6J0k/XffQLe4KloXsZ5WYD/cttZjS
         T4ED7ahjSFnM6dKzUJ63KtELMs5ptoTdnuLMzlwR7RANhFlyyyxXcm/eMCsl7PGM6u
         sF6xm1qUueUCVoH+agbEghvjW1uRxvANFEg4Zt4w=
Date:   Sun, 12 Mar 2023 07:52:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yaroslav Furman <yaro330@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uas: Add US_FL_NO_REPORT_OPCODES for JMicron
 JMS583Gen 2
Message-ID: <ZA12pMgwA/8CguYd@kroah.com>
References: <7f670cac-aa36-4bb9-a2b1-4451e4e85fab@rowland.harvard.edu>
 <20230311171226.20353-1-yaro330@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311171226.20353-1-yaro330@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 07:12:26PM +0200, Yaroslav Furman wrote:
> Just like other JMicron JMS5xx enclosures, it chokes on report-opcodes,
> let's avoid them.
> 
> Signed-off-by: Yaroslav Furman <yaro330@gmail.com>
> ---
>  drivers/usb/storage/unusual_uas.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
> index c7b763d6d102..1f8c9b16a0fb 100644
> --- a/drivers/usb/storage/unusual_uas.h
> +++ b/drivers/usb/storage/unusual_uas.h
> @@ -111,6 +111,13 @@ UNUSUAL_DEV(0x152d, 0x0578, 0x0000, 0x9999,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_BROKEN_FUA),
>  
> +/* Reported by: Yaroslav Furman <yaro330@gmail.com> */
> +UNUSUAL_DEV(0x152d, 0x0583, 0x0000, 0x9999,
> +		"JMicron",
> +		"JMS583Gen 2",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_NO_REPORT_OPCODES),
> +
>  /* Reported-by: Thinh Nguyen <thinhn@synopsys.com> */
>  UNUSUAL_DEV(0x154b, 0xf00b, 0x0000, 0x9999,
>  		"PNY",
> -- 
> 2.39.2
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
