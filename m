Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA126C3D38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCUV6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCUV5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:57:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA359416;
        Tue, 21 Mar 2023 14:56:53 -0700 (PDT)
Received: from localhost (unknown [188.24.179.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDA8A66030EC;
        Tue, 21 Mar 2023 21:56:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679435812;
        bh=+MtX3jyXI+IUnWH8L4gmCzjEp2lgpmeRUn7E2R8gEZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzXWPHcPGumZEt6p92/sYRVKTJy7TawAlOsfr0i0+FkosNRd7SnKRt2zwb7N0Fec9
         BPDfQSzTOvBEdEo3QUcQvE2hrSw4uibFWJdJMTvTzeHGxs4UCONLMvliItUwZdEDA9
         fyctN2f7sTmNgBUt6mKoJ6d8wnLzx0NG2c1vRDMD8DQJ/ImgOJVn4FR9cZ+QLQf33G
         Gztc+a1mvtLGCNUH7IH8rHbp6D9Bgw1718z62irSyfm/DZfURKu6zESJjJMIdRtM9E
         rRe4Eh2/iL1X/kzWAp7H0l2W4haeQIvMRaLFTP9dxeETqJ/32kP3ZEWiDbvjiO5geY
         9h43t8Wd4XMiQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 07/10] arm64: dts: rockchip: rk3588s: Move assigned-clocks/assigned-clock-rates out of scmi
Date:   Tue, 21 Mar 2023 23:56:21 +0200
Message-Id: <20230321215624.78383-8-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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

Since adding the missing properties to
Documentation/devicetree/bindings/firmware/arm,scmi.yaml was not an
acceptable solution, move them from scmi to cpu nodes.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index fca8503aed8c..24039144dfec 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -136,6 +136,8 @@ cpu_b0: cpu@400 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk SCMI_CLK_CPUB01>;
+			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB01>;
+			assigned-clock-rates = <1200000000>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -174,6 +176,8 @@ cpu_b2: cpu@600 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk SCMI_CLK_CPUB23>;
+			assigned-clocks = <&scmi_clk SCMI_CLK_CPUB23>;
+			assigned-clock-rates = <1200000000>;
 			cpu-idle-states = <&CPU_SLEEP>;
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -304,10 +308,6 @@ scmi: scmi {
 
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

