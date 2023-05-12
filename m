Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC22670081A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbjELMbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241212AbjELMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:31:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE314E7F;
        Fri, 12 May 2023 05:30:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1aafa03f541so95411815ad.0;
        Fri, 12 May 2023 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683894643; x=1686486643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ax1r9GRN+VA/FmFIK1JA4h/AKlk+7W/huKr8TlaDi4Y=;
        b=hyDxagQLQ94abcerhjOGoyLto8+EDQDejEU9mthbE517lpBfUN62WsQr4FC29sj3CG
         0c4oIEABLMVvXgct2QtWxXXyoUNM2j7v0UR41DU8iUhgbdUzZO0SYb4T4oe/4iNRWxJq
         A5X3K1J9YUESKhadYK1Tr0vvkafw1P0bKVhxXjGH5SW05kxh/EleJwZoeLpvyZh19R4Q
         OiVIFCyFpOgCskEmg7G6Y+p7kYdLVI+NYgDdOW/vICr4XKx/rXsigzpUtDr/DCmmmvVA
         x5WoIbw6NHYhPndxc7qfCN63bVY9oCqFz6yWUwf01SaGsscLV+hgWLwpjmywvBMp4aMp
         7Faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683894643; x=1686486643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax1r9GRN+VA/FmFIK1JA4h/AKlk+7W/huKr8TlaDi4Y=;
        b=X1W+thravch59F7IJPBAJe4r++uP41M54PTyibc2JPHMTNb/vSiZxSVElrBcgfWrLD
         8ibQ9H421eZfxt3YejnDSjAUPM59RTPX6N3fpAcs9GOLO2ZP9K+gXNMDM4R02Kg/9+wr
         YxoRE22dNKEAEYOFN6dHFfZ99I+cwE62NUbi93L+L+A7XJplrIR60lHRTvnVjCgWUJQK
         ABggLbtkgpmEJHyjMAhdVO5/L/4bdytHcEoJgKoYCT7qudHKw8oDGxnb+Beoi6+teJIe
         H3Q4pH3f2XxujsfoMdwscgcJ6MOLMMm1bCs+KWyUgd4iUYbJMH3pljrbNZ0hQIBegrvX
         HejA==
X-Gm-Message-State: AC+VfDzc44rxIaI+ZOZ3VznVsMzRtOs4vplKSPxvyyBXBodgRuVU8k77
        DN5oFIgdBIS+SgZ6RBVLPbVJtrdeFdg=
X-Google-Smtp-Source: ACHHUZ4SGEtDofa/fsKiAXf2WNkWyFgm4FEMNqWl1UykAcE/JtiwkPMY9jrsNdhyheoZpmt14WlEaA==
X-Received: by 2002:a17:902:d3c6:b0:1a9:7e44:17 with SMTP id w6-20020a170902d3c600b001a97e440017mr21623329plb.17.1683894643338;
        Fri, 12 May 2023 05:30:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b001aaf13db1acsm7793262plc.276.2023.05.12.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 05:30:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 May 2023 05:30:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add Loongson-1 watchdog
Message-ID: <1cf2b0e4-3d3e-4fc0-84b3-f5109d05e684@roeck-us.net>
References: <20230511121159.463645-1-keguang.zhang@gmail.com>
 <20230511121159.463645-2-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511121159.463645-2-keguang.zhang@gmail.com>
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

On Thu, May 11, 2023 at 08:11:58PM +0800, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 watchdog.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> V1 -> V2: Replaced the wildcard compatible string with specific ones
>           Use unevaluatedProperties instead of additionalProperties
>           (suggested by Krzysztof Kozlowski)
> ---
>  .../bindings/watchdog/loongson,ls1x-wdt.yaml  | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> new file mode 100644
> index 000000000000..81690d4b62a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/loongson,ls1x-wdt.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/loongson,ls1x-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-1 Watchdog Timer
> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls1b-wdt
> +      - loongson,ls1c-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/loongson,ls1x-clk.h>
> +    watchdog: watchdog@1fe5c060 {
> +        compatible = "loongson,ls1b-wdt";
> +        reg = <0x1fe5c060 0xc>;
> +
> +        clocks = <&clkc LS1X_CLKID_APB>;
> +    };
> -- 
> 2.39.2
> 
