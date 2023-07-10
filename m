Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4174CAA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGJDiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjGJDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A49B7;
        Sun,  9 Jul 2023 20:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04CD96068C;
        Mon, 10 Jul 2023 03:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437F3C433C8;
        Mon, 10 Jul 2023 03:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688960326;
        bh=lMGkb6vcjaJLddWMIbgP/aSewHMop7UBQMjE9P34SE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwtONS72051QwGae299V1XoWZ8cIDSJ2ALc8e0b+xRQC7BFtPDQR6GszTIpYdC3wI
         wwkf/LhTv9su3bw2YXlTc89a2KDsQdlLfia9fahZ63mrCseWPMLdbmYpHVdE1xC/h1
         WsTYv7NiJrd1dxOUKsdC8jG/q2nLR0SUfghA5vbxHvD4XTsZESvw+KXyugK3cl7Csn
         MkVxkqPhz7VbQphERMLZ6b4Ns68Sy1mE5nYJgA64TmfB3UN97E2Lr8XT7goN30X9ZD
         8IzNCs/Mnx86uL7neBTAcnsKpmnlshffLUSYl9cjCs6JPPyN4laJXoU5DyzFRHnehy
         fRwDsorX8+W0A==
Date:   Mon, 10 Jul 2023 11:38:34 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Thinh.Nguyen@synopsys.com, andriy.shevchenko@linux.intel.com,
        gregkh@linuxfoundation.org, imx@lists.linux.dev, jgilab@gmail.com,
        jun.li@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_eserrao@quicinc.com,
        quic_prashk@quicinc.com, r-gunasekaran@ti.com, rogerq@kernel.org
Subject: Re: [PATCH v2 2/2] usb: cdns3: fix incorrect calculation of
 ep_buf_size when more than one config
Message-ID: <20230710033834.GG2418446@nchen-desktop>
References: <20230707230015.494999-1-Frank.Li@nxp.com>
 <20230707230015.494999-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707230015.494999-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-07 19:00:15, Frank Li wrote:
> Previously, the cdns3_gadget_check_config() function in the cdns3 driver
> mistakenly calculated the ep_buf_size by considering only one
> configuration's endpoint information because "claimed" will be clear after
> call usb_gadget_check_config().
> 
> The fix involves checking the private flags EP_CLAIMED instead of relying
> on the "claimed" flag.
> 
> Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
> Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index ccfaebca6faa..3326955f6991 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2999,12 +2999,14 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
>  static int cdns3_gadget_check_config(struct usb_gadget *gadget)
>  {
>  	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> +	struct cdns3_endpoint *priv_ep;
>  	struct usb_ep *ep;
>  	int n_in = 0;
>  	int total;
>  
>  	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
> -		if (ep->claimed && (ep->address & USB_DIR_IN))
> +		priv_ep = ep_to_cdns3_ep(ep);
> +		if ((priv_ep->flags & EP_CLAIMED) && (ep->address & USB_DIR_IN))
>  			n_in++;
>  	}

Acked-by: Peter Chen <peter.chen@kernel.org>

-- 

Thanks,
Peter Chen
