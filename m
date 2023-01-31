Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CAB6833E4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjAaRbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjAaRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:31:19 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D296561BE;
        Tue, 31 Jan 2023 09:31:18 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id z25-20020a4ad1b9000000b00517affa07c0so296245oor.7;
        Tue, 31 Jan 2023 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+pH+4kerhTT1yotZGiO2JoX7wg0buHGicjvICTAxQU=;
        b=H58dUjxEO5BNWkPDwbUu1m9ZIgrvMcmCHauEQIWm8Zh9S3Y45/aKdOXZbLfa7m4oV6
         E9P6ArFrZ2Q2msw0nZfQf7TgORRn5pUQgCypB9acnVUSxb3Fvw2IGx3z1r26hbpxvKSC
         jPRwdZUkzcIFK/6D/3ARN93pWCrlF4bwr015JJFPqSG584Zcorflg3cimuYzn4Sy5Qqw
         Vb2wvoSkgjB4ELz2W3Vpu9H8UkGktIJElEfQSGIOC6KvGbJP7Xb6o6dXv0AJX+j+Jv2V
         4ZRSDBaKOO2TqzgAtoT4v1Tz2kFVxczsh30o08ODnOQW05H1HfaKum/r/s25z27zAwz7
         6pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+pH+4kerhTT1yotZGiO2JoX7wg0buHGicjvICTAxQU=;
        b=rGmfPb4Q+QuPzlcYVC7RlHe/o3tNkmccNpg9qHIVRZL/dBtME6LyQjUiegOUIjXv/L
         pHtVZqHC+PMff3r6Sn3rLqS9CLTfPQjtzarIAQDXIoTemj1jQfyTpCRlD1I0ILaYykbC
         yWlC6iyo5gI12Vt3bt8wEBJxRCIebfYPD4yCWmq4EXuEEOKdke7vvTLY6WDLzF+9XT7h
         MGDxLcmYXxzfoBH0J1/VjrYytEsFWlxhFd0Cbua0r+NrSG7NkSLQk8mbkRn8z7eRNlG1
         GhdTWv8nR1/IzGKhkTx9bPx8foxbz06syKn18roy7adR4qLik0FkJoyUornRuaoV8jGb
         OA4g==
X-Gm-Message-State: AO0yUKWNPedqK4R1k8iL5TYwl8B0aFBh7moil7AUQumT4YzW5hMpO5lK
        VmJcL9EvWKJFnt/K1LFz3L0=
X-Google-Smtp-Source: AK7set/dOA+Hp6dUT/DRLzsatE72Fbf3s97rUinD+efaaANHc7GuEdzB22jrJcnynbISW/s5lf/TPQ==
X-Received: by 2002:a4a:d58b:0:b0:517:784c:cfd4 with SMTP id z11-20020a4ad58b000000b00517784ccfd4mr4033520oos.5.1675186277624;
        Tue, 31 Jan 2023 09:31:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w12-20020a4aa98c000000b004a0ad937ccdsm6335832oom.1.2023.01.31.09.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:31:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:31:16 -0800
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
Subject: Re: [PATCH 01/12] dt-bindings: watchdog: qcom-wdt: require fallback
 for IPQ4019
Message-ID: <20230131173116.GA3601568@roeck-us.net>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
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

On Mon, Dec 12, 2022 at 05:35:21PM +0100, Krzysztof Kozlowski wrote:
> The device specific compatibles ("qcom,kpss-wdt-ipq4019") should be
> follwed by fallback "qcom,kpss-wdt", which is actually used by Linux
> driver for binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index a1f17c9e02db..e76364c52fc7 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -17,6 +17,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - qcom,kpss-wdt-ipq4019
>                - qcom,apss-wdt-msm8994
>                - qcom,apss-wdt-qcs404
>                - qcom,apss-wdt-sc7180
> @@ -35,7 +36,6 @@ properties:
>                - qcom,kpss-wdt
>                - qcom,kpss-timer
>                - qcom,kpss-wdt-apq8064
> -              - qcom,kpss-wdt-ipq4019
>                - qcom,kpss-wdt-ipq8064
>                - qcom,kpss-wdt-msm8960
>                - qcom,scss-timer
