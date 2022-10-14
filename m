Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0F5FF32C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJNRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJNRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:51:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86E1BE916
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:51:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a13so7925602edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BRzfRKDxaeHVs/GEuc3GGv5B2DGMz09Y1rLFxYGdPvQ=;
        b=I3Yc27ujyXHn3kpemFL/t4UfgZ6B6RErsnMNAgfreS3Cunh0XiPoSf9816h489ap+X
         mvPVmo5Ne8pI0UiM2yQ3NvBnVcye05CPWEbXR9zUG6eysQiFII9iSDIMjRcXDiHOCUSk
         jbsqcRBowfBAGQobB0S3A7J3aY61u0YLMFd/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRzfRKDxaeHVs/GEuc3GGv5B2DGMz09Y1rLFxYGdPvQ=;
        b=jteJtOaQLTYnTFGjKvcrXA7vbs0+H5AjglLhtRr7OcLMfD8D52hf7EW/YPmKESi0Jw
         qtvSv48keWwCcJSxf5ckY4Gj0ATaJgFpHR0sOzFfmEO0Jr1BQBx2QX21B9IUQvjYhFOn
         9GHBJal0UoLgYwX7xCmn+HdS3QAg+qjFMoHHRokq0xF8IN2PDmrWuPE7dk3BhiOktjB9
         PAJF6cM7QxBiddQA9DZoOxxt7lHMx31SYoR0DHEzscTvkYk8UohkaXsbl8fE+R3+EQZC
         gy/WsDIoMINJmTxLqodqI4bcz76tLGDem+kctK69EihrP4ek/y9lTJ6xzvpArzYRgTTA
         KZbg==
X-Gm-Message-State: ACrzQf2uVsAmzcpFCgXtBmseooQn2xuhh1zrPLnszXx1qCjmtRnEiX81
        MgwfeOKJYuhW15dAS7u5u5HvPxbViMuB+dfT
X-Google-Smtp-Source: AMsMyM7XAwAg4gBbSnQDpcYk5MBkc8bW647pKLgMRPrhU50NdKYDsM87FceEauugUw+xfiSO1XUFow==
X-Received: by 2002:a05:6402:26c2:b0:45c:1fef:ee1d with SMTP id x2-20020a05640226c200b0045c1fefee1dmr5166950edd.13.1665769894262;
        Fri, 14 Oct 2022 10:51:34 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906228a00b0078bfe57fc7bsm1859332eja.47.2022.10.14.10.51.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 10:51:33 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id j16so8724039wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:51:32 -0700 (PDT)
X-Received: by 2002:adf:dd0c:0:b0:22e:4bf6:6c08 with SMTP id
 a12-20020adfdd0c000000b0022e4bf66c08mr4224068wrm.617.1665769892087; Fri, 14
 Oct 2022 10:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221013184700.87260-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221013184700.87260-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Oct 2022 10:51:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9ofaQJSHaLoU=HVyOvezMjFQ7HeqMVcCaEjYBn9U5zg@mail.gmail.com>
Message-ID: <CAD=FV=V9ofaQJSHaLoU=HVyOvezMjFQ7HeqMVcCaEjYBn9U5zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7180-trogdor-homestar: fully
 configure secondary I2S pins
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 13, 2022 at 11:49 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The Trogdor Homestar DTSI adds additional GPIO52 pin to secondary I2S pins
> ("sec_mi2s_active") and configures it to "mi2s_1" function.
>
> The Trogdor DTSI (which is included by Homestar) configures drive
> strength and bias for all "sec_mi2s_active" pins, thus the intention was
> to apply this configuration also to GPIO52 on Homestar.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Fixes: be0416a3f917 ("arm64: dts: qcom: Add sc7180-trogdor-homestar")

> ---
>
> Changes since v1:
> 1. New patch
>
> Not tested on hardware.
>
> Cc: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> index 1bd6c7dcd9e9..bfab67f4a7c9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> @@ -194,6 +194,12 @@ pinmux {
>                 pins = "gpio49", "gpio50", "gpio51", "gpio52";
>                 function = "mi2s_1";
>         };
> +
> +       pinconf {
> +               pins = "gpio49", "gpio50", "gpio51", "gpio52";
> +               drive-strength = <2>;
> +               bias-pull-down;
> +       };

Personally I wouldn't have replicated the "drive-strength" and
"bias-pull-down" here (nor would I have replicated the "function =
"mi2s_1"" in the node above but I didn't notice it before). ...but it
doesn't really hurt, the resulting dtb (after combining all includes)
isn't changed, and you've about to clean this up in your next patch.

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
