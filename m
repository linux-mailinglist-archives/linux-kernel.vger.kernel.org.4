Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A6670F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjARAvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjARAuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:50:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3B24104
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:38:45 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o17-20020a05600c511100b003db021ef437so397580wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=if8KkFAbX4tKZerzemH1jyXjHQrdZV5HL6+sFppcaEE=;
        b=UCq03fh/I2M2014lZiVw7N56SgAAUOgQG9T2v1I87qpCXLvvtyQitQfhweWYorbHis
         Kqdz4ljUkdnE0LTMUZ8qWsC791hX8aX20UikKzZf3b1S/5NutFpOMfuksBkWNGlbjm5t
         c3wlLhKCFeHtjwKNrP3SZSRJb/kRn/lMRZP7hllUZoynZfSaCDHPSgptQnQ20kMMV0wf
         XabEra27se/cNBbQ+kabLnXbsgpHRzWgcqIXUSS91bN714AhJUQYVgr3fDeps9L6G8d9
         DxJf2KTALWLiJpRhgx73Nv2UfSglTi8VxGHPyeaA2D+EfxJDJe6+QMLsgUV2id37wMOV
         hfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=if8KkFAbX4tKZerzemH1jyXjHQrdZV5HL6+sFppcaEE=;
        b=ze5rTo+LZNSIOreSEpAEkqdJcaRlypR8zH70phU9EIREFvbqD/ynD00obZTdQpXR6h
         2A/ywYDaQIp4RRUy+S2mq71STrwGViGewfN1dTvCxvhyY1vPFfwCdFtSr31PzMcpnIui
         Emh4IXZEYgOdQktKra6Hak+R51dcRWjEuEiMJhUrKn8YgQJ7TfJhny2WBHrVGqQYsIJa
         DgKrrVv1LCk0Um/m1z4BpfIGTtSQiwwNsgaqNZO9l7aiNreAP1B9x/CbTC6wY9tNBjZW
         kZmFLEKCQ0AN1COiVx+S0dpqJ99h2rub2NvF3sfYCl2Ty6IQhqqXv6jWZK9Tv560HZxX
         zisQ==
X-Gm-Message-State: AFqh2kq+0j58AU2m7qj2mux62sGfxJAAeXJ2gSfXxTZbXBt+s+40f/Wd
        XehDvtJJdp/7O9WKYZPSJvOhZw==
X-Google-Smtp-Source: AMrXdXsmWikHKtq+yaeNbFF6+IEq32uJ19G0dYzDbgWfrtAp2920UH1oqOF6G0FKjuY0SeqFI76alA==
X-Received: by 2002:a1c:7414:0:b0:3d9:779e:9788 with SMTP id p20-20020a1c7414000000b003d9779e9788mr616408wmc.37.1674002324362;
        Tue, 17 Jan 2023 16:38:44 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b003d98f92692fsm365199wml.17.2023.01.17.16.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:38:43 -0800 (PST)
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
Subject: [PATCH v2 1/7] phy: qcom-qmp: pcs: Add v6 register offsets
Date:   Wed, 18 Jan 2023 02:38:28 +0200
Message-Id: <20230118003834.2330028-2-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
UFS and PCIE g3x2. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
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

