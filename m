Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD26807D1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbjA3ItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjA3Is4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:48:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F9E4;
        Mon, 30 Jan 2023 00:48:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j5so10437176pjn.5;
        Mon, 30 Jan 2023 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlNj6nV/dPZIBToTkn+V0Pg8NsW/e1iMo42iih8uevo=;
        b=ZL2pv4YX+WPOyt5YB+Dz1MDTtwU7sHsdyHVxJKwSD862zGTYLVGEfQpMkCiHoPNznq
         WpMr3wrJZ9CAve3J05cU0thOcV1ltoFlNyiR9n8KKplh2sF2yDhl1pXUrWVWuaMYEtx1
         nas71Z+r0GD1vxgO5iCMteAEE1xyRuLk6J4f/dj90YR/3BWRBl6jVjgynavaRGD8u1IH
         cXEmFDwo4gmYcozeDHRFSTFmQEddQm2IqXog8JOwHgb04O863UEh8/Vfj/GZrWkQNeqI
         DLrVQPGQ9ufijjduTrDvnDR+t4UxPX64qlkcpSh6tdA5AzOlFUHdaWHQ78Gv9oKEp7If
         Xuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlNj6nV/dPZIBToTkn+V0Pg8NsW/e1iMo42iih8uevo=;
        b=1Y4zB+yNsS2nbGiJiMMqtKVJ6RHT7ylf3GNv+e7eDNjIV/kf1hK5IY720ospCfrS72
         ElnKI2xTSEdr+HSwFqsO1VDwjVRbgyJPpBwiSldgQ0ixWmSaCMhl9lkKG4Dd1YkMHjK/
         /aGpStxjiFFTm0RKiROX4wDLPedAr5IW8c5Z1wVS23yj5Dwt/nVV0zxvsmg68MOV/IWl
         vGrLz1bouH3KWeRXbEn9D874kZsPjPq+KYYAqLPGXNFoKpu86N+UdPE9K4oRSwrxbKeX
         5tSNNt8/0pQK7iY8ZQpLRboZEjw8YLlBCulJD5DbDHemzgWNqsoA28h+V49qi17zggqZ
         EyMA==
X-Gm-Message-State: AO0yUKUiNu5kdwYNdnqSnHeJ2GMrRUuqjUY2y4NtvoPd5Z2FHwiaCIF7
        dBzjnKZ8ofGDFhF7rd5sPB8=
X-Google-Smtp-Source: AK7set8sw+QVFdw1TtJpqaY5CJwLSkyx7g399inzBBxohSwD0omwPF0st0dLS/JFX6cUrHuEDXh2Fw==
X-Received: by 2002:a17:903:32d2:b0:196:3ecd:c39a with SMTP id i18-20020a17090332d200b001963ecdc39amr18411085plr.43.1675068497047;
        Mon, 30 Jan 2023 00:48:17 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b00192d9258512sm7205284plb.154.2023.01.30.00.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 00:48:16 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v5 3/4] arm64: dts: meson: move usb-hub node under dwc3 node on Odroid C4
Date:   Mon, 30 Jan 2023 08:47:42 +0000
Message-Id: <20230130084744.2539-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230130084744.2539-1-linux.amoon@gmail.com>
References: <20230130084744.2539-1-linux.amoon@gmail.com>
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

Move the usb-hub node under dwc3 node and drop superfluous
dr_mode as it is the default in meson-g12-common.dtsi.

Fixes: 71593b2020b3 ("arm64: dts: amlogic: Used onboard usb hub reset on odroid c4")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v5: none
v4: new patch
---
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 41 +++++++++----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index d04768a66bfe..a988015dd2d5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -26,30 +26,29 @@ led-blue {
 	sound {
 		model = "ODROID-C4";
 	};
+};
 
+&dwc3 {
 	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
-	usb-hub {
-		dr_mode = "host";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* 2.0 hub on port 1 */
-		hub_2_0: hub@1 {
-			compatible = "usb2109,2817";
-			reg = <1>;
-			peer-hub = <&hub_3_0>;
-			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
-			vdd-supply = <&vcc_5v>;
-		};
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb2109,2817";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&vcc_5v>;
+	};
 
-		/* 3.1 hub on port 4 */
-		hub_3_0: hub@2 {
-			compatible = "usb2109,817";
-			reg = <2>;
-			peer-hub = <&hub_2_0>;
-			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
-			vdd-supply = <&vcc_5v>;
-		};
+	/* 3.1 hub on port 4 */
+	hub_3_0: hub@2 {
+		compatible = "usb2109,817";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&vcc_5v>;
 	};
 };
 
-- 
2.38.1

