Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2467A833
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjAYBCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjAYBC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:02:28 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D55B51C43;
        Tue, 24 Jan 2023 17:02:23 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Jan 2023 10:02:19 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 70E242059054;
        Wed, 25 Jan 2023 10:02:19 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 25 Jan 2023 10:02:18 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id CD4813D53;
        Wed, 25 Jan 2023 10:02:18 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 5/5] arm64: dts: uniphier: Add syscon-uhs-mode to SD node
Date:   Wed, 25 Jan 2023 10:02:01 +0900
Message-Id: <20230125010201.28246-6-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
References: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
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
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 9308458f9611..687a29c9d459 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -548,7 +548,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		sdctrl: sdctrl@59810000 {
 			compatible = "socionext,uniphier-ld20-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
@@ -611,6 +611,7 @@ sd: mmc@5a400000 {
 			resets = <&sd_rst 0>;
 			bus-width = <4>;
 			cap-sd-highspeed;
+			socionext,syscon-uhs-mode = <&sdctrl 0>;
 		};
 
 		soc_glue: soc-glue@5f800000 {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index b0c29510a7da..4c18f54abb15 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -370,7 +370,7 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		sdctrl: sdctrl@59810000 {
 			compatible = "socionext,uniphier-pxs3-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
@@ -437,6 +437,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr12;
 			sd-uhs-sdr25;
 			sd-uhs-sdr50;
+			socionext,syscon-uhs-mode = <&sdctrl 0>;
 		};
 
 		soc_glue: soc-glue@5f800000 {
-- 
2.25.1

