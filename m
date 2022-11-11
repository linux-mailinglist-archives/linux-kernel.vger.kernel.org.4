Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A06256C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiKKJ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiKKJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D177878C;
        Fri, 11 Nov 2022 01:26:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34C5961F13;
        Fri, 11 Nov 2022 09:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E44C43470;
        Fri, 11 Nov 2022 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158764;
        bh=UrFSXtJ3txbQP4cpdXwmp++PX9fOWMGWIAQXlwK8rWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ori2nCdeD5KLmQwtIrkUmbS+G1dB4qspOENLhoH3FQeXUT9fwtqwH56XFpWzbIcWg
         LWyi0bKpGuJyltDxN4oxX4bJe8KxKVBkWCYpoFFPoWy2NkZ95oPBgPlS3nYkIm+bLq
         KYiXz3RIc1TDCL2s/NmEgblOuBpa83QypxZrF24UipVSlqXO6q/XDX8/rmmXVpFZRf
         kJ6qS+F1rnWtjPbSZP8u3d9UtbLz3Ul7qA1awHpK2NasuG/pEgZJefl4zgqbIMvRn+
         l6iMmJj1qpeBBSlT2nDqnw4sfjFmsSeSTj5qNlTMlguoePcZ6zfoUysbXqny0BVsN6
         pfN40Hcbf3wAw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQI4-0002kp-IQ; Fri, 11 Nov 2022 10:25:36 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 01/14] dt-bindings: phy: qcom,qmp-usb3-dp: rename current bindings
Date:   Fri, 11 Nov 2022 10:24:44 +0100
Message-Id: <20221111092457.10546-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111092457.10546-1-johan+linaro@kernel.org>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 ...3-dp-phy.yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb3-dp-phy.yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} (92%)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
index 97a7ecafbf85..50b1fce530d5 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml
@@ -2,10 +2,17 @@
 
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,qmp-usb3-dp-phy.yaml#"
+$id: "http://devicetree.org/schemas/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
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

