Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05148640897
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiLBOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiLBOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:38:29 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2F85C0C5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:38:28 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so11963818ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGY6WkT4lRuXaZzdlQnZdGGZzLB2sng4XfKDkywn0jw=;
        b=FpCfeMTD2EZbG+mTWjfqX3lVMRGEWAZfQorccOoXyuf8d2BQchQ7uk5E07hW/9GL07
         SKyA3TwOxE7I5E0WFP4wLPF6M4oX4RBIQtoSyYHmUgCiSZGN97onFVIfLRUzEOmHT8OB
         3nUePhQjN7eie9jW0mEXtJShB0YsHewywd9Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGY6WkT4lRuXaZzdlQnZdGGZzLB2sng4XfKDkywn0jw=;
        b=M/ebb9+qYrdD55Ps9Igd1AaamSsB7gx7MjFU86Lwbii9gjscO2Wivqvm0ZwS2MX6ey
         CkgLHyq5HhHaRn2oYsTqPywT4R/DJA8nAMwqce9SXcM6XjzrmHsrExlZ6PplDJnHpIZM
         +vuKhcRwUgIuDDy6EDYgOuOxG0tYBZ6zwC94Qr0596RECPFC/lA2eCmGKg5Vpcya5xb0
         Ezbq6WHCqGtHo5fVkxak/2ei9vh2BwwyQnGx7hZrY2BfUErIraLM5ZRj9mmbKWW9D2Wa
         mOu6yXMps5SBslRjl6oRp0Zz++bXydHw3nba7KWP/H011Rtijd8ZFjOkCfW1t0yRianc
         c8Gg==
X-Gm-Message-State: ANoB5pmqJgwy79BxL/bHM6VHgPUCTHzIndd9GMwj9SjNnjUCUtJ5KkAI
        TFnArsIYUVonlCvu5sFuheHGM6rZeNaRHEf3AkQ=
X-Google-Smtp-Source: AA0mqf47PEMDKwNO6Bho58Hy29OxYc3s0Z7w0iMCM8Fl6XXJd6ULXr06oo0T4sDZ7ClI0FcZjxgV2A==
X-Received: by 2002:a17:907:d042:b0:78c:c893:1965 with SMTP id vb2-20020a170907d04200b0078cc8931965mr7382678ejc.247.1669991907324;
        Fri, 02 Dec 2022 06:38:27 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id jt10-20020a170906dfca00b007a9a56e2a07sm3064211ejc.49.2022.12.02.06.38.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 06:38:25 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id d1so8056028wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:38:25 -0800 (PST)
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id
 c12-20020adffb4c000000b002365270735emr32762102wrs.659.1669991904737; Fri, 02
 Dec 2022 06:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org>
 <CAD=FV=Vo9zbsjgYEn0eBkC8eKRceg6v4u1g=w6nSYHNctFQWxg@mail.gmail.com> <ca4693a5-e941-a2c9-b023-42a91589dad6@linaro.org>
In-Reply-To: <ca4693a5-e941-a2c9-b023-42a91589dad6@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Dec 2022 06:38:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VCJA0v-EpT9YyCRZg07QzGeH9PGcNcO=j=x0e9XeHtHQ@mail.gmail.com>
Message-ID: <CAD=FV=VCJA0v-EpT9YyCRZg07QzGeH9PGcNcO=j=x0e9XeHtHQ@mail.gmail.com>
Subject: Re: [RFT PATCH v2 1/2] arm64: dts: qcom: sdm845-db845c: drop unneeded qup_spi0_default
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 2, 2022 at 12:17 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/12/2022 01:49, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Nov 18, 2022 at 8:42 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> The qup_spi0_default pin override is exactly the same as one already in
> >> sdm845.dtsi.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Cc: Doug Anderson <dianders@chromium.org>
> >>
> >> Changes since v1:
> >> 1. New patch.
> >> ---
> >>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 --------
> >>  1 file changed, 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> >> index 02dcf75c0745..56a7afb697ed 100644
> >> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> >> @@ -1274,11 +1274,3 @@ ov7251_ep: endpoint {
> >>                 };
> >>         };
> >>  };
> >> -
> >> -/* PINCTRL - additions to nodes defined in sdm845.dtsi */
> >> -&qup_spi0_default {
> >> -       config {
> >> -               drive-strength = <6>;
> >> -               bias-disable;
> >> -       };
> >> -};
> >
> > I guess it's more of a question for what Bjorn thinks, but I view the
> > fact that the drive-strength / bias are in the dtsi file to begin with
> > as more as a bug in commit 8f6e20adaaf3 ("arm64: dts: qcom: sdm845:
> > enable dma for spi"), which is where these properties were introduced
> > to sdm845.dtsi.
> >
> > The historical guidance from Bjorn was that things like
> > "drive-strength" and "bias" didn't belong in the SoC dtsi file. Later
> > we came to an agreement that it could be OK to put drive-strength in
> > the SoC dtsi file but that bias was still problematic because it meant
> > ugly "/delete-property/" stuff in the board dtsi files [1].
>
> So let's move it from DTSI to all boards? Although what if the board
> does not use SPI0?

You'd look for boards that set spi0's status to "okay" and those
boards would be the ones to have it in their dtsi.

-Doug
