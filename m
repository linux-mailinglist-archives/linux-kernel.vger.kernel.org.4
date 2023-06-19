Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6314734C15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjFSHGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjFSHGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B851A4;
        Mon, 19 Jun 2023 00:06:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BDA760B02;
        Mon, 19 Jun 2023 07:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BD0C433C0;
        Mon, 19 Jun 2023 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687158390;
        bh=Qi0kxRUlKWF50DOfOELr34P/YasyzebyEfFENZXe5PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LC2fwE5UOFLGFIFz3QATqffcxTny+pB+QL+NnjWe+Md3Udt4QvYA4JOjx/Q2IroL2
         OA/Gh0nrQpfD8UxAidI4Og71Hmz4OY8ll3WqpSnMJa/bnsfSPWu4D281FYvfRrcbZl
         12jtlFWNeeg6phI5RJpmqaJO+2z/6XahpiUUD0nOKokHkRqqWpW/HM4S0XR4uv9FEu
         x9h1thnc+ykE3WX/c7JgUBPMuZZacM1E9/FfQcneLrJ7XZuOtcG+KA8ubA8reEB542
         NtLxdOTKk5d9a2fbQp0EGc7Y2e7EhvXJ6AVJhY0xVe6iZ/w55uwPuXP+eXoEnxkHj4
         Kk1LzURS+2YEw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qB8y3-0000mg-O5; Mon, 19 Jun 2023 09:06:27 +0200
Date:   Mon, 19 Jun 2023 09:06:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_ugoswami@quicinc.com
Subject: Re: [PATCH v3] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
Message-ID: <ZI_-c5g20DSJOSu2@hovoldconsulting.com>
References: <20230618120949.14868-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618120949.14868-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 05:39:49PM +0530, Krishna Kurapati wrote:
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
> Changes in v3: Added changelog mising in v2
> Changes in v2: Added Fixes tag
> 
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

This bit is broken and is also not mentioned or explained in the commit
message. What are you trying to achieve here?

You cannot set the state like this after runtime PM is enabled and the
above call will always fail. 

> +		return ret;
>  	}
>  
>  	if (dwc->pullups_connected == is_on) {

Johan
