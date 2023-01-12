Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74506672E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjALNGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjALNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:06:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CDFD13D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ss4so37314941ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbHIds8BFvGtaiOTl0/aVRYn+MTTKrUpCy0OwIBQhqQ=;
        b=J0wlkJdrSQYSqbfYrmFWRf8WEoZAPNQOUZ3DFXBug/xXeuSSPgCDZhqLyOso7VNX/A
         TOSrGXn/6kNPF3WSDFGHwe1Tyy5Es4Wr/0WbAGzV72fx2z3+faKmpcRMcYN8hl+809RX
         k8H7JNx8E2XKhN/QrblkYRLseZ4SJHCl2PipR4+WiqyGqQwvcAwedegboBHKyD5C66q4
         mkPG/AGrM9kWkOtkq0mBqHtlmn4qOrHjNF8qyuC4n/hzHPW5Pd7WanAobJHJlNGU23Ra
         J5VxAx48JKesRqgNnuto5sg/4RU/gP4MvbRD4WmQLKoIevARaCSJFlUJ+UiX7PE+313s
         9mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbHIds8BFvGtaiOTl0/aVRYn+MTTKrUpCy0OwIBQhqQ=;
        b=HpV5VFxi99hkcGa8Po0reeAVst8LAdgc5wblH2D7Vtwxkk7koKwMn8bbXfFjHWhws/
         vNOjrn54fObsMaEgN8Ei0TISlZTqtiOzXBWkMYfupt2dnodb7q/SNFz4ODOqnY+x8K5d
         fTzg97BFtVjgsWIv5+pEyE4bfVDCQe2tSUv2lQ0euMIp08EOj+yPG04uNBQhD7TbHd0h
         7N5NHeqIGwvZew2QGRbVh5X3HhHDw8pSHHljjzV403zQpOaL/tSSlk3viFmJDgI9202q
         WdQCsRRVHg7vwFZPkPWmUrpxgeoz2Ez9mtreCVUgXAJ7aFuXlJcAeHEao7wVuD2ch8pS
         2MOQ==
X-Gm-Message-State: AFqh2kolYT4QeHnsxXgWb48Z3yfdAxiPsusDlhm1aoFWF7YQeuopUf0v
        C2iT8OdziGZaQ/Iq2Kwq2WENng==
X-Google-Smtp-Source: AMrXdXtL/rn2Xiyw3+uwfI0xvT8ajBsruE4yQ8WRSkKeJIEwYzGTJlmoQnVgOZK3IDQhZFM8PBJkSQ==
X-Received: by 2002:a17:907:b681:b0:858:a721:8394 with SMTP id vm1-20020a170907b68100b00858a7218394mr9049653ejc.65.1673528757225;
        Thu, 12 Jan 2023 05:05:57 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b0078d3f96d293sm7427668ejy.30.2023.01.12.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:05:56 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] phy: qcom-qmp: pcs-ufs: Add v6 register offsets
Date:   Thu, 12 Jan 2023 15:05:41 +0200
Message-Id: <20230112130542.1399921-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112130542.1399921-1-abel.vesa@linaro.org>
References: <20230112130542.1399921-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2. Add the new PCS UFS specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h    | 31 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
 2 files changed, 33 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
new file mode 100644
index 000000000000..dde8830257b5
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_UFS_V6_H_
+#define QCOM_PHY_QMP_PCS_UFS_V6_H_
+
+/* Only for QMP V6 PHY - UFS PCS registers */
+#define QPHY_V6_PCS_UFS_PHY_START			0x000
+#define QPHY_V6_PCS_UFS_POWER_DOWN_CONTROL		0x004
+#define QPHY_V6_PCS_UFS_SW_RESET			0x008
+#define QPHY_V6_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB	0x00c
+#define QPHY_V6_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB	0x010
+#define QPHY_V6_PCS_UFS_PLL_CNTL			0x02c
+#define QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
+#define QPHY_V6_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
+#define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
+#define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0bc
+#define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL		0x158
+#define QPHY_V6_PCS_UFS_LINECFG_DISABLE			0x17c
+#define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME		0x184
+#define QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2			0x18c
+#define QPHY_V6_PCS_UFS_TX_PWM_GEAR_BAND		0x178
+#define QPHY_V6_PCS_UFS_TX_HS_GEAR_BAND			0x174
+#define QPHY_V6_PCS_UFS_READY_STATUS			0x1a8
+#define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1		0x1f4
+#define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1		0x1fc
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 6d6108925716..9de8e7e41af0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -49,6 +49,8 @@
 
 #include "phy-qcom-qmp-pcs-pcie-v5_20.h"
 
+#include "phy-qcom-qmp-pcs-ufs-v6.h"
+
 #include "phy-qcom-qmp-pcie-qhp.h"
 
 /* Only for QMP V3 & V4 PHY - DP COM registers */
-- 
2.34.1

