Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BDA670F24
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjARAwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjARAuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:50:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885BE4858B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:38:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so376076wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUb/S2D/vEg5DXQcpUFp2Jq273wdmh34OP7UkZOQF4I=;
        b=R2mEcqok6JYrd6hI+uMJg2GlORMxPbzmaRt0kLhbLTe1VfpahOcBvzhPysf+MvOpW4
         mH471MTdxiVaVO2fGRe4Pa23QVezlnQpifp4fk6vugs20pbF7BJ0szLJ0lw6MESQwyLB
         xFbfxB9F0zvifo2yUI99hfZJtzyfeM3pTwFoXsW1GAV6ndSfz83LpPMgyVJJS5tZfuth
         YJQ/6hklo3miyMprK5hxs8Af9ek7y7tvgS1LVnYCgZhq9ObaMtWCZGnQF1rWOckoFPeV
         YwbweSqDAVj190D+ie2oGA4xsSFb8p9q3DiBxFIcPEpuy1WaIVu/CW4iR/dPtuUQa8Ai
         yCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUb/S2D/vEg5DXQcpUFp2Jq273wdmh34OP7UkZOQF4I=;
        b=kZCoU4RqMT4dAci080ajpEi3EjzZwK8Rp7WQKQ8PlCcH4h1LySnDdKoL227fGJfE34
         RYjfKL35+9WISHpUmplv4LFv6jiG6rq9TR8X1HVKbe8pUtqccvf1oxXgJK211eOEr66+
         BIXK0/hH8AsWZME6TMBWqJuzOMD7EkXv9HGDBDsQLjom3qDSNNcX5b/FTI12P6+pefJo
         NISO/Kdrc30OD1iFsDtASicJ6DH9dPuWN2YuIYCz0ixTN+ZUHhA8E3x9N5IIDBnSJhOw
         H3rSgTJC5qteXycgJBrdbbWYKmBul9Wh8ydqZxmQlxTSQ/WrS1Tz7ogMcSGMRqgkRvxY
         LSnw==
X-Gm-Message-State: AFqh2kqaYbPWmOBSjujFa0qBiNWGDd+V7HYjDwQeSyCaVtc3bwqrbMvR
        VvOWlg3amx0CnPw/l9Y1XUEATw==
X-Google-Smtp-Source: AMrXdXuOy9ruiudQyEeh1GFJ0qSSteo2YtC/fdafCMAhj+OHLtvU/u7CunUrNz87zK0JYvnds/J34A==
X-Received: by 2002:a05:600c:510d:b0:3da:f6ae:faa9 with SMTP id o13-20020a05600c510d00b003daf6aefaa9mr10134566wms.29.1674002327050;
        Tue, 17 Jan 2023 16:38:47 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b003d98f92692fsm365199wml.17.2023.01.17.16.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:38:46 -0800 (PST)
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
Subject: [PATCH v2 3/7] phy: qcom-qmp: pcs-pcie: Add v6 register offsets
Date:   Wed, 18 Jan 2023 02:38:30 +0200
Message-Id: <20230118003834.2330028-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118003834.2330028-1-abel.vesa@linaro.org>
References: <20230118003834.2330028-1-abel.vesa@linaro.org>
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
UFS and PCIE g3x2. Add the new PCS PCIE specific offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c        |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 21727e90fad1..d4ca38f31e3f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -29,6 +29,7 @@
 #include "phy-qcom-qmp-pcs-pcie-v4_20.h"
 #include "phy-qcom-qmp-pcs-pcie-v5.h"
 #include "phy-qcom-qmp-pcs-pcie-v5_20.h"
+#include "phy-qcom-qmp-pcs-pcie-v6.h"
 #include "phy-qcom-qmp-pcie-qhp.h"
 
 /* QPHY_SW_RESET bit */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
new file mode 100644
index 000000000000..91e70002eb47
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_H_
+
+/* Only for QMP V6 PHY - PCIE have different offsets than V5 */
+#define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG2	0x0c
+#define QPHY_PCIE_V6_PCS_PCIE_POWER_STATE_CONFIG4	0x14
+#define QPHY_PCIE_V6_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x20
+#define QPHY_PCIE_V6_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
+
+#endif
-- 
2.34.1

