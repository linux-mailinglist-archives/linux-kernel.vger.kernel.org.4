Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA416CBAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjC1Jaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjC1J2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:28:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763BC6196
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso11870808pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679995710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/QZc9gZG9fueXODq2o89xljOdcpkBJcOX9/f1kD4r0=;
        b=U1IK8yQ2NW98GIn4MvYVjixBktX9jcju6v5HILaODZWe9oY70JJoOpFtFeFoN+yRvO
         mbAK9Q63jpslAhukHz/54xnuX9D1eIiQwC50cBoYp3dnB4Gb26k7mUH3pIWrICRICh1A
         7kQrAxDJpKYMLRKleSJ+UmYLwlshtosBD+c1Y4jeK3RLr/LqLcOj1JW430rP1jV/SuMj
         Eomw5JsHz2LlGP1+l8Z//Prlop0ztbNCHdthVmu7siXOJMhQOyTVkUerPKVTS2FUS6SY
         StlywhVEE5Fi2O30YUNVLgyMUK2a2Laz33rHemsMEVRfN54AnUMCWxARveA0G3YPVBaJ
         JODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/QZc9gZG9fueXODq2o89xljOdcpkBJcOX9/f1kD4r0=;
        b=pFAoJSnqZBUAk78e10vKTSNnptEZWrjNuAnNY+7Acq75hQoIIdobp5p6f3NaTtfphG
         DsVn/F4OXIr5Gk4W9bOz5Tn012MCuClsDQqG7w87L0CSGGJT1FrzluMN1NJZe/skmlpL
         GvXfg0dZDc8385Y0MOKOBISkQMqMib3jnqNt7vpH81mTCqYZY52gzsyl4FPe9UR/Dg+u
         gSNFYRq49nD6PxulS/J00thbpkZPVNAH2JCOV8q5YrQcktQq2mS8QJ0J1X8J4rozhklM
         cTDo0moVhgXzqonoH3gbP6GquhI6ZF53brysMojjmX9+Y7pMPGtctad84npG+I+tDeYy
         dBWQ==
X-Gm-Message-State: AO0yUKXjEgPWNhUsxKztOFdeByeA86b0wDaGNlshl+y6Wk7g4n73nukC
        6SSGr80SetJXcqedHIx4rQGnSQ==
X-Google-Smtp-Source: AK7set9XKYwsV9OQzuDBzNjiSmt5W7jpsuHlSRPHuhrsk3g58OdcKKl1AQds/JdxfQhqTtmo7ioLiw==
X-Received: by 2002:a05:6a21:3381:b0:db:5e69:c97d with SMTP id yy1-20020a056a21338100b000db5e69c97dmr15054161pzb.25.1679995709885;
        Tue, 28 Mar 2023 02:28:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:449a:10df:e7c1:9bdd:74f0])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b005a8bc11d259sm21261518pfo.141.2023.03.28.02.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:28:29 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v3 1/9] dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
Date:   Tue, 28 Mar 2023 14:58:07 +0530
Message-Id: <20230328092815.292665-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible for BAM DMA engine version v1.7.4 which is
found on Qualcomm SM6115 and QCM2290 SoCs. Since its very similar
to v1.7.0 used on SM8150 like SoCs, mark the comptible scheme
accordingly.

While at it, also update qcom,bam-dma bindings to add comments
which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
This provides an easy reference for identifying the actual BAM DMA
version available on Qualcomm SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index f1ddcf672261..624208d20a34 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -15,13 +15,21 @@ allOf:
 
 properties:
   compatible:
-    enum:
-        # APQ8064, IPQ8064 and MSM8960
-      - qcom,bam-v1.3.0
-        # MSM8974, APQ8074 and APQ8084
-      - qcom,bam-v1.4.0
-        # MSM8916 and SDM845
-      - qcom,bam-v1.7.0
+    oneOf:
+      - items:
+          - enum:
+              # APQ8064, IPQ8064 and MSM8960
+              - qcom,bam-v1.3.0
+              # MSM8974, APQ8074 and APQ8084
+              - qcom,bam-v1.4.0
+              # MSM8916
+              - qcom,bam-v1.7.0
+
+      - items:
+          - enum:
+              # SDM845, SM6115, SM8150, SM8250 and QCM2290
+              - qcom,bam-v1.7.4
+          - const: qcom,bam-v1.7.0
 
   clocks:
     maxItems: 1
-- 
2.38.1

