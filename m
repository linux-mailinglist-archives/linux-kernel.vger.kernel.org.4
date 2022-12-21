Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C42652A44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiLUADr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiLUADQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:03:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D41F2C2;
        Tue, 20 Dec 2022 16:03:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o5so13445757wrm.1;
        Tue, 20 Dec 2022 16:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDx4PoIIM9s55jr76B6tJoItpMqZgxuY5BT2+9L4lSA=;
        b=KSvwsEDwSmMQkLfJuZJjF/qg5HVZhKX5+asanYJ14dRgci2s8AXZYUaTAqQrpCqoEy
         hCt7nBBopzrFTlzr/TC4hFxMXpIiN3tSCx7O1fWgA93bH98oC03E7SekzTSp+pLl5C38
         xCeZC8Kfv/t3sMp4nXEeikNjyHb0Yp00R6krutG3bn2fsJiw+zPQP9EAP6A8z4qrl3Hf
         01w0zSvZBx5rrhkSd0kSDxsZZFFg3Bov7pdGGZV4sB7VLO/6HKy07O9Vf8Sssk/jUb+a
         mVk2iI/yz5ZP62UAaI4qeZoHfmUIdmQNR8+VurAChiPN32N69qB6HFuE34YBY7XkxWAi
         tVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDx4PoIIM9s55jr76B6tJoItpMqZgxuY5BT2+9L4lSA=;
        b=pvEQatrpcSgWL/ol0P4NLg1GKdRxfAfZdLDq/yUPR0+hcEmHMLzjBb0nucsMuZoAwT
         KOi8YmnNFqCnjjfqKmx5aHL7A11TYX7re4Dy+q46N3QyfUIqCCiRTysdyxCrW5iwzlOL
         7V9G4cOiAkyGvyb/Mr9YILS1CmlAGC1MOxIutHR9AEhg5pblMEnxaIcuqPKcOIZR+QLv
         S9qTMrf6vUslMsfp6qd/blNgbK/4UGkuUqMMLqdExbY02l5vSvz5tkLYgQ1/rGXsh2MS
         32eWInKIFIWcG8Z0OoJr/cBkOchy97tXeHDd95G2M9NFVaI6gUmJAe6CjeiR+jfAyrFk
         Lc2Q==
X-Gm-Message-State: AFqh2ko0LP0lC8i5y36yfQX6R/wjr/5rbv5MaLhxcZIZ9qjk9ToQLBxR
        3lb+YeAjV/cc84LSB0unWzo=
X-Google-Smtp-Source: AMrXdXv9LRP1Qpx2tmKWUDbyQUAHBj7IkpB6m1UmdJalm1DtiW26Q/6lEjvMRCLz7ljioJgYscwvlg==
X-Received: by 2002:a05:6000:691:b0:260:6dca:f239 with SMTP id bo17-20020a056000069100b002606dcaf239mr7450448wrb.22.1671580986330;
        Tue, 20 Dec 2022 16:03:06 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:03:05 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 9/9] arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for ETH{0/1}
Date:   Wed, 21 Dec 2022 00:02:42 +0000
Message-Id: <20221221000242.340202-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1 -> v2
* No change
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

