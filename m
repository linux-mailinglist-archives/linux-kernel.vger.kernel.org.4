Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F05B46B4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIJOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIJOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:32:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4733BC6B;
        Sat, 10 Sep 2022 07:32:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so7069902wma.2;
        Sat, 10 Sep 2022 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tfOkC7rAMPVTo8l6wnriy72fNtCnhfwJaZ8s4WJI0B8=;
        b=n8nSAEALjBXhAavns6HFURS85wmN13q1y+qmsxBjPJ43v0PqEFfsAxQuR5Iy8/x0zl
         cITDJVfWws8ULaiLz4tW7YHqAOq9+Bd7n3gCv1EPSjffN6Fcx2ct04zEVy6BQVgceuv9
         N8ujhqW90A6JjdfxknLAJA7yMSIpEz3BUNw6uai9Yj+JcvxrSCGlDxz+OXQnyaC419Bb
         O6QV2S8ig6X0CoOrnH7pHGJde4ewvxTQ4d466DUW4Vn4GLoMtQ3mqlzHPw5I4vGpmzSP
         LjUoipfIO5s8MXvO3w0hyeOmxbg7jYN3xUjBKw3XxXuqZI5p5CsnYbGOSxoUqF29kQ7K
         CyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tfOkC7rAMPVTo8l6wnriy72fNtCnhfwJaZ8s4WJI0B8=;
        b=8Ce5IWwIojGPwVWlFkUzFvXTEifqD0hsi7kXThJ7cnHlf6wioDmiULsTS1yfW+JSAd
         bfAbx8xvBJ6s3Wm/8uP+0InPES1btupFQe6i1wSmy1XpP7TIwnbNtlxvpK9mdHeu64UH
         7FXOhtZW9hEGEe1PkgUIqiYPPZyaIu5uGln9qoy8R6vhnJ6/wFGO81ovhWi5rvaPQ27s
         EIKB9M3Ki/dbi1qOSFaPXknWN57+IoVmWk/UDWGsTtXmzSbB00gCC7XF+vA1j+q/KPBo
         NbYkhbZMWV6y/w7YITF1At9w8yNO4QHjyMP/yF2At8PIYXsw5cfouqvTBmtgfSkzsW6C
         8acQ==
X-Gm-Message-State: ACgBeo0q3dybNvJtbrVDbQcN6K9SHuyb0e2jhu0Hi6uaEBo6+gxWzLyx
        b+o3WpcnFN+M/Syf0NZZO68=
X-Google-Smtp-Source: AA6agR5SLFVky//jqgsiUiCiDK8+7Q9F7etZ5Dju4IdzM2C0i5p0RF+Jz0PV1oGZtEbYLqEXJujqQw==
X-Received: by 2002:a05:600c:2181:b0:3b4:74e4:16f8 with SMTP id e1-20020a05600c218100b003b474e416f8mr1394617wme.174.1662820334801;
        Sat, 10 Sep 2022 07:32:14 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id v11-20020adff68b000000b0021e5adb92desm2939565wrp.60.2022.09.10.07.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:32:14 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] dt-bindings: ufs: qcom: Add sm6115 binding
Date:   Sat, 10 Sep 2022 17:32:05 +0300
Message-Id: <20220910143213.477261-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910143213.477261-1-iskren.chernev@gmail.com>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM6115 UFS to DT schema.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index f2d6298d926c..b517d76215e3 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,msm8998-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
+          - qcom,sm6115-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
@@ -178,6 +179,31 @@ allOf:
           minItems: 1
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm6115-ufshc
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: core_clk
+            - const: bus_aggr_clk
+            - const: iface_clk
+            - const: core_clk_unipro
+            - const: ref_clk
+            - const: tx_lane0_sync_clk
+            - const: rx_lane0_sync_clk
+            - const: ice_core_clk
+        reg:
+          minItems: 2
+          maxItems: 2
+
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
 unevaluatedProperties: false
-- 
2.37.2

