Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226AF657519
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiL1KF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiL1KFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:05:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455510069;
        Wed, 28 Dec 2022 02:05:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so16092466pjb.0;
        Wed, 28 Dec 2022 02:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn5jvMyqX0GecgS3SjW9qlzhKx37olketReSn4DJoo8=;
        b=nAkTmTUil3MywHiG+sLJPQZJPLM3Dp/Oe56sMR/xDQTY7uIbMdzZ466Tz0A+cUORlr
         2fxDuPotsYVpIe55fsGRVNcZRm5MSlTCdVUeGzuPIzifG8ywpZ8wfrs+XRpVRCo6+ih3
         H8vwP5AEnc73NOcsD9thwEDSa4HennnRpFBjlyOEMB5rFDdxrRzJVoR2NQZcK8jstx9K
         7IMJgBo1RaksgBbOJSo+kjw3qhFnR/9rCxeJEBJVwiMOocU/XeSQa+/bfSNt/YQ3C7IU
         Z0jhKHp8Fa5BooM66tvsxvxdmQbQc9fKU3nUD8nt4xmIs7DfJo9cPDzEH/mTjqi3tmfK
         RenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn5jvMyqX0GecgS3SjW9qlzhKx37olketReSn4DJoo8=;
        b=Kzo3SOlx8sAOcTggpY8Ta7eLzrxXFYrFUZTJrYFf+pCFdPPgTEFesuVd7vkYJ1+6G3
         qv7k8h9e3ml7FM1OZU+NZIqHbfuQpJ9FQdP0ffx3s4rsPo9GvWZdnr0ygwWq7VWqxzjZ
         Y09IuVoTVEmkRDZ+BJynwrxgS6NFftaRJ/OTg7+xh/B1Yd0VhzwrGY7/2pkuT1fcLH5r
         7SsqcyavZAJNROUpEmbK1gRjN+UB/Imyv1WPOGIgOezym16Gcc4DHqCT1r8pPDfL2Gxs
         NhtbQzOJoTGkxbz1mis2BjNz/yFdcRztJz22LO+ygdwbutBGcd81Nbc5nzOCaP8Lh3yH
         Ik/g==
X-Gm-Message-State: AFqh2koCXLRGoNsJJ3P2rkIRKqIdFG/qq5zx/on+bSEptggBBbZQKlDm
        G/m2b/4F0KAD5WydVc+BGng=
X-Google-Smtp-Source: AMrXdXuHhqxS7MfYPo8/enDYbq1jBAxX+4/gICB5Fh05G/QeVgK6F9eq+htlhjZCvbD/seggOCJozg==
X-Received: by 2002:a17:902:ce10:b0:189:af28:fd8d with SMTP id k16-20020a170902ce1000b00189af28fd8dmr31817789plg.1.1672221920466;
        Wed, 28 Dec 2022 02:05:20 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:20 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/11] arm64: dts: amlogic: Used onboard usb hub reset on odroid c2
Date:   Wed, 28 Dec 2022 10:03:12 +0000
Message-Id: <20221228100321.15949-4-linux.amoon@gmail.com>
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

On Odroid c2 previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 201596247fd9..3d3e61cf65a8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -208,6 +208,20 @@ codec-0 {
 			};
 		};
 	};
+
+	usb {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub@1 {
+			/* Genesys Logic GL852G-OHG usb hub */
+			compatible = "genesys,usb5e3,610";
+			reg = <1>;
+			vdd-supply = <&usb_otg_pwr>;
+			reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &aiu {
@@ -250,21 +264,6 @@ eth_phy0: ethernet-phy@0 {
 	};
 };
 
-&gpio_ao {
-	/*
-	 * WARNING: The USB Hub on the Odroid-C2 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	hog-0 {
-		gpio-hog;
-		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
-};
-
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
-- 
2.38.1

