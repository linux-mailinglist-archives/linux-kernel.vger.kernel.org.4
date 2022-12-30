Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED3659925
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiL3N5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiL3N45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:56:57 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E55B4A3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:51 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bq39so24043020lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djqz8ZadzsGEqLZDimR3853TTLAfo0lgcYA98afhE7g=;
        b=bOEaOPCg3/9ByS+Yv7fudeUmsqz49+3VBTNAhGq0A4nnvYpeJx3wCgAVhlQzjtp6B0
         c5rsRIJXNnbKl4vfYlTnahyjYion7UPA144mLiBoK/O18w8puZhr6KTV/eHOtVffjmzC
         cnZowUt7qoDz16h666zO4EGLPBKExqASVT81nSQr5SRgyD7phWZz+lZUR9AeUgMbhzym
         mD8sfV2g3SvaHfQKtdmfCaIAzsPKBcy1Fyw3LZNTyJSLHIM9aJvYwdq6VMND6rqpELwV
         hmpyUlXa0WLDde2XVjfhuoCR27zKFnlmSjVD1Rw0EzmeRKdiPkQy/9YH/462/wZousFY
         /PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djqz8ZadzsGEqLZDimR3853TTLAfo0lgcYA98afhE7g=;
        b=nWEK+AeZqr6P5wn7PigSNLnRaqVeWTzltjvYQ/z5tHWpFVNLAdotKcaLAWYyOKOZ5+
         kTd4omxgE3+LyRWMgcxVGIupggV8GX/mA+853WyhYwQ0oGvyO3akoRq1bAEZRfr39i19
         UIxheu0SRXH+A/Tr6gU00NwE5aqHc0ZCIL7JF4Ve7ETk25/aNvtjakh4yPOMtpMNklbv
         tVAt7lUJQyPSQNkLWnNO0kJqe3Fi8oEWwkAxazdzzam4xfo+YXDPxPTCF0PZ9Qr2yVSd
         goYMjEc3XXx9gtKltR/Ent9TTgxHmyNy9Cj3B7Tc3IaGZU4gGmmwYxIQnEJLf4pPmXMJ
         Feug==
X-Gm-Message-State: AFqh2kqZ6A3kjX3PZNUEvoh6XZMvVV4kkoIjNhJEH+Xb5d5LBa9Qj/6E
        7/HELedwrnXIGKRt2Nb1hRJxNg==
X-Google-Smtp-Source: AMrXdXtuDHGI/HADoruilzvLBgafgLP9uE+Cgh8nEzNP5jpALCMmF93Z8mazLv+QMKodBzBMSOUvjQ==
X-Received: by 2002:a05:6512:3f26:b0:4a4:68b7:d625 with SMTP id y38-20020a0565123f2600b004a468b7d625mr10727023lfa.12.1672408609761;
        Fri, 30 Dec 2022 05:56:49 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004a26ba3458fsm3454787lfs.62.2022.12.30.05.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:56:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/9] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: add input-enable and bias-bus-hold
Date:   Fri, 30 Dec 2022 14:56:38 +0100
Message-Id: <20221230135645.56401-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
References: <20221230135645.56401-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow bias-bus-hold and input-enable properties (already used in
SC8280XP LPASS LPI nodes):

  sa8540p-ride.dtb: pinctrl@33c0000: tx-swr-default-state: 'oneOf' conditional failed, one must be fixed:
    'pins' is a required property
    'function' is a required property
    'clk-pins', 'data-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
    'bias-bus-hold' does not match any of the regexes: 'pinctrl-[0-9]+'
    'gpio2' does not match '^gpio([0-1]|1[0-8])$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
index 309d3dd9013b..9a3f1fb8c2f7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
@@ -94,14 +94,12 @@ $defs:
           2: Lower Slew rate (slower edges)
           3: Reserved (No adjustments)
 
+      bias-bus-hold: true
       bias-pull-down: true
-
       bias-pull-up: true
-
       bias-disable: true
-
+      input-enable: true
       output-high: true
-
       output-low: true
 
     required:
-- 
2.34.1

