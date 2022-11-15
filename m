Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E7629C57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiKOOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKOOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F1624BE9;
        Tue, 15 Nov 2022 06:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0AC6617D0;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F15C433D7;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523252;
        bh=bL1Lmk1URusXyJ0VYumbL+Pqp5Rn8rtPK8iccOoWcEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDTh7eOIKmLyzPKukhlEIXQnqekVUiW4zNjFKpSMYcCdEFGljpXBbjPVq1NjKOcib
         Js1A7SRXUnQJqXGiew2bx9B94QiM/FfY/dReyK3zbxqQffdYOgwnb6mOSDHbjuk5cT
         +SKwl6U+Dkq+1B0gEzQDx3LEn8SDBciwI81rrnc3YvoHcM8YV76Aq087CTR2vZX5R1
         1FEly5nszuw3kJuI96aiENDm2B0ijXJadUAyaS0Cla42gZBonwOHMOYNu5UKFXB1aA
         5F7vGnnZOa82ZtZAWUZ4VDyBw9z0fZvZeLiduxjmS6e/hRqQYQBy7/UohD7rgdDJST
         YEXQI0jdS2AmA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oux6s-0000fI-J8; Tue, 15 Nov 2022 15:40:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/15] dt-bindings: phy: qcom,qmp-usb3-dp: rename current bindings
Date:   Tue, 15 Nov 2022 15:39:51 +0100
Message-Id: <20221115144005.2478-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221115144005.2478-1-johan+linaro@kernel.org>
References: <20221115144005.2478-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current QMP USB3-DP PHY bindings are based on the original MSM8996
binding which provided multiple PHYs per IP block and these in turn were
described by child nodes.

The QMP USB3-DP PHY block provides a single multi-protocol PHY and
even if some resources are only used by either the USB or DP part of the
device there is no real benefit in describing these resources in child
nodes.

The original MSM8996 binding also ended up describing the individual
register blocks as belonging to either the wrapper node or the PHY child
nodes.

This is an unnecessary level of detail which has lead to problems when
later IP blocks using different register layouts have been forced to fit
the original mould rather than updating the binding. The bindings are
arguable also incomplete as they only the describe register blocks used
by the current Linux drivers (e.g. does not include the PCS_LANE
registers).

In preparation for adding new bindings for SC8280XP which further
bindings can be based on, rename the current schema file after SC7180,
which was the first supported platform, and add a reference to the
SC8280XP bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 ...dp-phy.yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb3-dp-phy.yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} (91%)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
similarity index 91%
rename from Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
index 97a7ecafbf85..8afc5e815ae8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
@@ -2,10 +2,17 @@
 
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,qmp-usb3-dp-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QMP USB3 DP PHY controller
+title: Qualcomm QMP USB3 DP PHY controller (SC7180)
+
+description:
+  The QMP PHY controller supports physical layer functionality for a number of
+  controllers on Qualcomm chipsets, such as, PCIe, UFS and USB.
+
+  Note that these bindings are for SoCs up to SC8180X. For newer SoCs, see
+  qcom,sc8280xp-qmp-usb43dp-phy.yaml.
 
 maintainers:
   - Wesley Cheng <quic_wcheng@quicinc.com>
-- 
2.37.4

