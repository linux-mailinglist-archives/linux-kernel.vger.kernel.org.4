Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A745FD815
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJMLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMLFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:05:55 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7080B4D156;
        Thu, 13 Oct 2022 04:05:54 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A0CB6492;
        Thu, 13 Oct 2022 13:05:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665659151;
        bh=dUZBnksssSEsbfYjTSHdrj0Sb8JpUXd5lCyKkoOrkH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=td9o3P/iAjwPyoVF/NtEnmhWLO5rawjBajdtyTf4xyJGDzO90Dgh+VjIj9whSYvZP
         pCBr5bSg2Nq4A042YCFb3z1WKcxtdZiHrmfM8lbHcREkzYw14hH93ElRtY2qDENzS7
         /gSEdzy91op7PCVQw965JCA+kpaB0kQ49CEOMlvk=
Date:   Thu, 13 Oct 2022 14:05:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Message-ID: <Y0fxCVUtlkB4XHIq@pendragon.ideasonboard.com>
References: <20221013105116.180380-1-allen.chen@ite.com.tw>
 <20221013105116.180380-2-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013105116.180380-2-allen.chen@ite.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

Thank you for the patch.

On Thu, Oct 13, 2022 at 06:51:13PM +0800, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml   | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 833d11b2303a7..f2c3d1d10359e 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -52,10 +52,51 @@ properties:
>      maxItems: 1
>      description: extcon specifier for the Power Delivery
>  
> +  data-lanes:
> +    oneOf:
> +      - minItems: 1
> +        maxItems: 1
> +        uniqueItems: true
> +        items:
> +          enum:
> +            - 0
> +            - 1
> +        description: For one lane operation.
> +
> +      - minItems: 2
> +        maxItems: 2
> +        uniqueItems: true
> +        items:
> +          enum:
> +            - 0
> +            - 1
> +        description: For two lanes operation.
> +
> +      - minItems: 4
> +        maxItems: 4
> +        uniqueItems: true
> +        items:
> +          enum:
> +            - 0
> +            - 1
> +            - 2
> +            - 3
> +        description: For four lanes operation.

The data lanes should be in the output endpoint. If there's no output
port, one should be added.

> +
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
>      description: A port node pointing to DPI host port node
>  
> +    properties:
> +      endpoint:
> +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +
> +        properties:
> +          link-frequencies:
> +            minItems: 1
> +            maxItems: 1
> +            description: Allowed max link frequencies in Hz.
> +
>  required:
>    - compatible
>    - ovdd-supply
> @@ -84,10 +125,12 @@ examples:
>              pwr18-supply = <&it6505_pp18_reg>;
>              reset-gpios = <&pio 179 1>;
>              extcon = <&usbc_extcon>;
> +            data-lanes = <0 1>;
>  
>              port {
>                  it6505_in: endpoint {
>                      remote-endpoint = <&dpi_out>;
> +                    link-frequencies = /bits/ 64 <150000000>;
>                  };
>              };
>          };

-- 
Regards,

Laurent Pinchart
