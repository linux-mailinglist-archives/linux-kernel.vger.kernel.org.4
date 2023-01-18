Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1296712C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjAREqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAREp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:45:28 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951CA58660;
        Tue, 17 Jan 2023 20:45:18 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r18so23621003pgr.12;
        Tue, 17 Jan 2023 20:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqdFnWHjWAHKmuM+PoO/HnCy2n74on+Ymq3rYfqeAJE=;
        b=DlSEsi0KQ9JhYv/iu2q45d2JfoC8+2CKC7ECut2BUh35plePrVMWf4mebvkknGUrr5
         2pSFeKYmW65ZfjxlunY/SaR/XzEVnZNUk2w6uKzOJ0jRyNuERB5VAjFCiKHDKgoMFB6M
         duxipMvK5ckycVBRkseYba+l6G6zF5o8fcW9qqf8/0JKtBgK+T3Mx0toVEr+TcLg68zt
         tSx6hUgrL7MUPOQrBGjTmT4iM7gB4MDM/9VSsi9rOsHrz/WhgYHS2b9383b9mtHvJn4W
         4MBT8Jcou5EwffrVcWfbev08iHwYTuOL+qc9fV6ggSZNK83+TvGTHWz055RIGcoYCTWd
         wdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqdFnWHjWAHKmuM+PoO/HnCy2n74on+Ymq3rYfqeAJE=;
        b=pNd58ipT5jcMfUatkFrZ4lE95Mpv+I2CHaoyR0ZI4hW8md012+r9M+46geurSUlhXm
         A0aFRW5iTasfPbFJRjUzbdk5/xiPy+LIc0LO5YrN+JGwSKGQ3FexGVQjF4kDlrwOnemT
         gLWQd9VJr526JCsSK/N1iU0r8OvaKDWrB2Dey4XRA2nh27SRV1MI8yySaBoV0kh2KEM+
         1cN2ne0POtBipDnsquuTk6kk+HURVke7WyE1mSIo4GD0bJ9TIhx72pdHcwU00no7ljvs
         9z456s4Y/fDU5pm/tYhTgsIZ/TdCne9MlK8vyrsxFd1+Y6hjxxz22LAb/FJtabBEZpfL
         lqJw==
X-Gm-Message-State: AFqh2kroxs89TdfnJVjwxt/33QQrp9zZWIZumzsS0SfnWGw93myT5abv
        mTPl/6C0IwlhtSItWo4Jqhw=
X-Google-Smtp-Source: AMrXdXtUrZUrsaXEJ5PzpdHxzrcEgNit66ihCfMbac6SbFmNzLQthDYWpPzyAEQzHKJ0m6Ih7ikKqg==
X-Received: by 2002:a05:6a00:2354:b0:580:cf1a:f2b5 with SMTP id j20-20020a056a00235400b00580cf1af2b5mr8704552pfj.12.1674017118519;
        Tue, 17 Jan 2023 20:45:18 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:45:17 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] arm64: dts: amlogic: Used onboard usb hub reset on odroid c4
Date:   Wed, 18 Jan 2023 04:44:15 +0000
Message-Id: <20230118044418.875-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118044418.875-1-linux.amoon@gmail.com>
References: <20230118044418.875-1-linux.amoon@gmail.com>
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

USB hub is combination of USB 2.0 and USB 3.0 root hub so
use peer-hub node to link then.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: - fix the compatible string.
    - Fix the hub node to use peer-hub to link the usb 2.0 and usb 3.0.
---
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 36 ++++++++++++-------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index 8c30ce63686e..d04768a66bfe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -26,20 +26,30 @@ led-blue {
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
+	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
+	usb-hub {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* 2.0 hub on port 1 */
+		hub_2_0: hub@1 {
+			compatible = "usb2109,2817";
+			reg = <1>;
+			peer-hub = <&hub_3_0>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+			vdd-supply = <&vcc_5v>;
+		};
+
+		/* 3.1 hub on port 4 */
+		hub_3_0: hub@2 {
+			compatible = "usb2109,817";
+			reg = <2>;
+			peer-hub = <&hub_2_0>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+			vdd-supply = <&vcc_5v>;
+		};
 	};
 };
 
-- 
2.38.1

