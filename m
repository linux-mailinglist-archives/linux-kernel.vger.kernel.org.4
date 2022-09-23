Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A05E85AB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIWWPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWWPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:15:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6254CEEB72
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:15:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k10so2327024lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MjCIyVdNYTTKoVP4OLhW9xb+LVRJMI4IX/LyQztjHfk=;
        b=kHahx/UiGoRabYsHqSdNGerJopUg3qLNerV0gP8BGZNyPpFBTKJKBOOTPuJQY3qpyt
         KX4UQe6BGRb5PTDAmfRmbbpLtmT2ZEsyv+bYu0wvIulGGlmV5fhB7fXPCkqVhNj+JZaa
         7kt33yzmC36KDZeTuf3xRpqjuFM2SofHQSTIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MjCIyVdNYTTKoVP4OLhW9xb+LVRJMI4IX/LyQztjHfk=;
        b=SUL6Bk7ALeRtYyOL2eU01tMvI9oJNMdULi9jfOIN1mncRf0eAxFxQ6ASgESOrfeZpu
         ickzKi6wOLiopaxBnE3JoOO8JwyIUKgCGNqOmM27/cxSFc9wV0D8jqfpJbHPdekcDXVi
         syPTM+NjUynqOyuqcovrYllTnrAkB8mO6PdX1e6Ylew59pDUG9B2ecxQUS0r3TVsqrCn
         FXr2RaIbMYWm9/GhFgNdjsR5JnTVL9uhhfcEcZ67hOjjQzxKkvA9cStYREtUcL4OqFm3
         Ggb8DkToULgH6Z6VyXeifz2jwZvpBS5Et/ENLlYvvegrgQyKQnQPYmyc8Rho0N2fW1l5
         mTFw==
X-Gm-Message-State: ACrzQf022gjAW63LtJeKllQEboHrr/DYoZDAazow9mQvu7RE5gtU+gvt
        8FA/CPuC/2s9U3LJ5bA5Utc/QQr+ltT4hPYDnCM=
X-Google-Smtp-Source: AMsMyM6IttRRCWxa+Mwjxr5UicVpIRPOGIXxGKOJ60qfVmXfQ3atYctP7/9pWuyY7NTNtNTnYhEMJQ==
X-Received: by 2002:a05:6512:eaa:b0:497:a1ed:6fa5 with SMTP id bi42-20020a0565120eaa00b00497a1ed6fa5mr3875961lfb.108.1663971345521;
        Fri, 23 Sep 2022 15:15:45 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b0049487818dd9sm1632970lfq.60.2022.09.23.15.15.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 15:15:45 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id z25so2347882lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:15:45 -0700 (PDT)
X-Received: by 2002:a05:6000:168c:b0:226:f4c2:d6db with SMTP id
 y12-20020a056000168c00b00226f4c2d6dbmr6348292wrd.659.1663970856526; Fri, 23
 Sep 2022 15:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220923140918.2825043-1-judyhsiao@chromium.org>
In-Reply-To: <20220923140918.2825043-1-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Sep 2022 15:07:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UABpfLRehYT78mPdzgwVBhV_-uBQnkrtbbDbUH-6o8tg@mail.gmail.com>
Message-ID: <CAD=FV=UABpfLRehYT78mPdzgwVBhV_-uBQnkrtbbDbUH-6o8tg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add dtsi for sc7280 boards that using rt5682
To:     Judy Hsiao <judyhsiao@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Fri, Sep 23, 2022 at 7:09 AM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Put sound node and lpass_cpu node settings for boards that use rt5682
> codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
> choices of headset codec for herobrine projects. Common audio setting
> for the internal speaker is in sc7280-herobrine.dtsi.
>
> Change Since V4
> - Rebase and include sc7280-herobrine-villager-r0.dts change.
>
> Changes Since V3:
> - Remove Change-Id in the commit message.
> - Add dependency in cover letter.
>
> Changes Since V2:
> - Fix sc7280-herobrine-audio-rt5682.dtsi syntax.
>
> Changes Since V1:
> - Not to include the herobrine-villager-r0.dts changes in this patch
>   series to avoid conflict.
>
> Judy Hsiao (3):
>   arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
>   arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
>   arm64: dts: qcom: sc7280: Include sc7280-herobrine-audio-rt5682.dtsi
>     in herobrine-r1 and villager-r0
>
>  .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 122 ++++++++++++++++++
>  .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
>  .../dts/qcom/sc7280-herobrine-villager-r0.dts |   1 +
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  30 +++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

Please sync the Qualcomm tree upstream. I can tell you didn't since
you had the wrong email address for Bjorn. Mailmap should have
converted it to the kernel.org one.

In any case, with the correct address for Bjorn, I'd note that I think
this patch series is ready to land if you're planning a 2nd pull
request this cycle.

-Doug
