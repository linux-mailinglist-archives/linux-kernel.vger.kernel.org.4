Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066637503E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjGLJxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGLJxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:53:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C1B170E;
        Wed, 12 Jul 2023 02:53:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b703a0453fso107480681fa.3;
        Wed, 12 Jul 2023 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689155584; x=1691747584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bZKlV2wM5sufya1UkVMFgdgGjIXmAmPLF6IfOmbznOo=;
        b=fQcArm2cSwW1PfHBKO+8D/vVJk40YpQVzeWfdcIl0VWVeIqGLejr8y/ikfOox9KJSQ
         fIT7e16d+4F4PTqvkMriztsZrLLcdIPsVPTzS5D+Sx4heLIRofwDpI1+uB+oUwgVW082
         wLxegZPGTJMBJv0czAgdNUmOfY5ydF4j44ASU/Ez/nT7qC79Uyx4Y1xh0y1+rIA/DxVg
         dSpNXAFFEYTCJvMHKmpjb4jko1PnuGRwYntRgxAAwip9mIaSHqBpatCsGRaRuQeCveCA
         3U+YDf9EKgHEpqbRvrcg5ahsAMEqcCXN7BkiAyyOtxz8iojijCQsLAQANkgD4dq8l6SU
         WBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689155584; x=1691747584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZKlV2wM5sufya1UkVMFgdgGjIXmAmPLF6IfOmbznOo=;
        b=GZRYgvHrSYt9ID2SqitPfvPwz9JZCYYbBOK0lb9Oy5YWhBNNc8knfXjVVyo11K22i2
         WjiJbDgd4hvRvNR3uQPv+wQzEdlZ/H+xoTOYHpvclbHfpFZI/2F4TVG/hWI9E+yBsPF5
         mqy+hm/KH7mzwLQ8nNYlKPnd+giX7sdpp7CSxVDRyMqWW7vfimnS1+yeVqAvnZlQBFAL
         kWxYVqCX9TFmksbpCQtV+5B9u0zS6xrtEE0u0rOItuCpNodEwQobuNB+BDkB8S5skmFN
         b2iFwOGLSijJZ243q2kLPy4IW95IyH/aj3leYNhfMTHwFZZNVvHWa3psm1xCkBIKejgo
         8TkQ==
X-Gm-Message-State: ABy/qLZeSeI3zbf6+U4um4+423I8OouQwWHmcRL0xaKsdIUsGXNEev02
        loBbrJ2WhDsSi7RXj+34S5r/ULLGwN5szA==
X-Google-Smtp-Source: APBJJlE8QxFN4JArFr9UQvqwAtlEKS5kgbi+4nvnQ+shz5CujvysnDzeMoz0G1SeWEBws72OhHJJWg==
X-Received: by 2002:a2e:6e0e:0:b0:2b6:db9b:aadc with SMTP id j14-20020a2e6e0e000000b002b6db9baadcmr16749089ljc.32.1689155583696;
        Wed, 12 Jul 2023 02:53:03 -0700 (PDT)
Received: from mobilestation ([85.249.22.88])
        by smtp.gmail.com with ESMTPSA id f15-20020a2ea0cf000000b002b6f8d07d30sm879022ljm.134.2023.07.12.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:53:03 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:53:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: snps,dw-apb: allow gpio-line-names
Message-ID: <d25vlma6vefztgggatas7ipn36rumhuodzcalfq7c6apwliy7a@ddgo3fgulv2s>
References: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:45:53AM +0200, Krzysztof Kozlowski wrote:
> Allow the GPIO controller subnode to define GPIO names.  Already used in
> at least on DTS:

s/on/one

> 
>   bitmain/bm1880-sophon-edge.dtb: gpio@50027000: gpio-controller@0: 'gpio-line-names' does not match any of the regexes: 'pinctrl-[0-9]+'

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> index b391cc1b4590..209f03bba0a7 100644
> --- a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> @@ -61,6 +61,10 @@ patternProperties:
>        '#gpio-cells':
>          const: 2
>  
> +      gpio-line-names:
> +        minItems: 1
> +        maxItems: 32
> +
>        ngpios:
>          default: 32
>          minimum: 1
> -- 
> 2.34.1
> 
