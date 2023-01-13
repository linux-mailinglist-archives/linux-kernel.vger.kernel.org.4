Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F76669974
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbjAMOFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241504AbjAMOEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:04:55 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E182F8B;
        Fri, 13 Jan 2023 06:02:33 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso12289823otn.2;
        Fri, 13 Jan 2023 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7WW2I9csbO+sPBBS6W+BTb2f2LR/DZ2Nm6771eekLw=;
        b=L6e8noQIA1/1jxwHt3uM+Gt9VMDs87mkpUbV2FmglIF74jIHUVuvvzNs3SbSSOrAgf
         f/ka5NqOyOo+6F3CpZFffl6D5uxaU0fxZ1OqX8jIlc3B2KoUyv1JNQJrpUzRA1gQN2sj
         dDoXkJ8/Gggfx6p2NZXNmfPG7OyUH8nhFXQbB1/a+uq+MKaB8Sxjt7cUXPH7nW09KfYf
         U4IFPqWB0cn89Wo+6C4X8m30G/yM6VbIvu6Uc8zeRPOWtKAXcbsEnq/LYwuLYd/A9fo/
         eRKmcLoUlkdk/of3iVbAtOssePfnENN6XRycQstlcVKSGcYU2bSiCu6GVvWzki7itwgs
         b/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7WW2I9csbO+sPBBS6W+BTb2f2LR/DZ2Nm6771eekLw=;
        b=LeMGbDUBFAmH+/4GtxvFGIKZeUPhS10NjIHSB8g1DQLgie7GZnq8TY9Yex73shwx7X
         wp7Tkuo5dXVWDiN2qRje/t9uuUK6agPhHCLBucI9kGe5RaO0Sbi5vyVQrXTUn5njAB1S
         tYz4KtRpiN40ek2QVzNNcpdjQd2xKfCMp3R7RM9NL6cS68G5mTAdd3QMoV3RHJ2syGBT
         xb12FMJntnnbDbAS2uWsQsUzLI7NP7i1hMlcXbLig7E70r+7BvdMoE6iep9FYpsBqhb4
         zoEmikDaSSR3MolVFHfysJEpNlkkCHFB1SsYQrn2+8fBN7PGyKC/L3XFU3XdheC21QnR
         y9Yw==
X-Gm-Message-State: AFqh2kplycTGhrCSEnikJ7hgnnXx0fS+J323GVUxEhuKgUpayryx2zZJ
        p2rnsSAVsONy+rKjKmiB9n8JcCknPEc=
X-Google-Smtp-Source: AMrXdXvOTt4AXigd4jHpSeu67/kvX7httT+GIs3dvP1CAowS3j+PgRuAO92Q2enU75cWzmCl4RZOYw==
X-Received: by 2002:a05:6830:6718:b0:678:3281:61d5 with SMTP id cr24-20020a056830671800b00678328161d5mr44460731otb.4.1673618552630;
        Fri, 13 Jan 2023 06:02:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v20-20020a05683018d400b00670641eb272sm10514903ote.20.2023.01.13.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:02:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 13 Jan 2023 06:02:30 -0800
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
Subject: Re: [PATCH v2 1/7] dt-bindings: watchdog: qcom-wdt: require fallback
 for IPQ4019
Message-ID: <20230113140230.GA1606649@roeck-us.net>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103346.29381-2-krzysztof.kozlowski@linaro.org>
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

On Fri, Jan 13, 2023 at 11:33:40AM +0100, Krzysztof Kozlowski wrote:
> The device specific compatibles ("qcom,kpss-wdt-ipq4019") should be
> follwed by fallback "qcom,kpss-wdt", which is actually used by Linux
> driver for binding.
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
> -- 
> 2.34.1
> 
