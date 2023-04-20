Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DAB6E8B55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjDTHY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbjDTHYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:24:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34A40F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:24:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so540250a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681975487; x=1684567487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+HBRAHzS6T192KwkoETQ0kcTreq2pNJKfWHpy0M0Yc=;
        b=hypN3jYredFna/9ZAALLNqsd8I+k3K7lO4IB86cGE26YXY4qfWG4v4P97Kx/qf5LlN
         F3mn+qB0PSV3AnffuNTxwuzzhB9SqDEg683ouBIZkOK19kvD13PJLF8k0MB1EWxIs+G+
         ttQVE1xotsw792RuVap0OB3ov4hZ2YLZZgZWybChGgMi7P/mbwBGeNs8EonRQpZ90U2t
         Xmxw14aCULA4pmHvjCYDjuYG4xdI5WbVzmJwC5PjmfrA2GAEGUmDSPzkLlYv1gL2/l04
         MhVuU+s72YX860/J2Yrxvdz3Fpia8bMyKJnIaD9mwGSHLC6i1X42QavVEzP24F4FZHpD
         WBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681975487; x=1684567487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+HBRAHzS6T192KwkoETQ0kcTreq2pNJKfWHpy0M0Yc=;
        b=cOWZkvWCBhsSmDbLrSbLN6pGuqRzlPjkyRMF7gIxdYE4bCWNHy4GJ36o/7KYb5hAwr
         K/MFea4jdFEMIo+6yjkAN7bMwuJaQtIRCuOrWTrUNgaTcKfgqMfDoXV6/H7LvZNsoQ/8
         FawspL6af9RPDaZzF0eeNTimPfHtLMbyc31nZq2c5Ss8RwmMsbxiQ4HeH9KO07+M9xQs
         rj2VaaqwP8NdQjP486jRf6jIgqy1Yf7wpEn1/rpDEeq1pogsX0n6CQRakUXwTYNiNATc
         estqsihOIiwh5cVNPcw3NSHXFzrxEUn4eQi6+J7CIC5oazEZLxhu/gleRnEmlhhjdIJz
         3eBQ==
X-Gm-Message-State: AAQBX9dkHom3KBqrPcJPpB+rc9seZLs1IU6LktT91uv6ypIjno8lFc9t
        MiS7GwqNmBKB/YkoWsedXxZqwA==
X-Google-Smtp-Source: AKy350Z3/CKA8tzUMD8zqorNQIbxbz5pKe/C5s6Vs2QjO0Ivkg6sN0rPTj2LRxGksAk3irqoZOB1cw==
X-Received: by 2002:aa7:d88c:0:b0:504:a248:3741 with SMTP id u12-20020aa7d88c000000b00504a2483741mr851286edq.14.1681975486947;
        Thu, 20 Apr 2023 00:24:46 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id w20-20020aa7cb54000000b004fa19f5ba99sm435935edt.79.2023.04.20.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:24:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] media: dt-bindings: qcom: camss: correct unit address
Date:   Thu, 20 Apr 2023 09:24:42 +0200
Message-Id: <20230420072442.36308-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Match unit-address to first reg entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml | 2 +-
 Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml | 2 +-
 Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml  | 2 +-
 Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
index 12ec3e1ea869..abd444e12d05 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
@@ -155,7 +155,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/qcom,gcc-msm8916.h>
 
-    camss: camss@1b00000 {
+    camss: camss@1b0ac00 {
       compatible = "qcom,msm8916-camss";
 
       clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
index 6aeb3d6d02d5..db2604802d51 100644
--- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
@@ -221,7 +221,7 @@ examples:
     #include <dt-bindings/clock/qcom,gcc-msm8996.h>
     #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
 
-    camss: camss@a00000 {
+    camss: camss@a34000 {
       compatible = "qcom,msm8996-camss";
 
       clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
index b28c8e17f158..2f23baf32b61 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
@@ -227,7 +227,7 @@ examples:
     #include <dt-bindings/clock/qcom,gcc-sdm660.h>
     #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
 
-    camss: camss@ca00000 {
+    camss: camss@ca00020 {
       compatible = "qcom,sdm660-camss";
 
       clocks = <&mmcc CAMSS_AHB_CLK>,
diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
index f9a003882f84..8f5c9aff37fb 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
@@ -219,7 +219,7 @@ examples:
       #address-cells = <2>;
       #size-cells = <2>;
 
-      camss: camss@a00000 {
+      camss: camss@acb3000 {
         compatible = "qcom,sdm845-camss";
 
         clocks = <&clock_camcc CAM_CC_CAMNOC_AXI_CLK>,
-- 
2.34.1

