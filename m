Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190476B8CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCNILM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCNIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:10:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31396638
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so6824769edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G03PpRTbK5W/lPf8z95JweDlRYKrjkNzwWm5SRvjBEo=;
        b=JAQGHmUqI8JKEfDJdprOqKy2zrmglhWFzHzTCe6u4kPUzXUT1RDwbBjGeBEYYLy0Ym
         kL7DJuK181U6pdPSK+RbrNJ5eO85s6KOv1Bl6GuRoanqFs1rrC/UQMxk0B4cwpDaV+Rs
         lbvzNDi3qhrSHgn7JGuzz2dq4h2RD2lxCBj6RlwOAI57FsZ2UPJ8LMa2kumD3PqUA9Ux
         Q1hbtt57e/LfRIVwtFXlH/9g+Fa6ITzV/LQMDtbsDN1bm1gfmuPqWlIRIX2iLCmhPKEd
         K+R1QO/SlcQwUPqR9r7X5YplZ1OXtUqLZ7g5nAUn8f6P2KSt3/BCBsVj/OppqsJeDyjX
         Q8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G03PpRTbK5W/lPf8z95JweDlRYKrjkNzwWm5SRvjBEo=;
        b=x2Ilrxhh6bDCDRqjyg6IbzVIEB3PQ00GbDyedYSjEH/674pVyzwCPC75+glJ7t+FpC
         68lx4X6SBv+1lXXaOoXTJhZQo4Un+yohxp6A9THTV+RZqXGVW7mD7uXb8C4PIR/9dF+y
         72EWCg17QpwMEhmNS756tHg4XsirYxXcxNV0xqTVuurIc3FqtF7uLngKi13sUN0XCa4Z
         QmvkaeGUbfAsO3Y18EqZaw73B/LzsFllkgubBcv2vYYehpkr6km/RoqLLoCW0323F8gs
         vGQIlz2x+IpAKriPvljC1jDh/ha/mvNoix41dqRnPqFF0TamEV5RjXpYz7y30dibAJPv
         +uuw==
X-Gm-Message-State: AO0yUKWdM7/rHSLQhH/rBCnCSQyNgG/XTRiLiy0zuZU168sBw5rAGsc2
        vUrDmDmx+HZH+PLfWAMz//k0+A==
X-Google-Smtp-Source: AK7set9Y+Y+uqFC8RMnB2pHqRPoKShsR+z6Lydzdy4MT8Xl9lu+Wnbvp+xB9lXe2CdDvs+gulG+dwg==
X-Received: by 2002:a05:6402:2cd:b0:4fc:535c:3aa1 with SMTP id b13-20020a05640202cd00b004fc535c3aa1mr6059492edx.10.1678781361556;
        Tue, 14 Mar 2023 01:09:21 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b004fce9ff4830sm584872edb.88.2023.03.14.01.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:09:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/13] dt-bindings: mailbox: qcom,apcs-kpss-global: fix SDX55 'if' match
Date:   Tue, 14 Mar 2023 09:09:06 +0100
Message-Id: <20230314080917.68246-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom,sdx55-apcs-gcc is followed by another compatible (syscon), thus
the 'if' clause must match by contains.

Fixes: 0d17014e9189 ("dt-bindings: mailbox: Add binding for SDX55 APCS")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml   | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 2992227631c4..4d2f408a5efb 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -91,8 +91,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,sdx55-apcs-gcc
+          contains:
+            enum:
+              - qcom,sdx55-apcs-gcc
     then:
       properties:
         clocks:
-- 
2.34.1

