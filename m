Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01E772BCAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjFLJc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjFLJat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:30:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D53F35A9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso29735155e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561895; x=1689153895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXzZMEQkDaBAvE+ZbovBT4hal5Pn3NRrTeiS658EjW4=;
        b=DcuBFu7i8zRSQw8hKkh2pX678LFY4uXhQRa0m1zoChLoD/0S5zPhOg/N/5fCRqhJYj
         Z/zKl/ZA0YUpKlj3nfmm8WK7dbqp8Lz1GnBwSjRkWnCXmulByIqXZmyk9SecLTKdlKEp
         7XqAqh8l0T6g6hWUOB56/w+7mdIuq30uxJryTPArpeMbN91hdnLaykpbwvvQbF3VlWr5
         jvy48WfJVMGchgt+8J6Gp6hkKaiYTL3TgU2oDk+hfhvv+QDEuUdfV1axYsnXyQAb2/ox
         iKo4fug4hayVecTmLj6RFSmpadhjLeynFjSieMx2ZlRUmPe9LmSJZ1bM+o0ZfZ4+FOxq
         cyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561895; x=1689153895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXzZMEQkDaBAvE+ZbovBT4hal5Pn3NRrTeiS658EjW4=;
        b=MN4aqHe5US2dTQeX66WU2jHiqV/YP9tgHtMP+sVveUsuCW6Rx5968TOdTJuV/NA999
         STs0bjM/yjlh5C9lkzvptbkNK657Kzkt06G3B7U6vPOsOIIPrrUPr7y0HyKd6t3lOPku
         Uik5mGUOz+twmqfYrEKqF7KKQBMVRsRqXxiY/s2sAqHFaA1HCx+oZL3CxmE6RNmljlz9
         PbRHtz3OtZiBUFKhk5kkjbMwaHWvmNW5j6o7tkRq/xI4Mg5LlfCUB2RtGpLQkDodkeyJ
         FfU4PvzpfwSemp8sw4y2R9lHo0yBbRg3F4Y9yY3j2o4ZJIrdU+RC6XXprOnNqDMLEcbH
         S8JA==
X-Gm-Message-State: AC+VfDxve4E8pxm74EDoVUDYu2cbJXVAbpbtReJql853zH79A+QWvIAz
        yG2R9Enoh+vyRkaXlGDckejbow==
X-Google-Smtp-Source: ACHHUZ5UO/S8nDahmNKq8Vygdbss9quzKdAcp5DFednq7JQ+xTXMbpCVJCWEy9AyLcubMF3PwjgMDw==
X-Received: by 2002:a1c:7713:0:b0:3f6:784:9617 with SMTP id t19-20020a1c7713000000b003f607849617mr5402370wmi.11.1686561895166;
        Mon, 12 Jun 2023 02:24:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 20/26] dt-bindings: net: qcom,ethqos: add description for sa8775p
Date:   Mon, 12 Jun 2023 11:23:49 +0200
Message-Id: <20230612092355.87937-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612092355.87937-1-brgl@bgdev.pl>
References: <20230612092355.87937-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the compatible for the MAC controller on sa8775p platforms. This MAC
works with a single interrupt so add minItems to the interrupts property.
The fourth clock's name is different here so change it. Enable relevant
PHY properties.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/net/qcom,ethqos.yaml       | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
index 60a38044fb19..b20847c275ce 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - qcom,qcs404-ethqos
+      - qcom,sa8775p-ethqos
       - qcom,sc8280xp-ethqos
       - qcom,sm8150-ethqos
 
@@ -32,11 +33,13 @@ properties:
       - const: rgmii
 
   interrupts:
+    minItems: 1
     items:
       - description: Combined signal for various interrupt events
       - description: The interrupt that occurs when Rx exits the LPI state
 
   interrupt-names:
+    minItems: 1
     items:
       - const: macirq
       - const: eth_lpi
@@ -49,11 +52,20 @@ properties:
       - const: stmmaceth
       - const: pclk
       - const: ptp_ref
-      - const: rgmii
+      - enum:
+          - rgmii
+          - phyaux
 
   iommus:
     maxItems: 1
 
+  phys: true
+
+  phy-supply: true
+
+  phy-names:
+    const: serdes
+
 required:
   - compatible
   - clocks
-- 
2.39.2

