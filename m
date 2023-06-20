Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7AC736988
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjFTKjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjFTKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:39:39 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9C10D0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=tQR0dWwr8w4Ycm
        Bt80qqUYFnqdWmFqmB5wVjdVTNQGI=; b=aX0RyTv49uKNK1StgC86X7o4GVifF5
        L1mkoGXFqymtcBtohUJjjWCnnlZPBNgNnsRLpzdc10oWI5GQ2cri41QRyBQPGjmP
        k01F1OCQs90sV/YH9oKq+J1R7LC2UYulzv/Lqnt6h6MzXnm9ikbax6IyCldyG7SA
        sRo+apN62cWow=
Received: (qmail 601116 invoked from network); 20 Jun 2023 12:39:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 12:39:27 +0200
X-UD-Smtp-Session: l3s3148p1@QoLpQ43+vIxehhtC
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] arm64: dts: renesas: ulcb-kf: add node for GPS
Date:   Tue, 20 Jun 2023 12:39:08 +0200
Message-Id: <20230620103909.37582-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230620103909.37582-1-wsa+renesas@sang-engineering.com>
References: <20230620103909.37582-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa@kernel.org>

Add the node for the GPS receiver and its VCC supply.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
Changes since RFC v1:
* rebased because of patches dropped and refactored
* added static vcc-suplly

@Geert: Not sure if we need so many fixed 3v3 regulators. Most of the
other ones more or less directly derive from d_3v3. Or do you prefer it
this way?

 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index e62f5359f64b..dd1ffc31c874 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -39,6 +39,13 @@ accel_3v3: regulator-acc-3v3 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	d_3v3: regulator-d-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "d-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	hdmi_1v8: regulator-hdmi-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "hdmi-1v8";
@@ -434,6 +441,13 @@ &scif1 {
 	pinctrl-names = "default";
 
 	status = "okay";
+
+	gnss {
+		compatible = "u-blox,neo-m8";
+		reset-gpios = <&gpio_exp_75 6 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&d_3v3>;
+		current-speed = <9600>;
+	};
 };
 
 &sdhi3 {
-- 
2.30.2

