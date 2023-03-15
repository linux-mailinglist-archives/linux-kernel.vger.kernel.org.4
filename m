Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE16BA849
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjCOGp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjCOGo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:44:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14357664DA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:44:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v21so8896171ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EYpDut5qXdF8PJg7sJ4kHxpp0TN8JiS9nsevzfwY0E=;
        b=eCyk8+NbbhTpU1DUO8u1AITD+QqN8laTO+q2FzRt7a9jk9TlRje5p1Ho+5ThIQxIRf
         2f0/j3j235f7mhjF0cf2FJT17fYyGnRXerwyA6LEQrva63pwTgRIOQqMg3zZhTNNK7ii
         KIF0tdgGtfaxQobwMJRnhrMMK3pG/vIdOwA7jK0QSqX2/VuTzlT0Fy6VjyQfCunpzBag
         /7I/N08e6Egw6CCXRLYPn4MbY5sN3atQ9Ce+sSee+2GeMWLzEAkPLA5k24jLuKia9kgS
         ArH4y/IIc8+cW4Ro3PcHij40AczDn2yz3QThliSkiWFbRb9CyXSvzvAgzgK4oQWJQV6m
         D6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EYpDut5qXdF8PJg7sJ4kHxpp0TN8JiS9nsevzfwY0E=;
        b=dQp6XC4JpTmQxZEj0KZbb8dADYNQiLSs6MTvv/dTrwO5I5G81Qh46T5oqbCqnBUbYM
         inKrjDu7KKk7dMKSu8iQVwHaeSV/2mciyKYunsC0wtX6nLfqy4GocAFHLgdcch5Zji4a
         jrPFHqvW1omjVtutkyxCbTtkPClKr1hiqPt7WoGInHke6b5dKgb3Yon1PzXG5DrVZtEk
         XKIMp4vDZgY9xGwLZsQSGsy1SlXE8jwffzZJEBLIneBcI7UiP2eovGRP6xYxGIy2WoSa
         4LU/bLB0DJvBKdpj4zLj8/uT4ZhWQQ+7Kig1WiSeDkOAxUkbRYBnNBfjz0NK6CQI92Yd
         NiVQ==
X-Gm-Message-State: AO0yUKWvoqzbn+sdKRcdUUq/sXMRaTxGBEVdb97SB8u9CHMU99zNdr/F
        Rl4e4xdzwuh7n8k0RzdZIeEr
X-Google-Smtp-Source: AK7set+4380QzHY0UAb42me+uSpmOjWTVg4jjYTccUwR+gaaSF0U+9XeJc//pJLTOnt228PdGtrKyw==
X-Received: by 2002:a17:90b:1b52:b0:237:b64c:6bb3 with SMTP id nv18-20020a17090b1b5200b00237b64c6bb3mr42612193pjb.11.1678862644404;
        Tue, 14 Mar 2023 23:44:04 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a6a8400b002367325203fsm550747pjj.50.2023.03.14.23.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:44:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 14/18] dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
Date:   Wed, 15 Mar 2023 12:12:51 +0530
Message-Id: <20230315064255.15591-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mhi" register region contains the MHI registers that could be used by
the PCIe controller drivers to get debug information like PCIe link
transition counts on newer SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index fb32c43dd12d..ecbb0f9efa21 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -44,11 +44,11 @@ properties:
 
   reg:
     minItems: 4
-    maxItems: 5
+    maxItems: 6
 
   reg-names:
     minItems: 4
-    maxItems: 5
+    maxItems: 6
 
   interrupts:
     minItems: 1
@@ -185,13 +185,15 @@ allOf:
       properties:
         reg:
           minItems: 4
-          maxItems: 4
+          maxItems: 5
         reg-names:
+          minItems: 4
           items:
             - const: parf # Qualcomm specific registers
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
@@ -209,14 +211,16 @@ allOf:
       properties:
         reg:
           minItems: 5
-          maxItems: 5
+          maxItems: 6
         reg-names:
+          minItems: 5
           items:
             - const: parf # Qualcomm specific registers
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: atu # ATU address space
             - const: config # PCIe configuration space
+            - const: mhi # MHI registers
 
   - if:
       properties:
-- 
2.25.1

