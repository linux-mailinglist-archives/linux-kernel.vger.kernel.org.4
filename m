Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECB56DDA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDKMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDKMO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:14:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CEC35B5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:14:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a5197f00e9so4678075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681215297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPvrw1L14EQ5Op5VVbrtVe4j3Q0oZqvdKnq/zzgJ7Ds=;
        b=ad/xyjENGfN43NRhicwtQR4hmFMv7qRGcnxeOZXq0vCP1/gFRIFsuKtStvL/Pl5ZJ1
         aUXDVgVg+ouIPF1F9Clre/mIb6ywAsgaxfYUt9NSFLLqUxZa0/jk3O2PWessSz+P7v0M
         7w3LptVe4e1glCvlW5Dyacx9fAV9TO34V8VAGbbkVeZ3MBi9SktN/tgUC7js8UAVC2xl
         Y5vUTGZDfJ9ffT8BHC1lGzJcYtmEAzv6W8o4WIC36oalK0k/L3Izzbck8t5usCjzFM38
         lUeGvRDWcb4s4PtCQHauOM42lJ76gUg0BRmb3Nz2UZ7XOnYXu7ADGAevA0izMzrDf12m
         jRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681215297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPvrw1L14EQ5Op5VVbrtVe4j3Q0oZqvdKnq/zzgJ7Ds=;
        b=M8tgMuYfKYxM0GVC7LXP0L0Kmt36LCPvhHNhMPVybh86qmIsPx14ebKc4vtXShXkPN
         ZHtmd0Cj0T+V6N3adbmEcbGY7/snOFHGMxDeuUBW9vBxOKi/IkCS1O/dP6XN10k9kRJS
         eCDYlmWMlod0O6A2OFCCvb8zGyKcseEOKjmz1qoOPeJYWfedudwU4fGGQwQNjCr4PMdP
         UHSEQ64Xbm0AlJSDziR8WL9vOt6BMJYBcXltyv/ZhWdlDiFkil4ubGIgeeMRSwZuURvG
         0vPouJZU1lz77FzRVygJxAo1Ned1lyXf0waVpQ/bY6MFAUSjvAQA50e1w8TSKIfxrVBS
         nvTQ==
X-Gm-Message-State: AAQBX9dqxxji6FGfOLqmo3yTGb97DtIIOuKmmQJLf4sPTdsl96Ir1pke
        RoEuy3KM+t8tXu9PzQorUlIy
X-Google-Smtp-Source: AKy350ZOESW22mWr3MepPL0XZDsDSb6E7oeqR2HxzkblRK4IZyzVYNtBj+Tn1ZP68qmps4WGebUdtg==
X-Received: by 2002:a62:5216:0:b0:63a:5bcd:e580 with SMTP id g22-20020a625216000000b0063a5bcde580mr3372941pfb.9.1681215297077;
        Tue, 11 Apr 2023 05:14:57 -0700 (PDT)
Received: from localhost.localdomain ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id d2-20020a655ac2000000b00513c549e98asm8448425pgt.68.2023.04.11.05.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:14:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org, quic_devipriy@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4] dt-bindings: PCI: qcom: Document msi-map and msi-map-mask properties
Date:   Tue, 11 Apr 2023 17:44:42 +0530
Message-Id: <20230411121442.22227-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qcom PCIe controller is capable of using either internal MSI controller
or the external GIC-ITS for signaling MSIs sent by endpoint devices.
Currently, the binding only documents the internal MSI implementation.

Let's document the GIC-ITS imeplementation by making use of msi-map and
msi-map-mask properties. Only one of the implementation should be used
at a time and the drivers can choose the preferred one.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v4:

* Spun off from the "Qcom: Add GIC-ITS support to SM8450 PCIe controllers"
  series and incorporated the change to allow both MSI implementations.
* Added Reviewed-by tag from Rob

Changes in v3:

* Reworded the commit messages as per Lorenzo's comments
* Rebased on top of v6.2-rc1

Changes in v2:

* Swapped the Device ID for PCIe0 as it causes same issue as PCIe1
* Removed the definition of msi-map and msi-map-mask from binding
* Added Ack from Krzysztof

 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 5d236bac99b6..b26fff04859d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -130,14 +130,20 @@ required:
   - compatible
   - reg
   - reg-names
-  - interrupts
-  - interrupt-names
-  - "#interrupt-cells"
   - interrupt-map-mask
   - interrupt-map
   - clocks
   - clock-names
 
+anyOf:
+  - required:
+      - interrupts
+      - interrupt-names
+      - "#interrupt-cells"
+  - required:
+      - msi-map
+      - msi-map-mask
+
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
   - if:
-- 
2.25.1

