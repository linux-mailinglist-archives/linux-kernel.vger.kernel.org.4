Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43C739D74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjFVJf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjFVJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:33:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9737326A5;
        Thu, 22 Jun 2023 02:28:03 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 530306607077;
        Thu, 22 Jun 2023 10:28:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687426082;
        bh=RBuC46hmr6lxKxb743CP1Q/DCSEVEyNhNzronT5Rcf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avQ2eD8+QLW/pSP/VeHhlTNyOEll/57wPMy2CbFD8IGdoztlxnwYMdaP9822YNOM6
         vYmE0gJl6jkfI5A9KtOeQrfkErg5v2AOGzFujZPAov5o97R1z0iZagIoGsVKOmTVlU
         y07POElGMPobsaei9cido+LNo86givZNdWUR2C+sfwWXQhJfmgvVrHzj6si88dgbQl
         MyvCdVXV0z+/gHwBsisiK15+8PI5mT2tkgKyFsSSOkj5JWS6en3yvKvPzFTIimV+VJ
         vDU1Qru7u0JzusEDWHFWmNNNCQvgt3fqF50+N/C5O1oproOZNT4OH/K107hCIiOj6G
         iv6q3gXGjPObg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, luca@z3ntu.xyz, konrad.dybcio@linaro.org,
        dmitry.baryshkov@linaro.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 5/6] dt-bindings: iommu: qcom,iommu: Add QSMMUv2 and MSM8976 compatibles
Date:   Thu, 22 Jun 2023 11:27:41 +0200
Message-Id: <20230622092742.74819-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iommu/qcom,iommu.yaml   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index f7a64ad8a005..a74eb899c381 100644
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

