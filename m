Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842E1734599
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFRIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFRIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:51:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8623510E5;
        Sun, 18 Jun 2023 01:51:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3111547c8f9so2538902f8f.1;
        Sun, 18 Jun 2023 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687078267; x=1689670267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eioE0Dis/Lnd49iTib7LFRjx3tgvM39Dyou5eggWEA=;
        b=ceBN8iB14EtLu3N9xvBpe9SzqP7Os5abcLksAlPhYUzXLfD4RHOGOk2v6l4z6gb71k
         gxhqw4m+s7fo337qXycjAjAILc/sorK8GhXj5Kyc7NfI7MvETAtTe1JEeLDiBnV0OWDF
         TGuCXfO8ePw3M6AWjMzEcQdrEvGt7q+uZpr2eFJggEpn3jarFKo4i6MzEik9iXtQ0gps
         eP8AgN0n/PXiPihZtBGhBEDc0sgybtB8xyHkIaNHXAY25+kpPsF1WA9Tk1dwle1XdHgd
         HIvXd3wEv+lgzMR6cxOnMVtFqnmezrG7fn2iQ+i3qrA/i8GrJpUuSbLxKqKKLvGMhnBJ
         Rakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687078267; x=1689670267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eioE0Dis/Lnd49iTib7LFRjx3tgvM39Dyou5eggWEA=;
        b=QwxPP7f30YIabAZr7MFkaDdKmujRlLSguGGSyWP0pqFJsnJyD0NbfvHgMgwkJOAnGr
         2T+lDct0GXQGwYte0AYEDoYjRBpA4ICKEgnjReo300uEPCOCUK1WNrTX05f8kEkAOWyt
         ElEscxW28WJXtmIi8239PLSdVnDh2u8IWuVfUaHKn8SJprNZGVY7GA5lmEqbOhJGbAoS
         xdxWaMfQTJWbsvgR20c3LqK+ggZxtG7KpS+P9pJdOrkrSwYyHuORQgV/JRfOZ51HzikK
         trhop9ewzBpjmrVJS8BOCaNyz98JCljo74LY2R3+8itB4RSD8cAnWWby4MinOsdHy9y4
         Ikog==
X-Gm-Message-State: AC+VfDwRPrzfeAoAVy1vvdG5m76hddOTJTT6Lk++WupOFnOsRWHe4p9V
        9DhQIknFUeDhl5wwf8Xx03E=
X-Google-Smtp-Source: ACHHUZ7sQ0q3MRbhfTSqs8mEnL122mAB9a+9gkcgc+dp3fUXAmNDA3vWeeBZKNPeuH2w+FYy18K1oQ==
X-Received: by 2002:a5d:5751:0:b0:30f:c943:f925 with SMTP id q17-20020a5d5751000000b0030fc943f925mr5509586wrw.49.1687078266824;
        Sun, 18 Jun 2023 01:51:06 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id i17-20020adfded1000000b00301a351a8d6sm6953550wrn.84.2023.06.18.01.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 01:51:06 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] ARM: tegra: transformers: add connector node
Date:   Sun, 18 Jun 2023 11:50:46 +0300
Message-Id: <20230618085046.10081-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230618085046.10081-1-clamor95@gmail.com>
References: <20230618085046.10081-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index c2a9c3fb5b33..97350f566539 100644
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
index bdb898ad6262..153d34a012bd 100644
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
2.39.2

