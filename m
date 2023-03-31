Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA36D28FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjCaT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCaT7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:59:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A5A135
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:59:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r29so23534766wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680292773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llCiBCLkZ3VwD0RdupEiXDCSemDbuwgN30QJGJfgAvk=;
        b=AfHuBDpHyPAv0Wy3bgsU4YhWoDX8Zu+eGv/I6Fcp1ntbuuU6LHIcH1Q3CfUg3QbEYi
         o4+0BOp9nZjApWH3SDeKmpfyloF19qwgCTU7wujO/1899fH3wI5vF5n5KsSiaMZqbEh8
         wlTYyX/cpu7wUy9tWcn6lYBInPsK7r+3LUspILEljf2ULmfRk9zUmxXqCyXmSGgM5vab
         ZVXwjEXMb7C6YJt39sDj0R5GDAHz+ven7V26NnHiZ5V9Gay6H+6x9wgw6eo6Se6bmNBr
         OhS4zkrK35OH76td3Atl4WDcZib8U85t6oaYHJY7xURVCxof1ZKZZVmm0zokcC+gxCIm
         EtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llCiBCLkZ3VwD0RdupEiXDCSemDbuwgN30QJGJfgAvk=;
        b=7O8MOrL3acFKxw00yB+pH8JFt3KBQA7r7in83yKQwFJzIVAqJiW0QB/AniPf91tVjD
         RMix9lEJfBt/sGd/KC+N1t8Oxpvokk4eEEwzqkdyyWEU/Uv2UNw1KFMfGZDLzCNve+9t
         UURXau8w31ELf/sMHk425fB5swmMkp6VnXtDJKCP90aCIX97m7N+DpNCH62jrZzi/ksf
         1OkmcxlPfeGlW/zu7C8IZ/9U8+TCsYaAxbuC28WOP9hbUnaFS4wTYZjWq/ZvNmufuJ2e
         9BsEJBrkv/9MjhBeYLAwQmX0XnsukYZV6kX560keiuFfUVjsOmpK6L3re+ap04QQwj6x
         QM/g==
X-Gm-Message-State: AAQBX9enHCrbZQwGf8frXDFDPfzHxYiwnVEetVZSiYRVj46FBwminRmx
        +KnXHWZiwQgi39clwKvCeFtZNA==
X-Google-Smtp-Source: AKy350Z43aVx6tVoB3aq8wwPWgiTRQKjqg/qlDEz/CWtiCxXW8luW2LS9OgXhLxuZRTlAJhcWZrp2Q==
X-Received: by 2002:adf:e68d:0:b0:2c7:d575:e8a4 with SMTP id r13-20020adfe68d000000b002c7d575e8a4mr21366630wrm.65.1680292773088;
        Fri, 31 Mar 2023 12:59:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1dc:d1f:e44f:2a1d])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b002cff0e213ddsm2990286wrt.14.2023.03.31.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:59:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: phy: qmp-ufs: describe the UFS PHY for sa8775p
Date:   Fri, 31 Mar 2023 21:59:17 +0200
Message-Id: <20230331195920.582620-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230331195920.582620-1-brgl@bgdev.pl>
References: <20230331195920.582620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a new compatible for the QMP UFS PHY found on sa8775p platforms and
update the clocks property to accommodate three clocks.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 64ed331880f6..a414b2c2d9cc 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,sa8775p-qmp-ufs-phy
       - qcom,sc8280xp-qmp-ufs-phy
       - qcom,sm6125-qmp-ufs-phy
       - qcom,sm8550-qmp-ufs-phy
@@ -24,12 +25,12 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   clock-names:
-    items:
-      - const: ref
-      - const: ref_aux
+    minItems: 2
+    maxItems: 3
 
   power-domains:
     maxItems: 1
@@ -51,6 +52,31 @@ properties:
   "#phy-cells":
     const: 0
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-qmp-ufs-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: ref
+            - const: ref_aux
+            - const: qref
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: ref
+            - const: ref_aux
+
 required:
   - compatible
   - reg
-- 
2.37.2

