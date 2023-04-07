Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC256DAD15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjDGNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjDGM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F95DAF27
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j11so2575363wrd.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872395; x=1683464395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPFA2+mMpDkEnrSlP6Q1vK8FCaXq/JFd8egtENDoR5o=;
        b=31aAu/BHjejVg5FWkqBC79NltqOUEQIa8983mCIwYFlMW1A/XOImuvaDr8LznZ1WSM
         GI/VH9Y6G7sCKwe5L3Ur6qnCj5xICwXB8SCnqc32PX1EkK+UELeoKsOZ7PoJb7WPhbsB
         Z5wbAEGTD81vJZw5+AY7nz3rALN9Iy/Dh91/B9jDRmXcWltlifL5unzZGGyCIZBek2Ei
         8WEl9FVRYekDGFjGQiRrW54ywYW3F/Uhqt4/4nTeHmsYRyxcN4YevLyTKzn21pf0qEc/
         qfEcMjChuaEoWvip6p9VfPCsYsmk7aYpTPbBvlELRBbPdLofwZbVhwH2IfB+6n95RW/6
         6Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872395; x=1683464395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPFA2+mMpDkEnrSlP6Q1vK8FCaXq/JFd8egtENDoR5o=;
        b=zNqHMzpLet6MXe7oYu748vaLGR5hxB3ZTB01hmqecXsiBmobw64lHnEEsNYTyQGsi4
         Cfxcy+oQe+UemrGJP1taiINVfIMdqNL2aUCOulM0xyt5P6bNu+rGcQYA4Flof2d1GV8T
         xySxl1bKXN2LRAXl1O6nuTbwEtnvCUTPsdNBfRUrO8YtHdVkd2NNxkiPQ2xqC+uDnOfH
         +n2aXyfZEMOELtz0sJhx/YS92MfplL05KwbLLj4IcWllmhFDkf65FtQW7xML4bYO5kzJ
         1O8+QH1HyPj7tWenozDbV73Rt76FCyjsHygPhbLM9bEF+xvq8mbC22Wuq7RSREAsiggI
         Y9Sw==
X-Gm-Message-State: AAQBX9fv2QB59dOA7fn4SCQSQYp7rWY8Ffp+wyDbyQCQMChvPo/jlzB9
        v9yGHpmJA6IC/6V3dN++kI3JcA==
X-Google-Smtp-Source: AKy350aDy9OHG7oVwjFlDW19uG5rl/1oAcOsCVNzPVxx7v88umH7XsWfH5jN6RA3yU3vyl4x2flNiw==
X-Received: by 2002:a5d:4984:0:b0:2c5:5687:5ed5 with SMTP id r4-20020a5d4984000000b002c556875ed5mr1276463wrq.18.1680872395441;
        Fri, 07 Apr 2023 05:59:55 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:55 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Fri, 07 Apr 2023 14:59:31 +0200
Subject: [PATCH v5 12/12] arm64: dts: mediatek: Add CPU Idle support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-12-1883c1b405ad@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=tqYiFkOeI53hFAvkAFcO4mPwzuf3UCWBDqz4THM6QQc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO7nlDuhTGY5LcrIhA3CBgmhjCqwhMH9j4Fbo+Y
 Wvm4aAeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATuwAKCRArRkmdfjHURZfPEA
 C6UOP0sfhWwRHPPBo3A0M96nkZ7aEurjo/y27ff8b8D26ePX3E2VyZ9pRCetsJPvXUNIFI0jAO5OSx
 1vLav9Cl8tRgF0JZHFVAVfxBfTbksLMl58XTe/KeR7AjFPODdJvvSBx473XvVJ57sQqIeny0NheV5I
 QynDkpLK21iL4vXXfDjvG/bk2mhqKpMT9VwwcavlIGzRrP+sZlxIm6jCJeZMZbOlc518/eQ5/qQ+ip
 lKQF7WvbXLrAWL/effup193wZDaYq3c9ocabh5aCH3l4nk0BWcZTn0VIOURMUmgOav0Kf/hmkt8WIm
 2DT6mKzDNaEH57ANl9B0wUivl+n5seSCV6JukkvBiGaM4vltprRBH8eoRJ3m019ckPX/KvgS2KR2pH
 Z2zaG2JA9ASLqj+ilusQbuLMHw1ofIoAHKTsiSLiJOpHkAgjpUM4JhO5MvQByByePt8sxoXVq5WpbN
 YQS8tTLDg8MuqmwnbPFP0lhAoSgdIc08osf/vU9d5Lv94u83Y/HW7xGno18pmxVcGw8QLVNSzg/Rzh
 Ux82xCZZi8KYefQEugS954hCb9fy3R+6Ib1ts1xKkiI3t1dhwO6ilLOhHVmm6t3VgxOVsraTQ9EheM
 rRjOSIstwGccF/TDUmtV6FwRg1TsPUXjatr8p/ki937D6hcK6HSvFOW8uRVw==
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

From: Amjad Ouled-Ameur <aouledameur@baylibre.com>

MT8365 has 3 CPU Idle states:
- MCDI_CPU. (Multi-Core-Deep-Idle)
- MCDI_CLUSTER.
- DPIDLE. (Deep-Idle)

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index cfe0c67ad61f..413496c92069 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -128,6 +128,7 @@ cpu0: cpu@0 {
 			reg = <0x0>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -147,6 +148,7 @@ cpu1: cpu@1 {
 			reg = <0x1>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -166,6 +168,7 @@ cpu2: cpu@2 {
 			reg = <0x2>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -185,6 +188,7 @@ cpu3: cpu@3 {
 			reg = <0x3>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
+			cpu-idle-states = <&CPU_MCDI &CLUSTER_MCDI &CLUSTER_DPIDLE>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <256>;
@@ -198,6 +202,37 @@ cpu3: cpu@3 {
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
+		idle-states {
+			entry-method = "psci";
+
+			CPU_MCDI: cpu-mcdi {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x00010001>;
+				entry-latency-us = <300>;
+				exit-latency-us = <200>;
+				min-residency-us = <1000>;
+			};
+
+			CLUSTER_MCDI: cluster-mcdi {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x01010001>;
+				entry-latency-us = <350>;
+				exit-latency-us = <250>;
+				min-residency-us = <1200>;
+			};
+
+			CLUSTER_DPIDLE: cluster-dpidle {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x01010004>;
+				entry-latency-us = <300>;
+				exit-latency-us = <800>;
+				min-residency-us = <3300>;
+			};
+		};
+
 		l2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;

-- 
2.25.1

