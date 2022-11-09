Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA66229AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiKILJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKILI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:08:56 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031AF175B0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:08:55 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id q9so45842591ejd.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4ruhaK1OB91w9q/CU0a1pwKC1JPetLpgNN37FzbTqY=;
        b=yT5QxRRfzVBjBhrCNIPZPzlRFM4eGLFzRS12CACiGWCUH7UOf4iFrYTbQalID2C0c9
         hfXX927mLIvDG5QNpMmXUPj2eu4DUZeoxaPYUWq2tgVf1lRA/vr7yKc3WjG2fH++Da5H
         Z/+CmlsOj3mPxmJVgTRb1cBcvGCWXDsx+JepsRFtYU2PDI6DnDvWihLB3MvXFAe/oWfh
         5tMzH1gz+cJUTjElxbjt9yw8DEjmaVZRnj/lJAGFUV0FZ1S1ytd3QcoMn+EBvS6O5Lhs
         ATZbVRl9dkiHK78MAYYdLr+sxgoB+cQRWNWRDic+FgdhvvzONpMHsu3sCvIz4l6C7jGk
         b7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4ruhaK1OB91w9q/CU0a1pwKC1JPetLpgNN37FzbTqY=;
        b=RrMRW8S0KXt53NYtNdB9FVGybnHNj+TjWMcOEBIZYZVMFPTyG69LMLC6cF00TihxEX
         QwZvVrK1BevhSooS39GllHmAC/YsRY+H1e6YCvY/rfBney7NkcT1zD8zz/+TScfMQTo3
         nVB0eGVDFWSRZUcMOQ8F4TXaMe7OnGWN/gCNJQvgLOrimlnb6lyMg4D7CkeIvqNMWoYM
         /1PKG4yZmasFAJ+vE65FRFk4XQY+QJB9Ft5wT0m91IKAMZV76y+Pi2OM+qtpGyJLVLQP
         GxQiSI8DdLwK48AYqVPlaCvRo7R7XCf/hofmSSwXHUcW5etRreFqfYCmSJxxo3KfQO4d
         5xzg==
X-Gm-Message-State: ACrzQf2NSV7+1jNOOgJNFIy9swpqaZzMzxQu57yo54RUG/WYbXe06tDb
        nIftHb/Tt2/Px1jxLx2GKGseyw==
X-Google-Smtp-Source: AMsMyM4kfxxIM9+0eLpDUs48blURw8xGzVgJYevV9RFdcwHp/DzGgUnuoe9dZ5t5OX2O7WrgmizN+g==
X-Received: by 2002:a17:907:628a:b0:781:bbff:1d42 with SMTP id nd10-20020a170907628a00b00781bbff1d42mr54767260ejc.375.1667992133489;
        Wed, 09 Nov 2022 03:08:53 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b007add28659b0sm5863468ejx.140.2022.11.09.03.08.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:08:53 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: regulator: qcom,smd: Document PMR735a
Date:   Wed,  9 Nov 2022 12:08:45 +0100
Message-Id: <20221109110846.45789-1-konrad.dybcio@linaro.org>
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

PMR735a also appears to be bundled with some SMD RPM SoCs.
Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml  | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index 961eed51912c..8c45f53212b1 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -71,6 +71,8 @@ description:
 
   For pmi8998, bob
 
+  For pmr735a, s1, s2, s3, l1, l2, l3, l4, l5, l6, l7
+
   For pms405, s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
   l12, l13
 
@@ -98,6 +100,7 @@ properties:
       - qcom,rpm-pma8084-regulators
       - qcom,rpm-pmi8994-regulators
       - qcom,rpm-pmi8998-regulators
+      - qcom,rpm-pmr735a-regulators
       - qcom,rpm-pms405-regulators
 
 patternProperties:
-- 
2.38.1

