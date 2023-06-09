Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC18729115
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbjFIHaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbjFIH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:29:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0607530D1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:29:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6532671ccc7so1547663b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686295756; x=1688887756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx3f6Wm6ps/QyxePUFE7///Bl8akU2heb6xMNcQDqwE=;
        b=bEq/XMCkpRcn/qpDfFh99z+5pRb2nFrmgJNn9F9kUDTtU2LQ+LI0J1qjgUqrk0rPLH
         hQJN3j22wDDSUacsyVcbG4WIDzsX2OBa4xXh5s4XaEw/xZZXlaPkWAhS1QA0kT0r9RW8
         MO4zMD7Y9KIHa23yY+/LVswNrlCvxT/zeqIuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295756; x=1688887756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx3f6Wm6ps/QyxePUFE7///Bl8akU2heb6xMNcQDqwE=;
        b=FffDS4BjljDf6r3ngmS8FJlExb12lewl7dKH/QBC3pvxvnMcq8VxTYgadweHWtLD1E
         s+l725/VgtYhcDEZ0VRbciRVwLU4eE1jPRp7VR1YQY61pf1USRZ/Fi48aWT7u3ecVLav
         1Y3n5djbmiKsk6YSCN8DM1Fc/S55S8BmoCjPhctH8Bj971QScuIGiYipvXV8jM+lM+ZO
         TpWIbD/KogfKLuXMS355j+OG+EOhmSJxfKDWnr+LhlCkxMDA+2yMRwzOoRgdZ44fEQoc
         GmJl/vy8Yyg/pdQxVkAhDJuO87xzjZVHJUMpXWv73lAmZXK6LPPB05Sjf1XwlLCyBiQD
         fSTA==
X-Gm-Message-State: AC+VfDxobYWs0eIp3urx5riE4xfwQzTnmTA/hXVLmWAAajDuc3unGTnf
        PKavlVYSj3p4FMVCIlGdfGi7Uw==
X-Google-Smtp-Source: ACHHUZ67VLM8QCCvc4MuoUmV8m4uEBjlB2CTj8FhPA+2uw2ZYkdy5bOOBxBQum193wvjJV0yMbHdzA==
X-Received: by 2002:a05:6a00:1a10:b0:652:98e9:fb1 with SMTP id g16-20020a056a001a1000b0065298e90fb1mr571983pfv.32.1686295756257;
        Fri, 09 Jun 2023 00:29:16 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id y9-20020a655a09000000b005287a0560c9sm2160283pgs.1.2023.06.09.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:29:16 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 2/4] arm64: dts: mediatek: mt8186: Wire up CPU frequency/voltage scaling
Date:   Fri,  9 Jun 2023 15:29:03 +0800
Message-ID: <20230609072906.2784594-3-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609072906.2784594-1-wenst@chromium.org>
References: <20230609072906.2784594-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds clocks, dynamic power coefficients, and OPP tables for the CPU
cores, so that everything required at the SoC level for CPU freqency and
voltage scaling is available.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 242 +++++++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 93f3c45ba372..e2becf2fe79f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -120,6 +120,208 @@ cci_opp_15: opp-1400000000 {
 		};
 	};
 
