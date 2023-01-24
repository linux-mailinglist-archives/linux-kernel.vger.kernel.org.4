Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63DD679D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjAXPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjAXPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:36:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B8015552;
        Tue, 24 Jan 2023 07:36:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 659C3B8126A;
        Tue, 24 Jan 2023 15:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67D9C433D2;
        Tue, 24 Jan 2023 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674574581;
        bh=XrRqwbhfGcJet/92ke8rwPTG+8hf0GkoJkUDe6Xs0D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqBcHv5ttUZszZ25uk0blrw48MFW2fDKbF19urI4YT+wbVGwlNeFhyqPoCi9NvAYJ
         jqFDPXrIlcIaEzLBk7GvfcGC7ZVOZXFe+dKfK9xRHmEqgqlPuq1jfhvSDlF2i+7NSu
         Xk4gAWA81zdkW3VpLWPIZ01yJaYaG5eBMTiArpfM=
Date:   Tue, 24 Jan 2023 16:36:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Pavel Hofman <pavel.hofman@ivitera.com>,
        Joe Perches <joe@perches.com>, Julian Scheel <julian@jusst.de>,
        Colin Ian King <colin.i.king@gmail.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2] usb: gadget: f_uac2: Fix incorrect increment of
 bNumEndpoints
Message-ID: <Y8/68L3Se8094kru@kroah.com>
References: <1674559787-25928-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674559787-25928-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 04:59:47PM +0530, Prashanth K wrote:
> Currently connect/disconnect of USB cable calls afunc_bind and
> eventually increments the bNumEndpoints. Performing multiple
> plugin/plugout will increment bNumEndpoints incorrectly, and on
> the next plug-in it leads to invalid configuration of descriptor
> and hence enumeration fails.
> 
> Fix this by resetting the value of bNumEndpoints to 1 on every
> afunc_bind call.
> 
> Fixes: 40c73b30546e ("usb: gadget: f_uac2: add adaptive sync support for capture")
> Signed-off-by: Pratham Pratap <quic_ppratap@quicinc.com>
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/gadget/function/f_uac2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index 08726e4..0219cd7 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -1142,6 +1142,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
>  		}
>  		std_as_out_if0_desc.bInterfaceNumber = ret;
>  		std_as_out_if1_desc.bInterfaceNumber = ret;
> +		std_as_out_if1_desc.bNumEndpoints = 1;
>  		uac2->as_out_intf = ret;
>  		uac2->as_out_alt = 0;
>  
> -- 
> 2.7.4
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
