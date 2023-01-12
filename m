Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDEF6672E8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjALNGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjALNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:06:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563DC62E7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:56 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw16so32736581ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TbbMx9AwD2wS1jDEPU/HFPfiqv+I2QRqu4yPvQGj3o=;
        b=MkaNKurhvS56nKmoz8XoRgAA3TtW01K9wrnOYdnaFaIlrzjqAtaFGDtOZDGW/QPzYg
         P+aMaUxGOTmuYhwzbAR074dlLOYddIJvTphmIRa8viuVH0gAzFR8xp+qTq+XV9sLu4G3
         PlEie8POB0W5+1UsDzm9hrM8hEcpWEXScPsjMUkpohCBi4jmNu4CdQrpA7Fc4SsN8g8d
         CBLTF60deOhxkNx/jjeo6CP+R/Bi75Bgh4d4CWFeeBvlMnZg03N1NnKap4EzQm9WErvY
         w2YNc9oLUYgLeza5qGthZPOCkyWpQJJoFnuycdJPFq3lLCidisvlC2Ob08EeiFl5n7Zi
         p8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TbbMx9AwD2wS1jDEPU/HFPfiqv+I2QRqu4yPvQGj3o=;
        b=BUQyJVwhnpxIv2cmjUHceTmXpqn1JE26tnVVkAC09jEiAv+y3hz293fP87QPcEnAah
         HzwfaqE7LnqQeEDVGUwBJx/iVOhn3M2spIQsKKuB5awE+Bgfyt9r60JGXB+PzY2kM+0E
         U8BNxfoL74zorykcP5adzuZtlexdxR/xCp2qludc7eWhfZ1ms7MtcbUzncNaTTCOStKB
         jN6MOu8m+sHK8CuAKWMxyHkwacDjyrHr4DHsHppCZNb0mLDoFJDTLrvl65DePKTqxFcT
         aCmf5eg017qqqRtA99nZNJ8lQwXBnPduUPlC+W/4CIUgfrFzPUeTPVE2QoRfxEAQdVSs
         8SRQ==
X-Gm-Message-State: AFqh2kqzP+fcRWKZGAw7Fa1duMm9Wjdk3kaCkMaaMB2oglC8YZmiT0sn
        07UNUoZo7oTJ7qOo+7z8o4Wtzg==
X-Google-Smtp-Source: AMrXdXuI0iCRnSwAQAQf14AIzdkeR2ljIRr6sU46e2twAeNuJ6JUSZ7ENLZxvYOWag29S7u1svcvpw==
X-Received: by 2002:a17:907:c786:b0:7ad:a797:5bb9 with SMTP id tz6-20020a170907c78600b007ada7975bb9mr89186605ejc.29.1673528754572;
        Thu, 12 Jan 2023 05:05:54 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b0078d3f96d293sm7427668ejy.30.2023.01.12.05.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:05:54 -0800 (PST)
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
Subject: [PATCH v2 3/6] phy: qcom-qmp: qserdes-txrx: Add v6 register offsets
Date:   Thu, 12 Jan 2023 15:05:39 +0200
Message-Id: <20230112130542.1399921-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112130542.1399921-1-abel.vesa@linaro.org>
References: <20230112130542.1399921-1-abel.vesa@linaro.org>
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
UFS and PCIE g3x2. Add the new qserdes TX RX offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h   | 77 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  1 +
 2 files changed, 78 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
