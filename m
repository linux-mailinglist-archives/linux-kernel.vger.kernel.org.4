Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6B66DE45
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjAQM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjAQM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:56:09 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9C305E5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:56:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so4751121wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtdIHI1FrtH18srRT3J+hSb3cMdeCN2ZcbbQNM75CEA=;
        b=fxnU8xLS26QJ/X1BI4EbuhxqOjMtiQpKjwAqoqGDbMZm7HXnTnWDVk17wjIpzsji59
         I+vwuuMwUA2FcnoKsrfPNryrdDDmc07bnwKngvii3Ql7JWZgC42q9fjGa4daOiJrxPDw
         vu+ikRWEH/molleLzEp14MXJ7aWNhLeX/0QJE+24tklNOHUcdnK+O6expXav18ew4Oto
         7mjyGEDu18D/B84JJIjxjXpNgICS5rIgaEJY43obmzhAUiAmzxVpALoEZCy1gwgiM16V
         SHPAw+D5Tk1/MEzL057i8TMEA7Ap4rOBH6MxfKYZrhjwSIWJuxSIQL2Z8QsTlV2TCtTd
         0l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtdIHI1FrtH18srRT3J+hSb3cMdeCN2ZcbbQNM75CEA=;
        b=A91cE9QmrLwHM6elHbwTwO3KonDpOz72aLkD4vzPKRbM/UDj33tWNjhGRrEkc8ic12
         rDkXD3emds2yXQceKWfg3LtOD5aHSE3YswlxMlZ0clLwo8KwsUI11JVPPheRZvJBFYXf
         LpmXnmaXSY0NvxJe8n9m+yFNVoMjElQOGDwFYdGqzkZOooEKEfBhhREn8l5satogV0SR
         7VYNZn75MSzkgCznq3PvYUb40duVGSoorsDyH69baHAzWHzNz2gNZGSg/T0uNS0Md35o
         uEBWXm7JkIfg78PB/ykSH6EqqlNblto0Y330BQvtHwQ3IBkEsNLHUAudcMozi0XL8mVX
         +MBA==
X-Gm-Message-State: AFqh2kpV6UblguNG+QK635KTrbqbunMxPn80eLDybSkjHPf+AmZH/s11
        5/+XsL0FzfBfySUTQfaTuO3lHA==
X-Google-Smtp-Source: AMrXdXsExH0fa73mCl+7+GFfyZ6FC3iY7VcDQ1x7qAWIVeV4b0C9Ze1u0Cyzpt8R1aTIE9MPF0XTVw==
X-Received: by 2002:a05:600c:2e14:b0:3d4:a1ba:a971 with SMTP id o20-20020a05600c2e1400b003d4a1baa971mr2928140wmf.24.1673960166788;
        Tue, 17 Jan 2023 04:56:06 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm45069778wmo.39.2023.01.17.04.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 04:56:06 -0800 (PST)
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
Subject: [PATCH v3 4/6] phy: qcom-qmp: qserdes-txrx-ufs: Add v6 register offsets
Date:   Tue, 17 Jan 2023 14:55:53 +0200
Message-Id: <20230117125555.163087-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117125555.163087-1-abel.vesa@linaro.org>
References: <20230117125555.163087-1-abel.vesa@linaro.org>
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

