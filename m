Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2B6231A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiKIRlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiKIRlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:41:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6BD13CF5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:41:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v27so28241539eda.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=te8A29WYMbVhDB59m6Z/SwQUKjQn/YZP/J3QgC3V384=;
        b=bGAxNdswHtq6pnZVdLLvKKBG2rRu2c+Ccr10Zhdkps/EU0jxoMMjvjuaLlsb/civrq
         PtMvZePt1JdxkKNVwlScM4fQmS+Ai7BOYvC82fMtdWWDepeLOhl/93tAXywD3/xoxhJe
         42XJwbgUGyrfEdFZnIzqMyQe/6BvTlicoD6nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=te8A29WYMbVhDB59m6Z/SwQUKjQn/YZP/J3QgC3V384=;
        b=ApV7/5GMG4H8PNB/8iTLb67gyAPPWmYc8fNTAt5iqfNQYlRLRrbKnhg8k7Z/BTG3oY
         auZF9Ip7RxER5ofCitaaKvWZuKfPRPYIpI2DhloUBmn5xO8iuYevsqZCSE04CYN7nMp/
         MKKAFNobBKcAP/wAbdKiUDlY7D0wlWqmK/JN0CDsreT8WAixd5dDahlPiJsH4fi9zWed
         2on24tnYw+9ITMGgbAmJmTWthuM594Ck+l6bVWPki50bKIQjKdyQDJY/8JPqGZWkmcWD
         Ox3Zbe9PPz6n0C/yp2oEO+mEzhj70VqJBE2Rift0aRpu3FqC4z2lr0JeyqD8nMCNsh0E
         JroQ==
X-Gm-Message-State: ACrzQf1Cd+7JHM71uZXrv+1IcTl5mmsYtEGm6QRC9xd8aG27K1jOhtwm
        9iRKl+0KsGYzQrLDH7jTRtm4yhBwaiyWINio
X-Google-Smtp-Source: AMsMyM6cmm6P2rp5wtMOKB5/b+lrF2SVeVFl8Ycn40YhipSdnY/4JbOYhn08CCMlTG6xkGMP4ZKywA==
X-Received: by 2002:a05:6402:1a48:b0:461:900a:7f0d with SMTP id bf8-20020a0564021a4800b00461900a7f0dmr60480772edb.125.1668015661094;
        Wed, 09 Nov 2022 09:41:01 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906318d00b00734bfab4d59sm6244899ejy.170.2022.11.09.09.40.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 09:41:00 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id o4so26895843wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:40:59 -0800 (PST)
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id
 o8-20020a5d6488000000b0022b3b0b5e72mr39666063wri.138.1668015659395; Wed, 09
 Nov 2022 09:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20221109055132.609-1-quic_sibis@quicinc.com>
In-Reply-To: <20221109055132.609-1-quic_sibis@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Nov 2022 09:40:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wdrb27XCmj+VoNXtvFOYHGPkWXJujzZogzLK2ZMWgxTw@mail.gmail.com>
Message-ID: <CAD=FV=Wdrb27XCmj+VoNXtvFOYHGPkWXJujzZogzLK2ZMWgxTw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] arm64: dts: qcom: sc7280: Mark all Qualcomm
 reference boards as LTE
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     bjorn.andersson@linaro.org, jinghung.chen3@hotmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 8, 2022 at 9:51 PM Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> When the modem node was re-located to a separate LTE source file
> "sc7280-herobrine-lte-sku.dtsi", some of the previous LTE users
> weren't marked appropriately. Fix this by marking all Qualcomm
> reference devices as LTE.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Fixes: d42fae738f3a ("arm64: dts: qcom: Add LTE SKUs for sc7280-villager family")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>
> v3:
>  * Fix incorrect tag usage [Krzysztof]
>
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 4884647a8a95..ca09367abb6c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -13,6 +13,7 @@
>  #include "pmk8350.dtsi"
>
>  #include "sc7280-chrome-common.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"

I think you need to _remove_ the include from the "idp.dts" file now,
right? Otherwise it gets included twice.
