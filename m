Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C53675BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjATRqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjATRqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:46:44 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025560C91
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:46:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso4266889wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBcm1ksuIfBBKtt3kd68+qKTCAhQjKc2GeFln1kH0Fs=;
        b=uC97fJdEdReXs/6LQ44/N5YU6UhfpImjScLii/d7y/l6lqpcp1OFIzEa2B+vBbUTwz
         radFrAbksW3Tc6IDchGvfZtC5eqLMf4X7xWOEOGtEUHK8tTpdirX1LPzmIl9uASzMq5P
         fgjPGm+IVLsTsp6eicWw7s7C5tFus1+UaU4y7zKHDkPvpqeYZWHBog2dd8GhzUbhKuly
         8W+ybcOHur7xhYxUKD8kw9zNAg176VR4pIoPC1Ro0KAhra8+J7qs6AB4Ig4o8Kt62EhI
         EhL/ITiMuzG9c97Ab0EPQHj9JXIUUNbHgXeH9Aw0KQQxmI8Uo5aGjLLEWEOztoASCxhd
         n2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBcm1ksuIfBBKtt3kd68+qKTCAhQjKc2GeFln1kH0Fs=;
        b=2XVxo4c92YYnPWSay1r7FnbyD3Y9k72xKMgSZes6TaMRI5gblCXe/pwnFCr545nGOf
         sMGN5Nn8jj0R26C1CMyo9CHbuKKY1TBVdjtPQIzcWAvGBMmK1MxDbQgVPoEvylKBXZ+h
         Kw6wve+c4XoadQ+jKe7WH3YVNHsfOpQoMIA5ScpDdCEHfC8GScsFvBAJ1CUl1wxQW096
         TZNQapjJw9Gr+ZWB21YqwAbpr1RXPtU9LPdS4FROnIH0YncwtM86RBJfgclGAwTzNlfn
         djKG06PUaxzFZGHderMBQu4cu8sKSgDrhjs/VSrAFGI9WuOHCKU2hW2T7EBB0kGH+nqo
         YPNg==
X-Gm-Message-State: AFqh2ko5UWD2o0J/E/KOjFBFVaMaMrYwmsfwxGzwrwMVkxwfnNzNLVaU
        RU+hYo07BrD5jpoCnj0CG1iICQ==
X-Google-Smtp-Source: AMrXdXuePYcSfXcIeuXvqcdDTQP+BLAqWpMAXhPRzj8IjU39ZcetyMdIOSrGWxAcetf1ZRHKnD2uVQ==
X-Received: by 2002:a05:600c:3296:b0:3cf:82b9:2fe6 with SMTP id t22-20020a05600c329600b003cf82b92fe6mr15865983wmp.8.1674236801199;
        Fri, 20 Jan 2023 09:46:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id hg8-20020a05600c538800b003d974076f13sm2879682wmb.3.2023.01.20.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:46:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: dt-bindings: qcom: bindings for v6.3
Date:   Fri, 20 Jan 2023 18:46:31 +0100
Message-Id: <20230120174631.353345-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/qcom-pinctrl-6.3

for you to fetch changes up to 5b8c304c94d79f44aea8ee273ce70ca380804156:

  dt-bindings: pinctrl: qcom,pmic-mpp: Rename "mpp" child node names to "-pins$" (2023-01-20 18:43:06 +0100)

----------------------------------------------------------------
Qualcomm pinctrl Devicetree bindings changes for v6.3

Set of cleanups and fixes for Qualcomm pin controller bindings, to match
existing DTS and correct the schema.

----------------------------------------------------------------
Krzysztof Kozlowski (8):
      dt-bindings: pinctrl: qcom,sdm845-pinctrl: add GPIO hogs
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: correct pins pattern
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: add input-enable and bias-bus-hold
      dt-bindings: pinctrl: qcom,sm6350-tlmm: add gpio-line-names
      dt-bindings: pinctrl: qcom,sm8350-tlmm: add gpio-line-names
      dt-bindings: pinctrl: qcom,sm6350-tlmm: correct pins pattern
      dt-bindings: pinctrl: qcom,sm8350-tlmm: correct pins pattern
      dt-bindings: pinctrl: qcom: allow nine interrupts on SM6350

Rob Herring (1):
      dt-bindings: pinctrl: qcom,pmic-mpp: Rename "mpp" child node names to "-pins$"

 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,mdm9607-tlmm.yaml        |  4 +++-
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8660-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml        |  4 +++-
 .../bindings/pinctrl/qcom,msm8916-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8960-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8976-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml     |  4 +++-
 .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml     |  4 +++-
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |  4 ++--
 .../bindings/pinctrl/qcom,qcm2290-tlmm.yaml        |  4 +++-
 .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,sc8180x-tlmm.yaml        |  4 +++-
 .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   |  8 +++----
 .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml       |  4 +++-
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |  4 +++-
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml      | 15 +++++++++++-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       |  4 +++-
 .../bindings/pinctrl/qcom,sdx65-tlmm.yaml          |  4 +++-
 .../bindings/pinctrl/qcom,sm6115-tlmm.yaml         |  4 +++-
 .../bindings/pinctrl/qcom,sm6125-tlmm.yaml         |  4 +++-
 .../bindings/pinctrl/qcom,sm6350-tlmm.yaml         | 27 ++++++++++++++++++----
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |  4 +++-
 .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      |  4 +++-
 .../bindings/pinctrl/qcom,sm8350-tlmm.yaml         | 15 +++++++++---
 .../bindings/pinctrl/qcom,sm8450-tlmm.yaml         |  4 +++-
 .../bindings/pinctrl/qcom,tlmm-common.yaml         |  5 ++--
 36 files changed, 147 insertions(+), 47 deletions(-)
