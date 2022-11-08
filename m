Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1040B6204AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiKHA3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiKHA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:29:49 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEEF9FC4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:29:48 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k2so34588474ejr.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 16:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5MkQztElB6TBdZbZej/oORtZzWsfAyi0xB0CiV9UFEI=;
        b=dVe12lYAU0SpAJWVx0uFcqp08jjA3Nhr9V6bc7LC/oCcDrD3Hh/bCv/34I+pspFOqT
         5mx3a0rT8zyNldmpRxc+zAeUD4LZ0sogf18nIlBYBrqr4HI6kylHMbPhwS5c6RBfGFA4
         k9uW76Jj3u+2jSGqDZlRvdJYbM20B+5TVERtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MkQztElB6TBdZbZej/oORtZzWsfAyi0xB0CiV9UFEI=;
        b=Pr4aX6qH3y3rV3+ikVE3/vGe3mc1kDUu3O66NF6tRK8bYhZLC4zsST/JCllq/1jQNF
         nhPrkK/V6s1hir/LOU5Qvuu+GeJKZ8HstL/Gqigypww/FOdDpp1Gl65pgd9v0Bmk/Zqg
         BRqBu80xY3PY6PF9QylVWY7hbkfldh81qUBHERTpK9GjqgCvwitlEuEe46Dqm4Yn9U5U
         Qy9QDkTaVR4pUNwCbHQMx7wW4jpyTHUQlICGJPNnbwWFm07vetx/cj16NRp5a9Mf6t7s
         gaH2/67GOsSBW53PIsLe33z8G1YD+bjbMLNIcm5nqO/IGaVx/N1nglQ7ncyO0XKecdVI
         ZQcg==
X-Gm-Message-State: ACrzQf3Eq8V8BlzYlP5F31m35Q74GyiTcawU659skdNgAeAFCNqs1sWU
        0osNRW+xADF6xaWNWZG4nMLj+O94sQY9XPLi
X-Google-Smtp-Source: AMsMyM6QlgPsHyjw734kZWViNqwKem9qhOOQ8XIOs/fRQhF6YggQKEKc+z8NHOgG7XCU7s79Yohjqg==
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id nd15-20020a170907628f00b0072f58fc3815mr49610588ejc.719.1667867386130;
        Mon, 07 Nov 2022 16:29:46 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id k14-20020a056402048e00b00456c6b4b777sm4869365edv.69.2022.11.07.16.29.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 16:29:45 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id o4so18605911wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 16:29:45 -0800 (PST)
X-Received: by 2002:adf:d1ec:0:b0:236:880f:2adf with SMTP id
 g12-20020adfd1ec000000b00236880f2adfmr33865581wrd.617.1667867058306; Mon, 07
 Nov 2022 16:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org> <20221107235654.1769462-14-bryan.odonoghue@linaro.org>
In-Reply-To: <20221107235654.1769462-14-bryan.odonoghue@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Nov 2022 16:24:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XZ79JjmCW7wYoc0eEhMsAtqxb+p40x2f4mH+kdb0byow@mail.gmail.com>
Message-ID: <CAD=FV=XZ79JjmCW7wYoc0eEhMsAtqxb+p40x2f4mH+kdb0byow@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] arm64: dts: qcom: sc7180: Add compat qcom,mdss-dsi-ctrl-sc7180
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
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

On Mon, Nov 7, 2022 at 3:57 PM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> Add silicon specific compatible qcom,mdss-dsi-ctrl-sc7180 to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for sc7180 against the yaml documentation.
>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index d2c374e9d8c03..07acb7f843d62 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2985,7 +2985,8 @@ opp-460000000 {
>                         };
>
>                         dsi0: dsi@ae94000 {
> -                               compatible = "qcom,mdss-dsi-ctrl";
> +                               compatible = "qcom,mdss-dsi-ctrl-sc7180",
> +                                            "qcom,mdss-dsi-ctrl";

This seems fine, but I don't think it matches your bindings. Your
bindings says you can have one compatible string. It could be
"qcom,mdss-dsi-ctrl-sc7180" or it could be "qcom,mdss-dsi-ctrl".
...but your device tree has two compatible strings: the SoC specific
one and the fallback one. You need to change your bindings to make
this work.

-Doug
