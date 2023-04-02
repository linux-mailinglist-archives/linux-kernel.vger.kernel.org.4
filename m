Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78E6D36B0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDBJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDBJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:51:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665059E8;
        Sun,  2 Apr 2023 02:51:04 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF83D660312D;
        Sun,  2 Apr 2023 10:51:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680429063;
        bh=SvocWMiVjKrI7HollcLDxvyJtaFIB6bgp0o82PWqs70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIo9uK7+AH7ROGJvnguRB1/dtbxQviEQzGpzG1Y6HUMwCYqSyeiMJr8qk5c3+sT64
         M/8o4CFuIfXFDXhARCPHDoGq9beaSCPe55liYqH7R5NuZ5iebo+DJvvvawDU4qqHK4
         7/wiPV/7IIeX3f0vX8dggrqWSZarwAejtu03J2ouqKjPnoMMr/rYcAhgPiEXzuD4Hm
         Yy26n7XIWbt/jLt7GsGyPiBJpoHqjgn58zyXUIcBTI2GKU/8qmUxwvc00iT7QY7g5E
         2W11StE3PCPPTHsMeWc3IVukwpgaZosXovx0aHLeoPoZv0CNtYN5neJ0epyoJut/RJ
         kAuLb0Sbcrqfg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 1/5] arm64: dts: rockchip: rk3588s: Fix SCMI assigned clocks
Date:   Sun,  2 Apr 2023 12:50:50 +0300
Message-Id: <20230402095054.384739-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
References: <20230402095054.384739-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit df4fdd0db475 ("dt-bindings: firmware: arm,scmi: Restrict
protocol child node properties") the following dtbs_check warning is
shown:

  rk3588-rock-5b.dtb: scmi: protocol@14: Unevaluated properties are not
  allowed ('assigned-clock-rates', 'assigned-clocks' were unexpected)

Because adding the missing properties to firmware/arm,scmi.yaml binding
document was not an acceptable solution, move SCMI_CLK_CPUB01 and
SCMI_CLK_CPUB23 assigned clocks to the related CPU nodes and also add
the missing SCMI_CLK_CPUL.

Additionally, adjust frequency to 816 MHz for all the above mentioned
assigned clocks, in order to match the firmware defaults.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 7840767dfcd8..028dc62f63ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -60,6 +60,8 @@ cpu_l0: cpu@0 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <530>;
 			clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			assigned-clocks = <&scmi_clk SCMI_CLK_CPUL>;
+			assigned-clock-rates = <816000000>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
@@ -136,6 +138,8 @@ cpu_b0: cpu@400 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
+			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>;
+			assigned-clock-rates = <816000000>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -174,6 +178,8 @@ cpu_b2: cpu@600 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
+			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB23>;
+			assigned-clock-rates = <816000000>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -313,10 +319,6 @@ scmi: scmi {
 
 			scmi_clk: protocol@14 {
 				reg = <0x14>;
-				assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>,
-						  <&scmi_clk SCMI_CLK_CPUB23>;
-				assigned-clock-rates = <1200000000>,
-						       <1200000000>;
 				#clock-cells = <1>;
 			};
 
-- 
2.40.0

