Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1359747720
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGDQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjGDQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:42:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5EA1721;
        Tue,  4 Jul 2023 09:42:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso95421001fa.0;
        Tue, 04 Jul 2023 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488937; x=1691080937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKeDDjtxz1ZQI75QbUkXD6YDTxAzeUfWv1d+xUfqO7U=;
        b=Ns+YGBiWzxQru39ryw0Mxwc6oejcjv4eSdIXbgTh8roV3uHhB4J7E3+A3XSPElDTLv
         Im1XZ0f0SBacqdaN95RAlR5PH1dQwmRcWBo52vpXWGMlQXfyQIa0cGuhNo4BmbtnbD66
         pMKxDEsmofFjTuLDE8oGoxQT6Uc0ztmhN5vDBJTf6Ip6DpVEYyDYWFBE+fBhGgh58rO2
         dw0dkaLmXeW7e+QViwni3LLdFPupepsn5k5FciPy9QqJbVANV7ZojCEC9AxH3tx1mhOp
         yWrPTjGE04+enyQS2M3a8/oy0qeQb38/FdkiDAqNJJ3J0E4ABVGm+tU3K+9/S2UH4S0y
         8XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488937; x=1691080937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKeDDjtxz1ZQI75QbUkXD6YDTxAzeUfWv1d+xUfqO7U=;
        b=PmRrP05Fg6wuPiMEsCyRJfxXddetHNj/nT8+MSQnkTBBgZTqXQL10fZNnhUytLQJPg
         Ch3M1jmAhT8I0fs3JtjbUJq+cylzbjon9IieWUSrIDp7MzX6FWr1zxV3NK59EWKxp24t
         WRz9yOAH51Oywtq9MJ5m+bc120PIoe3aEFznsBiHgyjMhNkXNwi1Zp8HbmVXouWVcLJD
         COc34YUQ/WBAT/8vO3RtLTEbP40+3en08sZ25EIwJurtMM8PywUhgm1T4jakKvlcHSV9
         u5Q10yVqaQfoQVgNeHVabt91A/B4CWzeIer1NpgC4Wec/DpCU8G5YlcgQ3EtxU2z+mVQ
         +jhA==
X-Gm-Message-State: ABy/qLZYcOrxHs4sDomJS7oOW9Npcx02c8HfqA7xodod98z1KgEInuRS
        9lgkw0CKP9D81oqilQtbfSg=
X-Google-Smtp-Source: APBJJlGjWy05nTx4HVL7xaMl3tfy14qIDhXB4p5ufpBoOJ+JOAlGgjSbBfHxCg2Irq3HqYA/w/9nww==
X-Received: by 2002:a2e:9348:0:b0:2b6:dfef:d526 with SMTP id m8-20020a2e9348000000b002b6dfefd526mr5645681ljh.11.1688488936543;
        Tue, 04 Jul 2023 09:42:16 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id u15-20020a2e2e0f000000b002b6eb5db863sm1181920lju.43.2023.07.04.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:42:16 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        map220v <map220v300@gmail.com>,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 6/7] arm64: dts: qcom: Add SM7125 device tree
Date:   Tue,  4 Jul 2023 18:31:59 +0200
Message-ID: <20230704163848.169853-8-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704163848.169853-2-davidwronek@gmail.com>
References: <20230704163848.169853-2-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: map220v <map220v300@gmail.com>

The Snapdragon 720G (sm7125) is software-wise very similar to the
Snapdragon 7c with minor differences in clock speeds and as added here,
it uses the Kryo 465 instead of Kryo 468.

Signed-off-by: map220v <map220v300@gmail.com>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm7125.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/qcom/sm7125.dtsi
new file mode 100644
index 000000000000..8d7a745014db
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, map220v <map220v300@gmail.com>
+ */
+
+#include "sc7180.dtsi"
+
+/* SM7125 uses Kryo 465 instead of Kryo 468 */
+&CPU0 { compatible = "qcom,kryo465"; };
+&CPU1 { compatible = "qcom,kryo465"; };
+&CPU2 { compatible = "qcom,kryo465"; };
+&CPU3 { compatible = "qcom,kryo465"; };
+&CPU4 { compatible = "qcom,kryo465"; };
+&CPU5 { compatible = "qcom,kryo465"; };
+&CPU6 { compatible = "qcom,kryo465"; };
+&CPU7 { compatible = "qcom,kryo465"; };
-- 
2.41.0

