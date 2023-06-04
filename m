Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7797217FF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjFDO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjFDO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:57:14 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFCF13A;
        Sun,  4 Jun 2023 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685890612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bLUXA4878g/UvHVxmBNWXjGexK/P7B7yeTnDxDXg25A=;
        b=Qb9FfZl3AuPSaZOXRVqRm58S2lAknvCcydsyRNW9As6fkwTqqcnQ/I6+tmKFPmjEUGh/bo
        N6gtrqRr4mYjbXAEAnnRaope/woG5vjsNxyZZumWEHybiKPqZ0bqYMH1wMfawf8TKZ/BgC
        DBS8wXDhVAmc8uAUptU5H0Euw3E4NUY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/9] MIPS: DTS: CI20: Fix ACT8600 regulator node names
Date:   Sun,  4 Jun 2023 16:56:35 +0200
Message-Id: <20230604145642.200577-3-paul@crapouillou.net>
In-Reply-To: <20230604145642.200577-1-paul@crapouillou.net>
References: <20230604145642.200577-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Device Tree was using invalid node names for the ACT8600 regulators.
To be fair, it is not the original committer's fault, as the
documentation did gives invalid names as well.

In theory, the fix should have been to modify the driver to accept the
alternative names. However, even though the act8865 driver spits
warnings, the kernel seemed to work fine with what is currently
supported upstream. For that reason, I think it is okay to just update
the DTS.

I removed the "regulator-name" too, since they really didn't bring any
information. The node names are enough.

Fixes: 73f2b940474d ("MIPS: CI20: DTS: Add I2C nodes")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index e76953dce2e7..5361606c5e13 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -237,59 +237,49 @@ &i2c0 {
 	act8600: act8600@5a {
 		compatible = "active-semi,act8600";
 		reg = <0x5a>;
-		status = "okay";
 
 		regulators {
-			vddcore: SUDCDC1 {
-				regulator-name = "DCDC_REG1";
+			vddcore: DCDC1 {
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 			};
-			vddmem: SUDCDC2 {
-				regulator-name = "DCDC_REG2";
+			vddmem: DCDC2 {
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
-			vcc_33: SUDCDC3 {
-				regulator-name = "DCDC_REG3";
+			vcc_33: DCDC3 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
-			vcc_50: SUDCDC4 {
-				regulator-name = "SUDCDC_REG4";
+			vcc_50: SUDCDC_REG4 {
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5000000>;
 				regulator-always-on;
 			};
-			vcc_25: LDO_REG5 {
-				regulator-name = "LDO_REG5";
+			vcc_25: LDO5 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
-			wifi_io: LDO_REG6 {
-				regulator-name = "LDO_REG6";
+			wifi_io: LDO6 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
-			vcc_28: LDO_REG7 {
-				regulator-name = "LDO_REG7";
+			cim_io_28: LDO7 {
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-always-on;
 			};
-			vcc_15: LDO_REG8 {
-				regulator-name = "LDO_REG8";
+			cim_io_15: LDO8 {
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 			vrtc_18: LDO_REG9 {
-				regulator-name = "LDO_REG9";
 				/* Despite the datasheet stating 3.3V
 				 * for REG9 and the driver expecting that,
 				 * REG9 outputs 1.8V.
@@ -303,7 +293,6 @@ vrtc_18: LDO_REG9 {
 				regulator-always-on;
 			};
 			vcc_11: LDO_REG10 {
-				regulator-name = "LDO_REG10";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
-- 
2.39.2

