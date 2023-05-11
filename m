Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC166FF75C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbjEKQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbjEKQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:30:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336766195
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so81066052a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683822611; x=1686414611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRBwEvfGQIrh+pVMdhdSvf8KI6OxPqchD4EYbezjkwM=;
        b=afA0togys2/WCVNqYbtSl6wBcgtlb1iX4/Hi+Z+48VT//dtNljgbBaAl3lNwT5NQ1U
         V64qYSZXIaeW+Kl5rrQkRWmingsK4LrPv5mNpaP3CS9ZzWyvrGKPiTZnjyVc8s/d1Qrs
         31pReZiVdfSaEWIFkvgnBg9wQHnQjJlWf/SQaAkT9LYXp6BP+Ztlzn+LLzRg8ge5T0w+
         u70Xlp9ummOnpFr5duw8/CAf0Cfoj1yEdFs0347fo6Q9sJmB9eX6rZwKtuYeA+ffETcb
         08VUXfcMKqB2kK5L0frsQh3/17eXGpX6IS7olGMAnPwbmVYF7bmp6okotCx3cLpYgZIW
         4T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822611; x=1686414611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRBwEvfGQIrh+pVMdhdSvf8KI6OxPqchD4EYbezjkwM=;
        b=M0mQJMMyqa+4zNTB/zvG/kP7549WYMCe/HXuSdvqdept0+uOmeaFgXJXTwkhdMdOX1
         58JmWy+Y2aw8wHQYYt5n/g2DNfIMvrgIZ3e/VgavIjNysED5+/4VUhZU+ERr5K4R93Oe
         laMXmddiVdgTcWpdr+AMu0sDN6JOEVfkkDe+JMRLomipTm0u0Kdf1ta3Y6v2K1SSIrew
         1QYuObU8b25iUt8XXA/0ESc4snKebueDj/CNQ2Ugrqdfckh8T1enlsk9EqYU9+zr78Ar
         fzXJ+VUFEiOASFwWZAYqwoXJsj+9MBWvGaPEfd+zmKzWn/oGYZXJNqLY7p3RbSKbWjh6
         SGuQ==
X-Gm-Message-State: AC+VfDy2yZ92/zxC+Y4ADbEr/A1pMpGkfLrmENb67v+BJdmpQIEehLtO
        Wx3U4bf1fC939WFkn5We9ufV38dmm2sfHRqxIaU=
X-Google-Smtp-Source: ACHHUZ5ztEmDWE2m42ORaSyVflfkAcBjj30Wzi1DlMGthfU1V9Lk1C1qZzJjaFoWDCd9w5A5cD2cOw==
X-Received: by 2002:a17:906:5d13:b0:960:6263:138f with SMTP id g19-20020a1709065d1300b009606263138fmr20793864ejt.27.1683822611029;
        Thu, 11 May 2023 09:30:11 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm4209935eja.150.2023.05.11.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:30:10 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Thu, 11 May 2023 18:29:31 +0200
Subject: [PATCH v7 11/11] arm64: dts: mediatek: Add CPU Idle support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v7-11-98cbdfac656e@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
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
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2737; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=vYzOQ2oc5j6ZLGT/M6bLKTIS/chNEplrOLaJKWbM7ds=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkXRgFAzS6LbWTWUcMEoCaR8sqFR9Xigsp8S0Hmy95
 Jlm3L0uJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZF0YBQAKCRArRkmdfjHURTndEA
 Cex5rMbwQvMMzR73kflR/rwX5EN4mV+fpZkrlrvBamLuBzAKKj7uOGQqdw/Wks6I4YS/KYMM69x+lR
 z5GrCRQyHIJ+aL2Rfa/E1sQUxMqwY3HirlK7d2tM2A07/AiDc9pAebsAjOa9p5UeZAw+LLpV2zVfcy
 Gb+C8m2jwPbiU1GeGiLxWZJe5qarmv7uZU3r8a7KlEeOVN8teeOPcVml7+Uk8xXxU4NA72S6ahPKOw
 mjw79F0O/LlNWEuUJsFpqMzLnP8xRjFLPeiG5VxwMjJumTr1DKJObvcDnScO4jXR+hSu5d0KK9nSil
 Y7r1IGj1mhLZQfHaPsaDTJjDvdAPI26eJnPkTVrta3Lom/XYPchJ+lBchE/Ae+nbFLz/zn/0iX7ynV
 RTlb/swIKGAr8/BtpfWwZHhJM5u+9VjefT9TYVZ3Lm4D390TPM42taib/qj0AZ8PiFqUk6Xee5kcpx
 dT9pB3+fb0KwteX1w1iSeOvdU23qePJ8W5DceKAfkR+V+4s5sJ8xcLoUfwygcRkCN3IJx4B9ocXv1D
 pyWwvGkIIOXdaM7BMfbt/T/LPF5tSqOJSTJNcjak7LEI7dzuSVf9twuuw6cUoWgW9B24DyfUwMxjt0
 gWJXIYWo8XUAkhZMxIPQOR8opD3H5B/jF2M/igVlb7rZplIGufiJvdDVGWow==
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

From: Amjad Ouled-Ameur <aouledameur@baylibre.com>

MT8365 has 3 CPU Idle states:
- MCDI_CPU. (Multi-Core-Deep-Idle)
- MCDI_CLUSTER.
- DPIDLE. (Deep-Idle)

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
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

