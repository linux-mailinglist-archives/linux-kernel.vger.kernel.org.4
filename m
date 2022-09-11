Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6C5B4DF6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiIKLOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiIKLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:13:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2678F3C17F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x10so7399102ljq.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=E8Itur3iOiuWyn1wg10ogGLwaqdoS7iW/Pz+k6Unb5M=;
        b=zM8SjuRF+fdc7U44IskbAZtjD5OQnSfgy2A19OaEb4qbQ8mdRPTq7GlE6rZl+KbqHY
         9O900GZ3TEzxZ0HFTK6RGRbWF9GjQ67RgvWWSkBKpKDSLlBqBVvB8J2keUkc4ePynWHV
         Px0LgN060gPTJSlCI+CTxAEmF4Vpc9EoyAdmCDZP8dec7ap4/hPHkqkqY9wLLmQJxym8
         xy8hDfWMt2quNPO8pL2+mGJJ6GTxsLxWuSL6ZhI1ej0THOryG5Pz13fd3JjY4qD74Om6
         wLAD0Ylv7aFMdauF/kCzDSo6vAcstsPeV7eIPki7rcZDaBrU1zF39KoqjEM/ughgGpT3
         9XZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=E8Itur3iOiuWyn1wg10ogGLwaqdoS7iW/Pz+k6Unb5M=;
        b=2r9SgJQx7BZWs1plTeW3k6Pr0oTQk+9uUzGa5UydJiDeA/S72vjzASGFJWVvjxRYal
         wwIvIpLppAe1AXKUMgf5uTk9bwhCYpXaboV8MCDt77ViqFa6qJshuUC4wMQ8rA0l5eNo
         058x6zzbQ1CYXT+DO3dfVzFtB0Z2zbRccZnuzVmjTsp76BOkXhXCl7TxJf0No7lIZ6Fd
         rJrwKlQaktiQW1VM5Wpm9WsccX9Ef8fgZD8n7/Z19IYt+6wCs5G47laPS+06LLcXphh5
         JGrl1XHFhe4+HMzT5R3DSLRemPZQD6ShVwDkCK8K5vYx9eit7tk+3p4Uh7OzkpA4jysA
         MnIg==
X-Gm-Message-State: ACgBeo1FKxtczhgf3qeGqkktr03g8XEYFcgMDhmw+OiJTTL+oUSvYUM2
        0NZ5LaGq2niHd4PVKbrbnX3N9Q==
X-Google-Smtp-Source: AA6agR4OlfkdwenjZs9F0LdlvajDspnil4ZBDroaoegHdPq8JVb9CGo+23IToeRslD+L9KjcKo3HMg==
X-Received: by 2002:a2e:b4ad:0:b0:26c:24f:b260 with SMTP id q13-20020a2eb4ad000000b0026c024fb260mr639838ljm.173.1662894757357;
        Sun, 11 Sep 2022 04:12:37 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 25/40] dt-bindings: pinctrl: qcom,sc7280-pinctrl: add gpio-line-names
Date:   Sun, 11 Sep 2022 13:11:45 +0200
Message-Id: <20220911111200.199182-26-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common gpio-line-names property (used on SC7280 Herobrine boards).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 9bd5fbdde9a2..35d3962dac58 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -42,6 +42,9 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  gpio-line-names:
+    maxItems: 174
+
   wakeup-parent: true
 
 #PIN CONFIGURATION NODES
-- 
2.34.1

