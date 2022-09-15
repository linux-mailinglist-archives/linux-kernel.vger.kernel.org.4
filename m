Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437CF5B9D66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiIOOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiIOOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:35:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC673904;
        Thu, 15 Sep 2022 07:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 182DAB82108;
        Thu, 15 Sep 2022 14:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F71C433D6;
        Thu, 15 Sep 2022 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663252498;
        bh=MBEuRB4+zVxwIj+Pghot4ZhJxcst/TbsIw8jjymioF0=;
        h=From:To:Cc:Subject:Date:From;
        b=gmtJtNs8ZOB1r4cxXaWG4juoTtBhPPZIQ53ZQ2DVpOlfUatCxNQcU7i9hbFo9XeuU
         5/DaHWwkQEWaK0pUMPT7plOJCOdLe8eHmWi8lNlfpfAGW4pLidggxmyGHylstVEkXp
         1e/OhA+qjllUV0dT4kKG/oZzQBcm6XQVQ5cmHjS80jrWWhn9c5qkVnuIsWufyXwrM4
         2QKPRg7XM3B1denglydAWs0itGudVz6ekbaPxa0DVXv2GWL+3PTcJ1yJqL0RND+QzF
         8sYDx02ahVpYycq22zc5r01qF9vWk0Qjc0YXLzaQ1I39Iue/12s9UF/sOsAydnMn7/
         OEBnZxgeMb4sg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oYpxG-0005AW-Cc; Thu, 15 Sep 2022 16:35:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] arm64: dts: qcom: ipq8074: fix PCIe PHY serdes size
Date:   Thu, 15 Sep 2022 16:34:30 +0200
Message-Id: <20220915143431.19842-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The size of the PCIe PHY serdes register region is 0x1c4 and the
corresponding 'reg' property should specifically not include the
adjacent regions that are defined in the child node (e.g. tx and rx).

Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index d53675fc1595..b9bf43215ada 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -199,7 +199,7 @@ qusb_phy_0: phy@79000 {
 
 		pcie_qmp0: phy@86000 {
 			compatible = "qcom,ipq8074-qmp-pcie-phy";
-			reg = <0x00086000 0x1000>;
+			reg = <0x00086000 0x1c4>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -227,7 +227,7 @@ pcie_phy0: phy@86200 {
 
 		pcie_qmp1: phy@8e000 {
 			compatible = "qcom,ipq8074-qmp-pcie-phy";
-			reg = <0x0008e000 0x1000>;
+			reg = <0x0008e000 0x1c4>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.35.1

