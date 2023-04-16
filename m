Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8D6E3A00
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjDPPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPPyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:54:11 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797952D78;
        Sun, 16 Apr 2023 08:54:10 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-760ec550833so30367739f.3;
        Sun, 16 Apr 2023 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681660450; x=1684252450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bimSNd6xEhIq8jA9htH7BjEd6GsGtZ/bQFysqXyDsPY=;
        b=L9fdHOkaueZCGnggsVEqGNsBL0NjmhD0edl9v1kf3/xgWmYnGmNi9nm5+0owWt3k6D
         Ws4GmQpIw2XcEgZVUfljQBuUTjQLTzDdBm8DbNkZDyavieXNCRGTz885287fCPrkbZni
         p5VdUVQCztd7vSH1cXOZghBxxmob304rzZ28GiZ427CHTBMHggsVsYKu78iQhXHg28g3
         TPHkIhEn7Zb8nv3s9Om+MISSRBTDw33+viGyP1T5ekY2c//XnUNJ5+5AHV5c0um8up6p
         /q0FE6wdhNAnV4SMCNGrS5TaZOQ8gIhyY9BiiXWW6UN5rbHn6tqsD9Vk1XQT90laYeIH
         YIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681660450; x=1684252450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bimSNd6xEhIq8jA9htH7BjEd6GsGtZ/bQFysqXyDsPY=;
        b=Vmu5JBYxRz9hqOr9Gjajks1/VX8McilOcKfmPco7Gbf+vQ6cpg68n39aKVQrSjYr3v
         Iu0SnLJJ3xyf6anI+EjGsBYaF4x0MRFuc/QKbhLYU+TF9tzb/1ryT2uLu9lqPxxc+wna
         7yjGw3RPwD0+hH6LIjlEsADJuPf6+1amXr1Z0smXNK0n/UfhRQDUaLEoMAki3LsdOr1u
         ruFQW4rIoMxkFEz+QLdye3vwHYY7N9g4X8SzCG++gnsYXE9rSQctOJxodMJGo8Oui0Xf
         TVAxMK79aNkp4V4+Sc4m5c/pdWwFbYrCd/nmZUqE1umbgmgvm3QqmVy0wAHitcAd3FRd
         moPw==
X-Gm-Message-State: AAQBX9c+L/Mb9IJQFb2+HB4XvSv9F2wn6UhbdHsnY17vgIttdep+40GB
        c4tgM1viQGhEeklsFwh4/xE=
X-Google-Smtp-Source: AKy350aA9rPo+hX+AvG1x5sHeivprQVL5lRx1/5+WpZEEcsnnCnWdPQ23HTHmHO/EpDW+GqtgmsvzQ==
X-Received: by 2002:a92:c648:0:b0:32a:dfdd:1d80 with SMTP id 8-20020a92c648000000b0032adfdd1d80mr2923101ill.23.1681660449768;
        Sun, 16 Apr 2023 08:54:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10-20020a927d0a000000b00312f2936087sm1021391ilc.63.2023.04.16.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:54:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 08:54:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: watchdog: Add watchdog for StarFive
 JH7100 and JH7110
Message-ID: <e53e0441-b125-4a21-8b89-3406fd89d830@roeck-us.net>
References: <20230314132437.121534-1-xingyu.wu@starfivetech.com>
 <20230314132437.121534-2-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314132437.121534-2-xingyu.wu@starfivetech.com>
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

On Tue, Mar 14, 2023 at 09:24:35PM +0800, Xingyu Wu wrote:
> Add bindings to describe the watchdog for the StarFive JH7100/JH7110 SoC.
> And Use JH7100 as first StarFive SoC with watchdog.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../watchdog/starfive,jh7100-wdt.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> new file mode 100644
> index 000000000000..68f3f6fd08a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/starfive,jh7100-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive Watchdog for JH7100 and JH7110 SoC
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +  - Samin Guo <samin.guo@starfivetech.com>
> +
> +description:
> +  The JH7100 and JH7110 watchdog both are 32 bit counters. JH7100 watchdog
> +  has only one timeout phase and reboots. And JH7110 watchdog has two
> +  timeout phases. At the first phase, the signal of watchdog interrupt
> +  output(WDOGINT) will rise when counter is 0. The counter will reload
> +  the timeout value. And then, if counter decreases to 0 again and WDOGINT
> +  isn't cleared, the watchdog will reset the system unless the watchdog
> +  reset is disabled.
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh7100-wdt
> +      - starfive,jh7110-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: APB clock
> +      - description: Core clock
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: core
> +
> +  resets:
> +    items:
> +      - description: APB reset
> +      - description: Core reset
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@12480000 {
> +        compatible = "starfive,jh7100-wdt";
> +        reg = <0x12480000 0x10000>;
> +        clocks = <&clk 171>,
> +                 <&clk 172>;
> +        clock-names = "apb", "core";
> +        resets = <&rst 99>,
> +                 <&rst 100>;
> +    };
