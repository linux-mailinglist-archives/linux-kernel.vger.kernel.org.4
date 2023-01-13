Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB793669988
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbjAMOG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjAMOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:05:58 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122D66085E;
        Fri, 13 Jan 2023 06:03:03 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-142b72a728fso22326146fac.9;
        Fri, 13 Jan 2023 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wgirMkHc6sgDGPUHWTusfvJmmTOV/NUv8g32EEWGaU=;
        b=fgxWTjxxonfM6orZwi/fpVrlr6IWEubXrNJDEcKTsZV8eq2SEM1Ijhqn1EeN8bgnRd
         J7G3HOYxJ1zE9/7vGtX4nBLo8XDDL0VgEPXpaQoMjw5st5fM6Y8JTipNJqoLR/qftNml
         3o2ZMNw0+GhN1OASpfeQlnSld7mHtJfCL6PtVw3sO736BvJ2v7DcS95pSDB+aIJUQBia
         p+IahJOh0UoFKjdslAKiIgU6rlmFs/76j7NpJ2i16iAm8xXi6kZR8/kYV7/LkeWTaReH
         vnkUGxEd7VahVNLOlDKiVhk63yeYcK1pVcdWK2P81Z9tl4i8HqEpaiGXmzuBqKiQDEki
         3ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wgirMkHc6sgDGPUHWTusfvJmmTOV/NUv8g32EEWGaU=;
        b=pI/cqZPIHjT6wPSsW7ct8ge7Z3gUPTQliFqQQeiFJUWpKBLhUmwx9rV3zieTYYKjrD
         DbwQJTdQNrQUKDq/Aqoa7+/FA0Onypc83SE8FAxLYVCi4SCN/L/ZWsa5pQbBWuo5aqMZ
         HKRAEF9G9zU7aAzqgTKskCRzUo2sH87t1wN/9sHBzXGIKiexD5TGkeFJVadR5F+Th0Ak
         JtlZ5xVTIYUmn2ufAMjxPnGew/AUmm9bQcIQeTUTfxsPtgOFWw0fMIYhvToZUjQeyub6
         NNgUC9O+XH0U/yJUwEmbyuEXoHOoTQrSULiUxMjqtkqk4S7P7+xvKOfarbU/qFr2xgto
         TWQA==
X-Gm-Message-State: AFqh2krH6EDeDX0AgUloka/KmwJm9ILoE4V7ApV35lJ5Caiel8IArezz
        Y7Pd7Vt1eKo9gq6V9Gw4KWg=
X-Google-Smtp-Source: AMrXdXu2MzBiZ/Xysj0ykGukzM5YYPrcjHqLp4nZTcEwWVkgDe8vb/1V8yy6oiXY+dsTdV0ZJp7Tow==
X-Received: by 2002:a05:6870:61c1:b0:15e:d240:4e3a with SMTP id b1-20020a05687061c100b0015ed2404e3amr1815747oah.56.1673618582325;
        Fri, 13 Jan 2023 06:03:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u42-20020a056870f2aa00b00140d421445bsm10523182oap.11.2023.01.13.06.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:03:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 13 Jan 2023 06:03:00 -0800
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
Subject: Re: [PATCH v2 4/7] dt-bindings: watchdog: qcom-wdt: add
 qcom,kpss-wdt-mdm9615
Message-ID: <20230113140300.GD1606649@roeck-us.net>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103346.29381-5-krzysztof.kozlowski@linaro.org>
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

On Fri, Jan 13, 2023 at 11:33:43AM +0100, Krzysztof Kozlowski wrote:
> Document new MDM9615 qcom,kpss-wdt-mdm9615 watchdog/timer compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> 

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes since v1:
> 1. Add tag.
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 93e4381067dd..1828eaf70b3b 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -40,6 +40,7 @@ properties:
>            - enum:
>                - qcom,kpss-wdt-apq8064
>                - qcom,kpss-wdt-ipq8064
> +              - qcom,kpss-wdt-mdm9615
>                - qcom,kpss-wdt-msm8960
>            - const: qcom,kpss-timer
>            - const: qcom,msm-timer
> -- 
> 2.34.1
> 
