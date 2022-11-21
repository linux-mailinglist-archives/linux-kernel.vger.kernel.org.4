Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0663290C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKUQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKUQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:11:14 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C3C5B65
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:11:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by albert.telenet-ops.be with bizsmtp
        id n4BB2800W5WXlCv064BBA1; Mon, 21 Nov 2022 17:11:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9O3-0019Is-38; Mon, 21 Nov 2022 17:11:11 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9O2-00BRya-86; Mon, 21 Nov 2022 17:11:10 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] ARM: dts: am335x: Fix TDA998x ports addressing
Date:   Mon, 21 Nov 2022 17:11:09 +0100
Message-Id: <e9ac64d29bc18b3b394fd9a2abbfeafacc624f98.1669047037.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix addressing in the NXP TDA998x HDMI transmitters' subnodes:
  - Add missing #{address,size}-cells properties to ports capsule,
  - Add missing reg properties to port child nodes,
  - Drop bogus unit addresses from endpoint grandchildren nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Drop applied patches from the series,

v2:
  - No changes.
---
 arch/arm/boot/dts/am335x-boneblack-hdmi.dtsi | 7 ++++++-
 arch/arm/boot/dts/am335x-myirtech-myd.dts    | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack-hdmi.dtsi b/arch/arm/boot/dts/am335x-boneblack-hdmi.dtsi
index 7cfddada934861bc..486f24deb875c688 100644
--- a/arch/arm/boot/dts/am335x-boneblack-hdmi.dtsi
+++ b/arch/arm/boot/dts/am335x-boneblack-hdmi.dtsi
@@ -85,8 +85,13 @@ tda19988: tda19988@70 {
 		audio-ports = <	TDA998x_I2S	0x03>;
 
 		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			port@0 {
-				hdmi_0: endpoint@0 {
+				reg = <0>;
+
+				hdmi_0: endpoint {
 					remote-endpoint = <&lcdc_0>;
 				};
 			};
diff --git a/arch/arm/boot/dts/am335x-myirtech-myd.dts b/arch/arm/boot/dts/am335x-myirtech-myd.dts
index 9d81d4cc6890eea9..425ad9b81a68ab18 100644
--- a/arch/arm/boot/dts/am335x-myirtech-myd.dts
+++ b/arch/arm/boot/dts/am335x-myirtech-myd.dts
@@ -161,8 +161,13 @@ tda9988: tda9988@70 {
 		#sound-dai-cells = <0>;
 
 		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			port@0 {
-				hdmi_0: endpoint@0 {
+				reg = <0>;
+
+				hdmi_0: endpoint {
 					remote-endpoint = <&lcdc_0>;
 				};
 			};
-- 
2.25.1

