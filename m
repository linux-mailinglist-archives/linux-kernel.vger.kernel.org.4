Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E865B796
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjABWTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjABWSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:18:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B2B9594;
        Mon,  2 Jan 2023 14:18:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t15so18716013wro.9;
        Mon, 02 Jan 2023 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87pexaz/1Mg04XsXrAVU5SOSGgcQVwJXYmy5/v4n+sw=;
        b=JjLAUZ55HaemIjQxq0JLX3n2KYtyao/3S1EgMQ7TFge8k2jh+Oof76gWZAuJUFjqQ+
         BdIhZUkIYjzZMTXGYE/rdDkDWjuF81PsbuxVRQGvQ9f6sStEih8yLYa2thDwFcXYm/zh
         tGC78yT8Wn+HC0mADubihr2yZjUTyT41YFcDGa/wfDBpkSX6G/IvP+3phDPE5ffNX30d
         h6XTqLfbf0kFyLcXKwCe552LoHUy6rf8NCxuUpJjfHWisqkO9vsviYRLuDdoLDZXJR4C
         +i78eHvZDqJbsGGoN30YY9nXa+2oPwtwzQaivAFTHxiAb+vB1dobI+D/YR247W85N1Gi
         Beew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87pexaz/1Mg04XsXrAVU5SOSGgcQVwJXYmy5/v4n+sw=;
        b=Oo6mjrWMmpY/Un5Lh+Vv2sCEUb0OFQL5fbGNPWXTa1DRQZszFs4Y04u+HsxiF/FmU1
         DMRH73Yq16qJA5N/Be4dRKBvfwzQRm84Jv2CAP4Hay46D2/qKVeVvMplQzNCgBXpdPBD
         Qf9i5dfH2vY1e4niUWFwnZbmuAh2qk9jdEeA7cNE57UBB+mZ7Kg3CQqi0Vhu6gUJDVwr
         trj7VnSZqzBOcf6c2PO0MIQghGAIakdcoPOqzpkjTyOkME0x+GmTDkcDL+XKJUlLzuTz
         MeVTdzhJOw6CDZyFi1wHL000aZ+g4cEcnqb8ga0LCpjkREUsqrx0hsCTWzlSsayy6d24
         KquQ==
X-Gm-Message-State: AFqh2koFQXA+NFzaZYNnUSLKdy1i9N/9BIGmJhnlPDQHbNAgOmZ35xIA
        3pUcoksbIgX4O4RK5G8oiY+/2wzhBUcZbxEc
X-Google-Smtp-Source: AMrXdXs5ofU5819EL2FO1N0TDHgeBtXVz3DaYl6IOJ65XbX7nrksuwPRW7uub7CAi0HAj0tuTlSCwA==
X-Received: by 2002:a5d:58ee:0:b0:28c:d9bf:d71 with SMTP id f14-20020a5d58ee000000b0028cd9bf0d71mr9314818wrd.25.1672697912180;
        Mon, 02 Jan 2023 14:18:32 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:8a7:e535:b020:566a])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe34e000000b002366dd0e030sm29872463wrj.68.2023.01.02.14.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:18:31 -0800 (PST)
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
Subject: [PATCH v3 6/6] arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for ETH{0/1}
Date:   Mon,  2 Jan 2023 22:18:15 +0000
Message-Id: <20230102221815.273719-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2 -> v3
* No change

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

