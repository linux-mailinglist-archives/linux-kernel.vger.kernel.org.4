Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2116A61141F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJ1OJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJ1OJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:09:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3EE51E047D;
        Fri, 28 Oct 2022 07:09:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E499512FC;
        Fri, 28 Oct 2022 07:09:18 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 935F53F534;
        Fri, 28 Oct 2022 07:09:11 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: juno: Add Thermal critical trip points
Date:   Fri, 28 Oct 2022 15:08:33 +0100
Message-Id: <20221028140833.280091-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028140833.280091-1-cristian.marussi@arm.com>
References: <20221028140833.280091-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When thernal zones are defined, trip points definitions are mandatory.
Define a couple of critical trip points for monitoring of existing
PMIC and SOC thermale zones.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
----
Not sure if we want to add a:

Fixes: f7b636a8d83c ("arm64: dts: juno: add thermal zones for scpi sensors")
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 2f27619d8abd..8b4d280b1e7e 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -751,12 +751,26 @@ pmic {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 0>;
+			trips {
+				pmic_crit0: trip0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
 		soc {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 3>;
+			trips {
+				soc_crit0: trip0 {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
 		big_cluster_thermal_zone: big-cluster {
-- 
2.34.1

