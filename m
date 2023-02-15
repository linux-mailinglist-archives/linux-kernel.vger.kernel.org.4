Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF36981EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjBOR0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjBOR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:26:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99713A86B;
        Wed, 15 Feb 2023 09:26:29 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 69F2425E;
        Wed, 15 Feb 2023 18:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676481987;
        bh=SxkvjF5LPJ3U8784zKitL4PQRcqzkRD/JLzq6HKfh74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLiJgMLEwTuOuuuORFNyDJe30GhMzqEqzMnZIcBvqVkKSY64GQyGbkc5qqvMAHfwR
         g64JXkZFWM4Usls8tbBc+Udl4D8S6fyGjQZOVFIN6s1biCA60vAj//SN6Nzj6j26gR
         iOmNiFTsXmi4pLF+7Dy9P5Z4u1E5R8U+ECs/R9No=
Date:   Wed, 15 Feb 2023 19:26:26 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2] media: imx: imx7-media-csi: Fix error handling in
 imx7_csi_async_register()
Message-ID: <Y+0Vwm5Q0DH+RRrH@pendragon.ideasonboard.com>
References: <20230215171642.2122786-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230215171642.2122786-1-frieder@fris.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Thank you for the patch.

On Wed, Feb 15, 2023 at 06:16:38PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The CSI requires a connected source subdev to operate. If
> fwnode_graph_get_endpoint_by_id() fails and returns NULL, there is no
> point in going on. Print an error message and abort instead.
> 
> Also we don't need to check for an existing asd. Any failure of
> v4l2_async_nf_add_fwnode_remote() should abort the probe.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes for v2:
> * Improve commit message
> * Use dev_err_probe
> ---
>  drivers/media/platform/nxp/imx7-media-csi.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
> index 886374d3a6ff..76ce6ff2c60a 100644
> --- a/drivers/media/platform/nxp/imx7-media-csi.c
> +++ b/drivers/media/platform/nxp/imx7-media-csi.c
> @@ -2191,19 +2191,18 @@ static int imx7_csi_async_register(struct imx7_csi *csi)
>  
>  	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi->dev), 0, 0,
>  					     FWNODE_GRAPH_ENDPOINT_NEXT);
> -	if (ep) {
> -		asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
> -						      struct v4l2_async_subdev);
> +	if (!ep)
> +		return dev_err_probe(csi->dev, -ENOTCONN,
> +				     "Failed to get remote endpoint\n");
>  
> -		fwnode_handle_put(ep);
> +	asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
> +					      struct v4l2_async_subdev);
>  
> -		if (IS_ERR(asd)) {
> -			ret = PTR_ERR(asd);
> -			/* OK if asd already exists */
> -			if (ret != -EEXIST)
> -				return ret;
> -		}
> -	}
> +	fwnode_handle_put(ep);
> +
> +	if (IS_ERR(asd))
> +		return dev_err_probe(csi->dev, PTR_ERR(asd),
> +				     "Failed to add remote subdev to notifier\n");
>  
>  	csi->notifier.ops = &imx7_csi_notify_ops;
>  

-- 
Regards,

Laurent Pinchart
