Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6E60B0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiJXQMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiJXQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:05:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892928E30;
        Mon, 24 Oct 2022 07:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBD4BB818EB;
        Mon, 24 Oct 2022 12:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C885C433C1;
        Mon, 24 Oct 2022 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666616357;
        bh=oluLS6fbx5EfX/bPAz59Gt0aLRFpB7IURLSW5kgk/l4=;
        h=From:To:Cc:Subject:Date:From;
        b=QiJ2HWpRBhnKcAElAuFNs74EX3ed3GFDZcLTiN6gPxrAmjXBmF5sIqthO572zpo4/
         xCzupz3gxdHqZD33aRA2Vtc5llbsNkHMTi3dXI6HB3m8rUYdsYR4SVDScTTY5FZ0bz
         6KzqI6K0XTj6ZA1E3Zq3mQTc7BTKq7si7mahrVcTShhpegeXuF/+9zl0JfT5Xk+jnc
         ZOig9AAgfGBHK4gmBfs9X+W9a1cWloaDh5bpU+q/LVRdXIPwazr7NAAjdsWgLD48Wt
         Z8HF7RVk8VHDKM3byAXlc0cYaa/wcXOltXua2+1zSl2kuWDVXH/+g59ubiDshPHd8o
         EMb2IP3SX2b2Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omx2i-0006Zg-7u; Mon, 24 Oct 2022 14:59:01 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: add TCSR node
Date:   Mon, 24 Oct 2022 14:58:43 +0200
Message-Id: <20221024125843.25261-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
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

Add the TCSR node which is needed for PCIe configuration.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index b30c3b57fd13..79abe0e2c38d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -984,6 +984,11 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		tcsr: syscon@1fc0000 {
+			compatible = "qcom,sc8280xp-tcsr", "syscon";
+			reg = <0x0 0x01fc0000 0x0 0x30000>;
+		};
+
 		usb_0_hsphy: phy@88e5000 {
 			compatible = "qcom,sc8280xp-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
-- 
2.37.3

