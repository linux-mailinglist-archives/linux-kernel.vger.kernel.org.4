Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594356DB9F4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDHJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDHJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:47:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F4CCC2C;
        Sat,  8 Apr 2023 02:47:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qb20so1509861ejc.6;
        Sat, 08 Apr 2023 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680947267; x=1683539267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7JcVwqthdcJ8hCQRH20mpyswxWH0pIeDYiRTxlRyzE=;
        b=GrOTY5DqaxGZuDFLw9SJTkHvxA73yO/zPw/FZKG55r+tjyVbuOG+a2XAJUlYkxu+ku
         1pwXUF0J7QenhGNPYk2ljI8NhvtWOFetj+golw0VWH+Y4Nw4CpMaYl0a6zIFMJbMnysc
         WDNkab6lVRbLfP1a+o0Ef8S4x9x65IQ23WZZY4mqpCY8uBwLUXQys/oAMCF/Q7ExVfmH
         1bL0xYnF9N/Y1B+4kkcqMY1KHCvEwW6U4dZUj0crpahel0qCBNO7pQDEiHlFSU8dDGB6
         OLS3BtHd1OQQ39TRP73/Sm/eGJo+oGGJLfswJ+UMOjl4FJ/i6CcEbUKl7/yEGZxl0HEe
         S3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680947267; x=1683539267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7JcVwqthdcJ8hCQRH20mpyswxWH0pIeDYiRTxlRyzE=;
        b=CZcZW7ABmax0TNnhDfE188Zy1ZwhHbj8HxCH8p6yO/fom4NCXNplQrYHKQuVCM/9L+
         VZDtAQWYygwynfgqPp69v9pD60OJvcPavjZmWc4Y9kXjAnaAwBCE2m5x9070U3W5zjfJ
         auhbghSWeVVUU9EKmT2JTTIQEJxItY7C1g/+8+i3JvjoBopB+C3gKP1qzqUBK+TgGQyA
         Z2sh2F5EXZjwVD9cz+bguvH+U1beImLaQDa3uAowKiKSzBMFQfng1Dqia5Qtje+tPneq
         PRgxi7mhkGJw2lpBVVhOhojhg3fouRds5rjlsV4lmO1Pme+bYxvskZE4wg28Z/U3ffX3
         EN8A==
X-Gm-Message-State: AAQBX9e5uHXr+8NxM6Sa0t3nYJKQCW5aMrumCG7esc5njmPMicaCg8d8
        3Of4FRLDdpCJCXniLN9/weU=
X-Google-Smtp-Source: AKy350b6o8A/fVh/YL6rI4iMR4TK2MLQhaSPsZkerv2yJgeK2/onG9QYyVuPaJ/tfM+ENyVqTAXrLQ==
X-Received: by 2002:a17:907:a08:b0:93b:b8f3:225d with SMTP id bb8-20020a1709070a0800b0093bb8f3225dmr1490869ejc.15.1680947267449;
        Sat, 08 Apr 2023 02:47:47 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id a21-20020a50c315000000b0050481736f0csm982297edb.12.2023.04.08.02.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 02:47:47 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v1 2/2] ARM: tegra: transformers: add connector node
Date:   Sat,  8 Apr 2023 12:47:23 +0300
Message-Id: <20230408094723.12733-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230408094723.12733-1-clamor95@gmail.com>
References: <20230408094723.12733-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All ASUS Transformers have micro-HDMI connector directly available.
After Tegra HDMI got bridge/connector support, we should use connector
framework for proper HW description.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS TF T30
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101 T20
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201 T30
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts      | 22 ++++++++++++++++---
 .../dts/tegra30-asus-transformer-common.dtsi  | 21 ++++++++++++++++--
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 7b2969656ec9..d8d14aa145e5 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -82,9 +82,11 @@ hdmi@54280000 {
 			pll-supply = <&hdmi_pll_reg>;
 			hdmi-supply = <&vdd_hdmi_en>;
 
-			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
-			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
-				GPIO_ACTIVE_HIGH>;
+			port@0 {
+				hdmi_out: endpoint {
+					remote-endpoint = <&connector_in>;
+				};
+			};
 		};
 	};
 
@@ -963,6 +965,20 @@ clk32k_in: clock-32k-in {
 		#clock-cells = <0>;
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		hpd-gpios = <&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+		ddc-i2c-bus = <&hdmi_ddc>;
+
+		port {
+			connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+
 	cpus {
 		cpu0: cpu@0 {
 			cpu-supply = <&vdd_cpu>;
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index 1861b2de2dc3..b0d041a5b20f 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -80,8 +80,11 @@ hdmi: hdmi@54280000 {
 			pll-supply = <&vdd_1v8_vio>;
 			vdd-supply = <&vdd_3v3_sys>;
 
-			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
+			port@0 {
+				hdmi_out: endpoint {
+					remote-endpoint = <&connector_in>;
+				};
+			};
 		};
 	};
 
@@ -1492,6 +1495,20 @@ clk32k_in: clock-32k {
 		clock-output-names = "pmic-oscillator";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		hpd-gpios = <&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+		ddc-i2c-bus = <&hdmi_ddc>;
+
+		port {
+			connector_in: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+
 	cpus {
 		cpu0: cpu@0 {
 			cpu-supply = <&vdd_cpu>;
-- 
2.37.2

