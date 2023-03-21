Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F46C351D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjCUPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCUPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:08:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0667450721
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:07:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r29so14021235wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679411264;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFyWXWqsoSrr2n/nr5WFH4+XCUi3HeyHPmJXflcFG4M=;
        b=BkQC5wUD4CWB2PJ4wIBzixl/nv2bZ/wbBAXgWZZBoB7CPKElqOeL7pFUsAo8WyLasZ
         Jk8ZoxGEZke4a2oxpZG9QCWIwNaYzub2IogYm1zDpaGaAF7AxcOvlzdgqWkxcI30/EV0
         CItrJgAVwwUf9XiGhNvVA9DBIvM47GPVrzm6Z/04/pDDR634UO4mgcxXh9Yq9KsMJc8G
         0GjVOjqZAoZUTr4aeCb0Yh30eN9ajC6lmP6ioYSj9Sr8AtxTKDo7pR2NHAdPC2SC844a
         z32CGoa1C7I2uMynCUxep9zr5N6h3lu1RPDx14JyxzjPfB17oOuhFnVItnGm4nKEJxXk
         y/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411264;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFyWXWqsoSrr2n/nr5WFH4+XCUi3HeyHPmJXflcFG4M=;
        b=TGaDfaoiw5igjkgvgCwY2dkOLiqbDDstJAld0ri0O5nCSMlE16a67ZCaxmk1xBAQF6
         jfUGi6Ry3nk1/K137Zqzo7ee4kEURU197nRh/ZmvsGmL1r1dX1DZ/ri75g4kgJiSLyup
         CXCApXi96AutEW4UlJTwByBIflr0jds1RtQ2DnMnTXAM4jrG7YuvffZE9lg16fIBt9ng
         n1DZRzFeVMcpxrpcyjqLYySY5xjSoYqs6uBkTYbDOUweGZckUPXZ07RngPdFeO3Zx3Q+
         CDD/beWxcs+sFYgxmGk4hrTbhRPWLxAOYro8VJ1HDfWmJasvkv4i9UMLRDLAdvHkGJgU
         rzyw==
X-Gm-Message-State: AO0yUKWPCOdKC00yQWDn2UeQhYT0ZJcjNMV4JfAQwsPR/i4ojRHLVuN3
        Y39svpjPerLVni7StDJrpGDaGg==
X-Google-Smtp-Source: AK7set84LPqCUYf6yhhlDvPsISDuuO8P7FciRBhYMTb88p9jq1jWKFXiaxN9uhODbTmEO9zz5pAljw==
X-Received: by 2002:a5d:528f:0:b0:2d2:ac99:a72 with SMTP id c15-20020a5d528f000000b002d2ac990a72mr2379240wrv.46.1679411264305;
        Tue, 21 Mar 2023 08:07:44 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b002c559843748sm11573794wrq.10.2023.03.21.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:07:43 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: Drop unneeded quotes
In-Reply-To: <20230320234718.2930154-1-robh@kernel.org>
References: <20230320234718.2930154-1-robh@kernel.org>
Date:   Tue, 21 Mar 2023 16:07:42 +0100
Message-ID: <87lejqkurl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lun., mars 20, 2023 at 18:47, Rob Herring <robh@kernel.org> wrote:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # for mediatek,mt6779-keypad.yaml

> ---
>  Documentation/devicetree/bindings/input/adc-joystick.yaml     | 4 ++--
>  .../devicetree/bindings/input/google,cros-ec-keyb.yaml        | 2 +-
>  Documentation/devicetree/bindings/input/imx-keypad.yaml       | 2 +-
>  Documentation/devicetree/bindings/input/matrix-keymap.yaml    | 2 +-
>  .../devicetree/bindings/input/mediatek,mt6779-keypad.yaml     | 2 +-
>  .../devicetree/bindings/input/microchip,cap11xx.yaml          | 4 ++--
>  Documentation/devicetree/bindings/input/pwm-vibrator.yaml     | 4 ++--
>  Documentation/devicetree/bindings/input/regulator-haptic.yaml | 4 ++--
>  .../bindings/input/touchscreen/elan,elants_i2c.yaml           | 4 ++--
>  9 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> index da0f8dfca8bf..6c244d66f8ce 100644
> --- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
> +++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
> @@ -2,8 +2,8 @@
>  # Copyright 2019-2020 Artur Rojek
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/input/adc-joystick.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/input/adc-joystick.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: ADC attached joystick
>  
> diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> index e05690b3e963..3486c81699a8 100644
> --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> @@ -57,7 +57,7 @@ if:
>        contains:
>          const: google,cros-ec-keyb
>  then:
> -  $ref: "/schemas/input/matrix-keymap.yaml#"
> +  $ref: /schemas/input/matrix-keymap.yaml#
>    required:
>      - keypad,num-rows
>      - keypad,num-columns
> diff --git a/Documentation/devicetree/bindings/input/imx-keypad.yaml b/Documentation/devicetree/bindings/input/imx-keypad.yaml
> index 7514df62b592..b110eb1f3358 100644
> --- a/Documentation/devicetree/bindings/input/imx-keypad.yaml
> +++ b/Documentation/devicetree/bindings/input/imx-keypad.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Liu Ying <gnuiyl@gmail.com>
>  
>  allOf:
> -  - $ref: "/schemas/input/matrix-keymap.yaml#"
> +  - $ref: /schemas/input/matrix-keymap.yaml#
>  
>  description: |
>    The KPP is designed to interface with a keypad matrix with 2-point contact
> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.yaml b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
> index 4d6dbe91646d..a715c2a773fe 100644
> --- a/Documentation/devicetree/bindings/input/matrix-keymap.yaml
> +++ b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
> @@ -21,7 +21,7 @@ description: |
>  
>  properties:
>    linux,keymap:
> -    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>      description: |
>        An array of packed 1-cell entries containing the equivalent of row,
>        column and linux key-code. The 32-bit big endian cell is packed as:
> diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> index d768c30f48fb..47aac8794b68 100644
> --- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> +++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Mattijs Korpershoek <mkorpershoek@baylibre.com>
>  
>  allOf:
> -  - $ref: "/schemas/input/matrix-keymap.yaml#"
> +  - $ref: /schemas/input/matrix-keymap.yaml#
>  
>  description: |
>    Mediatek's Keypad controller is used to interface a SoC with a matrix-type
> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 5fa625b5c5fb..5b5d4f7d3482 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/input/microchip,cap11xx.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/input/microchip,cap11xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Microchip CAP11xx based capacitive touch sensors
>  
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> index a70a636ee112..d32716c604fe 100644
> --- a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/input/pwm-vibrator.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/input/pwm-vibrator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: PWM vibrator
>  
> diff --git a/Documentation/devicetree/bindings/input/regulator-haptic.yaml b/Documentation/devicetree/bindings/input/regulator-haptic.yaml
> index 627891e1ef55..cf63f834dd7d 100644
> --- a/Documentation/devicetree/bindings/input/regulator-haptic.yaml
> +++ b/Documentation/devicetree/bindings/input/regulator-haptic.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/input/regulator-haptic.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/input/regulator-haptic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Regulator Haptic
>  
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> index f9053e5e9b24..3255c2c8951a 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/input/touchscreen/elan,elants_i2c.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/input/touchscreen/elan,elants_i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Elantech I2C Touchscreen
>  
> -- 
> 2.39.2
