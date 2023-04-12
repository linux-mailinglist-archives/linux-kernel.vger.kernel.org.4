Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBAD6DF42B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDLLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDLLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:48:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6057292
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:48:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso52430a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681300111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XqtIJq4x9Uv7VCE+MyW77kD2bT9oscWHgTmXIM6GLQk=;
        b=FPY4+f7tj3sg1W11InhRGfg9nZ5Cz3zpKN6ctM079y4mUyOSskibQeyWdXfGX7JeSQ
         7nkT9WL6NyZw3SM06NXy9uYreD5IiAHZPT8TsUgBswRjsonNkzjsCaCZpHic510BXSUX
         q0ORzId2Nj4h1jyBkAVyM4sztArDsEwzZug32DXwVTliE8+eKXymHjvARQBxrciBBOxj
         Y1E4/p6J+zJXVVbcEo/00N4foRKKfxNb5+WGqkRUMAZaBS3g4TFq7Y+jHguf3NGtjexD
         Y2z34xyPm/pisxFnSDzqwhj1jccX5V9NCG7h7E2VE0dc2kBXpn9jSzw0jOGlq9zEm8Ep
         uDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681300111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqtIJq4x9Uv7VCE+MyW77kD2bT9oscWHgTmXIM6GLQk=;
        b=PUiIsg59YDp7mMQtu+JY16QczN0T9xhdft9Q3l9onkXiDGmVqrok363PPOqB5fU0c+
         /SPCCPh6rDl06o6dnDXvyZ6+Zce0MwndIDsgYewRDHGx9BBWhUJcBX2O0SkCvz5d7rAJ
         y6plBKrsnbExQ0t7zxCKtcS5XIR/ZjWMwOFkcalAigFg0ZpGrYnDDgcabprF51tn8bRt
         +TSzVfdiha35MFuAiSYKQlrGxddf/4a8UWMELwCWJnc1q50wI19S8M1aKnuCBP6QYHAw
         oi/kkoM7WAWT5qSVTfzprChdnQRSj3D7HX+Dy7Vm/JP874ytkQkKOYoMiILB/txURlwy
         Qm2A==
X-Gm-Message-State: AAQBX9c9kYPpaEkC4DRvf+TGQ8FjgxvX1oct+U7KaKZ5zlLm9oRL8H38
        ni/0H4G4BHalT6C/krMKo4ltFw==
X-Google-Smtp-Source: AKy350b7cz5vjLHb/9D8rj0cNeu9uSqOi5BImza/oeo+JiY19jPp3Jowdae9Q9ee5HMrllTS0qpaPQ==
X-Received: by 2002:aa7:d795:0:b0:504:943e:14b2 with SMTP id s21-20020aa7d795000000b00504943e14b2mr4746641edq.28.1681300111030;
        Wed, 12 Apr 2023 04:48:31 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090617c100b00930b13f6abdsm7217128eje.98.2023.04.12.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 04:48:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: dt-bindings: qcom: unevaluatedProperties cleanup for v6.4
Date:   Wed, 12 Apr 2023 13:48:28 +0200
Message-Id: <20230412114828.64043-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/qcom-pinctrl-6.4

for you to fetch changes up to 152674ab2e98bfd8677117314a77d223a2a1bedf:

  dt-bindings: pinctrl: qcom,sm8550-tlmm: simplify with unevaluatedProperties (2023-04-12 10:59:11 +0200)

----------------------------------------------------------------
Qualcomm pinctrl Devicetree bindings changes for v6.4

Cleanup and improvement of the bindings to use "unevaluatedProperties"
instead of "additionalProperties", which allows to accept all the
properties already parsed by referenced common qcom,tlmm-common.yaml
schema.

That common qcom,tlmm-common.yaml binding is going to remove
"input-enable" property, thus using "unevaluatedProperties" allows such
change to propagate to other bindings automatically.

----------------------------------------------------------------
Krzysztof Kozlowski (36):
      dt-bindings: pinctrl: qcom,ipq5332-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,ipq6018: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,ipq8074: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,mdm9607-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,mdm9615: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8226: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8660: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8909-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8916: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8953: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8960: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8974: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8976: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8994: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8996: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,msm8998: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,qcs404: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,qdu1000-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sa8775p-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sc7180-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sc7280-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sc8180x-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sdm630: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sdm670-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sdm845: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sdx55: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sdx65-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm6115-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm6125-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm6350-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm6375-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm8150: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm8250: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm8350-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm8450-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm8550-tlmm: simplify with unevaluatedProperties

 .../devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml      | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml   | 10 +---------
 .../devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml      | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml   | 12 +-----------
 .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml      | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml   | 10 +---------
 .../devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml   | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml    | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml      | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml      | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml    | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml    | 12 +-----------
 .../devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml      | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml    | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml       | 12 +-----------
 .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml    | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml     | 10 +---------
 .../devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml        | 10 +---------
 .../devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml       | 10 +---------
 .../devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml       | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml       | 12 +-----------
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml       | 12 +-----------
 .../devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml    | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml    | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml       | 13 +------------
 .../devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml       | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml       | 11 +----------
 36 files changed, 36 insertions(+), 362 deletions(-)
