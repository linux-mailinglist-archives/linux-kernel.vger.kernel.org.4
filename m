Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778955FCD81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJLVsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiJLVsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:48:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4CD1217E3;
        Wed, 12 Oct 2022 14:48:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s2so164833edd.2;
        Wed, 12 Oct 2022 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiOoGqWP9QI63dNxXTXejVxT+J2IullvD3xHlr3pqqI=;
        b=CuhP6SJAJqI9WLUgkws2o7QpcR3KOtu+vk40JKMcNTB7ITFZWoZdoY54dgctUAZ/v/
         PVv0V7sCooD18SZJteKjKf+IFKQmwvqKqs3X+OGg9cmp+GfRj2Xw2Y1ufTvA3rJaufbe
         4ar5B+w/gqaICz56Gu7Jq/B/V5aB7lkoHne2ocKK3H3NDjDYUSmzDfUC0KiN+tT75lNw
         9bjBohG1r+V7twxDQCDLq3x3apOlrb1Tze0/i8X3/+GeqpkBQJrkRSKsl25kFFjljd8i
         go7KK2h4WiFd1BJH/62P6yfdzUDg812obYEZa5Wd/TFlY9ucggat20Z3KBo+AtAnrZF2
         jhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiOoGqWP9QI63dNxXTXejVxT+J2IullvD3xHlr3pqqI=;
        b=nbXeeoKEBn0ZZQgCo5PoMb/Gn4Dy7bPqSOtftbPT4CIA/fbj9rTNyinZfEJF/xsZw6
         Nk5yjB+sDqEA+xFd5WtFTMHMXHDDGZ9Bnixj/xPNndRB9GLTUtlGnnDZW4elrfBwpO0z
         ozCL3NGHJ+Fyqqm8HmuTDDCFY3cb6yU7Dp6C7ULw7Oa/3i4XfiBGb1afcFt8h8R+F37W
         VC69wjlXhKVW4q6UPbvBTfae7s5L1DcJouXgMKcYKjFNODSMqWeTfbsf6ROl94kOSIL3
         Q92tSTufAWw+hSokiqKwKd96/gXc9u5YXKT8pCWlFaQc5PF783fnb+fKnq+NF1gx6oPx
         WgLg==
X-Gm-Message-State: ACrzQf1LOlsV09cGYCszEKsB1x3Ol+Ilm7Pu04tDscKsbHIUPpTdtW/8
        JfcIQhc9Lz4h2O1ms8WTH3w=
X-Google-Smtp-Source: AMsMyM5NKhZWo9SvUyqqCkby2CqZcu64sNYVrDopX0uUbIv+RX0/Berc7UxXx7bYGv1aVRFYuSrAeA==
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id ev6-20020a056402540600b004521560f9d4mr29573632edb.333.1665611280437;
        Wed, 12 Oct 2022 14:48:00 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ay8-20020a170906d28800b00788c622fa2csm1852551ejb.135.2022.10.12.14.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:47:59 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: sunxi: correct indentation
Date:   Wed, 12 Oct 2022 23:47:58 +0200
Message-ID: <2599730.BddDVKsqQX@kista>
In-Reply-To: <20221002091959.68815-1-krzysztof.kozlowski@linaro.org>
References: <20221002091959.68815-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Dne nedelja, 02. oktober 2022 ob 11:19:59 CEST je Krzysztof Kozlowski 
napisal(a):
> Do not use spaces for indentation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi index
> e899d14f38c3..1d1d127cf38f 100644
> --- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> +++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
> @@ -89,13 +89,13 @@ switch-4 {
>  	};
> 
>  	reg_gmac_3v3: gmac-3v3 {
> -		      compatible = "regulator-fixed";
> -		      regulator-name = "gmac-3v3";
> -		      regulator-min-microvolt = <3300000>;
> -		      regulator-max-microvolt = <3300000>;
> -		      startup-delay-us = <100000>;
> -		      enable-active-high;
> -		      gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "gmac-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <100000>;
> +		enable-active-high;
> +		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
>  	};
> 
>  	wifi_pwrseq: wifi_pwrseq {
> --
> 2.34.1


