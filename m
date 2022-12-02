Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A3640891
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiLBOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiLBOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:37:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A93D220D2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:37:10 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vp12so11986569ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R7S1hXfJrdA2OO05qT0bVLolHIgquQtzY/qiJ0ELKso=;
        b=iFbV+ZBpq8wDqSDeD0899VZYy/j7fXEh0JVZ4Ka/doaR3TEJKeRuxWUCeWOlPa2fPr
         abC1KxI3WehkC31cOilHKIqbJIsG5th63gllZOJqo10ba+MTr51kqHv2Anx6CKgXJwY1
         Qn/K+41ta0ATg6z/bJC9YrqtPWaQT/RDRGo7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7S1hXfJrdA2OO05qT0bVLolHIgquQtzY/qiJ0ELKso=;
        b=A92s9KNQISx5Mc4kF6LFX6vrIpO23hOBjaepiSaqjq60pMFj8M3htvXD50WFIqhAGk
         QTXElEUBgGx9IWhvI84G75Ix9xxPGndh+gssLN/YvQO0xFAbPbbmSGJjP1XnJjQNSL4b
         XFg+RaQ5v3/cl0Uyx6oZ7vwmr9NKZ8p3Cm/SRBgsFi9iDikvO61VW9osM8uPzGHVxHcA
         yRsMhkXhjt81cQI7OcY4qVXk+d0Y4J6UIB9ioardQ6cQK6gg3k7lwOxuirjCN6Ilklx8
         KWfGM5e1zYTpFqNqbb9eKKuQYXb9IkWmIcaRec9PAS8TALVl3VIgpehQAURMNy5O1Gag
         Zaig==
X-Gm-Message-State: ANoB5pk0Hfbffr7X6LGnUaJRjg1YAODU2sG62wTVDP0U0W6K0DXSGHz7
        E3oUlbH4YsWiiX82M13pQ3o7ERPZHfDndrNKM5s=
X-Google-Smtp-Source: AA0mqf6g8p8aO+wBRpj9UqnDoICu6gq6Fmhi2QTB3huj0gd9k4sMKcKEFeDJFqUsuXHecb/Idl8ggA==
X-Received: by 2002:a17:906:d1cc:b0:7c0:ae21:f1ff with SMTP id bs12-20020a170906d1cc00b007c0ae21f1ffmr7130084ejb.318.1669991828612;
        Fri, 02 Dec 2022 06:37:08 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7d492000000b004615e1bbaf4sm2986313edr.87.2022.12.02.06.37.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 06:37:07 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso4428819wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:37:07 -0800 (PST)
X-Received: by 2002:a05:600c:3c8e:b0:3d0:69f4:d3d0 with SMTP id
 bg14-20020a05600c3c8e00b003d069f4d3d0mr12058890wmb.93.1669991827159; Fri, 02
 Dec 2022 06:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org>
 <20221118164201.321147-2-krzysztof.kozlowski@linaro.org> <CAD=FV=XeaskcBRVRQDoha7Xiv9j57fuvtcSJUeN7HCZSGVJ8uQ@mail.gmail.com>
 <68bcdf25-e8e3-f817-f213-efb0bce3f43a@linaro.org>
In-Reply-To: <68bcdf25-e8e3-f817-f213-efb0bce3f43a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Dec 2022 06:36:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WBNpeWK31dCgzX5QAuR7AySkp_dEyY8WK3o8+SaiPxOg@mail.gmail.com>
Message-ID: <CAD=FV=WBNpeWK31dCgzX5QAuR7AySkp_dEyY8WK3o8+SaiPxOg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 2/2] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Fritz Koenig <frkoenig@google.com>
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

On Fri, Dec 2, 2022 at 12:15 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> >>                         qup_uart6_4pin: qup-uart6-4pin-state {
> >> -
> >> -                               cts-pins {
> >> +                               qup_uart6_4pin_cts: cts-pins {
> >>                                         pins = "gpio45";
> >>                                         function = "qup6";
> >> -                                       bias-pull-down;
> >
> > After your patch, where is the above bias set for cheza, db845c,
> > oneplus, shift-axolotl, ...?
> >
> >
> >>                                 };
> >>
> >> -                               rts-tx-pins {
> >> +                               qup_uart6_4pin_rts_tx: rts-tx-pins {
> >>                                         pins = "gpio46", "gpio47";
> >>                                         function = "qup6";
> >> -                                       drive-strength = <2>;
> >> -                                       bias-disable;
> >
> > After your patch, where is the above bias / drive-strength set?
>
> They don't use 4-pin setup. If they use, I would assume they will
> override the entries just like sdm850 boards (where I override it to set
> these).
>
> Alternatively I can keep it in DTSI, but it is not really property of
> the SoC.

I see things like:

.../sdm845-cheza.dtsi:     pinctrl-0 = <&qup_uart6_4pin>;

...before your patch that would get the bias/drive strength from the
SoC dtsi, right? After your patch, you've removed it from the dtsi but
not added it to the board. ...so I think it's a net change. Did I mess
up / miss something?
