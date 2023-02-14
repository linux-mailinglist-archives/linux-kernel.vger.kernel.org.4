Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB556696FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjBNVam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjBNVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:30:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D708A78;
        Tue, 14 Feb 2023 13:30:10 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1654A3D7;
        Tue, 14 Feb 2023 22:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1676410135;
        bh=tU9K3Ed+ODfAS92PB66QRq4VPSZ7K7Ly18eV3BZP2/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxZOpvcRrUHzVAcXO5lUng2LvdfFfVWYbAuvzwg09L3rFth6T/CqGOTy8xqOnwYoR
         DtSH0ndKkzoZ7LSoshF41GVg34Gm3bFR80wwNUP6jCbTYvn4i0Hr5LuSCrAX+wem74
         neO2TszAvvmzDNzExzeIdPpyEVfjPqzyMRP6xtho=
Date:   Tue, 14 Feb 2023 23:28:54 +0200
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
Subject: Re: [PATCH] media: imx: imx7-media-csi: Fix error handling in
 imx7_csi_async_register()
Message-ID: <Y+v9Fu5LNk5udjgB@pendragon.ideasonboard.com>
References: <20230214163200.1448837-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230214163200.1448837-1-frieder@fris.de>
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

On Tue, Feb 14, 2023 at 05:31:56PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> If fwnode_graph_get_endpoint_by_id() fails and returns NULL, there is
> no point in going on. Print an error message a abort instead.

s/a abort/and abort/

Explaining why as a reference to future readers would be nice:

The CSI requires a connected source subdev to operate. If
fwnode_graph_get_endpoint_by_id() fails and returns NULL, there is no
point in going on. Print an error message and abort instead.

> Also we don't need to check for an existing asd. Any failure of
> v4l2_async_nf_add_fwnode_remote() should abort the probe.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/media/platform/nxp/imx7-media-csi.c | 22 +++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
> index 886374d3a6ff..a7db310624e2 100644
> --- a/drivers/media/platform/nxp/imx7-media-csi.c
> +++ b/drivers/media/platform/nxp/imx7-media-csi.c
> @@ -2191,18 +2191,20 @@ static int imx7_csi_async_register(struct imx7_csi *csi)
>  
>  	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(csi->dev), 0, 0,
>  					     FWNODE_GRAPH_ENDPOINT_NEXT);
> -	if (ep) {
> -		asd = v4l2_async_nf_add_fwnode_remote(&csi->notifier, ep,
> -						      struct v4l2_async_subdev);
> +	if (!ep) {
> +		dev_err(csi->dev, "Failed to get remote endpoint\n");

Let's use dev_err_probe() as this is called from the probe function:

		dev_err_probe(csi->dev, -ENOTCONN,
			      "Failed to get remote endpoint\n");

> +		return -ENOTCONN;
> +	}
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
> +	fwnode_handle_put(ep);
> +
> +	if (IS_ERR(asd)) {
> +		ret = PTR_ERR(asd);
> +		dev_err(csi->dev, "Failed to add remote subdev to notifier: %d\n", ret);

Same here:

		dev_err_probe(csi->dev, ret,
			      "Failed to add remote subdev to notifier\n");

> +		return ret;
>  	}
>  
>  	csi->notifier.ops = &imx7_csi_notify_ops;

-- 
Regards,

Laurent Pinchart
