Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171DF609EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJXKIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJXKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281466432;
        Mon, 24 Oct 2022 03:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F551611B9;
        Mon, 24 Oct 2022 10:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC24FC43160;
        Mon, 24 Oct 2022 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606023;
        bh=oXPXYrr8xsw0e6647Mk5oRSxMADSBNVRiAcUXclN6lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jULMA8FGdLv7B22fUsU+M5jm6Fvcbi+Ft5Bwi0jKtGM0XSrzvckT8lwwhX6NQVWch
         ZhJZF8UywKd7zdm+DtFRkUWWx7VNt6NBQY+Mpkko00JMgDl0nEZncCsF8ts1ItrXzM
         DCU7kEvoa5ghCYJSLiRW6KvQCbtEt5LHwb1vDoPmR4VtvnvtZpH7suUU6E0vphBL5O
         AuALfv+Oay3i4ug6m4LsQW6EgIskAbfzBW59vYsrX9wrtjIitCAOpAs6VM0YzvCfaU
         g+n2bh12FcyQ7C0rbFFbwRDnWts86v9s2g3635O5S+ojlmZTpZs6EQRhFxUNNFxzTn
         IPWRck1LwyTBg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omuM3-0005Md-HG; Mon, 24 Oct 2022 12:06:47 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 10/13] dt-bindings: phy: qcom,qmp-usb: rename current bindings
Date:   Mon, 24 Oct 2022 12:06:29 +0200
Message-Id: <20221024100632.20549-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024100632.20549-1-johan+linaro@kernel.org>
References: <20221024100632.20549-1-johan+linaro@kernel.org>
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

The current QMP USB PHY bindings are based on the original MSM8996
binding which provided multiple PHYs per IP block and these in turn were
described by child nodes.

Later QMP USB PHY blocks only provide a single PHY and the remnant child
node does not really reflect the hardware.

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
bindings can be based on, rename the current bindings after MSM8996 and
add a reference to the SC8280XP bindings.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 ...qcom,qmp-usb-phy.yaml => qcom,msm8996-qmp-usb-phy.yaml} | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb-phy.yaml => qcom,msm8996-qmp-usb-phy.yaml} (97%)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb-phy.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb-phy.yaml
index 7acb4b7de7f9..a72e96f241d1 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb-phy.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/qcom,qmp-usb-phy.yaml#
+$id: http://devicetree.org/schemas/phy/qcom,msm8996-qmp-usb-phy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QMP PHY controller (USB)
+title: Qualcomm QMP PHY controller (USB, MSM8996)
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
@@ -13,6 +13,9 @@ description:
   QMP PHY controller supports physical layer functionality for a number of
   controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
 
+  Note that these bindings are for SoCs up to SC8180X. For newer SoCs, see
+  qcom,sc8280xp-qmp-usb-phy.yaml.
+
 properties:
   compatible:
     enum:
-- 
2.37.3

