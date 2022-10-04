Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23125F43E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJDNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJDNEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:04:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA3615E;
        Tue,  4 Oct 2022 06:03:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ECF7A2D9;
        Tue,  4 Oct 2022 15:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1664888591;
        bh=2ynmfYdyqP5fJ1srOy1TW6LiWh7wjTgnJ020UhOJKVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gf2CACt8kKiY5uTqfnXwr19UmKSe1vConrkOaRl5hJk5sY7HjFldCQU60KPtUTcWv
         ei46VBytQs08lepKoAPLSOpjL1VtiSzqkqXZzqUP3AKQ7Tpvp0zcas06kVfhwEyQbr
         pj/r78kWmrEdyGavJaJdmqS3evzP8mDwTLAV9QoE=
Date:   Tue, 4 Oct 2022 16:03:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: panel: use
 spi-peripheral-props.yaml
Message-ID: <YzwvDEKAzbqjSYjT@pendragon.ideasonboard.com>
References: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On Tue, Oct 04, 2022 at 02:09:07PM +0200, Krzysztof Kozlowski wrote:
> For devices connectable by SPI bus (e.g. already using
> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> schema to allow using all SPI device properties, even these which device
> bindings author did not tried yet.

Isn't this done implicitly by spi-controller.yaml ? SPI devices that are
children of an SPI controller should match the patternProperties
"^.*@[0-9a-f]+$" in that file, which has a $ref: spi-peripheral-props.yaml.
Is there something I'm missing ?

> Change "additionalProperties" to "unevaluatedProperties", so the actual
> other properties from "spi-peripheral-props.yaml" can be used.  This has
> additional impact of allowing also other properties from
> panel-common.yaml to be used.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9163.yaml    | 3 ++-
>  .../devicetree/bindings/display/panel/ilitek,ili9341.yaml    | 1 +
>  .../devicetree/bindings/display/panel/nec,nl8048hl11.yaml    | 3 ++-
>  .../bindings/display/panel/samsung,lms380kf01.yaml           | 5 ++---
>  .../bindings/display/panel/samsung,lms397kf04.yaml           | 3 ++-
>  .../devicetree/bindings/display/panel/samsung,s6d27a1.yaml   | 4 ++--
>  .../devicetree/bindings/display/panel/tpo,tpg110.yaml        | 1 +
>  7 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml
> index 7e7a8362b951..a4154b51043e 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml
> @@ -15,6 +15,7 @@ description:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
>    compatible:
> @@ -41,7 +42,7 @@ required:
>    - dc-gpios
>    - reset-gpios
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
> index 99e0cb9440cf..94f169ea065a 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
> @@ -16,6 +16,7 @@ description: |
>  
>  allOf:
>    - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml b/Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml
> index aa788eaa2f71..3b09b359023e 100644
> --- a/Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml
> @@ -15,6 +15,7 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
>    compatible:
> @@ -34,7 +35,7 @@ required:
>    - reset-gpios
>    - port
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
> index 251f0c7115aa..70ffc88d2a08 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml
> @@ -9,14 +9,13 @@ title: Samsung LMS380KF01 display panel
>  description: The LMS380KF01 is a 480x800 DPI display panel from Samsung Mobile
>    Displays (SMD) utilizing the WideChips WS2401 display controller. It can be
>    used with internal or external backlight control.
> -  The panel must obey the rules for a SPI slave device as specified in
> -  spi/spi-controller.yaml
>  
>  maintainers:
>    - Linus Walleij <linus.walleij@linaro.org>
>  
>  allOf:
>    - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
>    compatible:
> @@ -59,7 +58,7 @@ required:
>    - spi-cpol
>    - port
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml b/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml
> index cd62968426fb..5e77cee93f83 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml
> @@ -14,6 +14,7 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
>    compatible:
> @@ -51,7 +52,7 @@ required:
>    - spi-cpol
>    - port
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
> index 26e3c820a2f7..d273faf4442a 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
> @@ -7,14 +7,14 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Samsung S6D27A1 display panel
>  
>  description: The S6D27A1 is a 480x800 DPI display panel from Samsung Mobile
> -  Displays (SMD). The panel must obey the rules for a SPI slave device
> -  as specified in spi/spi-controller.yaml
> +  Displays (SMD).
>  
>  maintainers:
>    - Markuss Broks <markuss.broks@gmail.com>
>  
>  allOf:
>    - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
> index 6f1f02044b4b..f0243d196191 100644
> --- a/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
> @@ -41,6 +41,7 @@ description: |+
>  
>  allOf:
>    - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
>  properties:
>    compatible:

-- 
Regards,

Laurent Pinchart
