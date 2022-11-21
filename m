Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D86E631BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKUIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKUIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:52:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9E233B6;
        Mon, 21 Nov 2022 00:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1F960F3B;
        Mon, 21 Nov 2022 08:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728ACC433B5;
        Mon, 21 Nov 2022 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669020714;
        bh=bL1Lmk1URusXyJ0VYumbL+Pqp5Rn8rtPK8iccOoWcEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYqyXOz0h0KuyhVa+dPy4tjhg5emmFJdFsJXP7ceIp0sXvuHtLmNNHa73lofHtClG
         Fhm43TfTl1VQV1Fe98OBkdXvnUBsFWwgC9FKrpjukRQSmQO2B9IoaWMG4/uPmLXEpv
         qlEU0UgEVCZTvv3+H9YjKQ6Gy68GqGsZVo+8cqpAldPVQ7gy+z2+YoTUJxpO5hCAjZ
         Q4+CISs07vy7U1nRfcE6BZ7iBehCpWOtwFa3hDtgD4oVa0k/Cr4RGjZSiYsUCC4SSJ
         gdtZXWW3iHOq+96KF0W3rpO+LlyXqFTuKug2LoZmsEgE0e1HyiW6gSLqoZutYjdPAC
         733A1WKHV/GtQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ox2WS-00088F-G0; Mon, 21 Nov 2022 09:51:24 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 01/15] dt-bindings: phy: qcom,qmp-usb3-dp: rename current bindings
Date:   Mon, 21 Nov 2022 09:50:44 +0100
Message-Id: <20221121085058.31213-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221121085058.31213-1-johan+linaro@kernel.org>
References: <20221121085058.31213-1-johan+linaro@kernel.org>
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

