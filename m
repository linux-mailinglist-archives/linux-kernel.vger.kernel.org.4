Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03646A1AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBXLAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjBXK7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:59:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8072A244B4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:59:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so6000867pjn.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGDet0K+1/m01Mue6GMZv5iNZBwdpYi4DRLEmHhKT40=;
        b=wzykzWTLm9WRroHFoG0Wi4/XZv56thmYBqfYcTMsjRvlgFIqS7YEcL35e6oZhoDeTX
         3iZRGY2Qj1zBi0n4Ds3Q9wWRoRQCHAHJtnggV4VvKboWqiHGa0a7So9m9rN5Yl8p/evu
         cF9l87jWQ0FHeQFwLjYeevwF+dvbUSgO/jVW1rUrmvT3qcKt5ulkUyDD/+wNzPBc9mCb
         kqvPxj3z4FBMBgcsSp12n1L3AnTJlNbpS+tDJWKlIHsPxSVmjmOAlNW1/TWKObSDwMhg
         b3SbhF7WiUVvgYLj9kIwU+AkuSMLl9PT2tneUhCIC/v0JlFH5zOHDmeaSgPtKSEKfjI3
         xnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGDet0K+1/m01Mue6GMZv5iNZBwdpYi4DRLEmHhKT40=;
        b=U9Vwx+W81rX2fd1OJOfEWKXswyErzBYsGg2wWkejekt9RB/2rYSfhaTAuBvpg518RH
         KAe/gVCq9om93fRwD/SbqeGA3oq/dS7b0Dn6SyHBGI6rbKMDkWj6P2JBfC+SqVZpn/Gf
         AnlYK6WeQB9gkKLjNjSk18io5kUFK74jvmYrgZhBsZq1j7gxD41oYz1Ui5jiRrrk4IPb
         wS0rELxhcEmRolaCSDG0/JHZtt1hz2ga2ZXsHoggWMXsa2DYOzuV6GbOCvjvmK57yULW
         rs69iKd/bxNZyKSysFPsy9rxQXZ1CYR/nJg5otGDNWmSzM6UmnPHwPpyuU+6ALA/C6cx
         F2sw==
X-Gm-Message-State: AO0yUKVruSo7XOacjaQkNGv+G9go/tguLa4Vkzwi/GbL4u+nMTug50tj
        LOf0QPy7TgvfOeWi4tFzs6hX
X-Google-Smtp-Source: AK7set+6mGj4VAtYdGIkQ1vBWDtOV7gy94BYTfFVLAt8JxLm/NlVJr/LsvVWmNSRz2bjH20PvJiRDw==
X-Received: by 2002:a17:90b:388a:b0:234:1645:5266 with SMTP id mu10-20020a17090b388a00b0023416455266mr17301662pjb.30.1677236364970;
        Fri, 24 Feb 2023 02:59:24 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:59:24 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 02/13] dt-bindings: PCI: qcom: Add iommu properties
Date:   Fri, 24 Feb 2023 16:28:55 +0530
Message-Id: <20230224105906.16540-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
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

Most of the PCIe controllers require iommu support to function properly.
So let's add them to the binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a3639920fcbb..f48d0792aa57 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -64,6 +64,11 @@ properties:
 
   dma-coherent: true
 
+  iommus:
+    maxItems: 1
+
+  iommu-map: true
+
   interconnects:
     maxItems: 2
 
-- 
2.25.1

