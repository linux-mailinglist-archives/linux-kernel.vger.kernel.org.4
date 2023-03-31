Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5866D2607
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjCaQqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjCaQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:45:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD91A45E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:44:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id r7-20020a17090b050700b002404be7920aso21983630pjz.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScrPtwLifF81mLBCSzco8cbRfT+aGGc+R4ZbxOTPL28=;
        b=jMqNDnVJgU7VTnx/m509pjSRih3eionpwuF1Gywgv0QT1Oqq9LDiOdiG0QGzWigaQM
         xz7C5xZ75rov/5S+huNW+OioCbk++BKSro8tivaJmk/ltyPFxcwcBM8KE6RcuZFCokMi
         GHUYeBYr+b3UuqK6O4uXwFOEERHFPR1y2aSNZBNBs+uhNt5WLRW2f8vsVVCPEnl2YfNj
         jzM208N0HQ+LHRkNfiiuoPbx0LCqzooF9R2UB7vevtQ1L941SurByakm+R2cVMG6Qevd
         C87SbZdEFQrYVZ7qnZWX1A2RbVTK6uq/snIxTDadLJIa8y7LPVJs8KnLeBiP+ezKoFxe
         DY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScrPtwLifF81mLBCSzco8cbRfT+aGGc+R4ZbxOTPL28=;
        b=fWw3tZDwkMbTLgEBuIFl7XcX8RzzQOTolRRVM2q3FCYJJSyDymMG259q+fpAiKr5+n
         4mgxofMq9BC+uH5TL2pbSGTcwK2FBc5J2BlwOaO3ZR2RRzVd2NjiKssE8l9Vn8aO8WAF
         W8s1GoEigFobTzqN/7xKU7SSg7hI3UZPtZh3XgoCEb2keLTaJa763lFV/2hnCzJ6jOyt
         /4X76MoGgIWOz4dwRyO3bs99Lno7CBtDJHwa748quCM8WZhTaEGHzDTlrWTC4PJCXenx
         OPqE+ipJpPdpNcQdFe/e2PFXz+HH7dRwxdsWOqGBzmXYLMhPf0CUYJAhEbBN8bD/vM3Q
         /Ksw==
X-Gm-Message-State: AAQBX9dNcV3RWhTs4fjkH0fXr7XhsSJ7MT8kJWKQQpUGBcnd3tX7Fbir
        tQ/P/jgPGdt69es/zXlYR4LSRQ==
X-Google-Smtp-Source: AKy350axYry1znftsZjzg8LUEoktyveoFzhwG4Bb7Trgg+J45I/+MtYTQDxD96OldYQ7bQM7Lk76PQ==
X-Received: by 2002:a17:90a:1d1:b0:23b:4f1d:f5d9 with SMTP id 17-20020a17090a01d100b0023b4f1df5d9mr32242983pjd.30.1680281042094;
        Fri, 31 Mar 2023 09:44:02 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902b40d00b0019b089bc8d7sm1798767plr.78.2023.03.31.09.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:44:01 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v4 06/11] dt-bindings: qcom-qce: Add compatibles for SM6115 and QCM2290
Date:   Fri, 31 Mar 2023 22:13:18 +0530
Message-Id: <20230331164323.729093-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
References: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
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

Crypto Engine block on Qualcomm SoCs SM6115 and QCM2290
do not require clocks strictly, so add compatibles for these
SoCs, indicating that they are similar to the flavour
found on SM8150.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 90ddf98a6df9..82ea97568008 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -41,6 +41,8 @@ properties:
 
       - items:
           - enum:
+              - qcom,qcm2290-qce
+              - qcom,sm6115-qce
               - qcom,sm8250-qce
               - qcom,sm8350-qce
               - qcom,sm8450-qce
-- 
2.38.1

