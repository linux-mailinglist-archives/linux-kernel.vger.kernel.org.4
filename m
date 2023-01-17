Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243CA66E04C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjAQOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjAQOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:20:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162843C2B2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:20:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q8so10561045wmo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtdIHI1FrtH18srRT3J+hSb3cMdeCN2ZcbbQNM75CEA=;
        b=Z0VqaYk2yUf8AVshWz4ETaZQDjpCoO59K56sPZFp18Uvz+k/X7qJAuCC2RBDWscFqk
         6+UEYMhuP/P6p6OZOWs+d3oKEug7WRFMH6YHPzJDz9I3+oHR4yBQsQwJRk+/i99/GGZH
         RVAhSA6yIgwCLa7w2mpoiUT3s5Itr7/SqUZBIFTTOiHuu8aK7+8pby1/JPo5+ZZbMKIl
         rUphhHHLlPLrC628IiPYbJyxT6zWJ7ym5zx00T1hrbU8DGOZEM60+nnatRMPxbJCCNLd
         7p0gxPJuLIhV3cnmhm6XMta5Q6DCOimUAdZBA2owQYY8ULvNsGrWnVjkxBdlgqjK3Aqp
         KWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtdIHI1FrtH18srRT3J+hSb3cMdeCN2ZcbbQNM75CEA=;
        b=6hBmwey0hNc7l5GxDQ2w5xUBIdpjet/N77bEzuToRP4q6j+YhD6iXvTgIHl5Sj/nBR
         fXWVJtoXfeMxBRAGV3HXW1xUHPrW8MkCGrK+pS9Y+pOfu851KbYBDqViAQlaD0PD3Kjx
         XM1FTnPI44XnQeYEGrw/j3fKDCkX78Uh8VVkpt/tGMAT6itmQ1yFFH/Ji0Cc1uEuUT7s
         Glr+30UpZwJE0zsmsNoSy4wfRaYZihEwaqgHiYqqPf7BjVvqcxk1xrfbTybZ0ZslblHW
         3prwMt2CJLSSIt6PaQzkMNW5QV/4Aw86HfptSPKAqqTc093Gdya3v0sZOvgdI9tCSYav
         Ik+g==
X-Gm-Message-State: AFqh2kolRtkvD5d+KarlzVNbPxv9Hoc6VisQm4Z1nnIB1N7nBTFMWvW4
        PGMqdjxjhqIdONHO4KtmkC9iakJaNwbFHina
X-Google-Smtp-Source: AMrXdXtfUv7qbOKs9ZrV1yhnUIbgJJs6TJYQYB1my0CVM2WHTu0J8XKwsoNSd1fo3RAvznbeyf06PQ==
X-Received: by 2002:a05:600c:539a:b0:3db:419:8d3b with SMTP id hg26-20020a05600c539a00b003db04198d3bmr3379754wmb.39.1673965235675;
        Tue, 17 Jan 2023 06:20:35 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b003cf894dbc4fsm40443133wmq.25.2023.01.17.06.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:20:35 -0800 (PST)
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 4/6] phy: qcom-qmp: qserdes-txrx-ufs: Add v6 register offsets
Date:   Tue, 17 Jan 2023 16:20:13 +0200
Message-Id: <20230117142015.509675-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117142015.509675-1-abel.vesa@linaro.org>
References: <20230117142015.509675-1-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2. Add the new qserdes TX RX but UFS specific offsets
in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../phy-qcom-qmp-qserdes-txrx-ufs-v6.h        | 30 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  2 ++
 2 files changed, 32 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
new file mode 100644
index 000000000000..6238dd2b8421
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
+
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_TX			0x28
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX			0x2c
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34
+#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0x08
+#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4			0x10
+
+#define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6			0x220
+#define QSERDES_UFS_V6_RX_MODE_RATE2_B3				0x238
+#define QSERDES_UFS_V6_RX_MODE_RATE2_B6				0x244
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B3				0x25c
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B4				0x260
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 110d8fb9309f..a5cdd58c5b4d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -27,6 +27,8 @@
 #include "phy-qcom-qmp-pcs-ufs-v4.h"
 #include "phy-qcom-qmp-pcs-ufs-v5.h"
 
+#include "phy-qcom-qmp-qserdes-txrx-ufs-v6.h"
+
 /* QPHY_SW_RESET bit */
 #define SW_RESET				BIT(0)
 /* QPHY_POWER_DOWN_CONTROL */
-- 
2.34.1

