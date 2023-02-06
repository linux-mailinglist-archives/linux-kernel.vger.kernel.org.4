Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A02968C8A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjBFV0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBFV0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:26:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38913DCF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:26:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so11718474wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CdmZAvSDf3YUddspjlpEUpILIeMtabhNAIwhnaltBU=;
        b=xkeb1YIqT9oz9L3dgqAR2zf28izb/lIwSM6sy7voQ+vg5sYYiOJjcn/g91BTJSdjs2
         GLFUadNMoyG9Z4yidu4FjVVNGuKzUHf39ypWNyh5nbunACeXI47PKeTHEdZu841yR5Bz
         xrZ2eB0jXTpXeQ2aJSYD94t5MVf/py0iiJwUrzY+1C9udpX6fDPdnWRhPMIwGxugcKeR
         pu+4aMej+nyJ+XYAtfHoXfYMid57xqgQWzID7YZz0j9V0hX1kphZIOy6OJSMHSYyVKZ0
         FsDfTddOtFkshD1Dz5Y3x6xd5fEcFhk3g3k+0QUt3vD7vYk0ulU4BtzTJNLruC10xmSK
         vEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CdmZAvSDf3YUddspjlpEUpILIeMtabhNAIwhnaltBU=;
        b=zjV64Sem4K5vKDg/32wZvvhhSFBwlZw//sha+i2gAvIojcOPRAMchNcjABfZGSe3/T
         zAlt2cfTIjwA+xDiq6EKpnWGYCBp1Vg1H05lGica2SgISzRUcU6H59r2R1QlLh9K+DTI
         /4eZZ93QWGceT868dd8Kd8VRxOj8xqKjMXH6g/4WxX8iD0WihvujmwQ0DdaVWj0NJV2w
         Xa8DD/TmHJzeXyXJKhXpDqwtLzgrBaYW339/bTVHDO7kwQtm9+Itjwoe0WnKZbktY6Zr
         Qvex2/wcxHyZZ01G/ou5ToLahnTmEABuA+UGqtA+vSKPZPWEzVLTV/jUvl8eiY2MCTPN
         wnIA==
X-Gm-Message-State: AO0yUKWM12jJ5E3TeKaf47faIRepbdpfLRm2fquaaUZxy7nxDiF0QljU
        Fj9OIgmqsdehSOPfBMcum23wcA==
X-Google-Smtp-Source: AK7set8qwzmP/ZkyJr2uk+dl990xJNi3UxBhYjoQOqCzBx9mn4iqNs0qDgRvos9OiqTYQ7L+qtr3VQ==
X-Received: by 2002:a05:6000:cd:b0:2c3:dc42:524e with SMTP id q13-20020a05600000cd00b002c3dc42524emr356754wrx.10.1675718786483;
        Mon, 06 Feb 2023 13:26:26 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b002b57bae7174sm9783341wrt.5.2023.02.06.13.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:26:26 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v8 02/11] phy: qcom-qmp: pcs: Add v6 register offsets
Date:   Mon,  6 Feb 2023 23:26:10 +0200
Message-Id: <20230206212619.3218741-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206212619.3218741-1-abel.vesa@linaro.org>
References: <20230206212619.3218741-1-abel.vesa@linaro.org>
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
UFS and PCIE g3x2. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

The v7 of this patch is:
https://lore.kernel.org/all/20230203081807.2248625-3-abel.vesa@linaro.org/

Changes since v7:
 * none

Changes since v6:
 * none

Changes since v5:
 * none

Changes since v4:
 * none

Changes since v3:
 * added Dmitry's R-b tag

Changes since v2:
 * none

Changes since v1:
 * split all the offsets into separate patches, like Vinod suggested


 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h | 16 ++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h        |  2 ++
 2 files changed, 18 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
new file mode 100644
index 000000000000..18c4a3abe590
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_H_
+#define QCOM_PHY_QMP_PCS_V6_H_
+
+/* Only for QMP V6 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_PCS_REFGEN_REQ_CONFIG1		0xdc
+#define QPHY_V6_PCS_RX_SIGDET_LVL		0x188
+#define QPHY_V6_PCS_RATE_SLEW_CNTRL1		0x198
+#define QPHY_V6_PCS_EQ_CONFIG2			0x1e0
+#define QPHY_V6_PCS_PCS_TX_RX_CONFIG		0x1d0
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index a63a691b8372..80e3b5c860b6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -38,6 +38,8 @@
 
 #include "phy-qcom-qmp-pcs-v5_20.h"
 
+#include "phy-qcom-qmp-pcs-v6.h"
+
 /* Only for QMP V3 & V4 PHY - DP COM registers */
 #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
 #define QPHY_V3_DP_COM_SW_RESET				0x04
-- 
2.34.1

