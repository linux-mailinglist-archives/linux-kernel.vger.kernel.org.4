Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E086ECA29
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjDXKVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjDXKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:20:44 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D410DF;
        Mon, 24 Apr 2023 03:20:43 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 641195EE19;
        Mon, 24 Apr 2023 12:36:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-0lLAHDCF;
        Mon, 24 Apr 2023 12:36:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328975;
        bh=y7dJz8FU5tfDpAY0eGkdfYiaw3POjVAiEmGtpiD+K7I=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Ae86ylug5zIP3hrqEdZs5fOAVjGiBypkdvvpF4FHzEtH9iXURaoDa3LdB24TVjF7E
         +3deRQCYHVhJToNXFf0ggLVnnC/6MlF+r0MIwzC6gBvEsZzxznAtSSVKpqqIO/Xe63
         K4jCreeWzt7KixBS7FSWpitBsQRv0urcUgaqbGjY=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 41/43] ARM: dts: ep93xx: Add I2S and AC97 nodes
Date:   Mon, 24 Apr 2023 15:34:57 +0300
Message-Id: <20230424123522.18302-42-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Add the audio interfaces present in EP93xx SoCs.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/ep93xx.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/ep93xx.dtsi b/arch/arm/boot/dts/ep93xx.dtsi
index d896bdcc6b10..bba5fa753176 100644
--- a/arch/arm/boot/dts/ep93xx.dtsi
+++ b/arch/arm/boot/dts/ep93xx.dtsi
@@ -174,6 +174,19 @@ dma1: dma-controller@80000100 {
 			interrupts = <17>, <18>;
 		};
 
+		i2s: i2s@80820000 {
+			compatible = "cirrus,ep9301-i2s";
+			#sound-dai-cells = <0>;
+			reg = <0x80820000 0x100>;
+			interrupt-parent = <&vic1>;
+			interrupts = <28>;
+			clocks = <&syscon EP93XX_CLK_I2S_MCLK
+				  &syscon EP93XX_CLK_I2S_SCLK
+				  &syscon EP93XX_CLK_I2S_LRCLK>;
+			clock-names = "mclk", "sclk", "lrclk";
+			status = "disabled";
+		};
+
 		gpio0: gpio@80840000 {
 			compatible = "cirrus,ep9301-gpio";
 			chip-label = "A";
@@ -293,6 +306,17 @@ ide: ide@800a0000 {
 			pinctrl-0 = <&ide_default_pins>;
 		};
 
+		ac97: ac97@80880000 {
+			compatible = "cirrus,ep9301-ac97";
+			#sound-dai-cells = <0>;
+			reg = <0x80880000 0xac>;
+			interrupt-parent = <&vic0>;
+			interrupts = <6>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ac97_default_pins>;
+			status = "disabled";
+		};
+
 		uart0: uart@808c0000 {
 			compatible = "arm,primecell";
 			reg = <0x808c0000 0x1000>;
-- 
2.39.2

