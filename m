Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFA659C03
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiL3UWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiL3UWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:22:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8851D1AD91
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:22:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y8so20652920wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFnUrWdhcpbNtSqH6LxEFiIYrDwMlWVSmVEBxpFj6cM=;
        b=kmxfL6fljefuxy7oTCo6Ck4MJVSnHG/r2XSwEgNE6oexPxh8qDGKiEu32mPs/SV6UL
         0O9t6ivNMxv2FHjX1wD08XyeKELWGgjvxtOn1vIn/o8wfXSBXtkBZ5NfM81La9u5kUb0
         2fsNZOMFIZumQkNJuGizbnWxiED+uLbm3t0JETIxg5Yf0yDs6HFqCKyyfhXfFkjQudY9
         2cDeNfXv7zK75H7dLHs9wNflbfndyGAd6XCttu/Caw7bfyEht7u7Hvc/BO5EdE4wseyw
         QgM4F2pUp+/LBEgYdQ9J1dfoSn/B8gTmlHPe8h2ck/OwI4NiC9BPxoDIL1OoDFwmnA9E
         KNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFnUrWdhcpbNtSqH6LxEFiIYrDwMlWVSmVEBxpFj6cM=;
        b=iqY6EYozcB8pmF377/qxVoBHACODX3zLsDS/MB01YxKLihGUgzJlm8XGaBBRfwcr67
         tVleo9xIZxl8GogVKgPBwQ7U5V1kkMsK51tZnNiC0VKolA4mxHB2QRjk6BzVKR0BHS6Q
         UMtVZqs+xPH65gAqghlFTlV8dLXvycDJOJX7ZGl6U9tuV1jsqpxx71iFoHCRJ9meZ0Ar
         BO8MoL3qURLhVHH3nJSNA9Mj9UWzs7RoWUQkUSQujnki9UPp3rvZz1/4HH8PmB/mQNXS
         shHDNjDRtAxgUgtpQSr/lIDvjEy4mBZul6PHuAqLDfyk2zXpu6pGAwgHBXX2NefSamT2
         Sa3g==
X-Gm-Message-State: AFqh2ko2TdVWsjm2Q1yUMjP/CZ/gHyx4EK1Pti/iCsvww0wxhmZ/275m
        wLC5aankqGxwhM+zjdvNUo5Kew==
X-Google-Smtp-Source: AMrXdXv4fQxcljxtu90oRjwV/V8Jpr/QsmY4spMRJTx/0K2SPlPnsRt3j5tnpO4ph02FFVwgITUK3w==
X-Received: by 2002:adf:ce86:0:b0:242:43f3:8950 with SMTP id r6-20020adfce86000000b0024243f38950mr19879095wrn.22.1672431761103;
        Fri, 30 Dec 2022 12:22:41 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z1-20020adfdf81000000b00268aae5fb5bsm21359142wrl.3.2022.12.30.12.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:22:40 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 01/10] dt-bindings: arm: qcom: Document SM8550 SoC and boards
Date:   Fri, 30 Dec 2022 22:22:21 +0200
Message-Id: <20221230202230.2493494-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230202230.2493494-1-abel.vesa@linaro.org>
References: <20221230202230.2493494-1-abel.vesa@linaro.org>
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

Document the SM8550 SoC binding and the MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 27063a045bd0..f5a8fb4aa288 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -70,6 +70,7 @@ description: |
         sm8250
         sm8350
         sm8450
+        sm8550
 
   The 'board' element must be one of the following strings:
 
@@ -845,6 +846,11 @@ properties:
               - sony,pdx224
           - const: qcom,sm8450
 
+      - items:
+          - enum:
+              - qcom,sm8550-mtp
+          - const: qcom,sm8550
+
   # Board compatibles go above
 
   qcom,msm-id:
-- 
2.34.1

