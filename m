Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0FB66E079
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjAQOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjAQOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:23:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA63D0BD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:22:08 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k8so16248865wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybMp4yf1vi88OQah/2tawVPx6umiUGABzCImHyfek9Y=;
        b=hAktI9Hg4DyrxZHcvy3fynCOTVjETjt/zk2FifC5B7sAmkDT4FXNVTJXaFvRyg9+PW
         h2sMPFQ3W1yRaGT+aBC9EA0ARv2xmIhucPJiBWrU2xSjTtShNUjlexnybjRGdA1isVqL
         i23k3jz9FjVvxSxty27+XaeI7X8woahLuf+6fQbOTZInjmiJ0UjpN090asX9M0ecXQ9i
         3ffHvbT74wxs69cCzxFWaTu3U/6ey3kBofZUWIWhvtO5Vy+cVusZ+rglU33M+0CI+pus
         k8P6d0RU0qQMnP19IimHEO0Brxy9Os4KagSi7/61CSOyIpa5focrveqSs7afG0riRx4i
         afoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybMp4yf1vi88OQah/2tawVPx6umiUGABzCImHyfek9Y=;
        b=gXvdw39mS+xaEZe2vm0Ym5xv1WgAWBUiknHLiGeqrEtPxTcVEFYANz1oWwoFIQyqNF
         bVa7ab/a3hOtMOusQ6oJecdTDQw1aHeFFvQ2SyJV4gQ074VUZL2wknG3f/kF4awLRbFR
         VwdpI4n1HBLsi55qSS0JGuwg3l1xW7Tl9g7AXH3qiH76efepZky7hSTZabTIzK/EFzUM
         4Wo3oicHH7xCwHpB4iYQMgtOaMED983rlJLfaG8LZskfY2zPzRKoRMd1SqSf2ux0NxfI
         F348bwPsc4PyJH6V6EJgQ87i7slLi7f9DMpkssFv8CQk5fyJwhq5ZRTkjv71XpGW6ScH
         2NCw==
X-Gm-Message-State: AFqh2krpbPM/hQ70FkqFKu3W6HDtPmx1/hMiNf72TPZEn/w9b+osxxU6
        Ds+Vwzv7/DxCBHn7PctX/pMovVb1boE3jr4MzVE=
X-Google-Smtp-Source: AMrXdXtMv3z609fCfMMcn1lyVfLqtlv2kX3RFEiFg4rXFi4hUXOF/Cfb7gNI0fQ2luv3PkbTOGN4Vw==
X-Received: by 2002:adf:cc8c:0:b0:293:1868:3a14 with SMTP id p12-20020adfcc8c000000b0029318683a14mr11101982wrj.0.1673965327363;
        Tue, 17 Jan 2023 06:22:07 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b00286ad197346sm28891037wrq.70.2023.01.17.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:22:06 -0800 (PST)
Date:   Tue, 17 Jan 2023 14:22:04 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y8avDJj5PCy8OVWV@aspen.lan>
References: <20230117134742.23238-1-lujianhua000@gmail.com>
 <20230117134742.23238-2-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117134742.23238-2-lujianhua000@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:47:42PM +0800, Jianhua Lu wrote:
> Add Kinetic KTZ8866 backlight binding documentation.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>

Might be a good idea to take a look at this bit of the docs because
the patchset is not in the right order (I.5):
https://docs.kernel.org/devicetree/bindings/submitting-patches.html


> ---
> Changes in v2:
>   - Remove "items" between "compatible" and "const: kinetic,ktz8866"
>   - Change "additionalProperties" to "unevaluatedProperties"
>
> Changes in v3:
>   - Add Krzysztof's R-b
>
> Changes in v4:
>   - Drop Krzysztof's R-b
>   - Add some new properties
>
>  .../leds/backlight/kinetic,ktz8866.yaml       | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> new file mode 100644
> index 000000000000..18571d69accb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kinetic Technologies KTZ8866 backlight
> +
> +maintainers:
> +  - Jianhua Lu <lujianhua000@gmail.com>
> +
> +description: |
> +  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
> +  with dual lcd bias power.
> +  https://www.kinet-ic.com/ktz8866/
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: kinetic,ktz8866
> +
> +  current-num-sinks:
> +    description: Number of LED current sinks.
> +
> +  current-ramping-time:
> +    description: LED current ramping time.

Needs to document know what units this value is expressed in. IIRC
this should be expressed in SI units and included the property name.
Something like:

  current-ramping-time-us:
    description: LED current ramping time in microseconds.


> +
> +  led-ramping-time:
> +    description: LED on/off ramping time.

+1


Daniel.
