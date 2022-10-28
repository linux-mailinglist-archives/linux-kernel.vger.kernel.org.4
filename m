Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9333461131A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiJ1NiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiJ1Ngy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:36:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3DB1D8F3F;
        Fri, 28 Oct 2022 06:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05C01B82A2E;
        Fri, 28 Oct 2022 13:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A4BC4167D;
        Fri, 28 Oct 2022 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964209;
        bh=GiJmZNg8T5O5/fCxOI/o4taQRIeOyB6kSPSO4qZDxu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRpCQcxNqO65X3OEJS41fQwz+ntOGgwekh4xk4UKWvPyMxse0kGdvIm4RjiP5elXj
         /l046r4Mr0Jo/OFXscUmDhLGR4dcXFPxSu3nEsOpzOHRkfjz0svusUt/Q+ICKHZAHz
         qT8s8lGsM6U+rUoWs/7YWynNd9pURNFIHteC9RhhvmbsOwH4HBdcolF/d8SrI7tkN+
         lvgBUlUhU69mAC8lEOekm960V8h/58F1APPxP+OtNiK2VuF93KKeCO96RhqcO5hH1Z
         b55t9NQ4QCsJ3bjGFqz2uj0W+dSNXQxmeomd2u06FNJ1OKOIeualFDDF9F8pPjkRXF
         1GAeFpwdveT4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPXH-0004rK-KR; Fri, 28 Oct 2022 15:36:35 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 10/16] dt-bindings: phy: qcom,qmp-pcie: rename current bindings
Date:   Fri, 28 Oct 2022 15:35:57 +0200
Message-Id: <20221028133603.18470-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028133603.18470-1-johan+linaro@kernel.org>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current QMP PCIe PHY bindings are based on the original MSM8996
binding which provided multiple PHYs per IP block and these in turn were
described by child nodes.

Later QMP PCIe PHY blocks only provide a single PHY and the remnant
child node does not really reflect the hardware.

The original MSM8996 binding also ended up describing the individual
register blocks as belonging to either the wrapper node or the PHY child
nodes.

This is an unnecessary level of detail which has lead to problems when
later IP blocks using different register layouts have been forced to fit
the original mould rather than updating the binding. The bindings are
arguable also incomplete as they only the describe register blocks used
by the current Linux drivers (e.g. does not include the per lane PCS
registers).

In preparation for adding new bindings for SC8280XP which further
bindings can be based on, rename the current schema file after IPQ8074,
which was the first SoC added to the bindings after MSM8996 (which has
already been split out), and add a reference to the SC8280XP bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 ...om,qmp-pcie-phy.yaml => qcom,ipq8074-qmp-pcie-phy.yaml} | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-pcie-phy.yaml => qcom,ipq8074-qmp-pcie-phy.yaml} (96%)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 324ad7d03a38..62045dcfb20c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/qcom,qmp-pcie-phy.yaml#
+$id: http://devicetree.org/schemas/phy/qcom,ipq8074-qmp-pcie-phy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QMP PHY controller (PCIe)
+title: Qualcomm QMP PHY controller (PCIe, IPQ8074)
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
@@ -13,6 +13,9 @@ description:
   QMP PHY controller supports physical layer functionality for a number of
   controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
 
+  Note that these bindings are for SoCs up to SC8180X. For newer SoCs, see
+  qcom,sc8280xp-qmp-pcie-phy.yaml.
+
 properties:
   compatible:
     enum:
-- 
2.37.3

