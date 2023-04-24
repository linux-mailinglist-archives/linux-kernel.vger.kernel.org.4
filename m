Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947C56ED021
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjDXOQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:16:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79C4107;
        Mon, 24 Apr 2023 07:16:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so6129071b3a.2;
        Mon, 24 Apr 2023 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682345776; x=1684937776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlEwZU657Re1C/qr1Szis8WsdO701+C6/wVrP9XRqo0=;
        b=dLkgabVOWiIJsYJZlWgDIHehEFKg8Cp7f9piYBzMx3A/zh2ke5hfyCMkTraPJNtUyN
         ewUnGzHsxVFLWaguGOwXR6SyYgRMfAgFS2Iu14z95WVZ/Er5hi7FqZp6pfybJKTfKljW
         M1R2w80uUsKjD0qMPBV09kWxtF2nvp099fnl07UbhHan395bNsY0Dglfkd8VYItYtdk3
         0KDnixKTW00mBFd5d2ADBc0O81XW+Sf883Nz7KkS7sHrOqYR+tpQvc1wcL6ZxJWWqqqc
         yUIkP+9gmIBpi/70p9WeB+ALmkXEgNqa0TMfVrC5IS3f6SwmZd5DdUnCoImJjhwL2VmE
         1kFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682345776; x=1684937776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlEwZU657Re1C/qr1Szis8WsdO701+C6/wVrP9XRqo0=;
        b=Uth6QI4FQQ9XXXpQzusgdBRKy0tWlPy1MNztr9tfSUo1ZVS02Prn4tlwa+uLQCcgIE
         rRN23Rp5OqE2pVn6HwGO1/+ZxsnGhLrvSd3HXUaikgZLuYg7wQi2HiO1mRcFUAQ/Ak+z
         /tv6TwLKVIWrcM+Aig2ZjXDWtwZ8yafmvWGs5ISxhJEMJR+xEwfhMF0ThdiQcIT1Oz7V
         06ZbFadKmCaN8Bqd8WNzpNRqxoSL9O6LqJ4FvD1GUaE9VulBm9NjI4MusCLc289XN1eE
         kbPy6+OTyLHfMdNJ386/TIqiqohSYjQhhs88pu6FIPOrN1dN0o1lTK9XAyLtwZQqnrNi
         F4nw==
X-Gm-Message-State: AAQBX9fekIbd6Z07yJLizmrxI4xLnW45WsJE6eISKmHkgheqtDJXg+Rr
        iEeExMrGhVeBoE/kMcv4CJWm6ABwmWo=
X-Google-Smtp-Source: AKy350Y+JU4CqQ6YObgjJWM3FSRbTSTE6+R8IXnxE6+uZ+ieKNIp4o32VIaW/XGH/mHNlUSiPNPaEQ==
X-Received: by 2002:a05:6a21:100e:b0:f1:8f7:eeb5 with SMTP id nk14-20020a056a21100e00b000f108f7eeb5mr14909896pzb.60.1682345776129;
        Mon, 24 Apr 2023 07:16:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n41-20020a056a000d6900b005e0699464e3sm7475687pfv.206.2023.04.24.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:16:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 24 Apr 2023 07:16:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/43] dt-bindings: watchdog: add DT bindings for Cirrus
 EP93x
Message-ID: <b39724a8-5e29-411e-9deb-29dd37609372@roeck-us.net>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-10-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-10-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:34:25PM +0300, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> watchdog block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/watchdog/cirrus,ep93xx-wdt.yaml  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> new file mode 100644
> index 000000000000..f39d6b14062d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/cirrus,ep93xx-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx Watchdog Timer
> +
> +maintainers:
> +  - Wim Van Sebroeck <wim@linux-watchdog.org>
> +
> +description:
> +  Watchdog driver for Cirrus Logic EP93xx family of devices.
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,ep9301-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

The driver does support reading the timeout from devicetree.
It might make sense to mention that here.

> +
> +examples:
> +  - |
> +    wdt0: watchdog@80940000 {
> +        compatible = "cirrus,ep9301-wdt";
> +        reg = <0x80940000 0x08>;
> +    };
> +
> -- 
> 2.39.2
> 
