Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A864699BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjBPRyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjBPRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:54:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020BEFF02;
        Thu, 16 Feb 2023 09:54:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso2317196wms.4;
        Thu, 16 Feb 2023 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWeVPez/G0hU15sEueVSFp0xfXBrqoz46idtepvnSeQ=;
        b=QtAGIo99kEnquPE2qhIVDa2Wqtrndj7iIpY4F2/cHxBJ2vuzmMk3P2hwjA3a/aVzV8
         NZudfXvA3Nq7Vl1l0udsxzFhbl1CWE2Dc2UEFNKKd3X0Mc5+8y388Mh+jX3eLlM3A0Lt
         Yn1lQBofO11jeE9/jS3oZ4o4vcTeJuYPFYN3M+FAs6DnTcLyZiHe/iFluNJ+oTU3a3AS
         nFtIqv1+GmUgc7GRDWPP04AHDbFxZaTqPNejWAZEDGtueRg1OfhiIRMUAVNwrh9xTjrW
         54L1YTYhAtRrqRvtqDzcQRqfv9vr3IJCR8MX1PSAF/FdYYepZ8qWC/Aoo9ZiVKA2Xn5t
         ccKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWeVPez/G0hU15sEueVSFp0xfXBrqoz46idtepvnSeQ=;
        b=PZQfAaf2lVXuWz0IKmhUReY600/+EuW/7MKOEqEZ3rUP7hcfJyEApPCMOvzODtqoMP
         GpdaIR5hmJv10xu2KmZ+TLrOjN1dMigP3FEfDn2EpzOIloNJinqlHlZgjd3i4yq/US4/
         v/GYYNVd/9MlF0ChUR0j1cz23iow+vDsvz1Z6ZY74wOPeduVWP2MQtXn+dRhvZsTKtMO
         fDSSfg2sGs6c8oxNh1x3Ve6AzPY+f1wfzJeDVifdMW5bRt4u1uKSoTwoy5tn62diRSOj
         uBDInTCehb+WUJVA2NVdb1gCxFju1wrOzq9dyBgGGjoAsV2Z02xHixt/aTNqAX9ZWD3G
         qzEw==
X-Gm-Message-State: AO0yUKUWCToRiCSeP9MnZvU+/lzy3a4W5CefTf/aCJNTPEhL75gXMX+8
        y9Sb7DfLVOMChyZoAzwpv2Y=
X-Google-Smtp-Source: AK7set/HF92N4hiJ+BRM3PDf8nsJXXU7eCsPk+fKD0QJwnDd+eiwJ/nnF1G8fSozCKMy0vuLD3/IEA==
X-Received: by 2002:a05:600c:4f07:b0:3df:7948:886b with SMTP id l7-20020a05600c4f0700b003df7948886bmr5732846wmq.31.1676570043491;
        Thu, 16 Feb 2023 09:54:03 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:31b2:19e1:4409:5c3b])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003dc4aae4739sm5826836wmc.27.2023.02.16.09.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:54:03 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/3] arm64: dts: renesas: rzg2l-smarc: Add OV5645 node
Date:   Thu, 16 Feb 2023 17:53:46 +0000
Message-Id: <20230216175347.99778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

OV5645 sensor can be connected to the CN1 connector on the
carrier board. This patch adds the ov5645 node under i2c0 node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |  4 ++
 .../boot/dts/renesas/rz-smarc-common.dtsi     | 53 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
index bc2af6c92ccd..275e760324f3 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
@@ -6,6 +6,10 @@
  */
 
 /dts-v1/;
+
+/* comment the #define statement if OV5645 is not connected to CN1  */
+#define CAM_INTERFACE_OV5645	1
+
 #include "r9a07g044l2.dtsi"
 #include "rzg2l-smarc-som.dtsi"
 #include "rzg2l-smarc-pinfunction.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
index 3962d47b3e59..915ad7e3935d 100644
--- a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
@@ -38,6 +38,38 @@ audio_mclock: audio_mclock {
 		clock-frequency = <11289600>;
 	};
 
+#ifdef CAM_INTERFACE_OV5645
+	ov5645_vdddo_1v8: 1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdddo";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	ov5645_vdda_2v8: 2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdda";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	ov5645_vddd_1v5: 1p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
+	ov5645_fixed_clk: osc25250_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+#endif
+
 	snd_rzg2l: sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,format = "i2s";
@@ -119,6 +151,27 @@ &i2c0 {
 	pinctrl-names = "default";
 
 	status = "okay";
+
+#ifdef CAM_INTERFACE_OV5645
+	ov5645: camera@3c {
+		compatible = "ovti,ov5645";
+		reg = <0x3c>;
+		clocks = <&ov5645_fixed_clk>;
+		clock-frequency = <24000000>;
+		vdddo-supply = <&ov5645_vdddo_1v8>;
+		vdda-supply = <&ov5645_vdda_2v8>;
+		vddd-supply = <&ov5645_vddd_1v5>;
+		enable-gpios = <&pinctrl RZG2L_GPIO(2, 0) GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pinctrl RZG2L_GPIO(40, 2) GPIO_ACTIVE_LOW>;
+
+		port {
+			ov5645_ep: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+#endif
 };
 
 &i2c1 {
-- 
2.25.1

