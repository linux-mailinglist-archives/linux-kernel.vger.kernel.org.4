Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6286219AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiKHQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiKHQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:41:59 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5CA57B50
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:41:58 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k2so40162974ejr.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JAuu4hWloYmftBKHb/d+/mSKClNOAP3hfPN38eMhM00=;
        b=ZMIJpDBTGymi73YrPFNDvi2rGWDySW0Kd9h0+KHCimcFqASahQoW5nTZcBF508L018
         8xtPVYDlnFYpkmLiVpZWmtDMxNdUntN3QiwlBsfgfIm0O4AYoci8I+aHOEXKlWKnaeig
         zT3nFZD+5XTHmnIaoPUtapkA4RHxF/xAEH4NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAuu4hWloYmftBKHb/d+/mSKClNOAP3hfPN38eMhM00=;
        b=yz+5e7bH5+A1hgW6gx9rDMGw2R9km7qNqTPx7I1BzPyeNdmomIYLMcbPg8E34rfWMX
         wh0dh/SvPWE6nHI04EdDP/4czhzUDh364ypLDm5rK5INgb7HHFu7jW0iIEK0ZglbNFJ1
         i9yT4JdU/IGpnDQcrmHlyn6yvF/DXQvO8MER+kAX6ExRhjh6Jia5shiPjWWLU+0OlJhx
         TNI3/ulecHD6Q33HD+YDLqBXUza2xwVhJJM+TmGcgvDs8Tbx+etvPKnE4xydXrKx4PAI
         oYtKFUnK1qekAZVeVtfn/g1dbp6VWzDCD0nj3GHjRKmOCPfgIjnTd3DrINzCRW3iTrok
         fIaA==
X-Gm-Message-State: ANoB5pnkenoeNUQlGrvgeDwl1B6AisoSKmPappxM3jvigjLbJdaZtXIn
        Wy++Ye8k2Z5OjwkuLZsJjG32N61AxawtMyFT
X-Google-Smtp-Source: AA0mqf5+7Muvw7yYGP2j2hpzzNbFeXPg8HZJcU0fRskfBrNfosv6qCu5wkoZzezp0+gSNqshzqIZBA==
X-Received: by 2002:a17:907:7422:b0:7ae:7993:ae06 with SMTP id gj34-20020a170907742200b007ae7993ae06mr5104757ejc.226.1667925717493;
        Tue, 08 Nov 2022 08:41:57 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709064a1300b007ad9adabcd4sm4803407eju.213.2022.11.08.08.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 08:41:52 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id o4so21887757wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:41:49 -0800 (PST)
X-Received: by 2002:a5d:6488:0:b0:22b:3b0b:5e72 with SMTP id
 o8-20020a5d6488000000b0022b3b0b5e72mr36416288wri.138.1667925709225; Tue, 08
 Nov 2022 08:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org> <20221107235654.1769462-15-bryan.odonoghue@linaro.org>
In-Reply-To: <20221107235654.1769462-15-bryan.odonoghue@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Nov 2022 08:41:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XToQPNKwvY0K3kr0c+zAdTSsR2fvzHZJxa8ryJtC8xFQ@mail.gmail.com>
Message-ID: <CAD=FV=XToQPNKwvY0K3kr0c+zAdTSsR2fvzHZJxa8ryJtC8xFQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] arm64: dts: qcom: sc7280: Add compat qcom,mdss-dsi-ctrl-sc7280
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
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

On Mon, Nov 7, 2022 at 3:57 PM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> Add silicon specific compatible qcom,mdss-dsi-ctrl-sc7280 to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for sc7280 against the yaml documentation.
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
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
