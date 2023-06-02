Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22E5720668
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjFBPkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjFBPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:39:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C2B3;
        Fri,  2 Jun 2023 08:39:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59056844;
        Fri,  2 Jun 2023 17:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685720358;
        bh=oS6EYP4XE+4+Oq5RWtM0y/AhtxVoU4P0IParV/DSkvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXgTufZQ71XnC0V7x+tLy2k6qTbqMDBHZurvVir7B9UOJuZ09uIdgys8tuIHCaikH
         Kj9OAgtplwCJ2kk/125+ZdsWIacov/gA2BYNUOK+GX3dnxdeRiV08Pf5ox/azMwXQa
         nGY8Y40jtIslJuvb4NhuzKodCRsfqgDXLXf+jFX0=
Date:   Fri, 2 Jun 2023 18:39:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/panel-simple: allow LVDS format override
Message-ID: <20230602153938.GC3343@pendragon.ideasonboard.com>
References: <20230523-simplepanel_support_nondefault_datamapping-v2-0-87196f0d0b64@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v2-3-87196f0d0b64@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523-simplepanel_support_nondefault_datamapping-v2-3-87196f0d0b64@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

Thank you for the patch.

On Tue, May 23, 2023 at 10:19:43AM +0200, Johannes Zink wrote:
> Some panels support multiple LVDS data mapping formats, which can be
> used e.g. run displays on jeida-18 format when only 3 LVDS lanes are
> available.
> 
> Add parsing of an optional data-mapping devicetree property, which also
> touches up the bits per color to match the bus format.

Of course one could argue that the innolux,g101ice-l01 panel should have
used the panel-lvds bindings... :-)

> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> 
> ---
> 
> Changes:
> 
>   v1 -> v2: - fix missing unwind goto found by test robot
>               Reported-by: kernel test robot <lkp@intel.com>
>               Reported-by: Dan Carpenter <error27@gmail.com>
>               Link: https://lore.kernel.org/r/202304160359.4LHmFOlU-lkp@intel.com/
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 39 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 2a9c1a785a5c..0a35fdb49ccb 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -40,6 +40,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_panel.h>
> +#include <drm/drm_of.h>
>  
>  /**
>   * struct panel_desc - Describes a simple panel.
> @@ -559,7 +560,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  	struct device_node *ddc;
>  	int connector_type;
>  	u32 bus_flags;
> -	int err;
> +	int err, ret;
>  
>  	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
>  	if (!panel)
> @@ -605,6 +606,42 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>  			panel_simple_parse_panel_timing_node(dev, panel, &dt);
>  	}
>  
> +

Double blank line.

> +	/* optional data-mapping property for overriding bus format */

s/optional/Optional/

> +	ret = drm_of_lvds_get_data_mapping(dev->of_node);
> +	if (ret == -EINVAL) {
> +		dev_warn(dev, "Ignore invalid data-mapping property");
> +	} else if (ret != -ENODEV) {

If someone incorrectly sets the property in DT for a non-LVDS panel,
the result won't be nice. That's of course a DT issue, but I wonder if
we could/should protect against it. You could move this code to a
separate function (which would have the added benefit of lowering the
indentation level as you can return early in error cases), and call it
from panel_simple_probe() only if the panel is an LVDS panel (as
reported by its desc->bus_format value).

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
>  	connector_type = desc->connector_type;
>  	/* Catch common mistakes for panels. */
>  	switch (connector_type) {

-- 
Regards,

Laurent Pinchart
