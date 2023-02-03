Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7916891FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjBCISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjBCIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:18:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D86212BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:18:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso3217524wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiecONjnq8HfLhexUmKPGLEolULuRBwbc0h4TWAn85E=;
        b=X6mPaZTpjFizpOMchI/a1sHGuRmF2XN4ZbpawbdBkQaHzUmmqgmUmfdiip5ZTdQtAV
         WeBH1su0BBWwp0BFd1OUqPB/XDeHXVgr04815QXfs5ieWC6f+FUW2cgeyhcfQAjOUc13
         ivD6wxIvDq6MkLY8oiCWXy6zueWQmvEGXkgVI0hPQbxvhj2V+qu6AM/Wcf0lwMKetbCi
         ilOdXoYF9mGHc3wRdZsxn1zIsb6XHhhdQLNXwEo+a+jFkaZjUVmK7XteDbx29+myVItC
         30Xx1xbqCVYQ2wbsNl9FRq9ELO2yWAgn0jJyK224Olp7ED2K83UkVUU/nU4M+zMsNoRp
         L7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiecONjnq8HfLhexUmKPGLEolULuRBwbc0h4TWAn85E=;
        b=DGOoUTaoxRzjM/igzbP9eCNiPNZ8ZxDX25774L8fITaGWaEDHeTAtDzpP0D3iWIQVZ
         wrEnryZA7y1mnPmzqJ34NRoN8W8B+9PRw1Aa5ZMkLHwrgvZU0W3RJZEUlqvO8ERr3KN9
         i9UHZhYpLx1tdmTWbn663d/icBHyIydKuuALCb7TlFnX0obYPTvQOxBHlDC+iacEeJGB
         dzP7cZs/uQzLRVbmu6z0gU0yvQazHaG06KtEQGcStjm1oyPzSMxAU+b+qZh+Nb7WXnR8
         WrWIX2h3VbnNtQEh1K8DbosdJJutm4jwiOb/+t+6x/YnNtSMm2CLPm0ahummPPsB+5XF
         8M9A==
X-Gm-Message-State: AO0yUKXADxWQhkb229/WKagn1XXBzuEtpGeyzcPP26n3rD6PmzGg+FCX
        QcG4Smw2Vq+5ADzZr2Tz/i4Oog==
X-Google-Smtp-Source: AK7set/lzTsLd+rgFUvvYg4aOMoZSOb0DfaNnncE/+1uFkDA15IGFp64lTVdeX8TfpGY0utkBqpsZw==
X-Received: by 2002:a05:600c:3c96:b0:3da:516:19ed with SMTP id bg22-20020a05600c3c9600b003da051619edmr8395217wmb.29.1675412295617;
        Fri, 03 Feb 2023 00:18:15 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id az24-20020a05600c601800b003dc4baaedd3sm7316591wmb.37.2023.02.03.00.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:18:15 -0800 (PST)
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
Subject: [PATCH v7 02/12] phy: qcom-qmp: pcs: Add v6 register offsets
Date:   Fri,  3 Feb 2023 10:17:57 +0200
Message-Id: <20230203081807.2248625-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203081807.2248625-1-abel.vesa@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
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

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v6 of this patch is:
https://lore.kernel.org/all/20230202123902.3831491-3-abel.vesa@linaro.org/

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

