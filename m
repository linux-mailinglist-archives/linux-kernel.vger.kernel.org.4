Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C427107A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjEYIf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbjEYIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:34:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8BE67
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f60b3f32b4so2241395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685003643; x=1687595643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8BG56Q0+m7b3FaG//0Q095XeVZlwC5hERE//1oBbUU=;
        b=Nr+YXCF7gu5WMZQLSJZUKtPly5voQB+ObgNwMi9S8SZ4EJkXC6A1M0u/DkbPZnBWCA
         g0NR/SJ6AfAPGooSaT5CWoPsZbh7dclweppZh+QwTZ30qk7gup3rKUG4FMLJiylplSXJ
         xVzDRPjl2lmImokoMX335ywHmMVvI8TBHohnLoKx8yS1AfArPWWgYuMjtRoKaVeds4YE
         +56oDophciUsFNqMDnQbIAVKKF1ogFCuj56pqOCQp1X/fJbdSUx58iRrsN/1P9Spm4lC
         dI8J+MWpx0y3h+Ia+EUwEXCAaYBkiGymyQjKfqe8GY1HZHtfH++d+aMxsvaA5N6wPw3m
         YxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003643; x=1687595643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8BG56Q0+m7b3FaG//0Q095XeVZlwC5hERE//1oBbUU=;
        b=eAjs0+zHdzVJ9/mxg62WA1hbDLkvAcx083DUDyyDKEol5SyTJ+RQeRtekdep0JbheF
         UoGtkoQ/zqGhT5mI5XY+RlS5jxtAdJCK5agzo7nYZUeNf5rwQpYTPRIUuHJBvo86G6uB
         qi8AXsPqoNi4kcl4z0wuoUa8QjtXvLRygJGv5Ka446i6y8PO2baO8Q4Ch7f7AyCK3ljV
         s07rEaKGwszoxsuidwZCkoj/QafNLJh7VQg7RL3F/pA7Q21UuMXZ33fgbKd09q/KdaL9
         9gdqiyFh+mpRYinTlKYsiQoz/hy3fQS2JldFWgREDPAShINr9WzklZMczRb2aWvfpsnv
         gpLg==
X-Gm-Message-State: AC+VfDzCQkJaZFtFX0XilFtpef7EU6yFBTEr/HtzTd9drhaZ2m9CL8Ct
        WcjtDrwRiE/TwjMkxM0aD/OuCLdFWSblD3OLotQ=
X-Google-Smtp-Source: ACHHUZ62g7dNi0kd8H9zW9Mq7w2ssLpoOL7/MTyGfyUrFwN+8H1uGHBGDCi7HQeybb4skFAP4IkzmA==
X-Received: by 2002:adf:f68e:0:b0:307:8fa5:6e36 with SMTP id v14-20020adff68e000000b003078fa56e36mr1666829wrp.54.1685003642890;
        Thu, 25 May 2023 01:34:02 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o3-20020a5d6843000000b003095a329e90sm945809wrw.97.2023.05.25.01.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:34:02 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 25 May 2023 10:33:17 +0200
Subject: [PATCH v8 08/10] arm64: dts: mediatek: add OPP support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v8-8-7019f3fd0adf@baylibre.com>
References: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3792; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=iQCxmnK+eQfy1aBNVxZAL4gcwl2Oh2buOTNBmT3l0E0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkbx1v2Yzq2DRngEYVG4rSFQTE2FWufu/fkoiCUkWJ
 krZYeTaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG8dbwAKCRArRkmdfjHURdZ/EA
 CQPVys/VGqd7jIPh9AInyGVijaFiERtOfBmuvuqA8Bt20lYHwME4a53+FyYWyITy933qJlFMhhXA3J
 ce+yaRpo5/+JZdzXepXvleBH8sL7bxzJsHaEzPGp32LAdanMl02n78+VeR5w7qG6Hp1d/uDS7syquc
 EMyT833oMq1IHuWjMm6UldcieFk3DA3lpmd+PXlq7vsvzZ0EIfWPwdVGuvnQnA9z+UBIdP9+Fg8pOA
 UMJ8UimvEKyGOGuwL6mMl9P+FO1NP4yiOLq82EpoEF1B+0qNYuEF6bDXAJg50UyetuNJIt8D6qVNnq
 mnxXUs+hz8UPWxy472I4q8TDcA6EIpy+MtbFY+fAUOOzLJ3svEzTnk/IO6ypfcEGI1yqD5GWoIRc9b
 jwA8aSplVDx5xKjQy/nWrIt7PBKoxQT+9PW9sBnapr6nJXFQJdv+WcRMNUZNIEc2SX/rDBB5antRWO
 rk613AApeQk5lf7SRlxP8X5LM7b5q5x6+GcfwJCjuL+aY9KS2iMjzzThYbyhbV3C7H3c+hkosyuL8+
 v9HPQy2Z1B9UzbYqgFciBYDg3W202OnV5DpZpgXOh6M0wxEUHWOnZGsHTGkVjurxVRX2WEhXdeTKiH
 MtJgcvvM4KVXTlH/OquXvLTnXi1cphlxXHtYK6Hj0YqQnHmRVAVKTjD6K1Tg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have cpufreq support, this patch adds generic Operating
Performance Points support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 101 +++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index bb45aab2e6a9..cfe0c67ad61f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -20,6 +20,91 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-850000000 {
+			opp-hz = /bits/ 64 <850000000>;
+			opp-microvolt = <650000>;
+		};
+
+		opp-918000000 {
+			opp-hz = /bits/ 64 <918000000>;
+			opp-microvolt = <668750>;
+		};
+
+		opp-987000000 {
+			opp-hz = /bits/ 64 <987000000>;
+			opp-microvolt = <687500>;
+		};
+
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <706250>;
+		};
+
+		opp-1125000000 {
+			opp-hz = /bits/ 64 <1125000000>;
+			opp-microvolt = <725000>;
+		};
+
+		opp-1216000000 {
+			opp-hz = /bits/ 64 <1216000000>;
+			opp-microvolt = <750000>;
+		};
+
+		opp-1308000000 {
+			opp-hz = /bits/ 64 <1308000000>;
+			opp-microvolt = <775000>;
+		};
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <800000>;
+		};
+
+		opp-1466000000 {
+			opp-hz = /bits/ 64 <1466000000>;
+			opp-microvolt = <825000>;
+		};
+
+		opp-1533000000 {
+			opp-hz = /bits/ 64 <1533000000>;
+			opp-microvolt = <850000>;
+		};
+
+		opp-1633000000 {
+			opp-hz = /bits/ 64 <1633000000>;
+			opp-microvolt = <887500>;
+		};
+
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <912500>;
+		};
+
+		opp-1767000000 {
+			opp-hz = /bits/ 64 <1767000000>;
+			opp-microvolt = <937500>;
+		};
+
+		opp-1834000000 {
+			opp-hz = /bits/ 64 <1834000000>;
+			opp-microvolt = <962500>;
+		};
+
+		opp-1917000000 {
+			opp-hz = /bits/ 64 <1917000000>;
+			opp-microvolt = <993750>;
+		};
+
+		opp-2001000000 {
+			opp-hz = /bits/ 64 <2001000000>;
+			opp-microvolt = <1025000>;
+		};
+	};
+
 		cpu-map {
 			cluster0 {
 				core0 {
@@ -50,6 +135,10 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@1 {
@@ -65,6 +154,10 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@2 {
@@ -80,6 +173,10 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu@3 {
@@ -95,6 +192,10 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		l2: l2-cache {

-- 
2.25.1

