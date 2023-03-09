Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4386B1EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCIIxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjCIIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:52:38 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC18CDE1EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:52:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p6so1317797plf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EYpDut5qXdF8PJg7sJ4kHxpp0TN8JiS9nsevzfwY0E=;
        b=x3F7JgMlovl1XU8nVdsqn4mHmNqXlJEYHWmoDdnGdy7axcb9V0kWlcut+/j7ms2vY3
         bdzQLe2YnarCw7FURfEMM3g8FA7CdN9aBD/LlS/VzBA5rCHqfah3JNXuN3wJb+AjIdVC
         qstSluYMGygbTqFib7W/MX/7SabK1G8d95h2T5H1KVzB602YhSlED3pZeenHYseiA7Jy
         0HB66BP2HT+y7AKnW8cZkVszSn+9FgTzFeMKZrk0HXGLtngE6/MGvko0qAnx4RqwYzRx
         mQHJ2x/w1xDgBhoRH77WtggGLIZso7kRRs/jcbv9fzAJBiLSqb3ADV/hYomBlMWSftjt
         eSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EYpDut5qXdF8PJg7sJ4kHxpp0TN8JiS9nsevzfwY0E=;
        b=PqwRqD6PO/d4JxE52oYcEMMCN1khVI5r+faeaSrF1FXafGUGl98tr8YoxUa3MOxGlQ
         aNHgRatd6ylZxi1+LnWcGhKWoGM+RbSsgLIUssjtqLiUBcKKmIuhgqDgf5r1d3XLMHTY
         GBB+xUyh4EQEgxiX1ArsSTA9aGk1OTVC/dHFMi/H8p0Xytb5AQ3F3KBRaZLChFU+MjjV
         Jx+58bpA3xta2ihIvioDhPpFQlftZqNgQTPOkPP1VpmUpayQI4HvQstyUAYAQ/ZKWmvC
         0oybmoaSDa1m4jZQUBPlNF7WlUJmoVvcJMxbiBJBNi5JACPT9Ie3GCjCZQCbdaflOwhs
         lhWA==
X-Gm-Message-State: AO0yUKWgsCorhqZJ3pG5ZSngk/UJsdsIIuZ92MGKsgQZQj8J1OosItaM
        UW4UcSSMvQlngav74uUmGTfZ
X-Google-Smtp-Source: AK7set9VfPte/UHFCsEVGLAhICyvRPSNWw85/k9dEYb3tXq7cBVz1ZeoCAkQRcBPyn2ealkza5VhOw==
X-Received: by 2002:a05:6a20:9389:b0:cd:2952:7b69 with SMTP id x9-20020a056a20938900b000cd29527b69mr24464708pzh.52.1678351927414;
        Thu, 09 Mar 2023 00:52:07 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:52:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/17] dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
Date:   Thu,  9 Mar 2023 14:20:58 +0530
Message-Id: <20230309085102.120977-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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

