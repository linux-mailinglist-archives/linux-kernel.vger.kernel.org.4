Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202B674D992
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjGJPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjGJPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:08:29 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6983A0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=fXW2iwuEasBaakvFEnxtCVpluF+/2XyN0DqTEyNbwo4=;
        b=b17cmgR5dJGwA0Dk6g+Q+OvMk1EMbPogGbeV4tgz6bK4+FjeHZbeIxlp+/i4V8ZH5o1w+qMxrtysY
         YB6QZ7TAQS6lLgt98GNK/0bdHW3VgKYMo97SnS1/UNXoNov6DzaNlsJEMnq1YTk9GkYoCnety396Xj
         LYrrlae16bXnAcgNKt9hCuDxtSP1y5tACE6s1qvjFVVeZqTB/CKMLqcTbQCR1R9Xg/+8wmLkcmwvly
         w4gRJwcXKsFW89nos6/rW2yzahQK11Al12nwQpOm9bV0X/Ydl0756qqWeNCZ6G7lFnvxqpJYivRsAl
         pGrCjPuSQCo33sAqiH1UUm+2k6W3qng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=fXW2iwuEasBaakvFEnxtCVpluF+/2XyN0DqTEyNbwo4=;
        b=pfBe7R3sTfxJ815RFUxT6OnMAgw5P1idkPq03/VCAkSImfQs1gnk1pR8cUO/MKwT7AgxsaXAfFT+8
         t6M0IZHBg==
X-HalOne-ID: 9bdb67b0-1f33-11ee-93b1-5ba399456a4a
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 9bdb67b0-1f33-11ee-93b1-5ba399456a4a;
        Mon, 10 Jul 2023 15:08:24 +0000 (UTC)
Date:   Mon, 10 Jul 2023 17:08:22 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v7 5/8] drm/bridge: sii902x: Support format negotiation
 hooks
Message-ID: <20230710150822.GA5237@ravnborg.org>
References: <20230606082142.23760-1-a-bhatia1@ti.com>
 <20230606082142.23760-6-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606082142.23760-6-a-bhatia1@ti.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aradhya,

On Tue, Jun 06, 2023 at 01:51:39PM +0530, Aradhya Bhatia wrote:
> With new connector model, sii902x will not create the connector, when
> DRM_BRIDGE_ATTACH_NO_CONNECTOR is set and SoC driver will rely on format
> negotiation to setup the encoder format.
> 
> Support format negotiations hooks in the drm_bridge_funcs.
> Use helper functions for state management.
> 
> Input format is selected to MEDIA_BUS_FMT_RGB888_1X24 as default, as is
> the case with older model.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

As noted by Javier, this patch-set was forgotten, so sorry for not
providing timely feedback.


> ---
> 
> Notes:
> 
>     changes from v6:
>     * Add Neil Armstrong's R-b tag.
> 
>  drivers/gpu/drm/bridge/sii902x.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index ef66461e7f7c..70aeb04b7f77 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -473,6 +473,27 @@ static struct edid *sii902x_bridge_get_edid(struct drm_bridge *bridge,
>  	return sii902x_get_edid(sii902x, connector);
>  }
>  
> +static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
> +						     struct drm_bridge_state *bridge_state,
> +						     struct drm_crtc_state *crtc_state,
> +						     struct drm_connector_state *conn_state,
> +						     u32 output_fmt,
> +						     unsigned int *num_input_fmts)
> +{
> +	u32 *input_fmts;
> +
> +	*num_input_fmts = 0;
> +
> +	input_fmts = kcalloc(1, sizeof(*input_fmts), GFP_KERNEL);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
> +	*num_input_fmts = 1;
> +
> +	return input_fmts;
> +}

An alternative implementation of the above is:
{
        switch (output_fmt) {
        case MEDIA_BUS_FMT_RGB888_1X24:
                break;

        default:
        /* Fail for any other formats */
               *num_input_fmts = 0;
                return NULL;
        }

       return drm_atomic_helper_bridge_propagate_bus_fmt(bridge, bridge_state,
                                                         crtc_state, conn_state,
                                                         output_fmt,
                                                         num_input_fmts);
}

If you agree and have the time to do it it would be nice to use this
simpler variant.
Mostly so we avoid more open coded variants like you already did, and
which we have plenty of already.

It would be even better to walk through other implementations of
get_input_bus_fmts and update them accordingly.

Again, sorry for being late here. Feel free to ignore if you already
moved on with something else.

	Sam

