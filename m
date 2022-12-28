Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76512657524
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiL1KGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiL1KGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:06:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B11ADCD;
        Wed, 28 Dec 2022 02:05:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ge16so12115361pjb.5;
        Wed, 28 Dec 2022 02:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPZOgVkNc1yONsD0VkYpHu5bVHn1CQCfORwR9EnOA3I=;
        b=WjJcMPv9WalAK0UfWzbf+FjC74rXkGd7zvR9C+aauyHcIUTg83ET0NPPfhMZ2z+bYW
         muU0+EZj4G5cJOZuc7K84cMNEGAJxKspOO7twzr1AJHxo1mskprstHGbvkkObJONslmZ
         dEyRT1Siz2dReg/3YiG0TipWKLhGeM9Qf206dwta6gxJ5EwkVOEqkVg1uRTsHUGlgrZi
         cFOGDQclToPnRRSsgksYCO4vn5L0Ax4N4IyPqS69WCwGil61sFaT5dZ3HHm7pWVYqld0
         PqXYr9FGk0P2mxr1fiz4XbNEnnyxOvx4JATu0LIgByrCiBR4tR5/Dz0obxOaJ4fh/Xyk
         2nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPZOgVkNc1yONsD0VkYpHu5bVHn1CQCfORwR9EnOA3I=;
        b=C++UnRo3BieFouP1ArVOanlo+2fG5afTBHv241mOfNf7qF2C3t9LxLxpzUvD0gxTmc
         /sL6ABztGsU8nIooRHdQUC7DJjrjRrOqRTwq5iEtlBicjzqVHjcz7OgO0rqTjsmuaJMM
         r/kQpW7oQTqEYEQzi+L9i8aI5m9HSQCoPP+WZPRAWT/EobHUZS+Q+ROwdf0ymqj2ZCHj
         6YW6SOaPFqgrn03YINlb4ewVtabZ7v/aY1MemcAA4pw0KsjgIvPvfcaWdxLg6mRSHws3
         NMHGjWU0B236/1psS87nWiLKcvad3LRZXWipTgHkCNLSfxL6aiWqQqEeg8I3aEgbxGdS
         i7jg==
X-Gm-Message-State: AFqh2kpf7QYjkVR5WRfBvm2Yifzwdm8K3D3aQWAylVUXH7pMPp01ojzK
        /ovtCNqb6kCE0fYjpFbJEbw=
X-Google-Smtp-Source: AMrXdXvcf7QSIOwii5DQEnsuWcE70e8b9d+bU3dcARNCyDmO7VCBPvY6T7Y5zfT27y2z9/w3aruFeA==
X-Received: by 2002:a05:6a20:a687:b0:af:7cf6:1d4b with SMTP id ba7-20020a056a20a68700b000af7cf61d4bmr32717637pzb.23.1672221957637;
        Wed, 28 Dec 2022 02:05:57 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:57 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/11] arm64: dts: meson-sm1-odroid-c4: Used onboard usb hub reset on odroid c4
Date:   Wed, 28 Dec 2022 10:03:18 +0000
Message-Id: <20221228100321.15949-10-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
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

On Odroid c4 previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index 8c30ce63686e..9b8230d6a9da 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -26,20 +26,19 @@ led-blue {
 	sound {
 		model = "ODROID-C4";
 	};
-};
 
-&gpio {
-	/*
-	 * WARNING: The USB Hub on the Odroid-C4 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	hog-0 {
-		gpio-hog;
-		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
+	usb {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub: hub@1 {
+			/* Via lab VL817-Q7 usb hub */
+			compatible = "vialab,usb2109";
+			reg = <1>;
+			vdd-supply = <&usb_pwr_en>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
-- 
2.38.1

