Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB8670CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjAQXIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAQXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:07:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F1D42BF2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:42:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r9so9386070wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyqU+dQ/PirR7XQSF8hZZ4/NNKWpUvktF/kU+a8b9vU=;
        b=NRfGYeN//WcKXago8qHT1DoWT8U00rSW4EGMxyBRqBP7nZXBd1rLR941DRu7je4ozo
         mBhDtnY0Ct0+X3bNoOB3pw/6T6IeSmzxGL9OM1x2C/+ha2aDdSP7u2CORiUKIIPxCcC5
         f0/L3sVo6tPNl58YFDd6BrzSI+Ujvk1kPGLC85+P4wfueWGScoxsVGJ5wgMOiDgP/myW
         yTr0wFZuYGNq9mpMhR/NXNh/sSzQqJSMVHRMBlV5qOOJ61RAUhp9I5yffB1r4V84MPyo
         t0VYNwGcML/ecvZk6mIAhGb2uU4Q5sUZHQRjng55hHilVArXeb61Om4dOIWdVAEFjPQH
         bQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyqU+dQ/PirR7XQSF8hZZ4/NNKWpUvktF/kU+a8b9vU=;
        b=oxG56+OAu6PP/HahmJ6SdTWZflvQJLUlbV0+XFbbfhIALNcCt2uj6bIOX5P6JRhLwQ
         06VZky7XaTln6lrLeulYKqPVCQ2TwQ96OXM9+v2yjv5JcKCSKod/70iZVzSYnvrgme3P
         lsdIs0XACo5SMHB/jwDK4pgxvoE3hbnXvzCSJK+P33pNI5XX9NR36wF5ETuCCq2HdDcw
         M427ACGUUr/621Ft9nB6iUGtQ5NP/plub84Q424EY0tZyWGS+xwAm7NXqqi7be3gSmoY
         JbeqE8Oc87EhiflBFEbOWI2jZx1mTDu0rgHXKhuuxL5X3a/HTl7r7telr0xOXoMXmHLa
         QFzQ==
X-Gm-Message-State: AFqh2kp465Bsha7SY6Q/2BbJraRM6U62l96NBnycEfXgwvVkIokusgmv
        X/5iY4FjHlFrR/KaVqbEo8893w==
X-Google-Smtp-Source: AMrXdXu8heF4i6JfL39mjizxvfLw5oyDxZorfBV8XGumzu04vnT2+KHyxJh9UBC/15ASOQbEu0clCA==
X-Received: by 2002:adf:e74e:0:b0:2bd:e8c0:8dfe with SMTP id c14-20020adfe74e000000b002bde8c08dfemr4326000wrn.4.1673995317030;
        Tue, 17 Jan 2023 14:41:57 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm27024916wrv.113.2023.01.17.14.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:41:56 -0800 (PST)
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
        Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 2/6] phy: qcom-qmp: qserdes-com: Add v6 register offsets
Date:   Wed, 18 Jan 2023 00:41:44 +0200
Message-Id: <20230117224148.1914627-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117224148.1914627-1-abel.vesa@linaro.org>
References: <20230117224148.1914627-1-abel.vesa@linaro.org>
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
UFS and PCIE g3x2. Add the new qserdes com offsets in a dedicated
header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../qualcomm/phy-qcom-qmp-qserdes-com-v6.h    | 82 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 +
 2 files changed, 84 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
