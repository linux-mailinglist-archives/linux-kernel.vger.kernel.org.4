Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B26669983
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjAMOG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbjAMOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:05:52 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1990848C3;
        Fri, 13 Jan 2023 06:02:52 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so5587796oom.9;
        Fri, 13 Jan 2023 06:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIdIHCQo4qiprGc7sFFxrDjZzynhHIC6KZoUweTf9OA=;
        b=p2qK7nbEkQggLvqIQfjMeQK4E5Et+O0zNUxI/C2rzV1pmhYyilqPltxQebkgYldZGk
         4W9FmYJOAamN2MMYQFchwKUWwHJmlGgDx/VCvFA99miWe6+tCQNM0AuKmiwWNQq0klaJ
         Obe5C8/2O8dzmKnezt8HJYxrApXEIoTkiwp+2HXZBGKPRvvif4eCfJcsB7O7ya4SpmA3
         0YwQ5i1oPsFvwITm07YansbeVpAxHS22BlGf/8Q1MgthYmdVfc6ok3YJrvjs+JG6wGTR
         4djJvqOXndtmh3sr8LeUXmnsj+2FyxjH0f6B+fyroeWsrM2ilmx8s5PJtackC6KOWQf0
         GHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIdIHCQo4qiprGc7sFFxrDjZzynhHIC6KZoUweTf9OA=;
        b=CLdXt7Bz+B1Gw9U/16hE3ROHuFP4rL3DMTyK4ui0jpSEvekH1Ia1DMs3KexwSEQTi/
         qfZB6/sIrLohypI8Sgs0QtqcyNt9dXrHDyJNQzHcxpwd1iJB1gRhvi9REnQcRMgMxVJt
         6BhL7Wp+B6K5xmbuMfiD18XpunaOaYeEIKDcBfQFoyvr4AAQ4I/7BwsqrIdmCGsH2cRC
         buGeNVtcw0q5nOZ5v4HiTiTEBS9w2SltCrbn2JZu6GacG6MxxL/6nw7cWAbjmgBUJV88
         flYEWphk9HiXX9wM6Kkn660myg9ngTmIFvHBwy4TokOFMPuQ/GuP/sC8dKtUxb0O6Q9n
         H8xg==
X-Gm-Message-State: AFqh2kr/4ddZCMrj6wsGM1M9XZLN5zI6ucsEG6Q8OUUxGqejkRaopCDj
        Pn7kDya3/9ayjdXmdRL0w1eP0utCEAk=
X-Google-Smtp-Source: AMrXdXtr5IgUGIPi2Cu215mW/ZglwbTtoma3MwwTDbxvF+c2UCPiRfCD2IHK0iqMALEpjIJVk+M+EQ==
X-Received: by 2002:a4a:21c5:0:b0:4af:70e8:8afd with SMTP id u188-20020a4a21c5000000b004af70e88afdmr39218014oou.4.1673618572075;
        Fri, 13 Jan 2023 06:02:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w15-20020a4ae08f000000b004f1f6b25091sm7659656oos.41.2023.01.13.06.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:02:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 13 Jan 2023 06:02:50 -0800
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
Subject: Re: [PATCH v2 3/7] dt-bindings: watchdog: qcom-wdt: fix list of MSM
 timer compatibles
Message-ID: <20230113140250.GC1606649@roeck-us.net>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103346.29381-4-krzysztof.kozlowski@linaro.org>
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

On Fri, Jan 13, 2023 at 11:33:42AM +0100, Krzysztof Kozlowski wrote:
> The MSM timer ("qcom,msm-timer") is a bit different timer and watchdog
> device than KPSS watchdog.  It has its own generic and specific
> compatibles, so fix the list to reflect this.  Adjust the example to
> show the newer KPSS watchdog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> Changes since v1:
> 1. Add tag.
> ---
>  .../devicetree/bindings/watchdog/qcom-wdt.yaml    | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 3e0b30a817d6..93e4381067dd 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -33,13 +33,16 @@ properties:
>            - const: qcom,kpss-wdt
>        - const: qcom,kpss-wdt
>          deprecated: true
> +      - items:
> +          - const: qcom,scss-timer
> +          - const: qcom,msm-timer
>        - items:
>            - enum:
> -              - qcom,kpss-timer
>                - qcom,kpss-wdt-apq8064
>                - qcom,kpss-wdt-ipq8064
>                - qcom,kpss-wdt-msm8960
> -              - qcom,scss-timer
> +          - const: qcom,kpss-timer
> +          - const: qcom,msm-timer
>  
>    reg:
>      maxItems: 1
> @@ -56,9 +59,11 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> -    watchdog@208a038 {
> -      compatible = "qcom,kpss-wdt-ipq8064";
> -      reg = <0x0208a038 0x40>;
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    watchdog@17c10000 {
> +      compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
> +      reg = <0x17c10000 0x1000>;
>        clocks = <&sleep_clk>;
>        timeout-sec = <10>;
>      };
> -- 
> 2.34.1
> 
