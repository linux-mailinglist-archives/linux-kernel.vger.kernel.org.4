Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6EE670F18
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjARAvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjARAuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:50:05 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C4047EFA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:38:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso587696wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aJbCLNImI9LXSbsqFxABvt6t5tPg6gbPY4B/5o0nEw=;
        b=HudhzkXBQWW83l7EYUdJr0Y2d8LTf8yKwLNcudJrsioiuufXV0lD23oab0h/Ip4L4E
         g1dIQV6ANl2jthUSfQaubod+U426X8sO4a72b7Ql/ey6w7JE79KhY+D4Em0pjr2ZjbrI
         i0bJ0jW7qP5hnotuzUs30G/qF84YnByvMb0OqkON7vok6dRbkd5utfWMUK1K72Qzaa0L
         eMzXaIddvHW/GLgPJHkQ+zcq4yLQYTVuHS/24nrb9vohc3Vv5H5gToaIIE6xIIbFlZsn
         v2VDmh9/FGZX2F7q3LxD6wggrreGrky1/s5EIsq6JkLLz/QNk7bHP4bVbvrfF96olEYj
         qgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aJbCLNImI9LXSbsqFxABvt6t5tPg6gbPY4B/5o0nEw=;
        b=TMU6n1ip/FhDUuUwUnc/RMPru+3zcMwA0roPrnADN+9IvGMGfouJszgdzNXM4kj8HG
         XdR5cqacRqliiaTVYbydJGphTJEkWFd2ugxT5CkCnW95Ou6bnxN9nl9LQgvE3HpDAVzM
         VkEbKsXhml4ofXO4uXdkc8xHVZ5pW4/L/WmDzXRsF7fobtxIvwr5BjM3ORv+cP9rsBq9
         FynvTQTKgs6MJ04ZFQwT1prGZCaTyYyUp78bWEbHC/UhRDl3mObidCH1Fex18nvaSh6g
         QT1r57HjoNol64JBkKjBRz7QShTVSEscPjWxBisviMFbXbLFKtjU9Sl0oPz/UA7O0E0e
         v+2Q==
X-Gm-Message-State: AFqh2krWLiQ22h8n0RtgZesfOKQD4l82drm97jv7cgEAnJxEtzKZeGQG
        H1XYgW9kLjQ7/jCUwSC2Lkdaxw==
X-Google-Smtp-Source: AMrXdXsFN7nfJnEj6H/mGba/NLDYNDSULEOa4lvBBggmpGz6tMrGjCUfw3ksWaHU5xzhjYnBopz7kA==
X-Received: by 2002:a05:600c:4347:b0:3da:fc2c:cda8 with SMTP id r7-20020a05600c434700b003dafc2ccda8mr4780307wme.6.1674002325710;
        Tue, 17 Jan 2023 16:38:45 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b003d98f92692fsm365199wml.17.2023.01.17.16.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:38:45 -0800 (PST)
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
Subject: [PATCH v2 2/7] phy: qcom-qmp: pcs: Add v6.20 register offsets
Date:   Wed, 18 Jan 2023 02:38:29 +0200
Message-Id: <20230118003834.2330028-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118003834.2330028-1-abel.vesa@linaro.org>
References: <20230118003834.2330028-1-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6.20 for
PCIE g4x2. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h | 18 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
 2 files changed, 20 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
new file mode 100644
index 000000000000..9c3f1e4950e6
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_20_H_
+#define QCOM_PHY_QMP_PCS_V6_20_H_
+
+/* Only for QMP V6_20 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_20_PCS_G3S2_PRE_GAIN			0x178
+#define QPHY_V6_20_PCS_RX_SIGDET_LVL			0x190
+#define QPHY_V6_20_PCS_COM_ELECIDLE_DLY_SEL		0x1b8
+#define QPHY_V6_20_PCS_TX_RX_CONFIG1			0x1dc
+#define QPHY_V6_20_PCS_TX_RX_CONFIG2			0x1e0
+#define QPHY_V6_20_PCS_EQ_CONFIG4			0x1f8
+#define QPHY_V6_20_PCS_EQ_CONFIG5			0x1fc
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 80e3b5c860b6..760de4c76e5b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -40,6 +40,8 @@
 
 #include "phy-qcom-qmp-pcs-v6.h"
 
+#include "phy-qcom-qmp-pcs-v6_20.h"
+
 /* Only for QMP V3 & V4 PHY - DP COM registers */
 #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
 #define QPHY_V3_DP_COM_SW_RESET				0x04
-- 
2.34.1

