Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8027D736875
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjFTJyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjFTJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:53:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEF212E;
        Tue, 20 Jun 2023 02:51:38 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A09C36602242;
        Tue, 20 Jun 2023 10:51:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687254697;
        bh=QLBgAOvVUGSBnz1U69YbD+N4tPMfF9fPwWDG2K6scpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rw15G7lwYSsOVlgVJnqtQZVRkUivdnpgzPE1z4BjrTuB/Wd0WkSj+y8CZ81ldIzag
         qdewAQSpY9pqwuXEwztUjWukfAQrEqwlOPfnioeSV/yTgmq5pjFuQfOy6uy1zK2Sy1
         74VM+BpUvfzPX+BQBp/6cFORVaG9Pr/7XfSVeR4UeOGbMFL5DHaE+bnSPJ5DeLkQQX
         jIi1lVgs9C6vJyXxov5PmWgBBgvKHtiiyrVA9HFwkhaAkz2aXtrSBZfS9itCL+Xndx
         Sn9n3wvkn4HHej8o+yP3csl0hvUSwzoCA/6cxgaIOhwXf9EXg1v8AJ/ZXEm4Ldtwkh
         CqeLeYvGmAuLw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        dmitry.baryshkov@linaro.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com
Subject: [PATCH v4 5/6] dt-bindings: iommu: qcom,iommu: Add QSMMUv2 and MSM8976 compatibles
Date:   Tue, 20 Jun 2023 11:51:26 +0200
Message-Id: <20230620095127.96600-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
References: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string "qcom,msm-iommu-v2" for the inner node,
along with "qcom,msm8976-iommu" as a first user of it and
"qcom,msm-iommu-v2-ns" and "qcom,msm-iommu-v2-sec" for the context
bank nodes to support Qualcomm's secure fw "SMMU v2" implementation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/iommu/qcom,iommu.yaml   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index 0446ccc4116e..b94dbab1e1f1 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -17,11 +17,16 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,msm8916-iommu
-          - qcom,msm8953-iommu
-      - const: qcom,msm-iommu-v1
+    oneOf:
+      - items:
+          - enum:
+              - qcom,msm8916-iommu
+              - qcom,msm8953-iommu
+          - const: qcom,msm-iommu-v1
+      - items:
+          - enum:
+              - qcom,msm8976-iommu
+          - const: qcom,msm-iommu-v2
 
   clocks:
     items:
@@ -64,6 +69,8 @@ patternProperties:
         enum:
           - qcom,msm-iommu-v1-ns
           - qcom,msm-iommu-v1-sec
+          - qcom,msm-iommu-v2-ns
+          - qcom,msm-iommu-v2-sec
 
       interrupts:
         maxItems: 1
-- 
2.40.1

