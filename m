Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14705EC809
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiI0PgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiI0Pff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:35:35 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134FD10043
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:35:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id g20so11344175ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EalEz9AV2V0m5q+BMPo2gblVIc4RaNqnpRQA+ia4FNc=;
        b=E0i5PYEN24O+6dgL9ngxmJEGTGs47BaRui5U8vGwlpdKMIngJr2/XH4ZAXfdA2FyZQ
         QCug4TFZuaVXHHivO8BVAiDmo65MMrpC3ftNNeLDKvi+M6GIGoMa3+2osjcYrZr9+bsm
         yemvCSFXbYCo+l/Gh14xz9ng6qHw14g3an3w7r3kOK72aCLTkrLJEG0iRRSH84REC76L
         SyIj0zYDeINJwq5f+8k4qCsuDUMDktB5LP6772PCtyvpWN7rJm9IVIbJ4/K1o16ry/0M
         mvDBHfcsL52pLZR8VIervMuU4hAlgyQCAnQhrHmoxc2kPgSx6eXWhgx8KFVw7KzfD8bQ
         jTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EalEz9AV2V0m5q+BMPo2gblVIc4RaNqnpRQA+ia4FNc=;
        b=fOzfDlqeKXIJIdJDhzitur+6RUruH52n+4YmjTfU1iva8l7lJQjnY+mMwR6w26f1cl
         h85bsJ5kN7EDwbeb7MHaM9FH0qdZyL7iE4/3Y5SiuSFK1BJt3uE0k2l6jKAqo+iOB34O
         33g+Sq7dSUWrbO9VaQ1KNDZ2nXDGg8LVmgmeHVOoRGBwNIQVxA28qWD468gYyFq3A2G2
         B6lcmiEx/cBn6mBZVlumDOeD37fISKZSKqAg3FEj9mooqN/TcKT4Ibd6T6gD0n/uu4ra
         qK6K3chUW1jIQl6ZaOBVhKXUGpwEqlf4AL+++kN+KWujrp/7NMRfuQjxpnh03wLShjJ/
         88oQ==
X-Gm-Message-State: ACrzQf0PMuL8Z5/PGnmNXZC547dyMJxgB+8CBj1/KMVswRAIVuEegjNz
        Ppq3fE/XU3kTAvR1majlRWAxZA==
X-Google-Smtp-Source: AMsMyM4hs1yEXSuiLsujg/XbJUM5EFTVyJx5Cxs22w2sTyb14cMgxbDCc+qifhsud/W44L8RZT7Mzg==
X-Received: by 2002:a2e:9c1a:0:b0:26b:2bf7:9154 with SMTP id s26-20020a2e9c1a000000b0026b2bf79154mr9419060lji.417.1664292912811;
        Tue, 27 Sep 2022 08:35:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e7312000000b00268bc2c1ed0sm191592ljc.22.2022.09.27.08.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:35:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 11/12] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: add bias-bus-hold
Date:   Tue, 27 Sep 2022 17:34:28 +0200
Message-Id: <20220927153429.55365-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
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

The existing SC7280 LPASS pin controller nodes use bias-bus-hold, so
allow it.  Squash also blank lines for readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml      | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
index a8a48b684692..bd54c92287d6 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
@@ -91,13 +91,10 @@ $defs:
             3: Reserved (No adjustments)
 
       bias-pull-down: true
-
       bias-pull-up: true
-
+      bias-bus-hold: true
       bias-disable: true
-
       output-high: true
-
       output-low: true
 
     required:
-- 
2.34.1

