Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8160BC40
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiJXVdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJXVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA2186DD;
        Mon, 24 Oct 2022 12:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5E8661575;
        Mon, 24 Oct 2022 19:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB923C433C1;
        Mon, 24 Oct 2022 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666640271;
        bh=GTzGyK5ICOdcW3TRbCJOV0+yXyHnU9QoAMm0ZKS8v1c=;
        h=From:To:Cc:Subject:Date:From;
        b=ALITZss1pRbrMLdGnnQCScYQIAox+NcvETAU1maabpqGSPYDt06K5VvFXuzFOtgAT
         jnUpj/4Kf8pzKh4YkR7sbKknASD6DgQJlDKWscUF7ErS2PwmolbpJ9NUFUdmUwPueA
         IgF7ZhjNzcHl46dHOByqrTfML814kg079KcqiHjuFhr0eCyyMuHY88XK1LI1SosyT8
         RmlTXj2E59MkGAh/Mzcf3gbOXYexxeuJM6dfHGmjSxYb//EvbyHfzjWvSzb+x1fBhP
         b7wI7EEXjwuDvwVeQRYKT5m20PvJ5Knq12gE3A7rfbPy826UEx4gyTJI5LksnTxp+5
         h0pKCrJ70TL/g==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Padmarao Begari <padmarao.begari@microchip.com>
Subject: [RFC] riscv: dts: microchip: add OPPs to mpfs
Date:   Mon, 24 Oct 2022 20:36:48 +0100
Message-Id: <20221024193647.1089769-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.0
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

From: Conor Dooley <conor.dooley@microchip.com>

The U-Boot dts for mpfs defines three OPPs which are missing from the
Linux dts. For ease of synchronisation of the two, add the missing OPPs
to the Linux dt too.

CC: Padmarao Begari <padmarao.begari@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

Hey Padmarao,
I've been trying to pick off the bits that're different between the Linux
& U-Boot dts. Do you remember why we added OPPs to the U-Boot dts but
didn't propagate them elsewhere?

 arch/riscv/boot/dts/microchip/mpfs.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 0a9bb84af438..9d9ff7174341 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -23,6 +23,7 @@ cpu0: cpu@0 {
 			reg = <0>;
 			riscv,isa = "rv64imac";
 			clocks = <&clkcfg CLK_CPU>;
+			operating-points-v2 = <&cluster0_opps>;
 			status = "disabled";
 
 			cpu0_intc: interrupt-controller {
@@ -51,6 +52,7 @@ cpu1: cpu@1 {
 			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
 			next-level-cache = <&cctrllr>;
+			operating-points-v2 = <&cluster0_opps>;
 			status = "okay";
 
 			cpu1_intc: interrupt-controller {
@@ -79,6 +81,7 @@ cpu2: cpu@2 {
 			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
 			next-level-cache = <&cctrllr>;
+			operating-points-v2 = <&cluster0_opps>;
 			status = "okay";
 
 			cpu2_intc: interrupt-controller {
@@ -107,6 +110,7 @@ cpu3: cpu@3 {
 			clocks = <&clkcfg CLK_CPU>;
 			tlb-split;
 			next-level-cache = <&cctrllr>;
+			operating-points-v2 = <&cluster0_opps>;
 			status = "okay";
 
 			cpu3_intc: interrupt-controller {
@@ -136,6 +140,7 @@ cpu4: cpu@4 {
 			tlb-split;
 			next-level-cache = <&cctrllr>;
 			status = "okay";
+			operating-points-v2 = <&cluster0_opps>;
 			cpu4_intc: interrupt-controller {
 				#interrupt-cells = <1>;
 				compatible = "riscv,cpu-intc";
@@ -166,6 +171,24 @@ core4 {
 				};
 			};
 		};
+
+		cluster0_opps: opp-table {
+			compatible = "operating-points-v2";
+			opp-shared;
+
+			opp-600000000 {
+			    opp-hz = /bits/ 64 <600000000>;
+			    opp-microvolt = <1100000>;
+			};
+			opp-300000000 {
+			    opp-hz = /bits/ 64 <300000000>;
+			    opp-microvolt = <950000>;
+			};
+			opp-150000000 {
+			    opp-hz = /bits/ 64 <150000000>;
+			    opp-microvolt = <750000>;
+			};
+		};
 	};
 
 	refclk: mssrefclk {
-- 
2.38.0

