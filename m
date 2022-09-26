Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC125E9B30
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiIZHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiIZHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ACC38692
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k10so9504304lfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rip9dlqrCxUoqsfVIdKnVGZs/mVmoXJ1pwJE84kTnM0=;
        b=D+Sofw07TQjXsyVzkAZSP/EqENOZTmJh7z5imb4KgyLruWfeofVYZIuVnrbADfB2aI
         YnwgsQXXpejlU0PWRUnmJOgKLO4j4KtjUaXaaQJRigytDhdOXABb9WOEwJ9PmZyMyfHW
         03WkOJFzpowoJ1af3SK9SXAx8uVskwmeOCLsIl/cTaDTtbp1GhEyq6QPp2I8DcT6jWo3
         4IRmDdyPGPaIYGi9SLdv7LoETkYcofvI5TGEX9N0bxHI7W7WF+pf8ODB4vC9PFiOdsCR
         m7iG8cix2ygL+IMurOcYrG0oQkPSUteLFXVxNRMFB70eL5zNP8DQPKb4Se9NFK/Qj1CE
         G50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rip9dlqrCxUoqsfVIdKnVGZs/mVmoXJ1pwJE84kTnM0=;
        b=QCl5Rif3OCagn1++T2sAPZarTFmkl04epD4tButA6X/cQSDtxBYuKFTie5hBEyZJWP
         FHaXVBPxGwrV/cPF4g3NiVk/UGO53yu00EAX2r7jx085PdadPynJpsJf9a7aFNG/9IEx
         eXgHrCawVjU1E7nF9Ox7njYUAPFtZhcxkX9a8jLaf1KGDEGvC5aohXmC/GImp2MWKAhG
         /207viVKxNNN2pL/tKiGO26ODSUGXbzK8t2y91E7J+dP6UvCqB8Ftze1qAn9AOwZ+sa3
         Ai0/DgvU+DmRQAaSJFZkTH4gyMJyjq3dzYibJd6caNmNNlhD+7dQ4scwSADXVO4nLETD
         PaOg==
X-Gm-Message-State: ACrzQf37+7atwO2xc3mwO8vIxYfqV716NvB0jnvyi/v4j5DBKny65Z77
        ZnI0fG1Y7mnjRNceFHwHVTiuPQ==
X-Google-Smtp-Source: AMsMyM5jtk4k+suGHJrz0z+fgzKwhx4QWJeS4953XmFEzGBPsdZBw0u1HDdVkLuW46e0/S4jqXRagA==
X-Received: by 2002:a05:6512:3d17:b0:497:9e34:94f2 with SMTP id d23-20020a0565123d1700b004979e3494f2mr7891109lfv.285.1664178328055;
        Mon, 26 Sep 2022 00:45:28 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 33/33] dt-bindings: pinctrl: qcom,sc8280xp: fix indentation in example (remaining piece)
Date:   Mon, 26 Sep 2022 09:44:15 +0200
Message-Id: <20220926074415.53100-34-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.  Previous adjustment
missefd one spot.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
index b9ab130cd558..0b251caaebf2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
@@ -139,8 +139,8 @@ examples:
         gpio-ranges = <&tlmm 0 0 230>;
 
         gpio-wo-subnode-state {
-                pins = "gpio1";
-                function = "gpio";
+            pins = "gpio1";
+            function = "gpio";
         };
 
         uart-w-subnodes-state {
-- 
2.34.1

