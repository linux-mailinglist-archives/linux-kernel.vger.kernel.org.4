Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF2662681
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbjAINIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjAINHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:07:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F2F17593
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:05:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so12847922lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 05:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A85Hj2sYQJ0M2pCGuSbOsE3dYE86SavNJYR8ZErS730=;
        b=ykkKkU7ZATz8Dct73RoT7HCB4AZunV9Pg3q8e2FnBmyEj5I3qXuiRGvaqvnBL1bos5
         D2nPAh3OAZ4tHFODsR+FHNCVVlbhSEKMKgs1PKdT9+qobzwm3RcO4v2zRqoLqI+4xWSj
         reJ82uZyjY8KjafkOfNjzu5IC4NPGWtnAAJ6z1dH6AY53zrMUqoU0tc0KRd/x51tfCsB
         DnTWJ8I1tx7kVoQ3upjZOZtZ8b7Unyj/fgyDpDdhxbOzHDIw/7MQGbvwo1LVl+0PC+hC
         fA/GLTYabbLpEt1/bfgxhpXGbYKfGLShmqEdhzsFhIr1IoS0vH7dU5NjviBYDBi/xpCF
         /LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A85Hj2sYQJ0M2pCGuSbOsE3dYE86SavNJYR8ZErS730=;
        b=XoXMD8fGALg6I1xqsK/xwRJ+mmiOkk+xam0dAKPkOJgkUSNxVZ/fGfbc8HuMk2rgBn
         Ijam8F/xtmSzEICb1rRy0amKBlN8WuKk6n4/cSiyfIeKjYvwPE6cMRJJXCX0YnPEhQh1
         ZVVRTgrWv+T/es8KxZ3nXThXnnmtZDIO02yVB69xs2h4ktRrZIVcHksxEloSZL5jSjEo
         4ERiuYnDn9VDGJ2edqMz1VB+pdyvOiHG5y83pzrG+s9uRfBY/blaMDBJuJ77sdTWodez
         H9+wNgInPPHZuzd24joToLOJIXuszY5aFxsUgjBMfH5QulrTfsUf7DVwFE7yh0i20QH5
         y2Aw==
X-Gm-Message-State: AFqh2krs422dH1yOwhqsPv/7WHGPVIsWtVGXXBeG/iOvn+2+vvzCdZlk
        oteoJkEv4SrLkCmMseMaV3QYUA==
X-Google-Smtp-Source: AMrXdXuT74yTrDXoHXj6XcSvg22YF7D7zxmFRWG1XvQXVIeAf3sXADXGnHQI5BQJk8irzP6EaEi9ig==
X-Received: by 2002:a05:6512:1385:b0:4ca:dd8a:8c1f with SMTP id p5-20020a056512138500b004cadd8a8c1fmr20012773lfa.22.1673269532661;
        Mon, 09 Jan 2023 05:05:32 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id f1-20020a056512360100b004cc5e97d356sm1615031lfs.148.2023.01.09.05.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 05:05:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 3/3] dt-bindings: firmware: qcom: scm: Separate VMIDs from header to bindings
Date:   Mon,  9 Jan 2023 14:05:23 +0100
Message-Id: <20230109130523.298971-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109130523.298971-1-konrad.dybcio@linaro.org>
References: <20230109130523.298971-1-konrad.dybcio@linaro.org>
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

The SCM VMIDs represent predefined mappings that come from the
irreplaceable and non-omittable firmware that comes with every
Qualcomm SoC (unless you steal engineering samples from the factory)
and help clarify otherwise totally magic numbers which we are
required to pass to the secure world for some parts of the SoC to
work at all (with modem being the prime example).

On top of that, with changes to the rmtfs binding, secure VMIDs will
become useful to have in device trees for readability. Separate them
out and add to include/dt-bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v3 -> v4:
- Improve the commit message
- Dual-license
 include/dt-bindings/firmware/qcom,scm.h | 16 ++++++++++++++++
 include/linux/qcom_scm.h                |  7 ++-----
 2 files changed, 18 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/firmware/qcom,scm.h

diff --git a/include/dt-bindings/firmware/qcom,scm.h b/include/dt-bindings/firmware/qcom,scm.h
new file mode 100644
index 000000000000..1a4e68fa0744
--- /dev/null
+++ b/include/dt-bindings/firmware/qcom,scm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015 Linaro Ltd.
+ */
+
+#ifndef _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
+#define _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
+
+#define QCOM_SCM_VMID_HLOS		0x3
+#define QCOM_SCM_VMID_MSS_MSA		0xF
+#define QCOM_SCM_VMID_WLAN		0x18
+#define QCOM_SCM_VMID_WLAN_CE		0x19
+#define QCOM_SCM_VMID_NAV		0x2B
+
+#endif
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 150b72edb879..1e449a5d7f5c 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 
+#include <dt-bindings/firmware/qcom,scm.h>
+
 #define QCOM_SCM_VERSION(major, minor)	(((major) << 16) | ((minor) & 0xFF))
 #define QCOM_SCM_CPU_PWR_DOWN_L2_ON	0x0
 #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
@@ -51,11 +53,6 @@ enum qcom_scm_ice_cipher {
 	QCOM_SCM_ICE_CIPHER_AES_256_CBC = 4,
 };
 
-#define QCOM_SCM_VMID_HLOS       0x3
-#define QCOM_SCM_VMID_MSS_MSA    0xF
-#define QCOM_SCM_VMID_WLAN       0x18
-#define QCOM_SCM_VMID_WLAN_CE    0x19
-#define QCOM_SCM_VMID_NAV        0x2B
 #define QCOM_SCM_PERM_READ       0x4
 #define QCOM_SCM_PERM_WRITE      0x2
 #define QCOM_SCM_PERM_EXEC       0x1
-- 
2.39.0

