Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDD6333AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiKVDFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKVDFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:05:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477D21057D;
        Mon, 21 Nov 2022 19:05:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 03279890;
        Tue, 22 Nov 2022 04:05:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669086336;
        bh=OP7Y7hsHz9XtzH4OrAc1DG1nsm5BYY0TnHJs66LwpeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksEO7afwDfYQYLJcky9l5GiNb3FvnZiznXhKNyHfvPS+3j7Wy/APE98cIlCvCFA8G
         URnoxdxXbXbeqdZ9BqABrFKnQUNm0HiyvAd0CCFNt43PkZgDUcA5r9BqJzIlNbHewe
         /O5dUMsFzRHTQC3towY+Wt6Wty4luAbWXpoTk8aA=
Date:   Tue, 22 Nov 2022 05:05:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: Re: [PATCH v1 6/8] drm: rcar-du: Add r8a779g0 support
Message-ID: <Y3w8cBh0uVaSPonO@pendragon.ideasonboard.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
 <20221117122547.809644-7-tomi.valkeinen@ideasonboard.com>
 <166869771876.50677.1905794243575000038@Monstersaurus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166869771876.50677.1905794243575000038@Monstersaurus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:08:38PM +0000, Kieran Bingham wrote:
> Quoting Tomi Valkeinen (2022-11-17 12:25:45)
> > From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > 
> > Add support for DU on r8a779g0, which is identical to DU on r8a779a0.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > ---
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > index d003e8d9e7a2..b1761d4ec4e5 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > @@ -524,6 +524,27 @@ static const struct rcar_du_device_info rcar_du_r8a779a0_info = {
> >         .dsi_clk_mask =  BIT(1) | BIT(0),
> >  };
> >  
> > +static const struct rcar_du_device_info rcar_du_r8a779g0_info = {
> > +       .gen = 3,
> 
> Given that this is the V4H ... I wonder if this should be bumped
> already. I guess that has knock on effects through the driver though...

rcar_du_group_setup_didsr() would need to be fixed to test gen >= 3
instead of gen == 3. That seems to be the only problematic location. It
could thus fairly easily be done in v2, but we can also delay it.

> Aside from that, Which may need more work to handle correctly:
> 
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > +       .features = RCAR_DU_FEATURE_CRTC_IRQ
> > +                 | RCAR_DU_FEATURE_VSP1_SOURCE
> > +                 | RCAR_DU_FEATURE_NO_BLENDING,
> > +       .channels_mask = BIT(1) | BIT(0),
> > +       .routes = {
> > +               /* R8A779G0 has two MIPI DSI outputs. */
> > +               [RCAR_DU_OUTPUT_DSI0] = {
> > +                       .possible_crtcs = BIT(0),
> > +                       .port = 0,
> > +               },
> > +               [RCAR_DU_OUTPUT_DSI1] = {
> > +                       .possible_crtcs = BIT(1),
> > +                       .port = 1,
> > +               },
> > +       },
> > +       .num_rpf = 5,
> > +       .dsi_clk_mask =  BIT(1) | BIT(0),
> > +};
> > +
> >  static const struct of_device_id rcar_du_of_table[] = {
> >         { .compatible = "renesas,du-r8a7742", .data = &rcar_du_r8a7790_info },
> >         { .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
> > @@ -549,6 +570,7 @@ static const struct of_device_id rcar_du_of_table[] = {
> >         { .compatible = "renesas,du-r8a77990", .data = &rcar_du_r8a7799x_info },
> >         { .compatible = "renesas,du-r8a77995", .data = &rcar_du_r8a7799x_info },
> >         { .compatible = "renesas,du-r8a779a0", .data = &rcar_du_r8a779a0_info },
> > +       { .compatible = "renesas,du-r8a779g0", .data = &rcar_du_r8a779g0_info },
> >         { }
> >  };
> >  

-- 
Regards,

Laurent Pinchart
