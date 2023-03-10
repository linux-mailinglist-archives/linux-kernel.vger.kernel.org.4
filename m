Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B166D6B4910
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjCJPI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjCJPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:08:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B41223A4;
        Fri, 10 Mar 2023 07:01:11 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0DE92E5;
        Fri, 10 Mar 2023 15:59:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678460371;
        bh=Chwv7HFTcUaY/JET0sX7VEDo3HbGbnOEAmqSg2EzMbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ob9KojRlAz9DuOGHlgGEvMtOc+uHUeZdj/WmXCOwIiQaE+E6TVQIjry+0ODhV5NDm
         sZWrRRWmi63Y0pejiCDV9XcL9g/v66a2k9o6100n/mK1tzl4GIN66xQFe5xjjXUFUK
         A7Ph1q+xazouYwW0DwJjdJfy8lvW3XM7wvHAesIA=
Date:   Fri, 10 Mar 2023 16:59:35 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Use of_property_read_bool() for boolean properties
Message-ID: <20230310145935.GI5342@pendragon.ideasonboard.com>
References: <20230310144706.1542295-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310144706.1542295-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Fri, Mar 10, 2023 at 08:47:05AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().

s/to to/to/ (or maybe "to use" ?)

With this,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/bridge/parade-ps8622.c | 2 +-
>  drivers/gpu/drm/tiny/ofdrm.c           | 8 ++------
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
> index 530ee6a19e7e..efa80e309b98 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> @@ -496,7 +496,7 @@ static int ps8622_probe(struct i2c_client *client)
>  		ps8622->lane_count = ps8622->max_lane_count;
>  	}
>  
> -	if (!of_find_property(dev->of_node, "use-external-pwm", NULL)) {
> +	if (!of_property_read_bool(dev->of_node, "use-external-pwm")) {
>  		ps8622->bl = backlight_device_register("ps8622-backlight",
>  				dev, ps8622, &ps8622_backlight_ops,
>  				NULL);
> diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
> index 6e349ca42485..76cd7f515bab 100644
> --- a/drivers/gpu/drm/tiny/ofdrm.c
> +++ b/drivers/gpu/drm/tiny/ofdrm.c
> @@ -162,13 +162,9 @@ static bool display_get_big_endian_of(struct drm_device *dev, struct device_node
>  	bool big_endian;
>  
>  #ifdef __BIG_ENDIAN
> -	big_endian = true;
> -	if (of_get_property(of_node, "little-endian", NULL))
> -		big_endian = false;
> +	big_endian = !of_property_read_bool(of_node, "little-endian");
>  #else
> -	big_endian = false;
> -	if (of_get_property(of_node, "big-endian", NULL))
> -		big_endian = true;
> +	big_endian = of_property_read_bool(of_node, "big-endian");
>  #endif
>  
>  	return big_endian;

-- 
Regards,

Laurent Pinchart
