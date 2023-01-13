Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DB366910E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjAMIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbjAMIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:34:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FE0559F9;
        Fri, 13 Jan 2023 00:34:02 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 206F04D4;
        Fri, 13 Jan 2023 09:34:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673598841;
        bh=VP81boZNAULBig0pX/5Ej4adNCPEe27XN6cdfqVNgnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGLf5/5m47IFuh8UeLj+XpcdCSsohaE9DAuWqklfh+1eBEhANhgFCJroUdC77MzAY
         f0l8htJSunhTpr0ytTCZqJDOF5uxQq2aS0ie64hg381wozZt/23TaQ1XIcNDsC17FI
         Ty8jq7ZMZP8Z/kQFi7q8dOxy7wvkf5TkI2LyflgQ=
Date:   Fri, 13 Jan 2023 09:33:58 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to
 __v4l2_ctrl_modify_range
Message-ID: <20230113083358.yreo42dmnrwjlvak@uno.localdomain>
References: <20230113010135.2620818-1-shravan.chippa@microchip.com>
 <20230113010135.2620818-2-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230113010135.2620818-2-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan

On Fri, Jan 13, 2023 at 06:31:32AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> For evry mode we will get new set of values for hbalnk so use
> __v4l2_ctrl_modify_range() to support multi modes for hblank.
>
> The hblank value is readonly in the driver. because of this the function
> returns error if we try to change. so added dumy return case in
> imx334_set_ctrl function
>
> Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j
> ---
>  drivers/media/i2c/imx334.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index 7b0a9086447d..ebacba3059b3 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -382,7 +382,8 @@ static int imx334_update_controls(struct imx334 *imx334,
>  	if (ret)
>  		return ret;
>
> -	ret = __v4l2_ctrl_s_ctrl(imx334->hblank_ctrl, mode->hblank);
> +	ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, mode->hblank,
> +				       mode->hblank, 1, mode->hblank);
>  	if (ret)
>  		return ret;
>
> @@ -480,6 +481,9 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
>
>  		pm_runtime_put(imx334->dev);
>
> +		break;
> +	case V4L2_CID_HBLANK:
> +		ret = 0;
>  		break;
>  	default:
>  		dev_err(imx334->dev, "Invalid control %d", ctrl->id);
> --
> 2.34.1
>
