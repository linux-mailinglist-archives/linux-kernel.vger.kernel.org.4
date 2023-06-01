Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862BB719DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjFAN0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjFAN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:26:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD63519B;
        Thu,  1 Jun 2023 06:26:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so8787015e9.1;
        Thu, 01 Jun 2023 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685625977; x=1688217977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mY4ulbNFE/jjkAM6F1KYjqgtbBRcYBjAGNE85b4mha4=;
        b=Eyrfbb4GRekIwaWBrbBJoAQ+TnpS4Wpf9ICO7qzsFvxrI9yFUyGrFRxRngKXl20JW3
         tEbx+C9qcNg2G+jhDjaxDGirdsMr/nreZgAB9LkqbAaVVfWCJFlrs3R8sFu+BsIiquMP
         lbCyVxQMJzaR1SqXubYb72QmrEP1SnkUlHjOwgYf6cZjhmdUf0SWLC5O5Ya/hRGn8rHe
         v9SzgNnKjXNQNNs/ci1y7YuRaMQWCCUzO3r6LLTJz12h5My9spUJ8CexcmAWpWSJowE8
         MspDWpWbFA3mTGmxvAt9KdlZhRjlGfdLXibIIdrUbLBeVgxKF+cZsb4pvM56w+unqb+z
         CfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685625977; x=1688217977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY4ulbNFE/jjkAM6F1KYjqgtbBRcYBjAGNE85b4mha4=;
        b=cgqF1eLqN//cS5cC7lWmVficG2kWef2OtvL1fbhR4JgfUMYhzXzovcBhN0epRyum/J
         7fAmAUHeOFOGgrHYbhRu/n0A9n75ly9FeP7p4CsJzS1jvel9SQmkOZDVtmxWu+3gbmLx
         3i1WbTovfUFOYxtaFgQNYp6M4tSOYGGAOAUZPOExxwxbWsUB/2UeqnjyAbgbzqRlvdUx
         rtSH4+hrqvyCjWMMCPrq8jmQBIbDt1WL4AEHE3IXh3djGbYro3TD5uSIkTykX1Em054y
         f0Nztyn+TkTGdOE10O5itjxIQ1sFaM+V7CYIRB7bpMVw2sfNiVJZN89yZ88J66nmxJ+W
         0eZQ==
X-Gm-Message-State: AC+VfDwtaKZ8rp1xgf+2pMiGyBLXQNCSeEgGfN2XVpcY6C+IMH1Mzf3j
        0Y3VaEUDhn+U6oq5aYpAYNI=
X-Google-Smtp-Source: ACHHUZ4u07oje+b/pW5QY8IISmc/7hrBKpGR8OodL8MJC5Gg23AvYMTBZe3OPWHRjosNZWA7j6ukxw==
X-Received: by 2002:a7b:ca59:0:b0:3f4:f7c2:d681 with SMTP id m25-20020a7bca59000000b003f4f7c2d681mr2294755wml.29.1685625976702;
        Thu, 01 Jun 2023 06:26:16 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003f60119ee08sm2396549wmc.43.2023.06.01.06.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 06:26:16 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Andrew Powers-Holmes <aholmes@omnom.net>,
        Ondrej Jirman <megi@xff.cz>, stable@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register and range mappings
Date:   Thu,  1 Jun 2023 15:25:16 +0200
Message-Id: <20230601132516.153934-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Powers-Holmes <aholmes@omnom.net>

The register and range mappings for the PCIe controller in Rockchip's
RK356x SoCs are incorrect. Replace them with corrected values from the
vendor BSP sources, updated to match current DT schema.

These values are also used in u-boot.

Fixes: 66b51ea7d70f ("arm64: dts: rockchip: Add rk3568 PCIe2x1 controller")
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Powers-Holmes <aholmes@omnom.net>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---

Since nobody else was gonna submit this fix on a fix, I decided
to do it myself, based on the u-boot patch Jonas Karlman wrote.

Please test that this does not break the PCIe 3 controller on
RK3568 hardware, I don't have the right setup to easily test it
on there.

Changes since v1:
 - Fix copy-paste error on second reg property from 0xf2000000
   to 0xf0000000

 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 ++++++++------
 arch/arm64/boot/dts/rockchip/rk356x.dtsi |  7 ++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index ba67b58f05b7..f1be76a54ceb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -94,9 +94,10 @@ pcie3x1: pcie@fe270000 {
 		power-domains = <&power RK3568_PD_PIPE>;
 		reg = <0x3 0xc0400000 0x0 0x00400000>,
 		      <0x0 0xfe270000 0x0 0x00010000>,
-		      <0x3 0x7f000000 0x0 0x01000000>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x7ef00000 0x0 0x00100000>,
-			 <0x02000000 0x0 0x00000000 0x3 0x40000000 0x0 0x3ef00000>;
+		      <0x0 0xf2000000 0x0 0x00100000>;
+		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x40000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X1_POWERUP>;
 		reset-names = "pipe";
@@ -146,9 +147,10 @@ pcie3x2: pcie@fe280000 {
 		power-domains = <&power RK3568_PD_PIPE>;
 		reg = <0x3 0xc0800000 0x0 0x00400000>,
 		      <0x0 0xfe280000 0x0 0x00010000>,
-		      <0x3 0xbf000000 0x0 0x01000000>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0xbef00000 0x0 0x00100000>,
-			 <0x02000000 0x0 0x00000000 0x3 0x80000000 0x0 0x3ef00000>;
+		      <0x0 0xf0000000 0x0 0x00100000>;
+		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x80000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X2_POWERUP>;
 		reset-names = "pipe";
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index f62e0fd881a9..61680c7ac489 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -952,7 +952,7 @@ pcie2x1: pcie@fe260000 {
 		compatible = "rockchip,rk3568-pcie";
 		reg = <0x3 0xc0000000 0x0 0x00400000>,
 		      <0x0 0xfe260000 0x0 0x00010000>,
-		      <0x3 0x3f000000 0x0 0x01000000>;
+		      <0x0 0xf4000000 0x0 0x00100000>;
 		reg-names = "dbi", "apb", "config";
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
@@ -982,8 +982,9 @@ pcie2x1: pcie@fe260000 {
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";
 		power-domains = <&power RK3568_PD_PIPE>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
-			  0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
+		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
 		resets = <&cru SRST_PCIE20_POWERUP>;
 		reset-names = "pipe";
 		#address-cells = <3>;
-- 
2.40.1

