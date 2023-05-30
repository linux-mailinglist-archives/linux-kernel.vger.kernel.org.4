Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13C716A00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjE3QrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjE3QrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:47:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01FF9D;
        Tue, 30 May 2023 09:47:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205198071.34.openmobile.ne.jp [126.205.198.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 797077EC;
        Tue, 30 May 2023 18:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685465212;
        bh=b1FpUfw+Soo2stZMK535cATzI69cCENayvLuTSQl0Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jiPzPo9a/9eNF7A2JfrmSmdtLTpMHGuvqYe2SmywfzLh2CAt9+wE0vIOA2MFqqMnv
         nGnQjmJtzVbL3YZqQAA16RQpa05x3JhB1Jfi82+1U71aqKRcOQX3S3Z5Ig9dgsMrYq
         bNpiQtGYQ/IxlqQe2i8+kl4BdnzPryMIFRK/3174=
Date:   Tue, 30 May 2023 19:47:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] media: video-mux: fix error paths
Message-ID: <20230530164712.GB22516@pendragon.ideasonboard.com>
References: <20230524-video-mux-active-state-v1-0-325c69937ac3@pengutronix.de>
 <20230524-video-mux-active-state-v1-1-325c69937ac3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524-video-mux-active-state-v1-1-325c69937ac3@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for the patch.

On Wed, May 24, 2023 at 03:29:24PM +0200, Philipp Zabel wrote:
> Move notifier cleanup into video_mux_async_register() to avoid calling
> v4l2_async_nf_unregister() when v4l2_async_subdev_nf_register() failed.
> In case video_mux_async_register() fails, call media_entity_cleanup().
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/video-mux.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
> index 1d9f32e5a917..4fe31386afc7 100644
> --- a/drivers/media/platform/video-mux.c
> +++ b/drivers/media/platform/video-mux.c
> @@ -389,7 +389,7 @@ static int video_mux_async_register(struct video_mux *vmux,
>  			ret = PTR_ERR(asd);
>  			/* OK if asd already exists */
>  			if (ret != -EEXIST)
> -				return ret;
> +				goto err_nf_cleanup;
>  		}
>  	}
>  
> @@ -397,9 +397,19 @@ static int video_mux_async_register(struct video_mux *vmux,
>  
>  	ret = v4l2_async_subdev_nf_register(&vmux->subdev, &vmux->notifier);
>  	if (ret)
> -		return ret;
> +		goto err_nf_cleanup;
>  
> -	return v4l2_async_register_subdev(&vmux->subdev);
> +	ret = v4l2_async_register_subdev(&vmux->subdev);
> +	if (ret)
> +		goto err_nf_unregister;
> +
> +	return 0;
> +
> +err_nf_unregister:
> +	v4l2_async_nf_unregister(&vmux->notifier);
> +err_nf_cleanup:
> +	v4l2_async_nf_cleanup(&vmux->notifier);
> +	return ret;
>  }
>  
>  static int video_mux_probe(struct platform_device *pdev)
> @@ -473,11 +483,13 @@ static int video_mux_probe(struct platform_device *pdev)
>  	vmux->subdev.entity.ops = &video_mux_ops;
>  
>  	ret = video_mux_async_register(vmux, num_pads - 1);
> -	if (ret) {
> -		v4l2_async_nf_unregister(&vmux->notifier);
> -		v4l2_async_nf_cleanup(&vmux->notifier);
> -	}
> +	if (ret)
> +		goto err_entity_cleanup;
>  
> +	return 0;
> +
> +err_entity_cleanup:
> +	media_entity_cleanup(&vmux->subdev.entity);
>  	return ret;
>  }
>  
> 

-- 
Regards,

Laurent Pinchart
