Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E9D6833F5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjAaRdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAaRdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:33:16 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BEC4B1A2;
        Tue, 31 Jan 2023 09:33:13 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so1213029otq.13;
        Tue, 31 Jan 2023 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRTZ3vJNhDm4N9tkrHYGwLhPGFfqmXkCPPUJt0cvY18=;
        b=brxQ0OXSjQ0wRRx3CmZPMftDzxNI4xblyLsuLqIcDkEPAZOH04Avk9SLGtQ06MGwSJ
         rCVQml1tyoaPxNjWP69OGeHBbGpHFtmnZ6ufh5tfyuTGphWkp0Dd2yP0uzK8GcpVlOtc
         9Ce5NSqjXRfrhryWOYn2LJAGxDDMaJqxBwfDs3YXhuqXpgLZQFLwqlRIyHNn60Hrdg2R
         07GjxNlqgM+uLQEjPvBbSEQ8QeV3N/B8PPLlXW/yjsvd1aQgXWXqVeqRxwTksqJ9D1Kc
         Gx0llFMSM+BtTB6xHpNfi51K//YdlrzYBSbWrIZ3uFMv3Mp5Q9+iMuxdlaGyI71StKoD
         +eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRTZ3vJNhDm4N9tkrHYGwLhPGFfqmXkCPPUJt0cvY18=;
        b=igAnI1M+acO8dOCHevb3Cz3GyGbMrC8Tlo3XXukYA78Ql/Rbkk2sY8ca65z9dkuyB6
         9u2WKqa1nfxhoTYypwQA2e5fb5tsUGF6TTeRYHJKC5ex5Nzrhh6EdzVMx4nw7kpSYJQP
         5Q7OH6MQkxqvRl2HmGhfAYIK62J/b9Acu/URyqO5tjWUefKcyL8tC0S8uD3RQAvnmCkV
         gM85DtsxphOr7dQDiQV0P+fQQUy8PdqwJ8inVAO0wUG6HKDiyVTln9Yw3BJp8cHJyfI2
         x5r58UcMQkl6ai7/oQpUHBAllltzady2B+bhHo7j1x1k015bvWbCkRZqk/J56Aiv3Yz2
         Pqnw==
X-Gm-Message-State: AO0yUKXUdz82mWyg8R43fAoutjc1swF51opj8NztdxqU3I4NkjcZs9NX
        Os8GFdXE6pQxNbVAB2/k5kE=
X-Google-Smtp-Source: AK7set8pju0V3hHwCKn+KA5A0FjV/Dnbii88RxDaHttBzKOlNe04oSoTeTh1hS1aAnLH7BTa0UR4Qg==
X-Received: by 2002:a9d:4ce:0:b0:68b:cd04:e52b with SMTP id 72-20020a9d04ce000000b0068bcd04e52bmr4931816otm.35.1675186392808;
        Tue, 31 Jan 2023 09:33:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k96-20020a9d19e9000000b0068bb3a9e2b9sm5264663otk.77.2023.01.31.09.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:33:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:33:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] dt-bindings: watchdog: qcom-wdt: allow interrupts
Message-ID: <20230131173311.GA3601934@roeck-us.net>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 05:35:25PM +0100, Krzysztof Kozlowski wrote:
> Both of type of watchdogs described in the binding (the KPSS watchdog
> and APSS WDT timer) have interrupts.  Allow interrupts and describe them
> for KPSS watchdog to fix warnings like:
> 
>   watchdog@17c10000: Unevaluated properties are not allowed ('interrupts' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../bindings/watchdog/qcom-wdt.yaml           | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 1828eaf70b3b..b7fc57f4800e 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -9,9 +9,6 @@ title: Qualcomm Krait Processor Sub-system (KPSS) Watchdog timer
>  maintainers:
>    - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>  
> -allOf:
> -  - $ref: watchdog.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -51,11 +48,31 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  interrupts:
> +    minItems: 1
> +    maxItems: 5
> +
>  required:
>    - compatible
>    - reg
>    - clocks
>  
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,kpss-wdt
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          items:
> +            - description: Bark
> +            - description: Bite
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -66,5 +83,6 @@ examples:
>        compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
>        reg = <0x17c10000 0x1000>;
>        clocks = <&sleep_clk>;
> +      interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>        timeout-sec = <10>;
>      };
