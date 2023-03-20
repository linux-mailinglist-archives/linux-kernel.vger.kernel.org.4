Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791846C15A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjCTOxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjCTOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:53:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F18265A1;
        Mon, 20 Mar 2023 07:51:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o12so5511226iow.6;
        Mon, 20 Mar 2023 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679323869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QwLsUZ/tHxijlyn66nlgkLuAYh5gQ70WR4joiAYVq8=;
        b=B4TT2Zx3ZDUCS2kd1BV7u1aOIHoOBIUQ4aJjjgUorMVUTI5TrWPp/y2NJQPhJ1EQ6e
         gXoqutA7sFlPwq1BvXYOumxi2CT7UpeyJW/d9a7JtDA2/SZ7DWEsAl4ZcNWhtTDrzcpe
         70yU8joAXvYxzcSMNc21LXgzt5x0X90gazPI1bNbkYGTUO4e8YdJ1798aHp1sYL0CeDa
         3+k6iJRLDCHmlxOMCEN4P47+0oXt3IqSacdLk5FWbCUoOJWyDRJCVX3TEzHCQdpujKXm
         jADKXLHXxil8wd9X/wxDzeESGbA/WeOMsLjIaZq0Hkn9qkOukuPRCi6zXYXSrjnBMTJ0
         Vqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QwLsUZ/tHxijlyn66nlgkLuAYh5gQ70WR4joiAYVq8=;
        b=lk0sIKwbuhUpdOSldurORvCufi8/ftCKDDWwZFNDlEV+ESJcw20FGou3Xv2VacY5jB
         zc+9PLdynqMzoWkH+fGGu9ynJf7V1S3kfcBeJkWVpqvlSivB+wY0hNDE8ouPKcPEie9p
         5X9Xm1tf1P1N9PuBCY7+Pac8+9vUuxU5x1seedQ7zx3OaldO+BDum/t+3dCm1YBBxW51
         gcnN5iX9KtDwnx1rWVCr7Cj2234pHC0plA9lXm2Le2C3h2e+amwNg4hW7VEk6ybK0VSb
         2B6H3XS7Cfg7sgMHHGsrUzD0kCWzwXfo1PmBRWVtsDYbCIRFxm95r2nFxGV1DNHoYx24
         iuCw==
X-Gm-Message-State: AO0yUKWvYt9/BsyHalrzqSIGyKck5Fam+Hdmxwd8ey50WrsU/YRdwlKv
        J8Ie/AV8plsgBGxrbUqst1c=
X-Google-Smtp-Source: AK7set+CiKFz9qTVoztI3MIDgx4S4HraL6l6viFld+W4rZGOoaOqo0n3RsrLal5Lb8wRN0rl74Gf5w==
X-Received: by 2002:a5d:9ad0:0:b0:714:a25:2f91 with SMTP id x16-20020a5d9ad0000000b007140a252f91mr5290135ion.8.1679323869184;
        Mon, 20 Mar 2023 07:51:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b23-20020a026f57000000b00406431d0fb5sm2964409jae.72.2023.03.20.07.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:51:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Mar 2023 07:51:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: qcom-wdt: add
 qcom,apss-wdt-ipq5332 compatible
Message-ID: <641a1503-4da5-431c-b037-3a46b85834a2@roeck-us.net>
References: <20230320094450.8015-1-quic_kathirav@quicinc.com>
 <20230320094450.8015-2-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320094450.8015-2-quic_kathirav@quicinc.com>
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

On Mon, Mar 20, 2023 at 03:14:49PM +0530, Kathiravan T wrote:
> Add a compatible for the IPQ5332 platform's APSS watchdog.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 6448b633c970..8060a87d29da 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -18,6 +18,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,kpss-wdt-ipq4019
> +              - qcom,apss-wdt-ipq5332
>                - qcom,apss-wdt-msm8994
>                - qcom,apss-wdt-qcs404
>                - qcom,apss-wdt-sa8775p
> -- 
> 2.17.1
> 
