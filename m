Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC6265FE4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjAFJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjAFJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:46:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7D269B39;
        Fri,  6 Jan 2023 01:45:27 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BF8B94AE;
        Fri,  6 Jan 2023 10:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672998325;
        bh=/T5taXd6bLDz4vjWDvClITUNDq0FfAJjqZXAsSuuVDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITza31j00Q2sJ0eSZEMUDSpK8ypnGqTQf36VxePJmtaQpZtuqVr7bUD4SEBkefTWa
         AHKgSZN4NAisuR/Uadv5xDPK+vR/I6N/+3LAlDmgN4rCQ7kl8dNKpiTmBGNTrD5lyI
         Cc9cpS5f2qz+wwAfF22BLc1a4q7DAy3/ThsoFYpU=
Date:   Fri, 6 Jan 2023 10:45:23 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     shravan kumar <shravan.chippa@microchip.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/4] media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to
 __v4l2_ctrl_modify_range
Message-ID: <20230106094523.s2giohns4xgcvccy@uno.localdomain>
References: <20230106072931.2317597-1-shravan.chippa@microchip.com>
 <20230106072931.2317597-2-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230106072931.2317597-2-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sharavan,

I'm a bit confused here

On Fri, Jan 06, 2023 at 12:59:28PM +0530, shravan kumar wrote:
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

Hblank is said to be read-only

	if (imx334->hblank_ctrl)
		imx334->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;

So you shouldn't need this safety measure here.

However I see that __v4l2_ctrl_modify_range() can call s_ctrl() if the
current value has to be adjusted to the new limits.

Hans, how does this work ? Do we need the above even if the control is
said to be RO ?

Sharavan: have you experienced failures here, or is this just for
safety ?


>  		break;
>  	default:
>  		dev_err(imx334->dev, "Invalid control %d", ctrl->id);
> --
> 2.34.1
>
