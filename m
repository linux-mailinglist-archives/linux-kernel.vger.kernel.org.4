Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2083268CCA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBGCfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:35:23 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7884B3430F;
        Mon,  6 Feb 2023 18:35:21 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Feb 2023 11:35:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id AB8B42058B4F;
        Tue,  7 Feb 2023 11:35:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 7 Feb 2023 11:35:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 57A327368;
        Tue,  7 Feb 2023 11:35:20 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 4/8] ARM: dts: uniphier: Add syscon-uhs-mode to SD node
Date:   Tue,  7 Feb 2023 11:35:10 +0900
Message-Id: <20230207023514.29783-5-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207023514.29783-1-hayashi.kunihiko@socionext.com>
References: <20230207023514.29783-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sociopnext,syscon-uhs-mode prpperty to the SD node to refer the handle
of the control logic node.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro4.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pro5.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index c28071a08e3a..ba55af30e904 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -241,7 +241,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		syscon@59810000 {
+		mioctrl: syscon@59810000 {
 			compatible = "socionext,uniphier-pro4-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x800>;
@@ -307,6 +307,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&mioctrl 0>;
 		};
 
 		emmc: mmc@5a500000 {
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index a2000cfe9272..2d8591cdddb8 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -341,7 +341,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		syscon@59810000 {
+		sdctrl: syscon@59810000 {
 			compatible = "socionext,uniphier-pro5-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
@@ -699,6 +699,7 @@ sd: mmc@68800000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&sdctrl 0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 55a298552bec..f97a57222101 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -422,7 +422,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		syscon@59810000 {
+		sdctrl: syscon@59810000 {
 			compatible = "socionext,uniphier-pxs2-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
@@ -486,6 +486,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&sdctrl 0>;
 		};
 
 		soc_glue: syscon@5f800000 {
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 27aa55bb7f32..f876282760e9 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -211,7 +211,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		syscon@59810000 {
+		mioctrl: syscon@59810000 {
 			compatible = "socionext,uniphier-sld8-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x800>;
@@ -276,6 +276,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&mioctrl 0>;
 		};
 
 		emmc: mmc@5a500000 {
-- 
2.25.1