new file mode 100644
index 000000000000..ba45b554b6f5
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_USB_V6_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_USB_V6_H_
+
+#define QSERDES_V6_TX_CLKBUF_ENABLE				0x08
+#define QSERDES_V6_TX_RESET_TSYNC_EN				0x1c
+#define QSERDES_V6_TX_PRE_STALL_LDO_BOOST_EN			0x20
+#define QSERDES_V6_TX_TX_BAND					0x24
+#define QSERDES_V6_TX_INTERFACE_SELECT				0x2c
+#define QSERDES_V6_TX_RES_CODE_LANE_TX				0x34
+#define QSERDES_V6_TX_RES_CODE_LANE_RX				0x38
+#define QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX			0x3c
+#define QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX			0x40
+#define QSERDES_V6_TX_PARRATE_REC_DETECT_IDLE_EN		0x60
+#define QSERDES_V6_TX_BIST_PATTERN7				0x7c
+#define QSERDES_V6_TX_LANE_MODE_1				0x84
+#define QSERDES_V6_TX_LANE_MODE_3				0x8c
+#define QSERDES_V6_TX_LANE_MODE_4				0x90
+#define QSERDES_V6_TX_LANE_MODE_5				0x94
+#define QSERDES_V6_TX_RCV_DETECT_LVL_2				0xa4
+#define QSERDES_V6_TX_TRAN_DRVR_EMP_EN				0xc0
+#define QSERDES_V6_TX_TX_INTERFACE_MODE				0xc4
+#define QSERDES_V6_TX_VMODE_CTRL1				0xc8
+#define QSERDES_V6_TX_PI_QEC_CTRL				0xe4
+
+#define QSERDES_V6_RX_UCDR_FO_GAIN				0x08
+#define QSERDES_V6_RX_UCDR_SO_GAIN				0x14
+#define QSERDES_V6_RX_UCDR_FASTLOCK_FO_GAIN			0x30
+#define QSERDES_V6_RX_UCDR_SO_SATURATION_AND_ENABLE		0x34
+#define QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_LOW			0x3c
+#define QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_HIGH			0x40
+#define QSERDES_V6_RX_UCDR_PI_CONTROLS				0x44
+#define QSERDES_V6_RX_UCDR_SB2_THRESH1				0x4c
+#define QSERDES_V6_RX_UCDR_SB2_THRESH2				0x50
+#define QSERDES_V6_RX_UCDR_SB2_GAIN1				0x54
+#define QSERDES_V6_RX_UCDR_SB2_GAIN2				0x58
+#define QSERDES_V6_RX_AUX_DATA_TCOARSE_TFINE			0x60
+#define QSERDES_V6_RX_TX_ADAPT_POST_THRESH			0xcc
+#define QSERDES_V6_RX_VGA_CAL_CNTRL1				0xd4
+#define QSERDES_V6_RX_VGA_CAL_CNTRL2				0xd8
+#define QSERDES_V6_RX_GM_CAL					0xdc
+#define QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL2			0xec
+#define QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL3			0xf0
+#define QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL4			0xf4
+#define QSERDES_V6_RX_RX_IDAC_TSETTLE_LOW			0xf8
+#define QSERDES_V6_RX_RX_IDAC_TSETTLE_HIGH			0xfc
+#define QSERDES_V6_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x110
+#define QSERDES_V6_RX_SIDGET_ENABLES				0x118
+#define QSERDES_V6_RX_SIGDET_CNTRL				0x11c
+#define QSERDES_V6_RX_SIGDET_DEGLITCH_CNTRL			0x124
+#define QSERDES_V6_RX_RX_MODE_00_LOW				0x15c
+#define QSERDES_V6_RX_RX_MODE_00_HIGH				0x160
+#define QSERDES_V6_RX_RX_MODE_00_HIGH2				0x164
+#define QSERDES_V6_RX_RX_MODE_00_HIGH3				0x168
+#define QSERDES_V6_RX_RX_MODE_00_HIGH4				0x16c
+#define QSERDES_V6_RX_RX_MODE_01_LOW				0x170
+#define QSERDES_V6_RX_RX_MODE_01_HIGH				0x174
+#define QSERDES_V6_RX_RX_MODE_01_HIGH2				0x178
+#define QSERDES_V6_RX_RX_MODE_01_HIGH3				0x17c
+#define QSERDES_V6_RX_RX_MODE_01_HIGH4				0x180
+#define QSERDES_V6_RX_RX_MODE_10_LOW				0x184
+#define QSERDES_V6_RX_RX_MODE_10_HIGH				0x188
+#define QSERDES_V6_RX_RX_MODE_10_HIGH2				0x18c
+#define QSERDES_V6_RX_RX_MODE_10_HIGH3				0x190
+#define QSERDES_V6_RX_RX_MODE_10_HIGH4				0x194
+#define QSERDES_V6_RX_DFE_EN_TIMER				0x1a0
+#define QSERDES_V6_RX_DFE_CTLE_POST_CAL_OFFSET			0x1a4
+#define QSERDES_V6_RX_DCC_CTRL1					0x1a8
+#define QSERDES_V6_RX_VTH_CODE					0x1b0
+#define QSERDES_V6_RX_SIGDET_CAL_CTRL1				0x1e4
+#define QSERDES_V6_RX_SIGDET_CAL_TRIM				0x1f8
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 70b3bf7e5e37..62796ff5c35e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -22,6 +22,7 @@
 #include "phy-qcom-qmp-qserdes-txrx-v5_5nm.h"
 
 #include "phy-qcom-qmp-qserdes-com-v6.h"
+#include "phy-qcom-qmp-qserdes-txrx-v6.h"
 
 #include "phy-qcom-qmp-qserdes-pll.h"
 
-- 
2.34.1