+	cluster0_opp: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <600000>;
+			required-opps = <&cci_opp_0>;
+		};
+
+		opp-774000000 {
+			opp-hz = /bits/ 64 <774000000>;
+			opp-microvolt = <675000>;
+			required-opps = <&cci_opp_1>;
+		};
+
+		opp-875000000 {
+			opp-hz = /bits/ 64 <875000000>;
+			opp-microvolt = <700000>;
+			required-opps = <&cci_opp_2>;
+		};
+
+		opp-975000000 {
+			opp-hz = /bits/ 64 <975000000>;
+			opp-microvolt = <725000>;
+			required-opps = <&cci_opp_3>;
+		};
+
+		opp-1075000000 {
+			opp-hz = /bits/ 64 <1075000000>;
+			opp-microvolt = <750000>;
+			required-opps = <&cci_opp_4>;
+		};
+
+		opp-1175000000 {
+			opp-hz = /bits/ 64 <1175000000>;
+			opp-microvolt = <775000>;
+			required-opps = <&cci_opp_5>;
+		};
+
+		opp-1275000000 {
+			opp-hz = /bits/ 64 <1275000000>;
+			opp-microvolt = <800000>;
+			required-opps = <&cci_opp_6>;
+		};
+
+		opp-1375000000 {
+			opp-hz = /bits/ 64 <1375000000>;
+			opp-microvolt = <825000>;
+			required-opps = <&cci_opp_7>;
+		};
+
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <856250>;
+			required-opps = <&cci_opp_8>;
+		};
+
+		opp-1618000000 {
+			opp-hz = /bits/ 64 <1618000000>;
+			opp-microvolt = <875000>;
+			required-opps = <&cci_opp_9>;
+		};
+
+		opp-1666000000 {
+			opp-hz = /bits/ 64 <1666000000>;
+			opp-microvolt = <900000>;
+			required-opps = <&cci_opp_10>;
+		};
+
+		opp-1733000000 {
+			opp-hz = /bits/ 64 <1733000000>;
+			opp-microvolt = <925000>;
+			required-opps = <&cci_opp_11>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <950000>;
+			required-opps = <&cci_opp_12>;
+		};
+
+		opp-1866000000 {
+			opp-hz = /bits/ 64 <1866000000>;
+			opp-microvolt = <981250>;
+			required-opps = <&cci_opp_13>;
+		};
+
+		opp-1933000000 {
+			opp-hz = /bits/ 64 <1933000000>;
+			opp-microvolt = <1006250>;
+			required-opps = <&cci_opp_14>;
+		};
+
+		opp-2000000000 {
+			opp-hz = /bits/ 64 <2000000000>;
+			opp-microvolt = <1031250>;
+			required-opps = <&cci_opp_15>;
+		};
+	};
+
+	cluster1_opp: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-774000000 {
+			opp-hz = /bits/ 64 <774000000>;
+			opp-microvolt = <675000>;
+			required-opps = <&cci_opp_0>;
+		};
+
+		opp-835000000 {
+			opp-hz = /bits/ 64 <835000000>;
+			opp-microvolt = <693750>;
+			required-opps = <&cci_opp_1>;
+		};
+
+		opp-919000000 {
+			opp-hz = /bits/ 64 <919000000>;
+			opp-microvolt = <718750>;
+			required-opps = <&cci_opp_2>;
+		};
+
+		opp-1002000000 {
+			opp-hz = /bits/ 64 <1002000000>;
+			opp-microvolt = <743750>;
+			required-opps = <&cci_opp_3>;
+		};
+
+		opp-1085000000 {
+			opp-hz = /bits/ 64 <1085000000>;
+			opp-microvolt = <775000>;
+			required-opps = <&cci_opp_4>;
+		};
+
+		opp-1169000000 {
+			opp-hz = /bits/ 64 <1169000000>;
+			opp-microvolt = <800000>;
+			required-opps = <&cci_opp_5>;
+		};
+
+		opp-1308000000 {
+			opp-hz = /bits/ 64 <1308000000>;
+			opp-microvolt = <843750>;
+			required-opps = <&cci_opp_6>;
+		};
+
+		opp-1419000000 {
+			opp-hz = /bits/ 64 <1419000000>;
+			opp-microvolt = <875000>;
+			required-opps = <&cci_opp_7>;
+		};
+
+		opp-1530000000 {
+			opp-hz = /bits/ 64 <1530000000>;
+			opp-microvolt = <912500>;
+			required-opps = <&cci_opp_8>;
+		};
+
+		opp-1670000000 {
+			opp-hz = /bits/ 64 <1670000000>;
+			opp-microvolt = <956250>;
+			required-opps = <&cci_opp_9>;
+		};
+
+		opp-1733000000 {
+			opp-hz = /bits/ 64 <1733000000>;
+			opp-microvolt = <981250>;
+			required-opps = <&cci_opp_10>;
+		};
+
+		opp-1796000000 {
+			opp-hz = /bits/ 64 <1796000000>;
+			opp-microvolt = <1012500>;
+			required-opps = <&cci_opp_11>;
+		};
+
+		opp-1860000000 {
+			opp-hz = /bits/ 64 <1860000000>;
+			opp-microvolt = <1037500>;
+			required-opps = <&cci_opp_12>;
+		};
+
+		opp-1923000000 {
+			opp-hz = /bits/ 64 <1923000000>;
+			opp-microvolt = <1062500>;
+			required-opps = <&cci_opp_13>;
+		};
+
+		cluster1_opp_14: opp-1986000000 {
+			opp-hz = /bits/ 64 <1986000000>;
+			opp-microvolt = <1093750>;
+			required-opps = <&cci_opp_14>;
+		};
+
+		cluster1_opp_15: opp-2050000000 {
+			opp-hz = /bits/ 64 <2050000000>;
+			opp-microvolt = <1118750>;
+			required-opps = <&cci_opp_15>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -166,6 +368,11 @@ cpu0: cpu@0 {
 			reg = <0x000>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -185,6 +392,11 @@ cpu1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -204,6 +416,11 @@ cpu2: cpu@200 {
 			reg = <0x200>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -223,6 +440,11 @@ cpu3: cpu@300 {
 			reg = <0x300>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -242,6 +464,11 @@ cpu4: cpu@400 {
 			reg = <0x400>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -261,6 +488,11 @@ cpu5: cpu@500 {
 			reg = <0x500>;
 			enable-method = "psci";
 			clock-frequency = <2000000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_LL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
+			dynamic-power-coefficient = <84>;
 			capacity-dmips-mhz = <382>;
 			cpu-idle-states = <&cpu_ret_l &cpu_off_l>;
 			i-cache-size = <32768>;
@@ -280,6 +512,11 @@ cpu6: cpu@600 {
 			reg = <0x600>;
 			enable-method = "psci";
 			clock-frequency = <2050000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_BL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
+			dynamic-power-coefficient = <335>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
@@ -299,6 +536,11 @@ cpu7: cpu@700 {
 			reg = <0x700>;
 			enable-method = "psci";
 			clock-frequency = <2050000000>;
+			clocks = <&mcusys CLK_MCU_ARMPLL_BL_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
+			dynamic-power-coefficient = <335>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_ret_b &cpu_off_b>;
 			i-cache-size = <65536>;
-- 
2.41.0.162.gfafddb0af9-goog

