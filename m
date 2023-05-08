Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED906FA909
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjEHKrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjEHKqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:46:35 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2AD26E82
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=BzUDahvBEhVYMi
        I5z+9pq3NWIK0k2jvHIEQ8e/rO2YY=; b=XTFDUUY+ADmZCeeL/+sN9uwj5jsoYW
        kCj7RdMPuJC1temr1CQMLKvUzshYoGgjyEKIOslInImCDZ5JWXY4K9SlIREc7psK
        /FGiU3EdnxVl/BJt8qquNTpmrTP0TNjTZISXTtnnOj7G1g2RAsOsX5JQWTzkRhej
        cIUih3HKkivc4=
Received: (qmail 1693366 invoked from network); 8 May 2023 12:46:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 May 2023 12:46:11 +0200
X-UD-Smtp-Session: l3s3148p1@fR3RWCz7vMMujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] arm64: dts: renesas: ulcb-kf: add regulators for PCIe ch1
Date:   Mon,  8 May 2023 12:45:57 +0200
Message-Id: <20230508104557.47889-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without them, no power, so cards do not get recognized.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index efc80960380f..ff3a9ab6e6b0 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -52,6 +52,24 @@ hdmi_3v3: regulator-hdmi-3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	pcie_1v5: regulator-pcie-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie-1v5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		gpio = <&gpio_exp_77 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	pcie_3v3: regulator-pcie-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio_exp_77 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	snd_3p3v: regulator-snd_3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "snd-3.3v";
@@ -335,6 +353,9 @@ &pciec0 {
 
 &pciec1 {
 	status = "okay";
+
+	vpcie1v5-supply = <&pcie_1v5>;
+	vpcie3v3-supply = <&pcie_3v3>;
 };
 
 &pfc {
-- 
2.30.2

