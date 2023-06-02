Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16772048E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjFBOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjFBOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:35:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D906E43
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:35:08 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1q55rh-0001s5-P4; Fri, 02 Jun 2023 16:34:53 +0200
Message-ID: <19b4b043-7f14-7bd3-c4fa-817ae21009ca@pengutronix.de>
Date:   Fri, 2 Jun 2023 16:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] drm/panel-simple: allow LVDS format override
Content-Language: en-US, de-DE
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Dan Carpenter <error27@gmail.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de, patchwork-jzi@pengutronix.de
References: <20230523-simplepanel_support_nondefault_datamapping-v2-0-87196f0d0b64@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v2-3-87196f0d0b64@pengutronix.de>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <20230523-simplepanel_support_nondefault_datamapping-v2-3-87196f0d0b64@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gentle ping here - Do you have any feedback for me on this patch?

Thanks and best regards
Johannes

On 5/23/23 10:19, Johannes Zink wrote:
> Some panels support multiple LVDS data mapping formats, which can be
> used e.g. run displays on jeida-18 format when only 3 LVDS lanes are
> available.
> 
> Add parsing of an optional data-mapping devicetree property, which also
> touches up the bits per color to match the bus format.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> 
> ---
> 
> Changes:
> 
>    v1 -> v2: - fix missing unwind goto found by test robot
>                Reported-by: kernel test robot <lkp@intel.com>
>                Reported-by: Dan Carpenter <error27@gmail.com>
>                Link: https://lore.kernel.org/r/202304160359.4LHmFOlU-lkp@intel.com/
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 39 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 2a9c1a785a5c..0a35fdb49ccb 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -40,6 +40,7 @@
>   #include <drm/drm_edid.h>
>   #include <drm/drm_mipi_dsi.h>
>   #include <drm/drm_panel.h>
> +#include <drm/drm_of.h>
>   
>   /**
>    * struct panel_desc - Describes a simple panel.
> @@ -559,7 +560,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>   	struct device_node *ddc;
>   	int connector_type;
>   	u32 bus_flags;
> -	int err;
> +	int err, ret;
>   
>   	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
>   	if (!panel)
> @@ -605,6 +606,42 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>   			panel_simple_parse_panel_timing_node(dev, panel, &dt);
>   	}
>   
> +
> +	/* optional data-mapping property for overriding bus format */
> +	ret = drm_of_lvds_get_data_mapping(dev->of_node);
> +	if (ret == -EINVAL) {
> +		dev_warn(dev, "Ignore invalid data-mapping property");
> +	} else if (ret != -ENODEV) {
> +		int bpc;
> +
> +		switch (ret) {
> +		default:
> +			WARN_ON(1);
> +			fallthrough;
> +		case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
> +			fallthrough;
> +		case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
> +			bpc = 8;
> +			break;
> +		case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
> +			bpc = 6;
> +		}
> +
> +		if (desc->bpc != bpc || desc->bus_format != ret) {
> +			struct panel_desc *override_desc;
> +
> +			override_desc = devm_kmemdup(dev, desc, sizeof(*desc), GFP_KERNEL);
> +			if (!override_desc) {
> +				err = -ENOMEM;
> +				goto free_ddc;
> +			}
> +
> +			override_desc->bus_format = ret;
> +			override_desc->bpc = bpc;
> +			panel->desc = override_desc;
> +		}
> +	}
> +
>   	connector_type = desc->connector_type;
>   	/* Catch common mistakes for panels. */
>   	switch (connector_type) {
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

