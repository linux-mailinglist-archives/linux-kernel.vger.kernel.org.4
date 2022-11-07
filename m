Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9CD61FC3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiKGRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiKGRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:54:14 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93EBE1;
        Mon,  7 Nov 2022 09:53:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso7633262wmp.5;
        Mon, 07 Nov 2022 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4TTGBwgL+ktdOw4ymdhP2iQ7Qgir5s0YZqnZpagiD8=;
        b=qzc1ZsNUdzsob01/2wRaVQHNLF4py4pCfex3JUed9atVJy7CuwemVZfzOMiCo6zYV6
         2H8nF9UxAtBfgaxZsEOg6JIVVirPswkP6fXN0v0z94G7BEgAm4SgM5EY9CmohgFN6yDp
         0bdn6aXfJ/C9quufF9vJwDGIBpq7MKLQIqkKy1QqV0w9TCKesd/XcjVj1m2jhPIZjWBU
         hN8P5oAuQrboUpdXg9DU52EOohOtP390+F9QCygoyXPSMKR7zwCoOFYQBpQVpy9trTF7
         T9Q1vvuieZCCk2D4XjXCjpGQMQHH5n0OSRj7bYMEAAML+n5ilga1xsZh7617IUhPorvn
         u2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4TTGBwgL+ktdOw4ymdhP2iQ7Qgir5s0YZqnZpagiD8=;
        b=YTjy9v0yV5sbbNJignAF9HC9XfSl8T2/5h2sA+UjxxoacyvnDEpyb04qQHvaqoYalZ
         MO1oTReIwg+2TvS4BFH7Ktj9VP0nWmMuDpC9RveDliEtNm2wmTli1Kg+bzte2wkbYa7s
         BikmdbwA4wQoXCmbsw8wNXIsShMIwHwNzFjQOvr0XzXsNtVUuZVYyBgF2MKjFFziBBxs
         nq0uw9qN6rp/ozyRS7n8V1XoFRF9LYZPge5QzSe8qH6cePUSawniLQgsKDsCAbzdVWlK
         WadDpjKDfOnqRJAD16GCPruQjKDV8eUu86eIvUbbFxb0U9ETIsHo3afj5dlnZQakeeXG
         1FNg==
X-Gm-Message-State: ANoB5pm+v230R+x/k2eCI6nxrZ+cEzZHavqasy3FP3gpoBiToOjs5Abd
        4FNl3Qw0MsaH37eTSUAuH/w=
X-Google-Smtp-Source: AA0mqf5+1sHKNcJD4wf6tL+PWNxmSW/c4aKVYkw8LrS7L2MjhvRDOnkfTbcFh68vIahIPRsaP3dW2g==
X-Received: by 2002:a05:600c:4f44:b0:3cf:b5dd:46f7 with SMTP id m4-20020a05600c4f4400b003cfb5dd46f7mr419523wmq.73.1667843601979;
        Mon, 07 Nov 2022 09:53:21 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c45:7ed3:c12e:e25b])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b002365254ea42sm8072454wrs.1.2022.11.07.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:53:21 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 5/5] arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for ETH{0/1}
Date:   Mon,  7 Nov 2022 17:53:05 +0000
Message-Id: <20221107175305.63975-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ7 for ETH0 and
ETH1 respectively.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 931efc07d6fb..49ecd33aeeb8 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irqc-rzg2l.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 / {
@@ -77,6 +78,8 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -104,6 +107,8 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ7 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -151,7 +156,8 @@ eth0_pins: eth0 {
 			 <RZG2L_PORT_PINMUX(3, 2, 1)>, /* ET0_RXD0 */
 			 <RZG2L_PORT_PINMUX(3, 3, 1)>, /* ET0_RXD1 */
 			 <RZG2L_PORT_PINMUX(4, 0, 1)>, /* ET0_RXD2 */
-			 <RZG2L_PORT_PINMUX(4, 1, 1)>; /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(4, 1, 1)>, /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(5, 1, 7)>; /* IRQ2 */
 	};
 
 	eth1_pins: eth1 {
@@ -169,7 +175,8 @@ eth1_pins: eth1 {
 			 <RZG2L_PORT_PINMUX(9, 1, 1)>, /* ET1_RXD0 */
 			 <RZG2L_PORT_PINMUX(9, 2, 1)>, /* ET1_RXD1 */
 			 <RZG2L_PORT_PINMUX(9, 3, 1)>, /* ET1_RXD2 */
-			 <RZG2L_PORT_PINMUX(10, 0, 1)>; /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(10, 0, 1)>, /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(18, 5, 1)>; /* IRQ7 */
 	};
 
 	sdhi0_emmc_pins: sd0emmc {
-- 
2.25.1

