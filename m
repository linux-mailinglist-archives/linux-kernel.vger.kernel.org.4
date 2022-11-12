Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2154962693D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiKLLmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiKLLmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:42:12 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468B125EB2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:42:11 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q71so6370982pgq.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnom-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+8ovGggxGWxSLRDlpHhaP42GCe1Wrk8yvHSpDQauLg=;
        b=ItZota3pW1Oe2c4ew1z447dprDKVkB8hghHN+fvN/Ifs3kXDF6TpITAL1ImlfU4joI
         u18gsuiWh0slYSFiTwJXgfG1OBx4XpKP1JNmX2P4V64szjJvrKSZqVO5OKxbdbr90b+F
         gQJUrwdljt/HJX20hVazQ/48cpC8RZBzNUyDOEwt2w9xK5oKHKANjoP+PO4T0oRT+wkW
         D3XmDOqj8FXuSD0M6ZwTRar6OXv5S078RJgYwqq0PiGsKbk0Z4H5VURr5cZ8TThMBTmW
         5ciUe3H725WvqpkNAzIukKed3+DUIPil3DaCg5lcOjsbzwWNJD74IrVHU0/PEpqnAuxD
         OxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+8ovGggxGWxSLRDlpHhaP42GCe1Wrk8yvHSpDQauLg=;
        b=RYlT22F17Bul+9OyzmM4hvcWJ+BIPcDT7XTH3rS4s3Ly9lH9nuvh7VmZYixLRdCLCq
         eBta7AnjA1SG5Pqy/scvG1Rt61pL1eKCe86eaPXWIWra7UAX0LWcHPLnUeeaz6/wIKT0
         ty5KcgZAokfzVUlnMSoHVg7wOarx2EEm40C+mVeb9gHLFfBnFpnFzo2zsGdmYeIQDApA
         5O4YjmRGwkCX+9bnYtDpFKTiZvOjMdmP4/0/YoH11t32+SpfcfacO++sblVzoPT9kDKN
         rY2inb4KZcP2vGy6L/6ftX7fWnK3DVneuzTPUouOnZ4OqLMXoA1i+Wz/unQYsv9x0pnk
         qVaQ==
X-Gm-Message-State: ANoB5pnVnfRRUIVrcc9O8r4HgtLbHwEPM0MltaqTFy+YTrLd2lpgijos
        VuOBhtnTXMKBTyCO9j2Wb6aVGQ==
X-Google-Smtp-Source: AA0mqf6nOSEjLFrPtAFqvBC3Fe4L+65alGC2VEytOGlQYBjRUwqw8lkeqaDbR1I7e0tXHv17EffEHg==
X-Received: by 2002:a63:4a06:0:b0:46f:469a:249d with SMTP id x6-20020a634a06000000b0046f469a249dmr5221652pga.471.1668253330801;
        Sat, 12 Nov 2022 03:42:10 -0800 (PST)
Received: from astraea-lnx.home.neggl.es (119-18-16-128.771210.mel.static.aussiebb.net. [119.18.16.128])
        by smtp.gmail.com with ESMTPSA id e2-20020aa79802000000b0056e8ce106d1sm3132091pfl.132.2022.11.12.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 03:42:10 -0800 (PST)
From:   Andrew Powers-Holmes <aholmes@omnom.net>
To:     linux-rockchip@lists.infradead.org
Cc:     =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: rockchip: rk356x: Fix PCIe register and range mappings
Date:   Sat, 12 Nov 2022 22:41:26 +1100
Message-Id: <20221112114125.1637543-2-aholmes@omnom.net>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221112114125.1637543-1-aholmes@omnom.net>
References: <20221112114125.1637543-1-aholmes@omnom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register and range mappings for the PCIe controller in Rockchip's
RK356x SoCs are incorrect. Replace them with corrected values from the
vendor BSP sources, updated to match current DT schema.

Tested-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Andrew Powers-Holmes <aholmes@omnom.net>
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 14 ++++++++------
 arch/arm64/boot/dts/rockchip/rk356x.dtsi |  7 ++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index ba67b58f05b7..c1128d0c4406 100644
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
+		      <0x0 0xf2000000 0x0 0x01000000>;
+		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x80000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X2_POWERUP>;
 		reset-names = "pipe";
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 164708f1eb67..eec1d496c617 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -951,7 +951,7 @@ pcie2x1: pcie@fe260000 {
 		compatible = "rockchip,rk3568-pcie";
 		reg = <0x3 0xc0000000 0x0 0x00400000>,
 		      <0x0 0xfe260000 0x0 0x00010000>,
-		      <0x3 0x3f000000 0x0 0x01000000>;
+		      <0x0 0xf4000000 0x0 0x00100000>;
 		reg-names = "dbi", "apb", "config";
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
@@ -980,8 +980,9 @@ pcie2x1: pcie@fe260000 {
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
2.38.0

