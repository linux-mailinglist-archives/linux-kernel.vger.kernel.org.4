Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8187E68332F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjAaQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjAaQ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:59:49 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E6B5618D;
        Tue, 31 Jan 2023 08:59:37 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 14-20020a9d010e000000b0068bdddfa263so1021609otu.2;
        Tue, 31 Jan 2023 08:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6EHWBopwmyoZ8t02iSgYiy3q8eIFt2evLGFJVDXB0U=;
        b=XdOQTY1YGQ8QfZ+CnRoCAPxSvGoIvfQESz//mQqz0hVMANcC7XjKrdVFCXdhrz2BNF
         eECF5ptcXCs/i9+J55ZVQE+LXmb6k1DYAYWvPoql62pd9ZARXm4sROnlSQFWv2ngtQnP
         MNsqFe4QUStT3sMuPqaEAUr7LbWexU7K544m6MjqHI+dlfxfhteuCDcV0g0wYlFGUcI+
         1wtvxICsXzPJQhT4WK4Sf0OTkps/nMKl2g3rF3AIn7pq+PUYm6kuRiNVZ0LBDO/SgBdX
         UaCRjDbLNS0JXSYhSyLGbXMQGjheWNaf7of6KQq9MmXVWXcVsOylhFiOTZ1b6m7IJZXe
         cMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6EHWBopwmyoZ8t02iSgYiy3q8eIFt2evLGFJVDXB0U=;
        b=4pQiAQe6rSCyxkS26jPEdi/csCEIw10qgqkYRn/rGaJkJGACU9+CpogYgKvuRihMV/
         9EZHyJjUMjqBeswz9ZHoGRJgDHNPU6maepSdaLdl26Ik/SPxDNfFKXO0k4F+tcPyO774
         YNDIWFykLEC2+W3zq2hq3ncSRBPYvWcXQu672FZ5WQFx2F+1ay6x7AOyvxApdqlK1tRZ
         LGVxNpX5BC98BnHCucow59ptjoCLA5BK619vZ16Sk26x2aEiTJJWjKlUbpL+XAhuqsun
         W//D5xgQXZ1/67c0DGsMsYgiR/6WjYkNWuzJsJbSDgsilxIvlDg1Z1Pub0FnGiiO2Quw
         4VNg==
X-Gm-Message-State: AO0yUKVxOu36OLAKEe60eTtdknLDTeA3yc4WpDnnWHMfI3zwEyx9SItp
        MztmnPEO2Fcmmyn1i8hFo8Purn6t/oE=
X-Google-Smtp-Source: AK7set9rvFfW+9ZAMZPfXChr+dNJZg99s509uTrhWOefwXgAPeCAYvt7V72eSRhgWGoWDf9frNszzg==
X-Received: by 2002:a05:6830:4491:b0:68b:b3a2:a039 with SMTP id r17-20020a056830449100b0068bb3a2a039mr8155223otv.6.1675184376985;
        Tue, 31 Jan 2023 08:59:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e8-20020a9d5608000000b0066b9a6bf3bcsm6775819oti.12.2023.01.31.08.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:59:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 08:59:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: allow "timer" as node name
Message-ID: <20230131165935.GA3598170@roeck-us.net>
References: <20221212174933.208900-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212174933.208900-1-krzysztof.kozlowski@linaro.org>
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

On Mon, Dec 12, 2022 at 06:49:33PM +0100, Krzysztof Kozlowski wrote:
> On some SoCs the watchdog device is actually mixed with timer, e.g.
> the qcom,msm-timer on older Qualcomm SoCs where this is actually one
> hardware block responsible for both system timer and watchdog.
> 
> Allow calling such device nodes as "timer".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> See also:
> https://lore.kernel.org/linux-arm-msm/20221212163532.142533-1-krzysztof.kozlowski@linaro.org/T/#t
> 
> which causes warnings:
> 
> qcom-msm8960-cdp.dtb: timer@200a000: $nodename:0: 'timer@200a000' does not match '^watchdog(@.*|-[0-9a-f])?$'
>   From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> ---
>  Documentation/devicetree/bindings/watchdog/watchdog.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> index e3dfb02f0ca5..b1daefec86af 100644
> --- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> @@ -14,9 +14,14 @@ description: |
>    This document describes generic bindings which can be used to
>    describe watchdog devices in a device tree.
>  
> +select:
> +  properties:
> +    $nodename:
> +      pattern: "^watchdog(@.*|-[0-9a-f])?$"
> +
>  properties:
>    $nodename:
> -    pattern: "^watchdog(@.*|-[0-9a-f])?$"
> +    pattern: "^(timer|watchdog)(@.*|-[0-9a-f])?$"
>  
>    timeout-sec:
>      description:
