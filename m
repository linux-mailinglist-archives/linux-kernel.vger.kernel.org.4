Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC046DDB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDKM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjDKM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:59:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666674EEE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:59:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id he13so9485858wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681217956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA3SCmMmUD/IAk9Z1v5rltTbTYq+SKdjhm6lfHHp658=;
        b=JQNE1IfchbIn2GVpDDiaQ/zSPZ4+3Hd8CBeaUohmmz370EsZdeXyd3ZiFZ2RokeCHL
         GYlLLNw9h7PDbGYhKHqKk9UZURSHFaBYBuuKRO+vlFn+fJ9D0MxAWkpBcePyzlROQxSk
         UrVHGX3TqwoBBDKvBU4oWlpvdUTapDOx1w13AadmfrMjU0JSu2xWru80cnTKUzTSCuU2
         F1URxs3NbTxBIC1lpP9SLwEbAF9RDK4mlTDRyQetTqX1XYXFexQwV+vS0DKma5onroEP
         Ox1+Ouc5QgxWp8EQIwwcuWBRvDMojNocEQFC346/v3Czk2vepE37cGpv2FValB5YJhzi
         Izag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681217956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA3SCmMmUD/IAk9Z1v5rltTbTYq+SKdjhm6lfHHp658=;
        b=hJWC4jT25CHNKv2vsakFGS44Kv//eFeOTqI9by8BTDxB8axs0biGbCGVy/3QuAjAWb
         o1S+GoSSMWeC0tg8l3NCPJZi3ENrPVAGNcCC40ILyv1l16SNOkBcpFB+PilSvYngj2JJ
         p1MpVv9ybc5CHLZq4j9ZG2zu+WC3reI7U1uTGRagrQpgzc830ebdVxYxiX3ck730smWS
         7TO/P6ssLVpv2HavtpeeeSwLeWrofjZLyh7Aok1T2VgEXiUlemaa7v2NTOasRewrGJsb
         xtbUbFqeThBHJJ4bba5qbezzZmiyJ/afXxH6wkQuHclrVuCVmky/kk8/Fkmohj1RxhDs
         Z9HA==
X-Gm-Message-State: AAQBX9dNyEs5/xYYalghtdfWmiAyjmc/ch6ICwU/Ke9iBqtnahBwClPd
        jTO7wj+FrVUiI/RUZ0lpuqZRmg==
X-Google-Smtp-Source: AKy350baywg3HOg439/TevC2LolspPa+LK7BM0K/XWVinG0RZSlL/iGwnRcymLvmvmEhHVb4axzPBA==
X-Received: by 2002:a7b:c842:0:b0:3ed:88f5:160a with SMTP id c2-20020a7bc842000000b003ed88f5160amr2005327wml.11.1681217955867;
        Tue, 11 Apr 2023 05:59:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a099:fc1d:c99a:bfc3])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003eae73f0fc1sm16944591wme.18.2023.04.11.05.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:59:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/7] dt-bindings: clock: qcom: describe the GPUCC clock for SA8775P
Date:   Tue, 11 Apr 2023 14:59:04 +0200
Message-Id: <20230411125910.401075-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230411125910.401075-1-brgl@bgdev.pl>
References: <20230411125910.401075-1-brgl@bgdev.pl>
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

Add the compatible for the Qualcomm Graphics Clock control module present
on sa8775p platforms. It matches the generic QCom GPUCC description. Add
device-specific DT bindings defines as well.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 +
 .../dt-bindings/clock/qcom,sa8775p-gpucc.h    | 50 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-gpucc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index db53eb288995..1e3dc9deded9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -15,6 +15,7 @@ description: |
 
   See also::
     include/dt-bindings/clock/qcom,gpucc-sdm845.h
+    include/dt-bindings/clock/qcom,gpucc-sa8775p.h
     include/dt-bindings/clock/qcom,gpucc-sc7180.h
     include/dt-bindings/clock/qcom,gpucc-sc7280.h
     include/dt-bindings/clock/qcom,gpucc-sc8280xp.h
@@ -27,6 +28,7 @@ properties:
   compatible:
     enum:
       - qcom,sdm845-gpucc
+      - qcom,sa8775p-gpucc
       - qcom,sc7180-gpucc
       - qcom,sc7280-gpucc
       - qcom,sc8180x-gpucc
diff --git a/include/dt-bindings/clock/qcom,sa8775p-gpucc.h b/include/dt-bindings/clock/qcom,sa8775p-gpucc.h
new file mode 100644
index 000000000000..a5fd784b1ea2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sa8775p-gpucc.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPUCC_SA8775P_H
+#define _DT_BINDINGS_CLK_QCOM_GPUCC_SA8775P_H
+
+/* GPU_CC clocks */
+#define GPU_CC_PLL0				0
+#define GPU_CC_PLL1				1
+#define GPU_CC_AHB_CLK				2
+#define GPU_CC_CB_CLK				3
+#define GPU_CC_CRC_AHB_CLK			4
+#define GPU_CC_CX_FF_CLK			5
+#define GPU_CC_CX_GMU_CLK			6
+#define GPU_CC_CX_SNOC_DVM_CLK			7
+#define GPU_CC_CXO_AON_CLK			8
+#define GPU_CC_CXO_CLK				9
+#define GPU_CC_DEMET_CLK			10
+#define GPU_CC_DEMET_DIV_CLK_SRC		11
+#define GPU_CC_FF_CLK_SRC			12
+#define GPU_CC_GMU_CLK_SRC			13
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK		14
+#define GPU_CC_HUB_AHB_DIV_CLK_SRC		15
+#define GPU_CC_HUB_AON_CLK			16
+#define GPU_CC_HUB_CLK_SRC			17
+#define GPU_CC_HUB_CX_INT_CLK			18
+#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC		19
+#define GPU_CC_MEMNOC_GFX_CLK			20
+#define GPU_CC_SLEEP_CLK			21
+#define GPU_CC_XO_CLK_SRC			22
+
+/* GPU_CC resets */
+#define GPUCC_GPU_CC_ACD_BCR			0
+#define GPUCC_GPU_CC_CB_BCR			1
+#define GPUCC_GPU_CC_CX_BCR			2
+#define GPUCC_GPU_CC_FAST_HUB_BCR		3
+#define GPUCC_GPU_CC_FF_BCR			4
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		5
+#define GPUCC_GPU_CC_GMU_BCR			6
+#define GPUCC_GPU_CC_GX_BCR			7
+#define GPUCC_GPU_CC_XO_BCR			8
+
+/* GPU_CC power domains */
+#define GPU_CC_CX_GDSC				0
+#define GPU_CC_GX_GDSC				1
+
+#endif /* _DT_BINDINGS_CLK_QCOM_GPUCC_SA8775P_H */
-- 
2.37.2

