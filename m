Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF886621D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjAIJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbjAIJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:40:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198E64C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:39:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bu8so12058487lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufujsNyRyRXVthgeDnKR1JnzQQ3nZCe2ShZJg4elUjI=;
        b=oc+o3+22TMYTFJn99cdWpQZBxPYIHylp+CzpQPD6nHR/qpLHSk6f3SH7q99DZaP9W1
         ZfH9xpxBb0qvHbKqKxcJakPgHxZAqdGv9susMsPFvTqyX2L2kYVJrs+Oeu2hdKEl/q8G
         hWmwPlbad/sqL3Y5pJDMMJcbRbgQFfPkBY9TGbg8zHVRlHYg+NkbNYep6azeTbZTe6Y9
         /uPLqwliR9zYiL9FuXfJEEgtUYqzQtwMZV0BPNpQ4P5jdanFUZ0eNvDJDvwrNuapthzi
         T7b7frWcnQxfMoWUyANktgub8ZM9nEzLEM0RUafyXCTdw3csXPpZXuFvkT5XZDpyD2r9
         F2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufujsNyRyRXVthgeDnKR1JnzQQ3nZCe2ShZJg4elUjI=;
        b=edFkmVwpMKUTLfe5cpqSaOE0Do3r3GF5XMUSWrPBmwUusC/6nu48CHJ4yOw1YiNB3N
         Cb/9A8wJU2dIe5Z/2jnS7iSvI5VyVxDy7f5nh8fsb4UClV807f4eiD3AlLIupryCNQsz
         xP84+7/jBM1qvePlUQ4pJFCD0Tw9voBE+YmQndWsr352oQZ3ctcVJIW6XlvwfRMpwxJ+
         JQhd+XVH8fUxbAVQQoqzfiK+JcPyOBOdQGi7owDgOIkvxRtHh5NyUEq1wZTWA4dw3PRY
         oCx9PgvprRaFttofCHsg8K93zefMJ7JkPXCB3+VFxzMdFvPsND1GW8JQkex75VFlZKUg
         dDkg==
X-Gm-Message-State: AFqh2koSTfw1XZgSAfB8aWD9XUNQ+d4DhoXUmqRKn5Lhzo2FVGarOlLb
        lNB5dWu8htqlr+d6eb+lCI0evA==
X-Google-Smtp-Source: AMrXdXvEkW4fNqTy03QLPug/lDifYKEkZXvh5lb4F/lZA+xRZsvZC8OslySCt/DxLHljV5TcHMn/0Q==
X-Received: by 2002:a05:6512:ea2:b0:4b5:5bcc:cbcd with SMTP id bi34-20020a0565120ea200b004b55bcccbcdmr18713152lfb.0.1673257198397;
        Mon, 09 Jan 2023 01:39:58 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id b8-20020a056512060800b004cb1de3f487sm1526257lfe.104.2023.01.09.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:39:58 -0800 (PST)
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
        Stephan Gerhold <stephan@gerhold.net>,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v3 3/3] dt-bindings: firmware: qcom: scm: Separate VMIDs from header to bindings
Date:   Mon,  9 Jan 2023 10:39:47 +0100
Message-Id: <20230109093947.83394-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109093947.83394-1-konrad.dybcio@linaro.org>
References: <20230109093947.83394-1-konrad.dybcio@linaro.org>
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

With changes to the rmtfs binding, secure VMIDs will become useful to
have in device trees. Separate them out and add to include/dt-bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2 -> v3:
New patch

 include/dt-bindings/firmware/qcom/scm.h | 16 ++++++++++++++++
 include/linux/qcom_scm.h                |  7 ++-----
 2 files changed, 18 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/firmware/qcom/scm.h

diff --git a/include/dt-bindings/firmware/qcom/scm.h b/include/dt-bindings/firmware/qcom/scm.h
new file mode 100644
index 000000000000..d66818cd57a8
--- /dev/null
+++ b/include/dt-bindings/firmware/qcom/scm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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
index 150b72edb879..b0d285b08c9f 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 #include <linux/cpumask.h>
 
+#include <dt-bindings/firmware/qcom/scm.h>
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

