Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0192E671D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjARNUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjARNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:20:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094FA56EF3;
        Wed, 18 Jan 2023 04:43:51 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1DDA81643;
        Wed, 18 Jan 2023 13:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674045829;
        bh=tHlj3HkTx1GSBDMw1c7SA7mu5/2YsoMey8ABgUrPViY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpHaUpfH1Zr3kroRxhYUQOpcEzOzBDnpXEWN2V7X2gIgm0xcC5RiqNfiVeDBzWKHh
         oJ+VeA8AMjE1o0Z74ST/skSaEnZto1bX3kdquGFZiUPhyyitdvtv9Xy3pDbjg8rCT9
         yQKMG+E8GjzLAOWUTIcnpt4kXTvR+UKoTtY7sbZs=
Date:   Wed, 18 Jan 2023 14:43:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: renesas: vsp1: blacklist r8a7795 ES1.*
Message-ID: <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com>
References: <20230118122003.132905-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118122003.132905-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Wed, Jan 18, 2023 at 01:20:02PM +0100, Wolfram Sang wrote:
> The earliest revision of these SoC may hang when underrunning. Later
> revisions have that fixed. Bail out when we detect a problematic
> version.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> The BSP tries to work around the issue, yet this is neither upstreamable
> nor are we sure the solution is complete. Because the early SoC revision
> is hardly in use, we simply "document" the problem upstream.

The workaround isn't upstreamable as-is, but I think it could be
upstreamed after being cleaned up.

Overall, how much support do we still have upstream for H3 ES1.x, and do
we need to keep it ? H3 ES.1x is relatively old, does someone still rely
on it ?

>  drivers/media/platform/renesas/vsp1/vsp1_drv.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> index c260d318d298..b395e8eb0af9 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> +#include <linux/sys_soc.h>
>  #include <linux/videodev2.h>
>  
>  #include <media/rcar-fcp.h>
> @@ -875,13 +876,24 @@ static const struct vsp1_device_info *vsp1_lookup_info(struct vsp1_device *vsp1)
>  	return NULL;
>  }
>  
> +static const struct soc_device_attribute vsp1_blacklist[]  = {
> +	/* H3 ES1.* has underrun hang issues */
> +	{ .soc_id = "r8a7795", .revision = "ES1.*" },
> +	{ /* Sentinel */ }
> +};
> +
>  static int vsp1_probe(struct platform_device *pdev)
>  {
> +	const struct soc_device_attribute *attr;
>  	struct vsp1_device *vsp1;
>  	struct device_node *fcp_node;
>  	int ret;
>  	int irq;
>  
> +	attr = soc_device_match(vsp1_blacklist);
> +	if (attr)
> +		return -ENOTSUPP;
> +
>  	vsp1 = devm_kzalloc(&pdev->dev, sizeof(*vsp1), GFP_KERNEL);
>  	if (vsp1 == NULL)
>  		return -ENOMEM;

-- 
Regards,

Laurent Pinchart
