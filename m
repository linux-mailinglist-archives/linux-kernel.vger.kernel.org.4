Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BB72E4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbjFMODq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbjFMOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:03:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4C10F6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b1acd41ad2so68854741fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665002; x=1689257002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGqdYljk/BXQOSadkDKenWACuVWkhdGMQVPkOQZa/PU=;
        b=T9wjS1xvai8jGKhiO/BQFly3LYZm2HhxPTVxSXh0yEXTyU1BuOF6WpzgpMIQAz+rKM
         7NsLyYIU6D9ACP12FI8QHCLj3ytnAqHc6FEtSoEzNA00OnpvS6E+0EfFmXlcSwiE7q9V
         zKZRb84Er9A6/BfpU3Jfld0N3yBk9nFPhJxfyJgMz4px4dBRIlNrV4UJzW0tsJ2i+LUN
         dokP44Jkub7cynBUxLZj7WvwB1zqsq6UydWqElXrEF4jqgOpLOdrqjYN0wi1ZHXCrBRb
         RKJA59E0rpUcMG/m7SC64B/ZpsCXqcju7+Dz7h7jMX6m1y1pB5AV8C8Ex850ArK1HspJ
         u2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665002; x=1689257002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGqdYljk/BXQOSadkDKenWACuVWkhdGMQVPkOQZa/PU=;
        b=hfgbc44r229fGpicP9M2SDnIUmomIkL5AlhqlN8I3deZV/V1Ips7PjTt1F0rQCkgm2
         At8DR20VVVLD8g5AEVrJmyDeCmo6VzBETzHQ0h8sNajQRWV/lzwCknGh+KI92TOySpbD
         PKfjjXlvfzhiFmMiun/pSD/rW0NODBWH6AR+jwAEL6kUamm+FftNzuSy8cZ+jDKjzvxB
         KYnnWawOzr4hSOjR9YIihrstzpeJptiWPJpQnQg31uk3at8MdoMVhRy0vq78u1METJnC
         NIBQsiNsldEs1D+1bj0Sivxp5GLlYc0VmmxxytLLBpqij0GliA0K5XS6xzBwohPe3kgm
         HQnQ==
X-Gm-Message-State: AC+VfDxdeeQGFAQQ+rnGMr1EISagFVSUOh5TDlp9F8EhuZ9NFrUHce9b
        KClIMXsjmcjlcpSDN+ZzmuZK59Z12kCnCYyMkro=
X-Google-Smtp-Source: ACHHUZ6LqPF+2GFvU5PfB2AFfY5eWqpDw+F0gDEEv8al0NsgCCffgEtQAiHrCxUvdPShZn0TNkcxig==
X-Received: by 2002:a2e:9819:0:b0:2b3:31c1:c747 with SMTP id a25-20020a2e9819000000b002b331c1c747mr2014536ljj.24.1686665001699;
        Tue, 13 Jun 2023 07:03:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:07 +0200
Subject: [PATCH v4 07/22] interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-7-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=5451;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ylF4JrhNb4QpLR63mLl/kyJvmecazdKn76bHZ9DX7ks=;
 b=iqlMgzX0oUhKKIGbxMCVENb1BD0LTgwsr/dBuj3oFNeg0QAJEl52NnEKnESMe8q+E6K4LL3Sf
 1TWJe+UWv/rARyse/vFcWzhrzeZCMkRJR3JaUOtJU3CRgBmE2oRKjO9
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smd-rpm.h is not very useful as-is and both files are always included
anyway.. Combine them.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c |  1 -
 drivers/interconnect/qcom/icc-rpm.h |  5 +++++
 drivers/interconnect/qcom/msm8916.c |  1 -
 drivers/interconnect/qcom/msm8939.c |  1 -
 drivers/interconnect/qcom/msm8974.c |  2 +-
 drivers/interconnect/qcom/msm8996.c |  1 -
 drivers/interconnect/qcom/qcm2290.c |  1 -
 drivers/interconnect/qcom/qcs404.c  |  1 -
 drivers/interconnect/qcom/sdm660.c  |  1 -
 drivers/interconnect/qcom/smd-rpm.c |  2 +-
 drivers/interconnect/qcom/smd-rpm.h | 15 ---------------
 11 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 863e8ba1daa2..b8ecf9538ab9 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -14,7 +14,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include "smd-rpm.h"
 #include "icc-common.h"
 #include "icc-rpm.h"
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d2c04c400cad..9ec90e13bfbd 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
+#include <linux/soc/qcom/smd-rpm.h>
+
 #include <dt-bindings/interconnect/qcom,icc.h>
 
 #define RPM_BUS_MASTER_REQ	0x73616d62
@@ -121,4 +123,7 @@ enum qos_mode {
 int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
 
+bool qcom_icc_rpm_smd_available(void);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+
 #endif
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 5c4ba2f37c8e..196b05879896 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -15,7 +15,6 @@
 
 #include <dt-bindings/interconnect/qcom,msm8916.h>
 
-#include "smd-rpm.h"
 #include "icc-rpm.h"
 
 enum {
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index caf0aefad668..639566dce45a 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -16,7 +16,6 @@
 
 #include <dt-bindings/interconnect/qcom,msm8939.h>
 
-#include "smd-rpm.h"
 #include "icc-rpm.h"
 
 enum {
diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 1828deaca443..968162213d40 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -38,7 +38,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "smd-rpm.h"
+#include "icc-rpm.h"
 
 enum {
 	MSM8974_BIMC_MAS_AMPSS_M0 = 1,
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 20340fb62fe6..1f7e88a37acd 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -18,7 +18,6 @@
 #include <dt-bindings/interconnect/qcom,msm8996.h>
 
 #include "icc-rpm.h"
-#include "smd-rpm.h"
 #include "msm8996.h"
 
 static const char * const mm_intf_clocks[] = {
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index a29cdb4fac03..cb636e67a5a4 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 
 #include "icc-rpm.h"
-#include "smd-rpm.h"
 
 enum {
 	QCM2290_MASTER_APPSS_PROC = 1,
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index fae155344332..938283ddd0e3 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -13,7 +13,6 @@
 #include <linux/of_device.h>
 
 
-#include "smd-rpm.h"
 #include "icc-rpm.h"
 
 enum {
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 7ffaf70d62d3..003fc7d110a7 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 
 #include "icc-rpm.h"
-#include "smd-rpm.h"
 
 enum {
 	SDM660_MASTER_IPA = 1,
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index dc8ff8d133a9..b0183262ba66 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
-#include "smd-rpm.h"
+#include "icc-rpm.h"
 
 #define RPM_KEY_BW		0x00007762
 
diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
deleted file mode 100644
index ca9d0327b8ac..000000000000
--- a/drivers/interconnect/qcom/smd-rpm.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2019, Linaro Ltd.
- * Author: Georgi Djakov <georgi.djakov@linaro.org>
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
-#define __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
-
-#include <linux/soc/qcom/smd-rpm.h>
-
-bool qcom_icc_rpm_smd_available(void);
-int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
-
-#endif

-- 
2.41.0

