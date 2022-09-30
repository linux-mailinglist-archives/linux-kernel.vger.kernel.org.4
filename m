Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9CF5F1383
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiI3UTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiI3UTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:19:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C81277A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:19:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b2so11306731eja.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OCnebJynSrbcXhmt2sFtynLekZNoI+ENUjG4/Iv4I8g=;
        b=bxPqEInaZEWWzFT8rVnv4HClcvizZtxYsL1G2Gy7PfaelpNFzp1M3jaeahTlo2RIqU
         q3ouehTqScAN00/Z0FdJ4FzOTaRyVLbR95nVg+8o4s5Ev9iQDr/TerW6WEGAdbZx0dqX
         SlafXHF+VptrzpSSqKu/ergwarlgNwfpQI7SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OCnebJynSrbcXhmt2sFtynLekZNoI+ENUjG4/Iv4I8g=;
        b=06aeqHpFRLPDb27esatFUV6zg6K71hiQJad5tI4ZeDfo57OtuuZhX12mi9D3pdoglM
         2mZ1BnmI0ia29mFWUrnM7nFYS8sSpMZOHphbWySID7uPpgP5yrmenOLXno45g4MIAzmg
         QVvB9iEHwrrYwGKjjqXDZnsKOqsRSjsV9rWTn4iLOD1cS/2Jvled7AI0QOS5UX6KaEEQ
         3YhNRzfg1GiOHGgCG1ChEm7xw7VCOP0SsNEzGWGyGiE+ip/06ndREt3pkn7kWhEiFZFY
         rhu0pvnRQcio+xQAzmWNLzPNiDKLHk+4B+BWKSPITCi/q6J7PbqLA5B289FfhEYLkdPx
         pb4A==
X-Gm-Message-State: ACrzQf1RznxwahO1aWZdE1vb+VBv5yDgVhX0oZu7wJujCLXpx8oFdrI/
        iNN3D0r8gCQqHcouXYu8qt2O8lDIcRYqg8jr
X-Google-Smtp-Source: AMsMyM6mRCIXve20ba8+g/zN7Vkx2xirCTRehtXU01Hh4VYLkE4dk/IINBnknVS5RPERRUtwBu//4w==
X-Received: by 2002:a17:907:a05:b0:77b:b538:6476 with SMTP id bb5-20020a1709070a0500b0077bb5386476mr7770030ejc.324.1664569178425;
        Fri, 30 Sep 2022 13:19:38 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id au16-20020a170907093000b00773dbdd8205sm1598881ejc.168.2022.09.30.13.19.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 13:19:37 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id b4so1470961wrs.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:19:36 -0700 (PDT)
X-Received: by 2002:a5d:6c62:0:b0:22a:2f59:cb7d with SMTP id
 r2-20020a5d6c62000000b0022a2f59cb7dmr6839764wrz.405.1664569175910; Fri, 30
 Sep 2022 13:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220930182212.209804-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930182212.209804-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Sep 2022 13:19:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WHmGi0yxFNbdQ=BXjypDWkW9iS3jBnr2gUhTa5qch90Q@mail.gmail.com>
Message-ID: <CAD=FV=WHmGi0yxFNbdQ=BXjypDWkW9iS3jBnr2gUhTa5qch90Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm630: fix UART1 pin bias
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 30, 2022 at 11:22 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There is no "bias-no-pull" property.  Assume intentions were disabling
> bias.
>
> Fixes: b190fb010664 ("arm64: dts: qcom: sdm630: Add sdm630 dts file")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested on hardware.
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This does change behavior and has the potential to break someone.
Thus, without a bug report or someone to give a tested-by I'm at least
moderately worried about this going to stable@

I would also note that convention on Qualcomm SoCs that I've worked on
was that bias shouldn't be specified in the SoC dtsi file and should
be left to board files. This is talked a bit about in a previous email
thread [1].

That being said, it does look like this was the intention of the
original commit, so thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
