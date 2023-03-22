Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FC06C451F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCVIgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCVIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:35:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7695D75E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:35:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6C783A58;
        Wed, 22 Mar 2023 09:35:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679474128;
        bh=dzRkl61AnobAS2ipZh6Jf0RiwfAoBUdWthcPEZM9bHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMSutXQ/60qmKy2BkVjuWbDTdI/Jlo6Hhtaq52EPoozPHoxeO/0IPOZSfJ9LDpT1K
         wSw0pwEWctTkp6S8rpyO42Iqw+MGh9GU/WHHjktDIYdpHcuMYtTwZtgT9mr4HTh8n/
         O53BOPzxBDXvefnwu7+4sxjCC1LmBtY9Dveuu4h8=
Date:   Wed, 22 Mar 2023 10:35:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     ye.xingchen@zte.com.cn
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: display-connector: Use dev_err_probe()
Message-ID: <20230322083535.GH20234@pendragon.ideasonboard.com>
References: <202303221621336645576@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202303221621336645576@zte.com.cn>
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

On Wed, Mar 22, 2023 at 04:21:33PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/display-connector.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index fbb3e102c02f..56ae511367b1 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -271,12 +271,9 @@ static int display_connector_probe(struct platform_device *pdev)
>  	    type == DRM_MODE_CONNECTOR_DisplayPort) {
>  		conn->hpd_gpio = devm_gpiod_get_optional(&pdev->dev, "hpd",
>  							 GPIOD_IN);
> -		if (IS_ERR(conn->hpd_gpio)) {
> -			if (PTR_ERR(conn->hpd_gpio) != -EPROBE_DEFER)
> -				dev_err(&pdev->dev,
> -					"Unable to retrieve HPD GPIO\n");
> -			return PTR_ERR(conn->hpd_gpio);
> -		}
> +		if (IS_ERR(conn->hpd_gpio))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(conn->hpd_gpio),
> +					     "Unable to retrieve HPD GPIO\n");
> 
>  		conn->hpd_irq = gpiod_to_irq(conn->hpd_gpio);
>  	} else {

-- 
Regards,

Laurent Pinchart
