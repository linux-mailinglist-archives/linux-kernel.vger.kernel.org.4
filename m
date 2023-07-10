Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA474DB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGJQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGJQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B04D7;
        Mon, 10 Jul 2023 09:52:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 868AE660700F;
        Mon, 10 Jul 2023 17:52:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007952;
        bh=iAAaULXKzOM58JwUjAKjW61TNCzveUnAnpYj6EelEwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScLMNM0dSZ8G/eH50KidWkP/xzmxVlbKltljXCZhP3HbwUfO6EK+OYxMUq0Z+xurM
         iuxxTCcR1QAN0N+ufCiX1UPJy/9qL93HMCCXdK8zofBSwW3csw0RN4pLK5pE6T0aEy
         cLigX3JaScbuqXikzYD4zLOAJZw3s6yuUfx7ZD9R0HAxdI62DhVkb97hIFRfpDavCb
         UUCXPrgxGAp4c+EzJ5YRBbjkMGj6WrGfFGQd3RxY9cw611oqQZ5X9tsDQ4Z5/Vp39v
         ldcSCEKUntJlpyX5naJDCxbjosTQit2avsrVKiczs3S5C9Wi0//leJcHNsDOXR2EkS
         aU+YTzb3XKLMQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 24C224807E1; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 08/13] arm64: dts: rockchip: rock-5a: add analog audio
Date:   Mon, 10 Jul 2023 18:52:23 +0200
Message-Id: <20230710165228.105983-9-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add analog audio support based on the Everest Semi ES8316 codec.

Note, that this currently does not support headphone plug events. The
Rock 5A uses a different headphone jack with a different logic to detect
a headphone plug. Unfortunately the detect GPIO is always low.
Downstream uses an ADC channel instead, but that is currently not
supported upstream.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 5bad81c5b09d..4c6c87d462e9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -16,6 +16,20 @@ aliases {
 		serial2 = &uart2;
 	};
 
+	analog-sound {
+		compatible = "audio-graph-card";
+		label = "rk3588-es8316";
+
+		widgets = "Microphone", "Mic Jack",
+			  "Headphone", "Headphones";
+
+		routing = "MIC2", "Mic Jack",
+			  "Headphones", "HPOL",
+			  "Headphones", "HPOR";
+
+		dais = <&i2s0_8ch_p0>;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
@@ -149,6 +163,44 @@ regulator-state-mem {
 	};
 };
 
+&i2c7 {
+	status = "okay";
+
+	es8316: audio-codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru I2S0_8CH_MCLKOUT>;
+		clock-names = "mclk";
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s0_8ch_p0_0>;
+			};
+		};
+	};
+};
+
+&i2s0_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s0_lrck
+		     &i2s0_mclk
+		     &i2s0_sclk
+		     &i2s0_sdi0
+		     &i2s0_sdo0>;
+	status = "okay";
+
+	i2s0_8ch_p0: port {
+		i2s0_8ch_p0_0: endpoint {
+			dai-format = "i2s";
+			mclk-fs = <256>;
+			remote-endpoint = <&es8316_p0_0>;
+		};
+	};
+};
+
 &gmac1 {
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy1>;
-- 
2.40.1

