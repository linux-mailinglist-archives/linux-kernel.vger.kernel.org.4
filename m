Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D6063F5EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiLARGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiLARGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:06:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F1A322B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:06:46 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id be13so3458840lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZJV6+SVgpBCVWv21GfU8jziuPR1JpaZkkNURI7N3HI=;
        b=RTZTrqj9Pug5quATo+7suJG0AhsLMgOoiG8mgS6iJHXLDHESGBVBxyWzVAwsNscRB3
         AtjmKPhUbOHWhxF84M3GPUKEf695t34j94DKGkGbJY4SSwTKATklgjG/53Con0Nnmuhm
         NXcJ/aP9j71xY2cBjpcOdVux75fAGlL10skvGtrOaLsblXWQuf9n8rcyXJhMyahXQmsF
         13vuzOkcNdSrmWGsFSGGgp2tA41XAwAC2Sgg8u3WOyqGeWbug0GGii1F8CSmpPiDRtx/
         kJuTBfRsGM7xMno6t3xEPKApTDZHkcu2tCEXEkdEEsvha8cAlVjX5oydXoagARdEXQ+w
         Um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZJV6+SVgpBCVWv21GfU8jziuPR1JpaZkkNURI7N3HI=;
        b=oLded1080vTlYhhc3XygWj+GpIg1T+Ff+JoVlnafY+6i4wUz2HbUYAL9/drjT35rCw
         RCg97vTSlE7AnrNjzOxPPHFtsItizObhX+Fvsa0aKC8Ps0q7eVSFdX+4QTdfMX5u7SoB
         o8u9IzwOPVzsQFKGeGRMzjrfEJQFdbGadVohMFpcMTQpai/Q3tchVJOX/xV1fs3JgYrN
         G6ygzW3mRFw6pmj5HGPS+qDd4LzjR4vRZEZuIVxnsVyUPD/f3TccEGBsCpOHqJVyfk4S
         jawgP0W3gHSA70TGLc1XASOgarlk1faVJMsza/GlFs6v0Zzc2RKeC2BGc+/ZUXatfV/R
         qRpw==
X-Gm-Message-State: ANoB5plpC0rI65kbh9MEwILlALjRaPLGI6wXm2SnooVupb2SCD9QfA8e
        zGhSKJ67dtsdglebYKyOW/4FqQ==
X-Google-Smtp-Source: AA0mqf4wFFoCB7PXy8flQQx2vps9nSGaUyUEMJISMKOOyrf4TADG8fSMuPLL5WIquaXeGqlGS1NNbA==
X-Received: by 2002:a19:ca06:0:b0:4b5:29fd:a58b with SMTP id a6-20020a19ca06000000b004b529fda58bmr4643201lfg.591.1669914405141;
        Thu, 01 Dec 2022 09:06:45 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25fc9000000b004b40f5e7336sm703659lfg.199.2022.12.01.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:06:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] ARM: dts: logicpd: align LED node names with dtschema
Date:   Thu,  1 Dec 2022 18:06:39 +0100
Message-Id: <166991439954.130674.10015821109236292823.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125144122.476962-1-krzysztof.kozlowski@linaro.org>
References: <20221125144122.476962-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 15:41:22 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   logicpd-torpedo-37xx-devkit.dtb: leds: 'user0' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/1] ARM: dts: logicpd: align LED node names with dtschema
      https://git.kernel.org/krzk/linux-dt/c/0cd4cab6ac67b5ae88511b24d6c1a8c0e61f9f76

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
