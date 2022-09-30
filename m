Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B85D5F06D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiI3Ish (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiI3Is3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:48:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8A1F0CF3;
        Fri, 30 Sep 2022 01:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9E17B82751;
        Fri, 30 Sep 2022 08:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196A7C433C1;
        Fri, 30 Sep 2022 08:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664527706;
        bh=Jo/cOYiiIovyfrw3RudkLfXtR/QEJeserdY5pJ19vek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UqsjRZoYG8eZFpj6519V68tfD3hQbHVcOwNbtP2WHaHUgAe5bmr1gvSIw++2z9l/p
         O8HeMelTtjuZZuict2IqGLRAQsEmDMo8XHqZ0Rf34qw8/Xkk3rXt1dVM4hbkCorsmu
         +y3P6WPHAdkavMLGdw8F1LygEm89pUgPvAhFlKeA=
Date:   Fri, 30 Sep 2022 10:48:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrice.chotard@foss.st.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Audu <jerome.audu@st.com>,
        Felipe Balbi <felipe@balbi.sh>
Subject: Re: [PATCH v2] usb: dwc3: st: Rely on child's compatible instead of
 name
Message-ID: <YzatV6b5BRqR/bdW@kroah.com>
References: <20220930072707.516270-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930072707.516270-1-patrice.chotard@foss.st.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:27:07AM +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> To ensure that child node is found, don't rely on child's node name
> which can take different value, but on child's compatible name.
> 
> Fixes: f5c5936d6b4d ("usb: dwc3: st: Fix node's child name")
> 
> Cc: Jerome Audu <jerome.audu@st.com>
> Reported-by: Felipe Balbi <felipe@balbi.sh>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  drivers/usb/dwc3/dwc3-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index 166b5bde45cb..fea5290de83f 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	/* Manage SoftReset */
>  	reset_control_deassert(dwc3_data->rstc_rst);
>  
> -	child = of_get_child_by_name(node, "dwc3");
> +	child = of_get_compatible_child(node, "snps,dwc3");
>  	if (!child) {
>  		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
>  		ret = -ENODEV;
> -- 
> 2.25.1
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
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
