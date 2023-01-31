Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F404C6833E9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjAaRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAaRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:32:03 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9F0552BE;
        Tue, 31 Jan 2023 09:31:45 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so1211641otq.13;
        Tue, 31 Jan 2023 09:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5bGw1GezPF6lXREFqF5MGFbYS7Ls0VCvjS/3Gu5c1o=;
        b=dI1g0aM3WSZXEIh4UQRcbUZ6SxeMAjDTx2eaLT7Hi6013TN1+MngO+p9OOBRn5oFHj
         nVX7o3c7rSv2nJxP2nFumnUITGWUcZBd5aFtDjN1o+kQUImZkCo9Q2qzZUsExkYqeWgy
         aFIZVUaUvzTjtHr50MCY6PNjaGirZaM49lx6gAFiEpDjGQjhXb+m10v+UKvapyxjGbUb
         7Qn4tI867RSpBFTj7P4OsW7JhpeJRFJevXr85CojW5tKhaBTluP5ue76P27Yb5FBPKq4
         UtXAtwO3RYOYM5HYBi+D9fI99tr/4bC6BmFS5oluOGTUoRJQRgNPuOmwD7oXX1JUSHsv
         VSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5bGw1GezPF6lXREFqF5MGFbYS7Ls0VCvjS/3Gu5c1o=;
        b=BY8pleXD+WbVzaEr8LfjVS+bcSzuRcO/BoXsv+9Ot3asypuah5ZokSVPKsGQh7Gyyj
         4yHTbTrYBhS290s2eaBdDykXmMaRvJHFz9HP8+Sz7Fe7jqEw6pk/GMmIPMIQxk5+0bce
         +MXYE5aAXL+ZqSRg2P8E9IPHoAcKhnv6lkqHT29VAhy8rx3H6GswCt7IbzQi2OWW3mRx
         9pruvcjQAjDv3VAUh/Xwn6JQQJD4kzKKPD/HTytUsusPJzy2x5O+FLJ45nthP9gTnMJo
         Tq1kc7PLCkQVe8jCxq8v7Q8ImC2vD4/73XldGQGwqDfilzm02QZL/meWeb7U/8R8+w4P
         DuJw==
X-Gm-Message-State: AO0yUKV7SouC2cT/BiinGkLYf1XY4y93di4y/nmH5MmljQA/HMZshvyd
        1KNHrKX5yzaLw1MFajBE2Lk=
X-Google-Smtp-Source: AK7set9atEFPZOKuJlKHCZOavMXiSaklruZcJWcU4Gcs3M05uCUJF4eeAodqhtpCmABsL0P7//IK+w==
X-Received: by 2002:a05:6830:44a0:b0:68b:cdc3:78dd with SMTP id r32-20020a05683044a000b0068bcdc378ddmr5252347otv.17.1675186304967;
        Tue, 31 Jan 2023 09:31:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n19-20020a9d64d3000000b006884924ca4bsm6775540otl.5.2023.01.31.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:31:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:31:43 -0800
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
Subject: Re: [PATCH 03/12] dt-bindings: watchdog: qcom-wdt: fix list of MSM
 timer compatibles
Message-ID: <20230131173143.GA3601677@roeck-us.net>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-3-krzysztof.kozlowski@linaro.org>
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

On Mon, Dec 12, 2022 at 05:35:23PM +0100, Krzysztof Kozlowski wrote:
> The MSM timer ("qcom,msm-timer") is a bit different timer and watchdog
> device than KPSS watchdog.  It has its own generic and specific
> compatibles, so fix the list to reflect this.  Adjust the example to
> show the newer KPSS watchdog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
