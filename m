Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38923732971
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbjFPIEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244932AbjFPIDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:03:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FC2D7E;
        Fri, 16 Jun 2023 01:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EE2662D29;
        Fri, 16 Jun 2023 08:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD9EC433C9;
        Fri, 16 Jun 2023 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686902626;
        bh=SFhszW6Q8Og3ckltusGDv4yzQJqbNaNtVYyqIvkr9Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9E7o3CxcEeyXtiKotFqZp6iIiKLaeX8j12zFkjvecOIDxAhb+p5zEoboxSfYCVFn
         wuWcX2NIRLx9JjqZ0IVlblm1lst/lwOg6RTaNbqKQtItOwTSpZZFGaVjg35nZgWHFw
         Kl830DpuEB2+EUg+nO4xhUynoLJc+2yb2ZhGq1iU=
Date:   Fri, 16 Jun 2023 10:03:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_ugoswami@quicinc.com
Subject: Re: [PATCH v2] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
Message-ID: <2023061633-scarcity-pristine-4205@gregkh>
References: <20230616071715.20960-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616071715.20960-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 12:47:15PM +0530, Krishna Kurapati wrote:
> In scenarios where pullup relies on resume (get sync) to initialize
> the controller and set the run stop bit, then core_init is followed by
> gadget_resume which will eventually set run stop bit.
> 
> But in cases where the core_init fails, the return value is not sent
> back to udc appropriately. So according to UDC the controller has
> started but in reality we never set the run stop bit.
> 
> On systems like Android, there are uevents sent to HAL depending on
> whether the configfs_bind / configfs_disconnect were invoked. In the
> above mentioned scnenario, if the core init fails, the run stop won't
> be set and the cable plug-out won't result in generation of any
> disconnect event and userspace would never get any uevent regarding
> cable plug out and we never call pullup(0) again. Furthermore none of
> the next Plug-In/Plug-Out's would be known to configfs.
> 
> Return back the appropriate result to UDC to let the userspace/
> configfs know that the pullup failed so they can take appropriate
> action.
> 
> Fixes: 77adb8bdf422 ("usb: dwc3: gadget: Allow runtime suspend if UDC unbinded")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
>  drivers/usb/dwc3/gadget.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 578804dc29ca..27cb671e18e3 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2747,7 +2747,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>  	ret = pm_runtime_get_sync(dwc->dev);
>  	if (!ret || ret < 0) {
>  		pm_runtime_put(dwc->dev);
> -		return 0;
> +		if (ret < 0)
> +			pm_runtime_set_suspended(dwc->dev);
> +		return ret;
>  	}
>  
>  	if (dwc->pullups_connected == is_on) {
> -- 
> 2.40.0
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
