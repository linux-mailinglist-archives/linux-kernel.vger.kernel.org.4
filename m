Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB85670F72
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjARBFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjARBEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:04:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E372D15E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b5so11231687wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aJbCLNImI9LXSbsqFxABvt6t5tPg6gbPY4B/5o0nEw=;
        b=UKW/FXTK17zDNGn+DzXGd4yiGDuy4FHt5DUPwVTCtH5eu+Oug8aZ9yJI0yRBboiEQ9
         O+eoa5ldD9M8AfeZXb0hlKCCEfNVvXU5xRO5Maf3nVRw0hkRFDUwLntiuYYovmUn561G
         U1VGsdLvxyw5vQKazaTh+RyJmj/06W4dmR5DhSCPQYEhNkDu7w7G1AojErfRWdFpQNIH
         CuuhjmF2r6Y9xgFFC/c8UnPrchVe/6Pf4RX+GgPuU7YRXwcpWggIp/XQnJWL0MPoltoF
         /fMtxlVNX7SAFpoyWieioQ0TxN+9Eu9KL9KIRElXRlMqAblJBw8FOE7V3CCnvF6/RIW2
         zu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aJbCLNImI9LXSbsqFxABvt6t5tPg6gbPY4B/5o0nEw=;
        b=FdartHM+4OQ+GfgOkdSyJxGX1C7AgmDRhfDHwsLkLLtQfGzGBtgey9jeco14VyGbBy
         DGTbIMMsiKCRv8LbuqYegbPLKtK22I7iXQVlaz8D5hId6DbWlj1y5YcdDEKeWlIhE3uI
         s9iSfj0qAuQ/UZx2Cu+INXuphHl62nl5NDH2Fzd4B35olrDYz+dhfr8veI430OKVN7ml
         BV5RDs8nH07j5Xw3J3myMKa18DNyv+9LbiWLnSZJ2AZII0bIZw/5+b3DDbXZgQhcwR6D
         wVYEQ5cNKrZijbgh5/aGdM//f+ZtFcPvlg3742phesVRI51oy7wR4EvFvxkM5rrFO6c/
         4N0Q==
X-Gm-Message-State: AFqh2kqx4n6Ss2Cr0N+FC62queo7RGyjOJqArgFKvnDkb7J6pZeHGn9s
        TT7x7Zq9yjeQ2ySV/Pr1UTNSwA==
X-Google-Smtp-Source: AMrXdXtc3am9HAqbZU461KF8cylAvXEv9uDAqM4771WYxxFWj4kJpZCVoWZ+xPG8+mhhKHTy0VZvZg==
X-Received: by 2002:adf:e385:0:b0:2bd:d136:9eac with SMTP id e5-20020adfe385000000b002bdd1369eacmr4160407wrm.9.1674003215434;
        Tue, 17 Jan 2023 16:53:35 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm29609705wrx.21.2023.01.17.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:53:34 -0800 (PST)
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
Subject: [PATCH v3 3/8] phy: qcom-qmp: pcs: Add v6.20 register offsets
Date:   Wed, 18 Jan 2023 02:53:23 +0200
Message-Id: <20230118005328.2378792-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118005328.2378792-1-abel.vesa@linaro.org>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
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

