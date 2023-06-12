Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88FD72B947
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjFLH4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjFLHzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:55:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00140421A;
        Mon, 12 Jun 2023 00:54:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so3640664f8f.1;
        Mon, 12 Jun 2023 00:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686556437; x=1689148437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++GIztv4naBcPicwbwUH4k+fuc5iv8tnHanmi3MA+54=;
        b=kUPOkj4q6YKPAUU8Rse/9HP8nmYqFqpgILE56nG+Qxi1el0VRWTvLHFp7vNfK117B+
         XWMMQnueiey7TL4NN8/PvYFfs1xodyQToOkEBSZowwJZLxUBSSCXSbGjzET0X5DTf3z2
         UKybYw83/Qa8HLT3vpX6q+w3lmaZBeog5/WeZvsJJvRN6EvWmuH3FPkLBmxqme/d5Wny
         8Fj7f7VNyWggSuRDHZx+t1nHBgdCutexs1yODbxFsJkRTFaN6r0wu+fjlycG7UPGyXId
         gXHXWe5HgFAeda+9gaVP2SmEbaG4AAOPN9D/dNNtrwouzpvBXbTKxNhDnPzCid6LUBlq
         3j2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686556437; x=1689148437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++GIztv4naBcPicwbwUH4k+fuc5iv8tnHanmi3MA+54=;
        b=EEuIJoCApm618KMz9c9oBB+Y1f/poC1Hu29PGcF2UFV4tBf/crqCWyL9XhMn7/H8ez
         1t+kLbtL5Y0B0lMg3ljSOIYgXW5YnCXCFT/W4LrUVgLkbXBifxYKUgkcyRprQpld52Oj
         j6Kja5SX+L26xtRlKsLBiGLPXPG42RsNRxEyEMAbxTegqQUaAl5nodQzjhnoTp9t9VSY
         reJvqVErECXzXF7Or25Hm+hh8RFsGbJncE8EYVpVGnvaZXgx/v4yuJ79z9TCEAXiOhhf
         MJfvGoNFJ1k4bC/rqY0JfuEkdAvwTJ4qHlLo+a+jbarvqBt2f9eInfMbAHGmKD3tisLx
         182w==
X-Gm-Message-State: AC+VfDxDAZMOtjC+kXpvpabjndF0jaDzGqNFURtAfUDa37+uMHKSp3XN
        WYmgqmP8yysh/Op8YU/fteOeWzGTW5Q6hWIO
X-Google-Smtp-Source: ACHHUZ70Cj57LU8Ff8JQkoBSv0RL9hBJhhZSL6SwIfAD8toe6gVQ7t4REqheKzJzanSnq6DqIrnN6A==
X-Received: by 2002:a5d:53cc:0:b0:30f:b341:79ef with SMTP id a12-20020a5d53cc000000b0030fb34179efmr3851473wrw.71.1686551712345;
        Sun, 11 Jun 2023 23:35:12 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b002fed865c55esm11484811wrn.56.2023.06.11.23.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 23:35:12 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 3/3] riscv: dts: allwinner: d1: Add thermal sensor and thermal zone
Date:   Mon, 12 Jun 2023 09:34:19 +0300
Message-Id: <20230612063429.3343061-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612063429.3343061-1-bigunclemax@gmail.com>
References: <20230612063429.3343061-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

This patch adds a thermal sensor controller node for the D1/T113s.
Also it adds a THS calibration data cell and thermal zone.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 922e8e0e2c09..b893f3325554 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun20i-d1-ccu.h>
 #include <dt-bindings/reset/sun20i-d1-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	#address-cells = <1>;
@@ -138,6 +139,19 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		ths: thermal-sensor@2009400 {
+			compatible = "allwinner,sun20i-d1-ths";
+			reg = <0x02009400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(58) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			status = "disabled";
+			#thermal-sensor-cells = <0>;
+		};
+
 		dmic: dmic@2031000 {
 			compatible = "allwinner,sun20i-d1-dmic",
 				     "allwinner,sun50i-h6-dmic";
@@ -365,6 +379,10 @@ sid: efuse@3006000 {
 			reg = <0x3006000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@14 {
+				reg = <0x14 0x4>;
+			};
 		};
 
 		crypto: crypto@3040000 {
@@ -843,4 +861,12 @@ rtc: rtc@7090000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+	};
 };
-- 
2.39.2

