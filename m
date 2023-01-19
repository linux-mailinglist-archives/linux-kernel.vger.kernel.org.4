Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86E667405C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjASR4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjASR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:56:08 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD65421A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:56:06 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c26so2083409pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dK/MT5cZpGNEq2q0NNicN2x6KFwkRzxJpZw6zyull3w=;
        b=BrMfzB7ispzCRtIlt/nFnOZVt7ANeog8D5LRpfCI6FvNEBGj+u3JxcRJ6sU6vy/kW8
         wdwsp0KgU2DD5y75LcDe7N4VEIWJcdHbXccDWHOJz8QTioAGT5PNIjBSSpKmwlUewCJB
         Bef/m0WMqoTEb//gZcko2V4rfWHYU1xCRkaMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dK/MT5cZpGNEq2q0NNicN2x6KFwkRzxJpZw6zyull3w=;
        b=MQwFy5G+Divgbc7Ddd0vFIBHHZx6vKarNHbF+LKNgpbl2JFa83fz9MI+rJlJo4NrK7
         birxGM/PwEDdmnaAS4DQ8V0u4MuVt/YCP9BMdCuymUB4BwmZ81wi1QbtWYq8l1V1wHJO
         jlMEQdCEqZLO8a+LViehH0g62T93g5ND9zgBC7qF3gLhLDYnPBJT7VT7IdBjNR7Zk/An
         YyYfHkJ5a8FoNVw9kwpS7N7x0id73CExhRFSNu3P9qQm6s/mB0es1I2IXaJb22mV0V1z
         iaAlDAK8vP/LvxIt5QwJkkIYjYkl7N1onn2eOU6JCxMCm77kZ7ogUYG/9sZ9RZSlvsJd
         p/nw==
X-Gm-Message-State: AFqh2kq1N6THA3x7q0B6mxUiPJm8tCmAFKybGsXMIwi6l27JBKcp+KNt
        PLTA7QT/GvU+6tvQyJQE1QBygQ==
X-Google-Smtp-Source: AMrXdXtJi+q7YE7QtV7XTUW8K5K4naPvUNENli8B1bjnFwnoeHD7Ll2Egp7mWJfsjf8nj2EZ25zMIA==
X-Received: by 2002:aa7:9467:0:b0:58b:aaaa:82a9 with SMTP id t7-20020aa79467000000b0058baaaa82a9mr11526431pfq.25.1674150965427;
        Thu, 19 Jan 2023 09:56:05 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:588c:c3ec:d9b:dca0])
        by smtp.gmail.com with ESMTPSA id 2-20020a620502000000b00580cf1be16csm24277542pff.137.2023.01.19.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:56:04 -0800 (PST)
Date:   Thu, 19 Jan 2023 09:56:02 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     ye.xingchen@zte.com.cn
Cc:     dianders@chromium.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        ville.syrjala@linux.intel.com, sam@ravnborg.org,
        linmq006@gmail.com, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: Use devm_platform_get_and_ioremap_resource()
Message-ID: <Y8mEMgKlmBvtdwBO@google.com>
References: <202301191559014087173@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301191559014087173@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:59:01PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index df9370e0ff23..50f092b316d0 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1686,7 +1686,6 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct analogix_dp_device *dp;
> -	struct resource *res;
>  	unsigned int irq_flags;
>  	int ret;
> 
> @@ -1740,9 +1739,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
> 
>  	clk_prepare_enable(dp->clock);
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	dp->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	dp->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);

Rather than a NULL 3rd argument, couldn't you just use
devm_platform_ioremap_resource()? With that:

Reviewed-by: Brian Norris <briannorris@chromium.org>


>  	if (IS_ERR(dp->reg_base)) {
>  		ret = PTR_ERR(dp->reg_base);
>  		goto err_disable_clk;
> -- 
> 2.25.1
