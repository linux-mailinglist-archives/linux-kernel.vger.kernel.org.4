Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C71700378
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbjELJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjELJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:16:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706412721
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:16:04 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3361B2D8;
        Fri, 12 May 2023 11:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683882953;
        bh=8aj3gkZp6VDWp4PUGeLKxpnkIoSmqes4md/485PvAn0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kt4q7hr3Votllg0InPdSLsBr00s8bqAP8YwqlaiSKPbOK6Nq1YZimlPDhBZNEfaQi
         65CpfaNHB3EfNCVxUtuDRdf3bAw1NIat7ki1GqsCWFeViCjKah0YkmwzmgHc3kqVsl
         y0U9QyscePQ28eNJZOqoijXNK+pgB6Iu4TjW7kp0=
Message-ID: <db9b4117-b030-49a7-3732-2fc39d089ee2@ideasonboard.com>
Date:   Fri, 12 May 2023 12:15:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/8] drm/bridge: mhdp8546: Add minimal format
 negotiation
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230509093036.3303-1-a-bhatia1@ti.com>
 <20230509093036.3303-4-a-bhatia1@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230509093036.3303-4-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 12:30, Aradhya Bhatia wrote:
> From: Nikhil Devshatwar <nikhil.nd@ti.com>
> 
> With new connector model, mhdp bridge will not create the connector and
> SoC driver will rely on format negotiation to setup the encoder format.
> 
> Support minimal format negotiations hooks in the drm_bridge_funcs.
> Complete format negotiation can be added based on EDID data.
> This patch adds the minimal required support to avoid failure
> after moving to new connector model.
> 
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

You need to add your SoB to this and the other patches.

> ---
> 
> Notes:
> 
>      changes from v1:
>      * cosmetic fixes, commit message update.
> 
>      changes from v5:
>      * dropped the default_bus_format variable and directly assigned
>        MEDIA_BUS_FMT_RGB121212_1X36 to input_fmts.
> 
>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index f6822dfa3805..623e4235c94f 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2146,6 +2146,30 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
>   	return &cdns_mhdp_state->base;
>   }
>   
> +static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
> +					 struct drm_bridge_state *bridge_state,
> +					 struct drm_crtc_state *crtc_state,
> +					 struct drm_connector_state *conn_state,
> +					 u32 output_fmt,
> +					 unsigned int *num_input_fmts)
> +{
> +	u32 *input_fmts;
> +
> +	*num_input_fmts = 0;
> +
> +	if (output_fmt != MEDIA_BUS_FMT_FIXED)
> +		return NULL;

The tfp410 and sii902x drivers don't have the above check. Why does mhdp 
need it? Or the other way, why don't tfp410 and sii902x need it?

I guess at the moment we always do get MEDIA_BUS_FMT_FIXED as the out 
fmt (in all three bridge drivers), don't we?

  Tomi

