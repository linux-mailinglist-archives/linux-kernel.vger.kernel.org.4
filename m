Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD842623114
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiKIRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKIRId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:08:33 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E9DEE3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:08:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so48462108ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGckoAKiL+PDGTYOUgV90XuQ0OsD8munY0lKgBlT8+s=;
        b=NIOItJRTewEv5DYvzGdBGeSKT4mpKmy1pGwnHstesPtSCqn1tXV6A5AcJGX4WPtN13
         YR5sM1Zo1yLI+FVdB+gbRVeHkS96fpcisi37Omz0g/e6V8SI9zO27z9Q1WMG8zvJajAc
         1zmAbfyvQYU1nzXtbsQr0ABbAhJ/q3/iKYVZ4lIvcyQC7/5lwVHMen4OSLPhoAG01Bq8
         89MrSUpJtPgSmsOhi8DUeTBVirY9VWZFleyPU9cYp2Ivll3eI+SMWS8an0kwCY6auMG8
         C7stn7GLl2czqLWHeMbia7dGsJPSZVxGeZ3kt1mOKzJoDgK5AKt3S2wpPNBiaFT2Jh3Q
         3S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGckoAKiL+PDGTYOUgV90XuQ0OsD8munY0lKgBlT8+s=;
        b=i0Lkf8op1ALtGNY0bnW0y+t8e0Nn31ZfnWxOh0ir7FdGB0ZmggaXtUUncVnCzsLbtm
         2Y5HRgU4avzuf1hS/bNiM5+2rybfSc3SYH+KJfBD+wSeuE9ZgMSYak1Ku3Y2CN+21IKL
         ZvAQxD0SAEydl6SuaG6Ty9ORiNtVzcD7CsR0itgWtE/9iFJF+hsv7dFrP76u4DoEPuTL
         30LwomPc4UI4JtV1VCHMC1K2kgfYKa71cynvSw5JXMI+QiqsFYPyWKvmgNGRjv0okyb6
         qe3KD2xGCQmpWGufJXoHFOnRHVM0TXYoL3XMQ4pDx+ghXXN+3Kr9U3VvBj7WVDMnY+R0
         goiw==
X-Gm-Message-State: ACrzQf1Lbdpj5aQ8OkTSMWmgbGnyvq/AsTo9wXWP+ETE85RaBpzEuohc
        B38Cwrg503rsEuKq3xAGS8JWMg==
X-Google-Smtp-Source: AMsMyM6Fmko3ZwqfkYv4RDk0uzq7sMO+AwhwNSzC3++RWkc09dWpeViELtKxZUiXmPtkvGuE1F9FvA==
X-Received: by 2002:a17:907:217a:b0:7ae:415:3fb5 with SMTP id rl26-20020a170907217a00b007ae04153fb5mr1136935ejb.255.1668013707262;
        Wed, 09 Nov 2022 09:08:27 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id w6-20020a056402070600b0046191f5e946sm7207012edx.21.2022.11.09.09.08.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 09:08:26 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: remoteproc: qcom,adsp: Add SM6375 ADSP and CDSP
Date:   Wed,  9 Nov 2022 18:08:21 +0100
Message-Id: <20221109170822.58281-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

Add entries for SM6375 ADSP and CDSP. They are effectively the same
as SM6350 ADSP and SM8150 CDSP respectively.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index db9e0f0c2bea..a9219c7c8349 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -40,6 +40,8 @@ properties:
       - qcom,sm6350-adsp-pas
       - qcom,sm6350-cdsp-pas
       - qcom,sm6350-mpss-pas
+      - qcom,sm6375-adsp-pas
+      - qcom,sm6375-cdsp-pas
       - qcom,sm8150-adsp-pas
       - qcom,sm8150-cdsp-pas
       - qcom,sm8150-mpss-pas
@@ -197,6 +199,8 @@ allOf:
               - qcom,sm6350-adsp-pas
               - qcom,sm6350-cdsp-pas
               - qcom,sm6350-mpss-pas
+              - qcom,sm6375-adsp-pas
+              - qcom,sm6375-cdsp-pas
               - qcom,sm8150-adsp-pas
               - qcom,sm8150-cdsp-pas
               - qcom,sm8150-mpss-pas
@@ -315,6 +319,8 @@ allOf:
               - qcom,sdm845-cdsp-pas
               - qcom,sm6350-adsp-pas
               - qcom,sm6350-cdsp-pas
+              - qcom,sm6375-adsp-pas
+              - qcom,sm6375-cdsp-pas
               - qcom,sm8150-adsp-pas
               - qcom,sm8150-cdsp-pas
               - qcom,sm8150-slpi-pas
@@ -372,6 +378,7 @@ allOf:
               - qcom,msm8226-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
+              - qcom,sm6375-cdsp-pas
               - qcom,sm8150-adsp-pas
               - qcom,sm8150-cdsp-pas
     then:
@@ -468,6 +475,7 @@ allOf:
               - qcom,sc8180x-cdsp-pas
               - qcom,sc8280xp-adsp-pas
               - qcom,sm6350-adsp-pas
+              - qcom,sm6375-adsp-pas
               - qcom,sm8150-slpi-pas
               - qcom,sm8250-adsp-pas
               - qcom,sm8250-slpi-pas
-- 
2.38.1

