Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D27357CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjFSNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjFSNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:04:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52CAE65
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f7deee339dso4007637e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179884; x=1689771884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnD8CjcCc/FAeQtS42aEkvj3Zwl/GPxxQhI6lxnE9EI=;
        b=oB9cEEu4UiJi94V5Xwx6bpx3eNn3ZLrJgAdNMSRYEtiFXevRPRzRCekkvkbGs4sLkY
         pBraYmLvpvGxfAuuRwErCZksgEeSwJkF3gH8uOxtwX+Tr1MIL/66hs0MlpVJDXf0v9iI
         DFbHw3FM5Yz08d2WTqKRMT5oo0Y2H/8qv8YM/n1DAs4WDR0vkhz1AYNw+tkUq51L//4k
         k1BGmB82Sf8B3G8h5yqkNB6d2RJljAIr92gbIzsCLpdtPFjvIqgACjYQq+eZe/ivup1a
         wc5evoHrBn0DSFfcegHtPVD9neEuwPu4ZqAG7vkAty/eMw2HMLG6s1xr7BMNDmxEi0fQ
         BUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179884; x=1689771884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnD8CjcCc/FAeQtS42aEkvj3Zwl/GPxxQhI6lxnE9EI=;
        b=lMxoZ3OmOpeHmv0RyZZgfnRicYaW3D5iQbgzpOCzcwH0CoI35nucaNrmbGFKK3G/rE
         /X1WqQEJqfrpmDd91jqMu9Q6x2e0PPH7aHuNPoxvFMMD31CYRCFdtc+2S7U68LpU0FUV
         ZBA/BmEt7xGmQGjU/O7A/xUyybZmbbZwZyYsPEujfsu7jw0uXxE9ezXDZoUEFPFoX57G
         7OOG6IfaAVaaxnQ3Ri7v1S+rdg5tDU7in582Qp4b9ceGUR5uzLgUZXK4GeHcojtBEsf7
         NKiKQNr27nuXsrB/WlB1I/u0NnjGKnEckeaf08SpFkFpvr/LrwzqSVYN6PkNl1Orpp9V
         XQrA==
X-Gm-Message-State: AC+VfDxGE0X0QV7756HP+M9hY0U9fNcpLFCvDIIPV0nLBdGCOAyscty/
        0voLsbd2roYzyobTKcrdxECKug==
X-Google-Smtp-Source: ACHHUZ59WyHczLUGyUBjETGetuPdNVwOjhs+jl94m1ehkqM0Ml+1DE0I2q3sZadjAJidXDnC6K3QlA==
X-Received: by 2002:a19:2d17:0:b0:4f8:55dd:e726 with SMTP id k23-20020a192d17000000b004f855dde726mr5031495lfj.12.1687179884056;
        Mon, 19 Jun 2023 06:04:44 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:33 +0200
Subject: [PATCH v7 08/22] interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-8-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=5476;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YrFfALUF34HtEoPnnGGBWyzkWOZPATnw6OZK7hGMX9k=;
 b=gpOCjx5JNwBfFrc9Ran+sDPC5mFeRsauMPTUzSYDfFasgEAJVKmbeseiJZ5g71uZkt21pehpv
 rk6sDSwBcwTAPSiQ/YK+C5d0XNrygz7t61lmtU3ymxeuxAkqps0yIWA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 80409f59b2c8..3fdf3962b80d 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -13,7 +13,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include "smd-rpm.h"
 #include "icc-common.h"
 #include "icc-rpm.h"
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 899e75e8ebaf..4755e422d2d1 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -6,6 +6,8 @@
 #ifndef __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
+#include <linux/soc/qcom/smd-rpm.h>
+
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <linux/clk.h>
 #include <linux/interconnect-provider.h>
@@ -124,4 +126,7 @@ enum qos_mode {
 int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
 
+bool qcom_icc_rpm_smd_available(void);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+
 #endif
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 518f4b40ecc2..70b67fbe453f 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -14,7 +14,6 @@
 
 #include <dt-bindings/interconnect/qcom,msm8916.h>
 
-#include "smd-rpm.h"
 #include "icc-rpm.h"
 
 enum {
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index a7398c3c7411..b1005dee4e38 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -15,7 +15,6 @@
 
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
index 733213a0b8c1..b03b1d454a41 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -17,7 +17,6 @@
 #include <dt-bindings/interconnect/qcom,msm8996.h>
 
 #include "icc-rpm.h"
-#include "smd-rpm.h"
 #include "msm8996.h"
 
 static const char * const mm_intf_clocks[] = {
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 95ea1f6d25ba..36a53add866d 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 
 #include "icc-rpm.h"
-#include "smd-rpm.h"
 
 enum {
 	QCM2290_MASTER_APPSS_PROC = 1,
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 9292f8ac01b8..1faec0af74e7 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -12,7 +12,6 @@
 #include <linux/of_device.h>
 
 
-#include "smd-rpm.h"
 #include "icc-rpm.h"
 
 enum {
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 904014a9fd32..e7bd86808f13 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -16,7 +16,6 @@
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

