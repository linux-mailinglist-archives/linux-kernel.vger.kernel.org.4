Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C932C6A01ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjBWEXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjBWEWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:22:33 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7415A49892
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:21:23 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso561071oti.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+KyrF1DXPa/BBYyuptUwg7+QHC/Wtb90A7GWVnf/LQ=;
        b=F42rBy0uNCTG5FsGgWJ7gvpyDmSYfo3yFM5gZac73TMYx+LrwX1jO7AwW9dyjHka0h
         rnHYGX9Wz5vnkb7lNdAosUAC4awxAvzZNGPYxxmbUkBwAdaZMya9euLYtRK5z9j8f+47
         TITlZAVhSxWZeTGAjCFg4QLmHwOg+gl5HJyOR6cP71MeSXdW5OkaIbQ9cMf/ZG/zrDTc
         +fP8NP7Qcz5t1OvWj1iB4G1vHMUZijn1ik1LoNN3MsA92wmsTfB7uNoI57WowQUtAw9e
         2gUvAok7e8ZywAy2RfIzRREBCY01wJaBM26hgusDPeAy5CcVpckpu/USushlNF0j1M22
         wD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+KyrF1DXPa/BBYyuptUwg7+QHC/Wtb90A7GWVnf/LQ=;
        b=4LQvWxYkjk2kmaMWEBt/5lnK4+W5veO9EVX9Z3pJ/ajWIrwCTRHsMUZSb+NyivozkH
         nik+hIXW4tNOZqDhWtj48xtL+8RmyboV6ungt/rkXkQNzEmOEqbu1209RocAVOFlJfAZ
         W+t2to1DuQ0FnxjCDh8EcRy7YzSGcNzX0Tg+QW071ylsxsHD8e4F5XbrE0BLWax586yw
         /h24r2hYltgEiqTdqOya41ogVSGezHAGVp1XQQsOov3p5SQE6KtSAxF7Geq2IFjh4En3
         pDDV1vvkoskUei9cNrPSUSkKh8Vmbubg+QniQdXn+hhuW43BU1zl326T4GaL6uQ7th2J
         mI4g==
X-Gm-Message-State: AO0yUKW2bY9nJJYngIR88f6iCr1b8cY94bE9cUWO8Smqb3MEN1Dc4dgF
        a5rbVrHtm2sbsQaUB0gbWxaixQ==
X-Google-Smtp-Source: AK7set+jvVKbzwVqAV0SPhuE7cVbyzq+q+DqSnejyIwB+JA1S1TT05zoCY2O7j66FLwanJ04I8nKMQ==
X-Received: by 2002:a9d:1788:0:b0:690:ece7:62d2 with SMTP id j8-20020a9d1788000000b00690ece762d2mr2237610otj.19.1677126079713;
        Wed, 22 Feb 2023 20:21:19 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id l3-20020a9d5503000000b00693c66c0692sm1708793oth.29.2023.02.22.20.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:21:19 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Virag <virag.david003@gmail.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: clock: exynos850: Add Exynos850 CMU_G3D
Date:   Wed, 22 Feb 2023 22:21:28 -0600
Message-Id: <20230223042133.26551-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230223042133.26551-1-semen.protsenko@linaro.org>
References: <20230223042133.26551-1-semen.protsenko@linaro.org>
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

CMU_G3D generates Gondul GPU and bus clocks for BLK_G3D.
Add clock indices and binding documentation for CMU_G3D.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Rebased on top of most recent soc/for-next tree
  - Added Rob Herring Acked-by tag

 .../clock/samsung,exynos850-clock.yaml        | 19 ++++++++++++++++++
 include/dt-bindings/clock/exynos850.h         | 20 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
index 141cf173f87d..8aa87b8c1b33 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
@@ -37,6 +37,7 @@ properties:
       - samsung,exynos850-cmu-cmgp
       - samsung,exynos850-cmu-core
       - samsung,exynos850-cmu-dpu
+      - samsung,exynos850-cmu-g3d
       - samsung,exynos850-cmu-hsi
       - samsung,exynos850-cmu-is
       - samsung,exynos850-cmu-mfcmscl
@@ -169,6 +170,24 @@ allOf:
             - const: oscclk
             - const: dout_dpu
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos850-cmu-g3d
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: G3D clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_g3d_switch
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/exynos850.h b/include/dt-bindings/clock/exynos850.h
index 88d5289883d3..8bb62e43fd60 100644
--- a/include/dt-bindings/clock/exynos850.h
+++ b/include/dt-bindings/clock/exynos850.h
@@ -85,7 +85,10 @@
 #define CLK_DOUT_MFCMSCL_M2M		73
 #define CLK_DOUT_MFCMSCL_MCSC		74
 #define CLK_DOUT_MFCMSCL_JPEG		75
-#define TOP_NR_CLK			76
+#define CLK_MOUT_G3D_SWITCH		76
+#define CLK_GOUT_G3D_SWITCH		77
+#define CLK_DOUT_G3D_SWITCH		78
+#define TOP_NR_CLK			79
 
 /* CMU_APM */
 #define CLK_RCO_I3C_PMIC		1
@@ -195,6 +198,21 @@
 #define CLK_GOUT_SYSREG_CMGP_PCLK	15
 #define CMGP_NR_CLK			16
 
+/* CMU_G3D */
+#define CLK_FOUT_G3D_PLL		1
+#define CLK_MOUT_G3D_PLL		2
+#define CLK_MOUT_G3D_SWITCH_USER	3
+#define CLK_MOUT_G3D_BUSD		4
+#define CLK_DOUT_G3D_BUSP		5
+#define CLK_GOUT_G3D_CMU_G3D_PCLK	6
+#define CLK_GOUT_G3D_GPU_CLK		7
+#define CLK_GOUT_G3D_TZPC_PCLK		8
+#define CLK_GOUT_G3D_GRAY2BIN_CLK	9
+#define CLK_GOUT_G3D_BUSD_CLK		10
+#define CLK_GOUT_G3D_BUSP_CLK		11
+#define CLK_GOUT_G3D_SYSREG_PCLK	12
+#define G3D_NR_CLK			13
+
 /* CMU_HSI */
 #define CLK_MOUT_HSI_BUS_USER		1
 #define CLK_MOUT_HSI_MMC_CARD_USER	2
-- 
2.39.1

