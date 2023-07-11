Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212F74F213
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGKOXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjGKOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E07019BE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b71ae5fa2fso40463961fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085321; x=1691677321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SGKxGE8WoMQ/68eSd1pAXEY4H4AMGjzzA6a9FWvKkU=;
        b=zOwfN48ZszaDqyrw2SvBlJDdymz0lrnHO5hyporS0BJrFVxWXGuqgfZKR8KtZ784sx
         pWiEwrxiZxO3yUMwRMc96fJ7MSPr5VbDoCLoIbXd8bbk48883lW2zEz64te28HVAUDOd
         ua3XZnqJfgQbrkG8eZMZSnrJEyf9vd7B5U7eCvdX+79mHDGZiXm5sqTXJ+gE4RV3PYRk
         IrRD9/spbkmL4Kr1K6b2/93SA0+u1VltcAwOMz/Rmxc/Lpy10ahiNul7BtcQaRdahyhS
         GfT1sPrAZlFUx8lcSP/ZuF6Bwpl3UCbcJv7g4Gz7F6JIxr4mpmBxwKgopb8WupvmCmAO
         00BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085321; x=1691677321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SGKxGE8WoMQ/68eSd1pAXEY4H4AMGjzzA6a9FWvKkU=;
        b=FiU6QOR6aoDXtyRNB+iMb4xextCoNA5ZyvPaUpiI9izlWzI81pSaSYOkidj9/xpsV0
         O8hCRBulHrYL8kb/vhinA9VnI6ebkjlhDQ0CdPJu1HMVEn7a4yc8jJey2ONpLzx0I9Ae
         BhdBhZJNLAvmKb4AJPbD0A3WKRTFrWvowWJHlsyx83ZaXfCvqVMBOApJrmlTcfZKXcHh
         gP6acglNNrmDEa1OGsLSz2frnGGTR5VG8OcFFdWGaj6igNEIDcWu8sFDtbKgLvNw7NIP
         GYD67zEy2c/RhjV7l7IZhbw9LU4cmDSq3EAdruEifsXPbk+fSAKuwBvpS4KC1FC4Ip5d
         e3kw==
X-Gm-Message-State: ABy/qLZfe0qx0Gx9yPSAwjHWVoPICGLVNbV2jsFOEiEkLugAGuM5HtuE
        BEaLdc+iRL/g2Ts9SmhTrwWepA==
X-Google-Smtp-Source: APBJJlGdbHN2h/WcztcPqGYEJLrNzJoDpArY7mIaFd7Rx6uq2AyPkHJ16rmqd2gp/s+w3xy8Qprs0A==
X-Received: by 2002:a2e:9b15:0:b0:2b1:a89a:5f2b with SMTP id u21-20020a2e9b15000000b002b1a89a5f2bmr13320793lji.2.1689085321165;
        Tue, 11 Jul 2023 07:22:01 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e87c9000000b002b6b4424a28sm487934ljj.13.2023.07.11.07.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:00 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 00/15] drm/msm: Add SM6125 MDSS/DPU hardware and enable Sony Xperia 10 II panel
Date:   Tue, 11 Jul 2023 17:21:50 +0300
Message-Id: <168908465043.1869384.3228866712722407267.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 22:14:15 +0200, Marijn Suijten wrote:
> Bring up the SM6125 DPU now that all preliminary series (such as INTF
> TE) have been merged (for me to test the hardware properly), and most
> other conflicting work (barring ongoing catalog *improvements*) has made
> its way in as well or is still being discussed.
> 
> The second part of the series complements that by immediately utilizing
> this hardware in DT, and even enabling the MDSS/DSI nodes complete with
> a 6.0" 1080x2520 panel for Sony's Seine PDX201 (Xperia 10 II).
> 
> [...]

Applied, thanks!

[05/15] dt-bindings: display/msm: dsi-controller-main: Document SM6125
        https://gitlab.freedesktop.org/lumag/msm/-/commit/4d125651038a
[06/15] dt-bindings: display/msm: sc7180-dpu: Describe SM6125
        https://gitlab.freedesktop.org/lumag/msm/-/commit/6321c42645b2
[07/15] dt-bindings: display/msm: Add SM6125 MDSS
        https://gitlab.freedesktop.org/lumag/msm/-/commit/a628b5b16872
[08/15] drm/msm/dpu: Add SM6125 support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/01077e7c890f
[09/15] drm/msm/mdss: Add SM6125 support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/c6da55b771de
[10/15] dt-bindings: msm: dsi-phy-14nm: Document SM6125 variant
        https://gitlab.freedesktop.org/lumag/msm/-/commit/d44ddd646858
[11/15] drm/msm/dsi: Reuse QCM2290 14nm DSI PHY configuration for SM6125
        https://gitlab.freedesktop.org/lumag/msm/-/commit/ac2f330f92f2

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
