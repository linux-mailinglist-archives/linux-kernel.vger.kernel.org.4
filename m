Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55272721B02
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 01:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjFDXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDXM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 19:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5DCA9;
        Sun,  4 Jun 2023 16:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBC0060C48;
        Sun,  4 Jun 2023 23:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7808C433D2;
        Sun,  4 Jun 2023 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685920375;
        bh=YKeJsb9nhFq0Uyt46AONGemv5Y80lD367AfKzlLfI+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKcHXR2L+n8UzDDc0dJ9C1Luj+sFU7bcRa/wSWm6MQbxd+aYx+FwynwOBJ5F/lQHY
         54B61fEKa5SpXd+uaGt9v9Qvh5vmP0SFBzShzBtkfUZkFFj1yL0jeX4lPmKl4UD/Qe
         3lsFrBju/C/OPfHte1Vo+wT+BInPZL9/ECgkomDMo0dO08AkV6FOg2JAO1nN+POkj7
         9Hk0JlqkOa1RyHpEyaeJxsD89b5AgZJjx5XW3+3Cv34H6s78dlCCrPikWBHHpJZuLm
         I5QtC/tEp6Tba6NgghbVX7d9X5zJXyrOriB7HgZALwApDYi1kyt26o1bnaxWvGnbdp
         NF4DegSRq+s2A==
Date:   Mon, 5 Jun 2023 07:12:44 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] usb: cdns3: improve handling of unaligned address
 case
Message-ID: <20230604231244.GC258497@nchen-desktop>
References: <20230518204947.3770236-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518204947.3770236-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18 16:49:45, Frank Li wrote:
> When the address of a request was not aligned with an 8-byte boundary, the
> USB DMA was unable to process it, necessitating the use of an internal
> bounce buffer.
> 
> In these cases, the request->buf had to be copied to/from this bounce
> buffer. However, if this unaligned address scenario arises, it is
> unnecessary to perform heavy cache maintenance operations like
> usb_gadget_map(unmap)_request_by_dev() on the request->buf, as the DMA
> does not utilize it at all. it can be skipped at this case.
> 
> iperf3 tests on the rndis case:
> 
> Transmit speed (TX): Improved from 299Mbps to 440Mbps
> Receive speed (RX): Improved from 290Mbps to 500Mbps
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 1dcadef933e3..09a0882a4e97 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -800,7 +800,8 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
>  	if (request->status == -EINPROGRESS)
>  		request->status = status;
>  
> -	usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
> +	if (likely(!(priv_req->flags & REQUEST_UNALIGNED)))
> +		usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
>  					priv_ep->dir);
>  
>  	if ((priv_req->flags & REQUEST_UNALIGNED) &&
> @@ -2543,10 +2544,12 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
> +	if (likely(!(priv_req->flags & REQUEST_UNALIGNED))) {
> +		ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
>  					    usb_endpoint_dir_in(ep->desc));

So, the possible reason for performance drop is	do cache coherency
operation twice for unaligned buffers?

Peter

> -	if (ret)
> -		return ret;
> +		if (ret)
> +			return ret;
> +	}
>  
>  	list_add_tail(&request->list, &priv_ep->deferred_req_list);
>  
> -- 
> 2.34.1
> 

-- 

Thanks,
Peter Chen