new file mode 100644
index 000000000000..f420f8faf16a
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V6_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V6_H_
+
+/* Only for QMP V6 PHY - QSERDES COM registers */
+
+#define QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1			0x00
+#define QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1			0x04
+#define QSERDES_V6_COM_CP_CTRL_MODE1				0x10
+#define QSERDES_V6_COM_PLL_RCTRL_MODE1				0x14
+#define QSERDES_V6_COM_PLL_CCTRL_MODE1				0x18
+#define QSERDES_V6_COM_CORECLK_DIV_MODE1			0x1c
+#define QSERDES_V6_COM_LOCK_CMP1_MODE1				0x20
+#define QSERDES_V6_COM_LOCK_CMP2_MODE1				0x24
+#define QSERDES_V6_COM_DEC_START_MODE1				0x28
+#define QSERDES_V6_COM_DEC_START_MSB_MODE1			0x2c
+#define QSERDES_V6_COM_DIV_FRAC_START1_MODE1			0x30
+#define QSERDES_V6_COM_DIV_FRAC_START2_MODE1			0x34
+#define QSERDES_V6_COM_DIV_FRAC_START3_MODE1			0x38
+#define QSERDES_V6_COM_HSCLK_SEL_1				0x3c
+#define QSERDES_V6_COM_VCO_TUNE1_MODE1				0x48
+#define QSERDES_V6_COM_VCO_TUNE2_MODE1				0x4c
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1		0x50
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE1		0x54
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0		0x58
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0		0x5c
+#define QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0			0x60
+#define QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0			0x64
+#define QSERDES_V6_COM_CP_CTRL_MODE0				0x70
+#define QSERDES_V6_COM_PLL_RCTRL_MODE0				0x74
+#define QSERDES_V6_COM_PLL_CCTRL_MODE0				0x78
+#define QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0			0x7c
+#define QSERDES_V6_COM_LOCK_CMP1_MODE0				0x80
+#define QSERDES_V6_COM_LOCK_CMP2_MODE0				0x84
+#define QSERDES_V6_COM_DEC_START_MODE0				0x88
+#define QSERDES_V6_COM_DEC_START_MSB_MODE0			0x8c
+#define QSERDES_V6_COM_DIV_FRAC_START1_MODE0			0x90
+#define QSERDES_V6_COM_DIV_FRAC_START2_MODE0			0x94
+#define QSERDES_V6_COM_DIV_FRAC_START3_MODE0			0x98
+#define QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1			0x9c
+#define QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE0			0xa0
+#define QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE0			0xa4
+#define QSERDES_V6_COM_VCO_TUNE1_MODE0				0xa8
+#define QSERDES_V6_COM_VCO_TUNE2_MODE0				0xac
+#define QSERDES_V6_COM_BG_TIMER					0xbc
+#define QSERDES_V6_COM_SSC_EN_CENTER				0xc0
+#define QSERDES_V6_COM_SSC_PER1					0xcc
+#define QSERDES_V6_COM_SSC_PER2					0xd0
+#define QSERDES_V6_COM_PLL_POST_DIV_MUX				0xd8
+#define QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN			0xdc
+#define QSERDES_V6_COM_CLK_ENABLE1				0xe0
+#define QSERDES_V6_COM_SYS_CLK_CTRL				0xe4
+#define QSERDES_V6_COM_SYSCLK_BUF_ENABLE			0xe8
+#define QSERDES_V6_COM_PLL_IVCO					0xf4
+#define QSERDES_V6_COM_SYSCLK_EN_SEL				0x110
+#define QSERDES_V6_COM_RESETSM_CNTRL				0x118
+#define QSERDES_V6_COM_LOCK_CMP_EN				0x120
+#define QSERDES_V6_COM_LOCK_CMP_CFG				0x124
+#define QSERDES_V6_COM_VCO_TUNE_CTRL				0x13c
+#define QSERDES_V6_COM_VCO_TUNE_MAP				0x140
+#define QSERDES_V6_COM_VCO_TUNE_INITVAL2			0x148
+#define QSERDES_V6_COM_CLK_SELECT				0x164
+#define QSERDES_V6_COM_CORE_CLK_EN				0x170
+#define QSERDES_V6_COM_CMN_CONFIG_1				0x174
+#define QSERDES_V6_COM_SVS_MODE_CLK_SEL				0x17c
+#define QSERDES_V6_COM_CMN_MISC_1				0x184
+#define QSERDES_V6_COM_CMN_MODE					0x188
+#define QSERDES_V6_COM_PLL_VCO_DC_LEVEL_CTRL			0x198
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_1			0x1a4
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_2			0x1a8
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_3			0x1ac
+#define QSERDES_V6_COM_ADDITIONAL_MISC				0x1b4
+#define QSERDES_V6_COM_ADDITIONAL_MISC_2			0x1b8
+#define QSERDES_V6_COM_ADDITIONAL_MISC_3			0x1bc
+#define QSERDES_V6_COM_CMN_STATUS				0x1d0
+#define QSERDES_V6_COM_C_READY_STATUS				0x1f8
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index fd99a5d02703..d1275d20a3a3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -21,6 +21,8 @@
 #include "phy-qcom-qmp-qserdes-txrx-v5_20.h"
 #include "phy-qcom-qmp-qserdes-txrx-v5_5nm.h"
 
+#include "phy-qcom-qmp-qserdes-com-v6.h"
+
 #include "phy-qcom-qmp-qserdes-pll.h"
 
 #include "phy-qcom-qmp-pcs-v2.h"
-- 
2.34.1

