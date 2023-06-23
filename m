Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522CA73BBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjFWPdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjFWPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:33:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94F1FC0;
        Fri, 23 Jun 2023 08:33:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C7EDD838;
        Fri, 23 Jun 2023 17:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687534349;
        bh=JVfaRnSbQrHYAiCZDbY1FbYcUglLgSKy8UvL0wg76zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJCnEOictwO7hF4WDKxK6MuAgbsat9u11YHP21PXR1yOm2n9jY3vC4anqMKGi6pSY
         8I4XxSDgAB7vh2ZxaOhWRLw+2yU2LclTG7174+e4Q4vyYUYYOuTQ65XrCODSWZiXJE
         cn4KLlsr5buLI9ri6RfIMEncOP2sQnYnj1JX+Wjs=
Date:   Fri, 23 Jun 2023 18:33:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/39] dt-bindings: display: Add Renesas SH-Mobile LCDC
 bindings
Message-ID: <20230623153304.GP2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <2259ff548f007afcb5a315a4c95c83a0ee4b7e03.1687423204.git.geert+renesas@glider.be>
 <20230623144312.GE2112@pendragon.ideasonboard.com>
 <CAMuHMdXdknNczxXod7b6znBHSgXVEb9oNZCAajKCc0Spm1SrYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXdknNczxXod7b6znBHSgXVEb9oNZCAajKCc0Spm1SrYQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:19:45PM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 23, 2023 at 4:43 PM Laurent Pinchart wrote:
> > On Thu, Jun 22, 2023 at 11:21:13AM +0200, Geert Uytterhoeven wrote:
> > > Add device tree bindings for the LCD Controller (LCDC) found in Renesas
> > > SuperH SH-Mobile and ARM SH/R-Mobile SOCs.
> > >
> > > Based on a plain text prototype by Laurent Pinchart.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/renesas,shmobile-lcdc.yaml
> > > @@ -0,0 +1,108 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/renesas,shmobile-lcdc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Renesas SH-Mobile LCD Controller (LCDC)
> > > +
> > > +maintainers:
> > > +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > I'd be happy if you co-maintained this with me :-) Or even took
> > ownership completely.
> 
> OK. Thinking about it ;-)
> 
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - renesas,r8a7740-lcdc # R-Mobile A1
> > > +      - renesas,sh73a0-lcdc  # SH-Mobile AG5
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    minItems: 1
> > > +    maxItems: 5
> > > +    description:
> > > +      Only the functional clock is mandatory.
> > > +      Some of the optional clocks are model-dependent (e.g. "video" (a.k.a.
> > > +      "vou" or "dv_clk") is available on R-Mobile A1 only).
> > > +
> > > +  clock-names:
> > > +    minItems: 1
> > > +    maxItems: 5
> > > +    items:
> > > +      enum: [ fck, media, lclk, hdmi, video ]
> >
> > Switching to per-item descriptions would allow documenting which clock
> > applies to which SoC.
> >
> > Are enum items unique by default ?
> 
> Given how about all clocks but fck are optional, it's a bit hard
> to handle this in a perfect way.
> Note that "pattern: '^dclkin\.[0123]$'" in renesas,du.yaml has the same issue.
> 
> > This would allow a combination of clocks that doesn't include the fck
> > clock, that's not right.
> 
> Right. But when fixing the first to "fck", you have to duplicate all others.
> So it should become something like:
> 
>   - const: fck
>   - enum: [ media, lclk, hdmi, video ]
>   - enum: [ media, lclk, hdmi, video ]
>   - enum: [ media, lclk, hdmi, video ]
>   - enum: [ media, lclk, hdmi, video ]

It's not great. Any input from the DT maintainers ?

> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +    description: |
> > > +      The connections to the output video ports are modeled using the OF graph
> > > +      bindings specified in Documentation/devicetree/bindings/graph.txt.
> >
> > it's available in YAML form now. I'd just drop the "specified in ...".
> 
> OK.
> 
> > > +      The number of ports and their assignment are model-dependent.
> > > +      Each port shall have a single endpoint.
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: LCD port (R-Mobile A1 and SH-Mobile AG5)
> > > +        unevaluatedProperties: false
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: HDMI port (R-Mobile A1 LCDC1 and SH-Mobile AG5)
> > > +        unevaluatedProperties: false
> > > +
> > > +      port@2:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: MIPI-DSI port (SH-Mobile AG5)
> > > +        unevaluatedProperties: false
> >
> > Let's condition the ports on the compatible value to enable automatic
> > validation.
> >
> > > +
> > > +    required:
> > > +      - port@0
> >
> > Based on the above, port@1 is required too as it's present on all
> > supported SoCs. Let's condition this on the compatible value too.
> 
> It does not depend solely on the SoC, but also on the LCDC instance.
> port@1 is not available on R-Mobile A1 LCDC0, only on LCDC1.

Ah, my bad. It can't be mandatory indeed. I'd still prefer conditioning
ports to the compatible string for proper validation.

-- 
Regards,

Laurent Pinchart
