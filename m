Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A16622A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKILcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKILcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:32:08 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C502CDD3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:32:07 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h12so25281908ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnhQoXgqWChOSupWd26PNEi+MyU1K/k2bXa+DH33Fio=;
        b=nwmgpQIBECrs1Zud8ZuqCP2m7gh4JsnS3m1E63oPFYzBvQbBK5MfOPLuxteDa/Pctb
         BLLwkdZnNsBOtK4zoq3vP3GNBWtmWTXTlrDiaGEPiWRuNOrPIFZmyna6xKQsU5HqB6cJ
         4euLCRdAkFfGaXuOZfSgzGLDZ4DGVHcPAu7UliLXaSh/qOXdkZ7KZ9/9we5kE3fGVwu+
         KYTYiM1Ha6zv7wBTjYulP9to3OmB5FDfoEgFVY+wU1DJynVtb7T2Ef7vEV90fZRBvGtN
         aihcl2aOiN7q9xpN4YBMuzwOFMQjyELYsninXYZs678mNNQMoiI0OEmNYH9RgcFIIgcV
         oaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnhQoXgqWChOSupWd26PNEi+MyU1K/k2bXa+DH33Fio=;
        b=SiCQ+fGAIWQuUWGBq0RMn6fr+n2r3e2fhUD40pmC3LKdBhduxSHFjV/N/1bTd3k0Jg
         wdbc9S/OkDqEYDcfyKRyxEukobRBGJClwTwAQudV0Lo1h+9ej83u/cwLYcC1fJMOKLbT
         M0BYi8t/1InK0fU9yddACDoisQWnp7SZUbd83TvfBs1jAA5gNw3vn6VyGwqhFxMHi3ai
         TQF2h09ullbSoh6h6VnjaJL0RCZwui2jHSruxuwb+DTNjnd5S4V8P1h3VQFs0xWoPgDH
         cTmOkmHFwrcH2TYYLODwVwUpsW0b9Kg4+rqH/gUl4yIGyT4B2Ext1WTetHSmxiK7op8M
         e1sw==
X-Gm-Message-State: ACrzQf16WJ5OnuyaOhJNsW+v57j37FvUfXf8OAbkSNAmsRmqku0ZEqHS
        Acw9PrAiUNgBwcO2cDXw8bDDkw==
X-Google-Smtp-Source: AMsMyM7ztAYNYFaTZJ2mjxlJnGhwhsar3MutJudYZpota/mxEUgHCr2VhBag/TTUpQXavnP7v5G2ug==
X-Received: by 2002:a2e:80d8:0:b0:277:309:73cb with SMTP id r24-20020a2e80d8000000b00277030973cbmr8144318ljg.371.1667993525673;
        Wed, 09 Nov 2022 03:32:05 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id m4-20020a2e97c4000000b0026dcac60624sm2038146ljj.108.2022.11.09.03.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:32:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2] dt-bindings: PCI: qcom,pcie-ep: correct qcom,perst-regs
Date:   Wed,  9 Nov 2022 12:32:02 +0100
Message-Id: <20221109113202.74406-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

qcom,perst-regs is an phandle array of one item with a phandle and its
arguments.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---

Changes since v1:
1. Correct lang typo.
2. Add tags.
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 977c976ea799..8005ccd287c0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -47,8 +47,10 @@ properties:
                  enable registers
     $ref: "/schemas/types.yaml#/definitions/phandle-array"
     items:
-      minItems: 3
-      maxItems: 3
+      - items:
+          - description: Syscon to TCSR system registers
+          - description: Perst enable offset
+          - description: Perst separation enable offset
 
   interrupts:
     items:
-- 
2.34.1

