Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706D5660166
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjAFNhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjAFNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:37:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464955FC3;
        Fri,  6 Jan 2023 05:37:35 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84C7D4AE;
        Fri,  6 Jan 2023 14:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673012253;
        bh=uRZB5pjOykCODOYScnfRSBE21JUxXCnhmdfXZFIOhqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjyQ/M/B4AzsE6RyqVXIMTHih+UiJMkIGQdy1L3BR0JTh0EyPWCtgeLGQ5m0jkxJs
         L9R2hqnkRe2wVHDYIwnvTPkUGtZPeRPPL35uaxolLCt3bPzwNhTXdk1GPB15AdBf2m
         Fb+7ADPS5j5/ajG980PLQjT9efw1HXRI4VbHHlck=
Date:   Fri, 6 Jan 2023 15:37:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: platform: Fix refcount leak in probe and remove
 function
Message-ID: <Y7gkGGEFDQShRr5o@pendragon.ideasonboard.com>
References: <20230106075809.966856-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230106075809.966856-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miaoqian,

Thank you for the patch.

On Fri, Jan 06, 2023 at 11:58:09AM +0400, Miaoqian Lin wrote:
> rcar_fcp_get() take reference, which should be balanced with
> rcar_fcp_put(). Add missing rcar_fcp_put() in fdp1_remove and
> the error paths of fdp1_probe() to fix this.
> 
> Fixes: 4710b752e029 ("[media] v4l: Add Renesas R-Car FDP1 Driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> I take commit Fixes: 7113469dafc2 ("media: vsp1: Fix an error handling
> path in the probe function") for reference.
> ---
>  drivers/media/platform/renesas/rcar_fdp1.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/rcar_fdp1.c b/drivers/media/platform/renesas/rcar_fdp1.c
> index 37ecf489d112..ed97bb161743 100644
> --- a/drivers/media/platform/renesas/rcar_fdp1.c
> +++ b/drivers/media/platform/renesas/rcar_fdp1.c
> @@ -2313,8 +2313,10 @@ static int fdp1_probe(struct platform_device *pdev)
>  
>  	/* Determine our clock rate */
>  	clk = clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		goto put_dev;
> +	}
>  
>  	fdp1->clk_rate = clk_get_rate(clk);
>  	clk_put(clk);
> @@ -2323,7 +2325,7 @@ static int fdp1_probe(struct platform_device *pdev)
>  	ret = v4l2_device_register(&pdev->dev, &fdp1->v4l2_dev);
>  	if (ret) {
>  		v4l2_err(&fdp1->v4l2_dev, "Failed to register video device\n");
> -		return ret;
> +		goto put_dev;
>  	}
>  
>  	/* M2M registration */
> @@ -2393,6 +2395,8 @@ static int fdp1_probe(struct platform_device *pdev)
>  unreg_dev:
>  	v4l2_device_unregister(&fdp1->v4l2_dev);
>  
> +put_dev:
> +	rcar_fcp_put(fdp1->fcp);
>  	return ret;
>  }
>  
> @@ -2400,6 +2404,7 @@ static int fdp1_remove(struct platform_device *pdev)
>  {
>  	struct fdp1_dev *fdp1 = platform_get_drvdata(pdev);
>  
> +	rcar_fcp_put(fdp1->fcp);

I would move it at the end, after unregistering the V4L2 device, as here
we may still be using the fcp.

Apart from that, the patch looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

No need to send a v2, I'll make this small change in my tree.

>  	v4l2_m2m_release(fdp1->m2m_dev);
>  	video_unregister_device(&fdp1->vfd);
>  	v4l2_device_unregister(&fdp1->v4l2_dev);

-- 
Regards,

Laurent Pinchart
