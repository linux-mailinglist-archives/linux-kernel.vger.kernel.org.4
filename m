Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C95C66086D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjAFUp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjAFUp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:45:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E846B6144B;
        Fri,  6 Jan 2023 12:45:55 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C706B4AE;
        Fri,  6 Jan 2023 21:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673037954;
        bh=Ct/jcd1llwkTY99zzc6JViNIUd/QpymrsWSpUqn87EI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVA6Tx42lSDge+vumdacgT5cOcNviGIg1FmCRp2yo36YQX5xt5w60PfUsR9dn2S6i
         ygc5Qc5nBCy38UPe0BycdeazB1FkWM+jvvQzFVnFYqlEKnslX/mha1166YkXISW3Na
         EeRtzqAN5T368RhyusTAsJYtl32RqZrkxVF2bJ54=
Date:   Fri, 6 Jan 2023 22:45:48 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 4/7] media: uvcvideo: Refactor uvc_ctrl_mappings_uvcXX
Message-ID: <Y7iIfA/k3jGiTeHG@pendragon.ideasonboard.com>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
 <20230105-uvc-gcc5-v2-4-2ba6c660d6f5@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105-uvc-gcc5-v2-4-2ba6c660d6f5@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Thu, Jan 05, 2023 at 02:52:55PM +0100, Ricardo Ribalda wrote:
> Convert the array of structs into an array of pointers, that way the
> mappings can be reused.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 81 +++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 2ebe5cc18ad9..9af64f7a23d3 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -723,34 +723,40 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>  	},
>  };
>  
> -static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
> -	{
> -		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> -		.entity		= UVC_GUID_UVC_PROCESSING,
> -		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> -		.size		= 2,
> -		.offset		= 0,
> -		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> -		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -		.menu_info	= power_line_frequency_controls,
> -		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
> -					  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
> -	},
> +static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
> +	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> +	.entity		= UVC_GUID_UVC_PROCESSING,
> +	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> +	.size		= 2,
> +	.offset		= 0,
> +	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> +	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> +	.menu_info	= power_line_frequency_controls,
> +	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
> +				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
>  };
>  
> -static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
> -	{
> -		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> -		.entity		= UVC_GUID_UVC_PROCESSING,
> -		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> -		.size		= 2,
> -		.offset		= 0,
> -		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> -		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -		.menu_info	= power_line_frequency_controls,
> -		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
> -					  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
> -	},
> +static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc11[] = {
> +	&uvc_ctrl_power_line_mapping_uvc11,
> +	NULL, /* Sentinel */
> +};
> +
> +static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
> +	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> +	.entity		= UVC_GUID_UVC_PROCESSING,
> +	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> +	.size		= 2,
> +	.offset		= 0,
> +	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> +	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> +	.menu_info	= power_line_frequency_controls,
> +	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
> +				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
> +};
> +
> +static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc15[] = {
> +	&uvc_ctrl_power_line_mapping_uvc15,
> +	NULL, /* Sentinel */
>  };
>  
>  /* ------------------------------------------------------------------------
> @@ -2506,8 +2512,7 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
>  static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
>  			       struct uvc_control *ctrl)
>  {
> -	const struct uvc_control_mapping *mappings;
> -	unsigned int num_mappings;
> +	const struct uvc_control_mapping **mappings;
>  	unsigned int i;
>  
>  	/*
> @@ -2574,21 +2579,13 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
>  	}
>  
>  	/* Finally process version-specific mappings. */
> -	if (chain->dev->uvc_version < 0x0150) {
> -		mappings = uvc_ctrl_mappings_uvc11;
> -		num_mappings = ARRAY_SIZE(uvc_ctrl_mappings_uvc11);
> -	} else {
> -		mappings = uvc_ctrl_mappings_uvc15;
> -		num_mappings = ARRAY_SIZE(uvc_ctrl_mappings_uvc15);
> -	}
> -
> -	for (i = 0; i < num_mappings; ++i) {
> -		const struct uvc_control_mapping *mapping = &mappings[i];
> +	mappings = (chain->dev->uvc_version < 0x0150) ? uvc_ctrl_mappings_uvc11

No need for parentheses.

> +						      : uvc_ctrl_mappings_uvc15;
>  
> -		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> -		    ctrl->info.selector == mapping->selector)
> -			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
> -	}
> +	for (i = 0; mappings[i]; ++i)

Missing curly braces.

Let's add a local mapping variable:

	for (i = 0; mappings[i]; ++i) {
		const struct uvc_control_mapping *mapping = &mappings[i];

		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
		    ctrl->info.selector == mapping->selector)
			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
	}

I'll address this when applying.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		if (uvc_entity_match_guid(ctrl->entity, mappings[i]->entity) &&
> +		    ctrl->info.selector == mappings[i]->selector)
> +			__uvc_ctrl_add_mapping(chain, ctrl, mappings[i]);
>  }
>  
>  /*
> 

-- 
Regards,

Laurent Pinchart
