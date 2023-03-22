Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F996C5393
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCVSUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCVSU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:20:29 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B586285B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:20:28 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r16so23791649qtx.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679509227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh/hJeo7sTFkQ4LaRklYoR/MA7aBfNbUpjc0I8W6RK8=;
        b=W+z5m6In7PqwMRSiq1TNm1XFYVDrKqqe7P8p+/flnqSneQNMCbQiC92lEpDN6kOgla
         V2tkkf5gtrzvoUwb5vWCJXQnZ2KAY1vUFfCY5oFk+T07hP8MGscoCOmkkFE19beCo0n7
         xbFtos8Mk+9fLRyty/CWHMuIVU/TSgDFWrlwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uh/hJeo7sTFkQ4LaRklYoR/MA7aBfNbUpjc0I8W6RK8=;
        b=A7V7YBk8Tp8AgOsI6Aeh+pvNr2NT3M4nVGh1MpAME55GgJe9MadY0m1jhtfamHhomk
         SAxUdLGh5B6uTZwoWMovKiVQLK4YCwVqfJPWQjWt7HteTQYKIixXLN4QCAHZ+36WnPr/
         DIzYe3ICNi7BkMnFmcgMYzUREy45fUBnQHSSUC7lPFeupsgX/rLak33tSZWMiFMZR56F
         uwfPazxW1jPEw47NgP10QtaFfouUfXO+4R0JafPP5J6EpMpRkFsahRVL2bMqXygv7DlH
         MvA6mWyHTAQMPU+g1Y65Jmm6XVT9nvsc8XY6EQnCvgic3EpqPt/n0XdUVvaNz9Tig2cT
         WOpw==
X-Gm-Message-State: AO0yUKWk0tOs42Oj1w0chCh2GJLD1S79HJFcq2/DwWRxuQO7QjLQ5lc4
        m1VMnRbv7HL89xcmRrlUpmpVnAk3xFwv0ZhVrmY=
X-Google-Smtp-Source: AK7set9Mon+rFMCLQWL7ZDqrTIp56M03tb7jARIf1F2+vEdvhH5f/RTVqHaMFH/FMvz2CpIvD8V9QA==
X-Received: by 2002:ac8:7f43:0:b0:3bf:d9ee:8814 with SMTP id g3-20020ac87f43000000b003bfd9ee8814mr8518457qtk.17.1679509227441;
        Wed, 22 Mar 2023 11:20:27 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id g19-20020a05620a40d300b007290be5557bsm11868544qko.38.2023.03.22.11.20.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 11:20:27 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id x198so12391871ybe.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:20:27 -0700 (PDT)
X-Received: by 2002:a05:6902:1546:b0:b74:6c88:7bff with SMTP id
 r6-20020a056902154600b00b746c887bffmr357158ybu.0.1679509226666; Wed, 22 Mar
 2023 11:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230220095401.64196-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220095401.64196-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Mar 2023 11:20:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoSWOYuG5K9wcoPXC-490N9yP+JLkg3Nt+JEHvnRdwNg@mail.gmail.com>
Message-ID: <CAD=FV=XoSWOYuG5K9wcoPXC-490N9yP+JLkg3Nt+JEHvnRdwNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7280-idp: drop incorrect
 dai-cells from WCD938x SDW
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 20, 2023 at 1:54=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The WCD938x audio codec Soundwire interface part is not a DAI and does
> not allow sound-dai-cells:
>
>   sc7280-idp.dtb: codec@0,4: '#sound-dai-cells' does not match any of the=
 regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 2 --
>  1 file changed, 2 deletions(-)

I'm pretty soundwire ignorant but this looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Seems like folks who were involved in landing the patch that
originally added those properties should be CCed on this, though.
Adding them.
