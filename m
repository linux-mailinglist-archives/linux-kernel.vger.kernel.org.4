Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1786DAD16
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbjDGNAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjDGM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF57D9E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r29so42224562wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872393; x=1683464393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dv6Eb/XHCNKSdHW5zbcXguJe5+5nqrZlLcRsnMdnSlk=;
        b=MX3YVFdCMIoNhqN0MIUQA41/eP30CkgBvPO6afw/WAq/0OGxqXF2lB4TkgaWk1t7gl
         z/G7BuEoQjUCXIrE1Btk22lW/DGKIZ3flbw85+TndaFS+frGCKrOVldp9tsqyehTFSJ6
         azE8txkNN/Peh5O5goLvaT6vqojN1sQdvwyG02Q+WJWy8T5YkK/zb5wxlf/lGWfDasyb
         1k+mpfOCHCLnuvaFuWqWIrpMDFLirqnPObtLLI9J6/gqvgOOHWWa0Y1nOpvqEX3qXM2L
         3/BHSz+vYQYQaBEEuHhFZD8uqHqa7M/ghjFbn1IByLa+nyoN4EGlo8Ibi2fXQDmSH6BQ
         /ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872393; x=1683464393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dv6Eb/XHCNKSdHW5zbcXguJe5+5nqrZlLcRsnMdnSlk=;
        b=Kek3DoC0NTndohsJzQgL35RXqjz7yxqkjOtVwWt30wb7H2CEri+Yr289t5BiJYXFP1
         UCr8I9ZPxVW00Ogv2wf7HUldKkzqzb/06PFCqPvPGNwtnRjAt84OYCR7C+wHqMQi4Jze
         rIKWBv0JyS3/ryC1/cLrfg/xYJIxYg5Hh/qN9qAC0VgcBmqPEJUUejVbH0dYFFiu46ZC
         kQBRLtpHu6n203KP/xUadvb/ANDyBg6lK4CH+blFZ95FRhRFzbnibb1Xquqjh1oXzeZz
         QLobqFHSc5nX9Dpqad3fR4tAPz2RZGkH1TfzQ/NFOcjvsZklINfiB+lTx/1aGZCCRE17
         h/lw==
X-Gm-Message-State: AAQBX9cQmN5V0J3iqPIN+TO+FXVobkfb/kNQgYNv2W4bthB3TA+gSGQJ
        TnM4FEZwWBqRMRTmAhF+AjWSoiRUXWTdTFqPKrY=
X-Google-Smtp-Source: AKy350ay6LqBMC55Esdb5lT/PUmlszWizvzUCPIbmaeFVtTCNvqNsiPeMo3jTOfRc+9d7jxXxHczog==
X-Received: by 2002:adf:e0c1:0:b0:2ef:b4a9:202f with SMTP id m1-20020adfe0c1000000b002efb4a9202fmr586960wri.69.1680872392995;
        Fri, 07 Apr 2023 05:59:52 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:52 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 14:59:29 +0200
Subject: [PATCH v5 10/12] arm64: dts: mediatek: add OPP support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-10-1883c1b405ad@baylibre.com>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3661; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=vbee9YlPZnb6kFNtpMf6YbhiqwJ/puB0VHW9S9J3p/Y=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO6UfjnHjdAutiMzXQui00FKmzx9EVmCv1qzP7h
 zHI1K+GJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATugAKCRArRkmdfjHURQD0EA
 CFQuzdpxHY+fOQZ7iTR3ZEkwWgt1EFV+6uc+MSilkJshwL/eP71Ke3HSYd1+jLoAHtqPkpJ6StRlaU
 2kU9RjoZQkn9n0ThrESMksto0/pdCwybg399z+tAUZC6uylXe2obZ3qmt/zYOa7PU94LNYd8XU0Tmx
 BYK2J/Zwl+7gslF/5/Z7WSu7oGZ5U8Bcd4H10UQnGD5Ukpy5Av0YV1o44WwpfE14LhTwGJ6ufkZxqb
 1/acDZpZXLUGQhu9rXy86gvLijvW8QHpyMymO/yrw5CCLHIoQy/8KpmVJed8jSIuCM8B0rUV461aQA
 7gmO7JIaR84pUU2ppUFiVTXQscsEKxweS0ZKNq5HDDVIezzo1AJAcALi8KiH8IwDTgdcsa64d6bJJJ
 yTbZNfod042lb1JW10MEm88GZtuEGorXKiEG4qGZM5AKa35lz7MumMoHRM6QyHMsuTeSv4K5L4DIqs
 Pjkr9fux3vjEQSUgVSYI7oecV8tN5+otkrI/moPZSvhr/qkEIvHhvAK7JvE/R7fAUv+KPRdpBdzUyf
 2OEfLpLv3f10OTpH57G1XL5ticsVqw5McBvK24zT4MAlT3OmHEbYwkHPNpLGrPheWro/VYuLVy43jB
 rD2hHVyF0vjA7ioQkh0Dl2F0VBn95y7S2GxzfAAvVl0RR/G9Lk/qe+epabSQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have cpufreq support, this patch adds generic Operating
Performance Points support.

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

