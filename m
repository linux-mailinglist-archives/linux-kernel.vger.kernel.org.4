Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B683568D5CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjBGLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjBGLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:41:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E383193E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:40:52 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso12971148wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eY/XeHsmBpHFfWUU1KgjKnCSnSpQ/HCuRyOD3JEmOg=;
        b=ZV+ELRRC1rmE14CtaWM5a34Ivu1JV/24TbvQx9LG6zwTWvCEhOoQRxONQxf6C88UvP
         r+v9Ae8RPcSbDwy+tA8g4IvmOVhhC17NFwybFwv5+hzMZ+xR7qGZFc5zF6FIiSO9KWoR
         nKAuLz74nYs1lB93o3QGUyIp/J9H9k0RP5sVWHdvoSIC8Bmf9QnWpp+kFcTMgFQTihKw
         R3k6MxlF+r0e5uXUBM95sCz2NUZd+dNFow1LVQ7epMJIGaHrAXe2TAvYJYCwpylnpwwN
         MEZyfq5w+mcoZAcmDn5FGDZHiSwQjPIqmkqapOLgWVCtHxPEOMq1pYN678VeTlI79ttc
         mCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eY/XeHsmBpHFfWUU1KgjKnCSnSpQ/HCuRyOD3JEmOg=;
        b=sMj2mAz3MXExUjfBOpQGdlxyo47XxcK7a/L/YNzgFyCg1dp30YCRN2DdD3Hak31XLl
         NcBj5IW28Km4CU7LpihJYpkB+qEm6ashkfndiKbay4VuPdGQt/QN5EUZIcBkEgHzRvGe
         XXC2DWrFR4E8uHTPcl2d68g3/X360ul/sEUg7j0y0TQfkW6FRNvHAR8r+6/iXlbRDDvT
         n3TbDFe0flNT7r3xHaw6Zfe4yH5AsaCn05LggYqlNPC9T9iTjw1DR6BoZLKX/wZebmBP
         VDGDCO0BtYF9VfFbdtCAgmfDc+Ff4JiShrrZDaZz5IlflR0Hr46AeiGXCrwMr9edcOlj
         ShYQ==
X-Gm-Message-State: AO0yUKVd8J1fB0VriJMtII1MPKZOm+rUPEgJ6lWjvwE5fqSZGYih7APt
        Au6Mx6I/EfXIlNxV6F2wi/rbYQ==
X-Google-Smtp-Source: AK7set/ZrXcRdbVJ1NlZokDnVJqc8qclfZMr5nHHU0C8eW80+MnFHXVtpCsj/ZSTCozZfp8GzsUvGQ==
X-Received: by 2002:a05:600c:1714:b0:3df:dc29:d69 with SMTP id c20-20020a05600c171400b003dfdc290d69mr2693353wmn.36.1675770050627;
        Tue, 07 Feb 2023 03:40:50 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003d1d5a83b2esm18326005wmr.35.2023.02.07.03.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:40:50 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/6] phy: qcom-qmp: Add v6 DP register offsets
Date:   Tue,  7 Feb 2023 13:40:23 +0200
Message-Id: <20230207114024.944314-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207114024.944314-1-abel.vesa@linaro.org>
References: <20230207114024.944314-1-abel.vesa@linaro.org>
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

The new SM8550 SoC bumps up the HW version of QMP phy to v6.
Add the new DP specific offsets in the generic qmp header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v4 version of this patch was here:
https://lore.kernel.org/all/20230202132511.3983095-6-abel.vesa@linaro.org/

Changes since v4:
 * none

Changes since v3:
 * none

Changes since v2:
 * none

 drivers/phy/qualcomm/phy-qcom-qmp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 148663ee713a..7ee4b0e07d11 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -134,4 +134,8 @@
 #define QPHY_V4_PCS_MISC_TYPEC_STATUS			0x10
 #define QPHY_V4_PCS_MISC_PLACEHOLDER_STATUS		0x14
 
+/* Only for QMP V6 PHY - DP PHY registers */
+#define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
+#define QSERDES_V6_DP_PHY_STATUS			0x0e4
+
 #endif
-- 
2.34.1

