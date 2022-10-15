Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7095FFBA6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 20:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJOS2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJOS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 14:28:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5860E4C627;
        Sat, 15 Oct 2022 11:28:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF4FB480;
        Sat, 15 Oct 2022 20:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665858509;
        bh=DG8PAbn5t9CS/s216yD46tH3E1t5E7pFPMUouWzS9lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFb6t8g5ctr85iLoXBcLRRGBZg5EQ+jk1m7b/q1URNisFSD8V/LHmUiE9PxST++ZS
         Mxk+hInELQ024/FGGBm+6aov2R949RTZwj+n6YbBklst6gngb/P++Y8hfQBMhm+QjA
         1H5ZtQQB5bhOCxyHz9X1kAX3dXqiUFuVWXegMRx0=
Date:   Sat, 15 Oct 2022 21:28:06 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     allen.chen@ite.com.tw
Cc:     robh@kernel.org, treapking@chromium.org, Jau-Chih.Tseng@ite.com.tw,
        Kenneth.Hung@ite.com.tw, Hermes.Wu@ite.com.tw,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Message-ID: <Y0r7tplRZbtiX+U6@pendragon.ideasonboard.com>
References: <20221013105116.180380-1-allen.chen@ite.com.tw>
 <20221013105116.180380-2-allen.chen@ite.com.tw>
 <Y0fxCVUtlkB4XHIq@pendragon.ideasonboard.com>
 <20221013192016.GA95717-robh@kernel.org>
 <e24a52c109444452a9027d53a21d6ef0@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e24a52c109444452a9027d53a21d6ef0@ite.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 14, 2022 at 03:28:31AM +0000, allen.chen@ite.com.tw wrote:
> On Friday, October 14, 2022 3:20 AM, Rob Herring wrote:
> > On Thu, Oct 13, 2022 at 02:05:45PM +0300, Laurent Pinchart wrote:
> > > On Thu, Oct 13, 2022 at 06:51:13PM +0800, allen wrote:
> > > > From: allen chen <allen.chen@ite.com.tw>
> > > > 
> > > > Add properties to restrict dp output data-lanes and clock.
> > > > 
> > > > Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> > > > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > > > ---
> > > >  .../bindings/display/bridge/ite,it6505.yaml   | 43 +++++++++++++++++++
> > > >  1 file changed, 43 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > > index 833d11b2303a7..f2c3d1d10359e 100644
> > > > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > > > @@ -52,10 +52,51 @@ properties:
> > > >      maxItems: 1
> > > >      description: extcon specifier for the Power Delivery
> > > >  
> > > > +  data-lanes:
> > > > +    oneOf:
> > > > +      - minItems: 1
> > > > +        maxItems: 1
> > > > +        uniqueItems: true
> > > > +        items:
> > > > +          enum:
> > > > +            - 0
> > > > +            - 1
> > > > +        description: For one lane operation.
> > > > +
> > > > +      - minItems: 2
> > > > +        maxItems: 2
> > > > +        uniqueItems: true
> > > > +        items:
> > > > +          enum:
> > > > +            - 0
> > > > +            - 1
> > > > +        description: For two lanes operation.
> > > > +
> > > > +      - minItems: 4
> > > > +        maxItems: 4
> > > > +        uniqueItems: true
> > > > +        items:
> > > > +          enum:
> > > > +            - 0
> > > > +            - 1
> > > > +            - 2
> > > > +            - 3
> > > > +        description: For four lanes operation.
> > > 
> > > The data lanes should be in the output endpoint. If there's no output 
> > > port, one should be added.
> 
> ==> In this dt-binding, our output point is "extcon" so doesn't have output endpoint.
> I don't know how to add the endpoint.
> If need to add the endpoint to this dt-binding, what is your recommend about adding the endpoint?

You will also need to add a port to the USB-C connector. Then endpoints
can be added to connect the two.

> By the way, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> said
> we could put "data-lanes" here.

If I read him correctly, Krzysztof said we have a standard property for
the data lanes (and that's true, we do), but I don't think he implied it
could be put outside of the endpoint (Krzysztof, please correct me if
I'm wrong).

> > > > +
> > > >    port:
> > > >      $ref: /schemas/graph.yaml#/properties/port
> > 
> > To fix the error, this must be:
> > 
> > $ref: /schemas/graph.yaml#/$defs/port-base
> > unevaluatedProperties: false
> > 
> > > >      description: A port node pointing to DPI host port node
> > > >  
> > > > +    properties:
> > > > +      endpoint:
> > > > +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > > > +
> > > > +        properties:
> > > > +          link-frequencies:
> > > > +            minItems: 1
> > > > +            maxItems: 1
> > > > +            description: Allowed max link frequencies in Hz.
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - ovdd-supply
> > > > @@ -84,10 +125,12 @@ examples:
> > > >              pwr18-supply = <&it6505_pp18_reg>;
> > > >              reset-gpios = <&pio 179 1>;
> > > >              extcon = <&usbc_extcon>;
> > > > +            data-lanes = <0 1>;
> > > >  
> > > >              port {
> > > >                  it6505_in: endpoint {
> > > >                      remote-endpoint = <&dpi_out>;
> > > > +                    link-frequencies = /bits/ 64 <150000000>;
> > > >                  };
> > > >              };
> > > >          };

-- 
Regards,

Laurent Pinchart
