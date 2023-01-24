Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BAF679C30
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjAXOli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjAXOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:41:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856E4955F;
        Tue, 24 Jan 2023 06:41:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so14249420pjl.0;
        Tue, 24 Jan 2023 06:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uUEIUXRT9q9lHy3kc8AWUGd4aWNpn7Eo0QlIhJUhEE=;
        b=eUDnRJKusBCr1/mZou2IOZLhTguJg9PBV2wJzZZ/65lXYaydQgWbUAwWqHsnFakdh7
         kWvChIRgFlfQvHqGwIRoJ+IWFWgEew9QS2GQT45FuCTJOdIionl9NpG72Uu7H3QoYwg8
         WKKrVoqdJ5BhEapA6b9rMmyr4bk3SLlmKe/85JMQPpdAooXdYxTF1HYt9NJ8Rft756jY
         8yPYwSghWYrnRCcC4CgL0Ua+JuBP40SYQOXwJyTlCOYZXIYmdseXUpHRXJnfjz2SM37T
         A8fhI0yvFo6m16H3Emsbu2jmDWMmFY4/EVEVslTgiVv3l951RxB6LGsYHMwfOAtT8t5F
         /hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uUEIUXRT9q9lHy3kc8AWUGd4aWNpn7Eo0QlIhJUhEE=;
        b=Y3t4+mPZMV2VBVvSFw4wgBRtwoUDl4qf65hk3hyHD2+ozv7abp59rmVieOShjeqdQ9
         blnM8dWL4hMhAIO/To5horPdOKLoYgEFnhpUhmKRA7t+Gc596ZROc0o5LNwPv3Q3jOwf
         Ooek6NmK4Mc0jQp+LwrbJG0bHMWEQ0uE5KblhBr+I4yOkU5GA4mDCjUQjdGA9RRBDi0G
         1jy1UZgMc1O7MlQFDz2fseT7dlSn0VMmWGQJWi6WTFnof8N9j3kvYOO+l+6GSWTFDswa
         YfACEo+xzh1xcfwjeF7g1u0jt02aStHu+REHGjI19tUFfPuteCciReKR3/sCL1EDHXy0
         6j+g==
X-Gm-Message-State: AFqh2komEu7HAuOTfk05jFgjDnjzzarL/iac7hbphSWW04Ubei56u4Ub
        tVDeX5igEanA0Am/rdRYmfc=
X-Google-Smtp-Source: AMrXdXsy5ggk7FkRTG8ILVNAvvy48mrrw3kSNsv5pemuHuWH0o/Jx9IxCKcHpKCGZNKdpHyVoKXLOA==
X-Received: by 2002:a05:6a20:6f61:b0:b5:a231:107f with SMTP id gu33-20020a056a206f6100b000b5a231107fmr26168256pzb.12.1674571287455;
        Tue, 24 Jan 2023 06:41:27 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b0019602dd914csm1747865plc.180.2023.01.24.06.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:41:27 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v4 3/4] arm64: dts: meson: move usb-hub node under dwc3 node on Odroid C4
Date:   Tue, 24 Jan 2023 14:40:52 +0000
Message-Id: <20230124144054.13556-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124144054.13556-1-linux.amoon@gmail.com>
References: <20230124144054.13556-1-linux.amoon@gmail.com>
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

