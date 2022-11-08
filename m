Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605DE6219BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiKHQss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiKHQsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:48:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F175317E9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:48:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n12so40084181eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMec66hp71TWs3o/wo3ARGg7ftBfO6FZm4lMQC+qaXY=;
        b=nygImnQwy/qQBpMTVv9i4AovKSBGIzVmc80uHobnTNMdDla+vBeLabbqi2Z8dx3NvM
         NRjIiF4VLgItz+pOl8NoCU2nR2oDURxS0PC5rY68adCIChLjv+dLkHLAKmAdX0YzADBw
         0IHXv6p9tFzZcUIxXCoIPgNpgHk016810nb2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMec66hp71TWs3o/wo3ARGg7ftBfO6FZm4lMQC+qaXY=;
        b=q69os7FJvlJoRwaKXg5bRezWmlw2MpNM0clV8dzQhjgXCCDnLJihvwlQmaK9t35E5n
         /N6TcUkxIeRB/xbfjwC1BIsBsW3cBR08JFKdGHGOqx9amlc91wWU+Hq25OgbCV3bg83S
         XTMO3i2xqQsdqY2fCSWVa+pQsgGYtLBE0tBE+97Vz/IHXeQLXyorwMZS79TqRA2u71ll
         p40NKD1Osw2KXW+R0Rvau42QUngGIxCAtzeXByC2/xOwO/tlKz4hhwkTonrqoZlxbPN1
         9O8QSoB4XFFABIthgvff3qe4tv0Kfd9w6dZ4tmowS98ZtZNtLjRWzLYyi/R2MgGxrD4n
         poYA==
X-Gm-Message-State: ANoB5pntWQdd15Jq2nKfJugI+e4HQsQFvDen/mwF3i1OAi+Ti3+Zg1tF
        K2Px9FeoVVR0z2rT8yZ5G74aRTK+n8aeAVmR
X-Google-Smtp-Source: AA0mqf5sr7zoAagWCKXv5A/umkpaMAXR0nUrW4z4oRvoSfdcQfqdp1oyAPYRFETBecnCJWzmNKoL1g==
X-Received: by 2002:a17:907:2179:b0:7ae:6bcd:d0cf with SMTP id rl25-20020a170907217900b007ae6bcdd0cfmr9623833ejb.428.1667926123333;
        Tue, 08 Nov 2022 08:48:43 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id f24-20020a056402069800b00458a03203b1sm5784217edy.31.2022.11.08.08.48.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 08:48:42 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id y16so21836845wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:48:42 -0800 (PST)
X-Received: by 2002:a5d:4410:0:b0:236:a8f9:268f with SMTP id
 z16-20020a5d4410000000b00236a8f9268fmr36396106wrq.405.1667925766971; Tue, 08
 Nov 2022 08:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20221107235654.1769462-1-bryan.odonoghue@linaro.org> <20221107235654.1769462-18-bryan.odonoghue@linaro.org>
In-Reply-To: <20221107235654.1769462-18-bryan.odonoghue@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Nov 2022 08:42:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VL5C86kA0Z3fMu-uVwKmKj5CGuNmWeCuwOTbXi-7xKaQ@mail.gmail.com>
Message-ID: <CAD=FV=VL5C86kA0Z3fMu-uVwKmKj5CGuNmWeCuwOTbXi-7xKaQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] arm64: dts: qcom: sdm845: Add compat qcom,mdss-dsi-ctrl-sdm845
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, quic_mkrishn@quicinc.com,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
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
> Add silicon specific compatible qcom,mdss-dsi-ctrl-sdm845 to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for sdm845 against the yaml documentation.
>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
