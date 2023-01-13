Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD4966998C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbjAMOHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjAMOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:06:16 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9BE840A3;
        Fri, 13 Jan 2023 06:03:17 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so12276054otp.9;
        Fri, 13 Jan 2023 06:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaZL3zzO4Lst6ZcQ2rStVAw0bjy5dGmT6m4Rpv3NYno=;
        b=YuvdaX9G28dVWenaG0d5/V8jIQflgMb6cfPYmSl1jjWRvBD4K8qJDDP+SBQnvqDsCK
         DZofxVXPE5L918rHY/X3782yMWPb4OOSPv8pSTXV4yB0rdjxRCVuLoLsfHhpUxFguKvz
         CcANirhCX9AJJzPFIync1PCFZKZaIZIWPeCzG+G1m5DlWAGb2BCTFh9fWUaIyaalgocs
         vckzZ9cQnn9oQE2h+EaBGmZK9jB0H6s30hf2ZoLOia5OX+F5DJWKflZEj9GioEmiT8KS
         MPCrjTyqb+FsrynI23lL1jieg1/W7LdSBh1CxT9FYqbFST6mcbtfaPXhhkklYUUU1Ntl
         /R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaZL3zzO4Lst6ZcQ2rStVAw0bjy5dGmT6m4Rpv3NYno=;
        b=rstBWbkTJ+SPDLdYMBHWkaYt+ioE316IGNvduw1XYnj252JO4SW73d/IwB3EDrJ5yS
         uQSMh6J6PGWMECvxFH+521A5HMfmeSwEptpPomZYgI45Y4aMCzonN+sL9D0TK7lc9R+i
         eQUeJ0zo6ViV9j49RJjY99W/hPAgIh84H5iJOPAocO6hiVhVOJnEOJveXIbVQJru5xA/
         v/cOj5Cm1bqALX414GGgGPYIcgWFA4vSEj5a+HB7drE6CrHpkMkIzi0LTMtMD04o5v09
         cEkVrvlWnk7Br75bylNyMvb2z7UhXcCg98vq2TlhwVdZ6YjwVyxndiI0v8G5LofVj3ks
         Nbjg==
X-Gm-Message-State: AFqh2kqgyExVV+ep7LHItNKCqw6EG9MZIKfE2zwfg/bJ3GpWsM0WaaCY
        ALaEFferZzmtWj1z3E+LGrI=
X-Google-Smtp-Source: AMrXdXuqjcD94Z5fnD82uRpFQ0S6Qk72PBVYUMYzsu8/9rEdTkXYOxaCrTB5Ros8UpavXL4iJ6XglA==
X-Received: by 2002:a05:6830:6617:b0:670:9473:c376 with SMTP id cp23-20020a056830661700b006709473c376mr5594237otb.34.1673618596386;
        Fri, 13 Jan 2023 06:03:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12-20020a9d6d8c000000b0066c15490a55sm1915513otp.19.2023.01.13.06.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:03:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 13 Jan 2023 06:03:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: watchdog: qcom-wdt: allow interrupts
Message-ID: <20230113140314.GE1606649@roeck-us.net>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103346.29381-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:33:44AM +0100, Krzysztof Kozlowski wrote:
> Both of type of watchdogs described in the binding (the KPSS watchdog
> and APSS WDT timer) have interrupts.  Allow interrupts and describe them
> for KPSS watchdog to fix warnings like:
> 
>   watchdog@17c10000: Unevaluated properties are not allowed ('interrupts' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> Changes since v1:
> 1. Add tag.
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
> -- 
> 2.34.1
> 
