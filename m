Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BA7615D82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKBIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKBISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:18:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6C64C0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:18:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v17so12845542plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvETYdbc76kEW0rVObCekapqGD6Z7e93imf/1vvzFKY=;
        b=DHTsrpz8Hjy0gqmYkg8k+jHJGJabu3TzJtjtNmVVvza6+bFvIPY21jau3DuWz4eNg7
         pQhawK7BzpTAHwmjLolIhZ3Eua4JM/ODdv7v4+rrqmGs6rpGsXzV12ev54nEpz16OlOq
         lE7C/3HNI1/uioDRxWQVU4AgGiIREkQWmrGUKp9nDOECn4edbS4OKTNrm5x3TBrcz0nn
         zC22SqrT18Bh8gb5vD3RdDPvLy7/0C7SD06FIPlyr+aQV0vKwlNo2uhhSwj7fZQhUHhA
         l+vHuophjGRNqZFI0ESi8hcKRyP8SqZw1xhJw1WSi+6zEUKLWuD4pH3jlnyHft5NMM0j
         5zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvETYdbc76kEW0rVObCekapqGD6Z7e93imf/1vvzFKY=;
        b=139e3fe+1jVwMKHV6WWwePIIEle7pGUoI6PpyH4KKRvYs/Dx6Xy8i7aoMOuX5BCtKZ
         UMK8kdMFe8TpunZ5brSgw5Bx67e/xrN5sQ32bR4fDgnDxKeiUfIqbpToleTet+0SKIas
         ufquzAZ8lCX+q511bV76WtbZC/q5Nj2TRvQ853W84sM2uqwdMfJeLMS9H67a7saj2HYX
         JRRjPVTwY5NVZD5R5a4tp9tgr9i2x2yuyjPKcXpuUPkogJ1x9EzaZ13Dp4imop9UmmA9
         c3438PpCncf6Dtkp12ARnBAx+JKstORzxb7kQrDvL65SWFI3j9MLFeVa7iZ4ZlBqXzrW
         g5EA==
X-Gm-Message-State: ACrzQf04T2UqDD2aRlr7jXVY+il9N0WSO16STe7VMNktjYOaB2KwIX8W
        ANkzJSfMNYSpyxW/yaLL5biv
X-Google-Smtp-Source: AMsMyM40LpepuHXpzbdSqfp4zIzIq+yFWe+KUkhhol2oFVylhXYKiXUjPwHxcHkyyTQzLYRA+vxrmw==
X-Received: by 2002:a17:902:b944:b0:187:28c4:69a3 with SMTP id h4-20020a170902b94400b0018728c469a3mr12132052pls.134.1667377130498;
        Wed, 02 Nov 2022 01:18:50 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id v18-20020a170902ca9200b00186e8526790sm7635119pld.127.2022.11.02.01.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:18:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] phy: qcom-qmp-pcie: Fix sm8450_qmp_gen4x2_pcie_pcs_tbl[] register names
Date:   Wed,  2 Nov 2022 13:48:35 +0530
Message-Id: <20221102081835.41892-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102081835.41892-1-manivannan.sadhasivam@linaro.org>
References: <20221102081835.41892-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sm8450_qmp_gen4x2_pcie_pcs_tbl[] contains the init sequence for PCS
registers of QMP PHY v5.20. So use the v5.20 specific register names.
Only major change is the rename of PCS_EQ_CONFIG{2/3} registers to
PCS_EQ_CONFIG{4/5}.

Fixes: 2c91bf6bf290 ("phy: qcom-qmp: Add SM8450 PCIe1 PHY support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* New patch

 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  8 ++++----
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h | 14 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 9473f63d2c1c..71bb86c3deff 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1289,10 +1289,10 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_rx_tbl[] = {
 };
 
 static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_tbl[] = {
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG2, 0x16),
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG3, 0x22),
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_G3S2_PRE_GAIN, 0x2e),
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x99),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG4, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_EQ_CONFIG5, 0x22),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_G3S2_PRE_GAIN, 0x2e),
+	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_RX_SIGDET_LVL, 0x99),
 };
 
 static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h
new file mode 100644
index 000000000000..9a5a20daf62c
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V5_20_H_
+#define QCOM_PHY_QMP_PCS_V5_20_H_
+
+#define QPHY_V5_20_PCS_G3S2_PRE_GAIN			0x170
+#define QPHY_V5_20_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_V5_20_PCS_EQ_CONFIG4			0x1e0
+#define QPHY_V5_20_PCS_EQ_CONFIG5			0x1e4
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 26274e3c0cf9..29a48f0436d2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -38,6 +38,7 @@
 #include "phy-qcom-qmp-pcs-pcie-v4_20.h"
 
 #include "phy-qcom-qmp-pcs-v5.h"
+#include "phy-qcom-qmp-pcs-v5_20.h"
 #include "phy-qcom-qmp-pcs-pcie-v5.h"
 #include "phy-qcom-qmp-pcs-usb-v5.h"
 #include "phy-qcom-qmp-pcs-ufs-v5.h"
-- 
2.25.1

