Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E7E6C4558
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCVItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:49:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0BB53DB1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:49:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 068E9A58;
        Wed, 22 Mar 2023 09:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679474980;
        bh=6QZ1PsOMp+7W6iDxFRNuFgWGUQvAt/eYqNCv/Wjo14I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzvCulRemaeNYC8FQXQhe6QvMW4vt/EtlPbKoN9ruDFQINnftCqvEZHq65a/cyc/t
         JvZaoW1BgyPT0S0IM2OjcT9CeM+wDOopSjbIs+2xMzMTGWvtTPo0qtF41ku6nVNka7
         bnNa3fEkkXVRaL+Akxm0kbscBLJWvbLHqO5T+uR8=
Date:   Wed, 22 Mar 2023 10:49:46 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     ye.xingchen@zte.com.cn
Cc:     hyun.kwon@xilinx.com, airlied@gmail.com, daniel@ffwll.ch,
        michal.simek@xilinx.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: zynqmp: Use dev_err_probe()
Message-ID: <20230322084946.GI20234@pendragon.ideasonboard.com>
References: <202303221625255005719@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202303221625255005719@zte.com.cn>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

Thank you for the patch.

On Wed, Mar 22, 2023 at 04:25:25PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 0a7b466446fb..c6c2cb4626b9 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1700,10 +1700,8 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
> 
>  	dp->reset = devm_reset_control_get(dp->dev, NULL);
>  	if (IS_ERR(dp->reset)) {
> -		if (PTR_ERR(dp->reset) != -EPROBE_DEFER)
> -			dev_err(dp->dev, "failed to get reset: %ld\n",
> -				PTR_ERR(dp->reset));
> -		ret = PTR_ERR(dp->reset);
> +		ret = dev_err_probe(dp->dev, PTR_ERR(dp->reset),
> +				    "failed to get reset: %ld\n");

There's no format string argument anymore, so you should drop the
": %ld". Didn't the compiler warn about this ?

>  		goto err_free;
>  	}
> 

-- 
Regards,

Laurent Pinchart
