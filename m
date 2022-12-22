Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274286541EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiLVNby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLVNbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:31:48 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD9A14D38
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:31:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d82so1212458pfd.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOniKrb0GQ9WjhoUQcWo7o7ITGbjHRsfNlny869TuiA=;
        b=RXfCUc6DuscK6pSxe4TWf7ROX9vnBY/mOBG8/W2FUvubLqbhzjVOE3w/Hf6dXzf8gh
         IkhVVvyKBH3hEhzV0bTP+hgPrXzgs4uUUnpdTjeBKY6BQRbkDWcvGqyAQCHRa/0xtUgx
         mwAoA30aOtXjknVTCEVlt22ks/lj6ule3aPYzWYon0qjYDxjY2pgTVOcwpStvlibqdHk
         QXlyOfIrhAwFBG+Ms7WL8WDih0el88qT7UFslSFORnuJ8ycSfZJede76gZoOuB9COoud
         F9sghyxBYljYN7xJZIEfN8dDdvxJEI88GK6P3bZYiN1lW3i6UPcBWQgc3Gk9TC5CJh4R
         W/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOniKrb0GQ9WjhoUQcWo7o7ITGbjHRsfNlny869TuiA=;
        b=F/XOiCQGUyGE78mAvq/OdfX6OqTn3TXzlGPc96UIVdpk6VjB3q5DFzOxw7mS59Tnmu
         lA2XtnkVLR4DVETtSu2YmYl756lSXbdB/hfT96n3KfhLEQYu9YqQ5blbs+aoImwkLcSS
         dPUEd+ZpqpaDwBTESeFe1CVq6UI+PJl+V9fS1iXzbQ5TBpGQi8Tdm6SNZ6yag9MaK7tX
         wLLVxBaupHFwon3UjdonQkurxvOblPMczu8v8+MTCC68QsOJMUXgiA17yF3jpltq8S5A
         qKxPFP50Ds0mhOcsKF+af5RD+GDJw8HpkhqfNQElZqkwGlDYX780MCL9pn9qp/oJTBHl
         YJCw==
X-Gm-Message-State: AFqh2krjwdVW0+RPH69vLP0b0XT5zp1j2hXDApNEn/CxrVMgYv/M5Euj
        eBKfydV3URhvFssczCCZymld
X-Google-Smtp-Source: AMrXdXvq2jEi5GKhsl6hQVoJsM6pxaidM2iYeGzG5EDQ7gb5qjUobCUHSESWRvwVjcKeenBcvarSaQ==
X-Received: by 2002:a05:6a00:13a4:b0:57f:f7a4:511a with SMTP id t36-20020a056a0013a400b0057ff7a4511amr8553345pfg.2.1671715906971;
        Thu, 22 Dec 2022 05:31:46 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id f66-20020a623845000000b00573a9d13e9esm737467pfa.36.2022.12.22.05.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:31:46 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: PCI: qcom: Document msi-map and msi-map-mask properties
Date:   Thu, 22 Dec 2022 19:01:22 +0530
Message-Id: <20221222133123.50676-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
References: <20221222133123.50676-1-manivannan.sadhasivam@linaro.org>
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

The Qcom PCIe controller is capable of using either internal MSI controller
or the external GIC-ITS for receiving the MSIs from endpoint devices.
Currently, the binding only documents the internal MSI implementation.

Let's document the GIC-ITS imeplementation by making use of msi-map and
msi-map-mask properties. Only one of the implementation should be used
at a time.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 02450fb26bb9..10fec6a7abfc 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -104,14 +104,20 @@ required:
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
 
+oneOf:
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

