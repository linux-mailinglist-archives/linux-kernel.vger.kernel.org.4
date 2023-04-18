Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2216E5A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjDRHet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjDRHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:34:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF849DB;
        Tue, 18 Apr 2023 00:34:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso1268476b3a.2;
        Tue, 18 Apr 2023 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681803284; x=1684395284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=js+iwSD9dRdBHvw9elXMMmJ/oVIvO5ZqNCOrYFY3n00=;
        b=Prz4HoHlA3UrHJHjuIb+9F7kj5FEtiebURe3gV3BcJY8Qmb29iCQVajznBZXB63mNw
         iyX2GPs6JjfMMulR9VYsKG2zhfrjPGI1IfrFRR8k9UriJGPKyKLU2uND54gEWOsXRDqk
         +k6ADwAfnOCgHJPjK5WCpr4aZxSEOUzqrjNuL5ue0DnpRd05H+vyP7OLfNwdLxPTKxM3
         vYep0RKb6lanDZAgFlYaOIRxcq9D7g3HUq/+8rhngJLqCPdJTbs5nrYAjx2Ni9s7gIQ6
         4t1Q06f7BNljgOC+x0eG2Udh0BRtxRDdb+Pt5jSDlGQzV9H6y7BR6SWPY4t3DMIkZ4v7
         nN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681803284; x=1684395284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js+iwSD9dRdBHvw9elXMMmJ/oVIvO5ZqNCOrYFY3n00=;
        b=MwjV1s5D/CnZYfcOanECCdGOvre8djCI2nLxRQaYsMq5jt+exMOWPLrBtRLaoMMUii
         J1/US9W5Jz6URqtqa4+BjlMrXB3YumWHubErr+kok1uKEZSKvqNvOpUD4aC0G/AWF4nQ
         N/go1odQnLuBju0e/vX9WHd7afs6q0VUHEsUJz2a44nUPs3HFXyfE+h+UW4I0MgatYJY
         RG9XHf0xTAKOGgBiHavgsqXfBQA9VCpsJ4eBLrAsTAY7VJj+c+2dpDC33lNSiodMuGjh
         8F8+tWJYwY0c473xMekg9AJ5A+WgK+JMhotVk6ga13bMwGvQA5zhBR5IcqQ67ZqxNwCS
         OAxw==
X-Gm-Message-State: AAQBX9cnm841ic99Y306F3Er3SXztjNyWZT39BZcTqJHCkTsx8KfHWnw
        56QeE7mZ4XsHIsr42YoCOKo=
X-Google-Smtp-Source: AKy350ZNHxHGvkb2a/7Pu30kHUaPaNXYp9CsqYkV6qbGNIWmkLQdNFsbunGE38TWi0P3lQ2WYgM+kA==
X-Received: by 2002:a05:6a00:1356:b0:63d:3d2b:a7ee with SMTP id k22-20020a056a00135600b0063d3d2ba7eemr788973pfu.18.1681803284146;
        Tue, 18 Apr 2023 00:34:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i12-20020aa78d8c000000b00634b9132694sm8691038pfr.126.2023.04.18.00.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:34:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Apr 2023 00:34:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Om Parikh <hack3r-0m@proton.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: watchdog: alphascale-asm9260: convert to
 DT schema
Message-ID: <1d10bfb3-1486-4aae-b615-7dfdf695fa78@roeck-us.net>
References: <20230418051446.24288-1-hack3r-0m@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418051446.24288-1-hack3r-0m@proton.me>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 05:16:10AM +0000, Om Parikh wrote:
> Makes alphascale-asm9260 dt bindings adhere to the dt json-schema
> by replacing txt file with yaml file.
> 
> Signed-off-by: Om Parikh <hack3r-0m@proton.me>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  v1 -> v2:
>   - drop quotes in "$ref" value
>   - update compatible string from board name to node name
>   - drop "Olof Johansson" from maintainers
>   - update "compatible" property from enum to const
>   - drop generic reset description
> 
>  v2 -> v3:
>   - drop timeout-sec property
>   - update description for mode property
>   - set default as "hw" for mode enum
> 
>  .../watchdog/alphascale,asm9260-wdt.yaml      | 70 +++++++++++++++++++
>  .../bindings/watchdog/alphascale-asm9260.txt  | 35 ----------
>  2 files changed, 70 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
> new file mode 100644
> index 000000000000..fea84f5b7e6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/alphascale,asm9260-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Alphascale asm9260 Watchdog timer
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +maintainers:
> +  - Oleksij Rempel <linux@rempel-privat.de>
> +
> +properties:
> +  compatible:
> +    const: alphascale,asm9260-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: source clock, used for tick counter
> +      - description: ahb gate
> +
> +  clock-names:
> +    items:
> +      - const: mod
> +      - const: ahb
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: wdt_rst
> +
> +  alphascale,mode:
> +    description: |
> +      Specifies the reset mode of operation. If set to sw, then reset is handled
> +      via interrupt request, if set to debug, then it does nothing and logs.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [hw, sw, debug]
> +    default: hw
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/alphascale,asm9260.h>
> +    watchdog0: watchdog@80048000 {
> +      compatible = "alphascale,asm9260-wdt";
> +      reg = <0x80048000 0x10>;
> +      clocks = <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
> +      clock-names = "mod", "ahb";
> +      interrupts = <55>;
> +      timeout-sec = <30>;
> +      alphascale,mode = "hw";
> +    };
> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> deleted file mode 100644
> index 75b265a04047..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Alphascale asm9260 Watchdog timer
> -
> -Required properties:
> -
> -- compatible : should be "alphascale,asm9260-wdt".
> -- reg : Specifies base physical address and size of the registers.
> -- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
> -- clock-names : should be set to
> -	"mod" - source for tick counter.
> -	"ahb" - ahb gate.
> -- resets : phandle pointing to the system reset controller with
> -	line index for the watchdog.
> -- reset-names : should be set to "wdt_rst".
> -
> -Optional properties:
> -- timeout-sec : shall contain the default watchdog timeout in seconds,
> -	if unset, the default timeout is 30 seconds.
> -- alphascale,mode : three modes are supported
> -	"hw" - hw reset (default).
> -	"sw" - sw reset.
> -	"debug" - no action is taken.
> -
> -Example:
> -
> -watchdog0: watchdog@80048000 {
> -	compatible = "alphascale,asm9260-wdt";
> -	reg = <0x80048000 0x10>;
> -	clocks = <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
> -	clock-names = "mod", "ahb";
> -	interrupts = <55>;
> -	resets = <&rst WDT_RESET>;
> -	reset-names = "wdt_rst";
> -	timeout-sec = <30>;
> -	alphascale,mode = "hw";
> -};
> --
> 2.40.0
> 
> 
