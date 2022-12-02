Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811E8640633
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiLBLxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiLBLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A024F2C;
        Fri,  2 Dec 2022 03:52:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d14so1212396edj.11;
        Fri, 02 Dec 2022 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emFoOM20hOM5X61XhU2Zz+3u4EcYFFGnLjIcqz3xjIc=;
        b=qGbxd30K3aoUCNRV3nAecE6ozZ6k5GHFTNjZ5lhz+nyIpwhHjEZJfCB8u43XI0hp1u
         zbB8Tob8DUgVVO8rRxdGFIOqh3jMy2eK7U+XhSBFf+9rEUbDnrs1qUBP0nC5Gvc2iknW
         ZKUgSSJrvtsFh/Yd+PGy012+1gt4J20IbV859+eln+HHAZ5JAiB30wBSxQXz2J+oKHhR
         nv06iSAIyqgwx0kgnRHP8g+jnjJiAmMotHkQIJfI0xCgVs7n4vXx4QHICBYoRM7cbsOj
         kSV64zlK5zrdMd6/mDfTKl5uoQbbNzN86Aab3UiFezv+24LDB3G0mDpfCj04F4+pbruV
         uJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=emFoOM20hOM5X61XhU2Zz+3u4EcYFFGnLjIcqz3xjIc=;
        b=h5M+W3ekBW0J3orE3DCEmlCwRY4TMPGM1bZmBNnxlK4aX7nAvS0jDV6rGA+7H4nhl6
         72VJmx2wxJ3xKvOfySuFjnBRaKRicaZWBD2euZmDkPdZctqOg5mxYXYKJ/5oFHkBcihS
         J7Icu7dCSReNFvuYWYuazgN6N3EUdmGDmwdkIbaE1ABAHVHQZLnTyNkiyccyNUuvF0Y9
         FqTpcKpODjAWhMvi3nFl5cWAOt2ZWNBLt+F1AVKQnOfASUWsrixhuj7jlHQbN80zOQsp
         xeUpYB3lRTn4BFeFWyHJabMdIYLbjZoMl+eqdspFPNXSc49OJ3GEIJIm6CpBMO409S+1
         4TPQ==
X-Gm-Message-State: ANoB5plyfAl4qvEnwxChd5QY9OXN78tvrOCtFEelUqfKY1sL0Zjq/EbC
        BM1itjXYs3UjUo8TplfSjwk=
X-Google-Smtp-Source: AA0mqf5V6uCq7x3xqjBW+9xhSr7fmB9ifJ0yaL8Q+0LV5jIiurfuIcPejyhfPVb44rvShzNrrmpCag==
X-Received: by 2002:aa7:da01:0:b0:46b:9f6e:4005 with SMTP id r1-20020aa7da01000000b0046b9f6e4005mr12419198eds.203.1669981960977;
        Fri, 02 Dec 2022 03:52:40 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm1206762ejb.41.2022.12.02.03.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:52:40 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 4/8] arm64: dts: Add DT node for the VIPNano-QI on the A311D
Date:   Fri,  2 Dec 2022 12:52:16 +0100
Message-Id: <20221202115223.39051-5-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "NPU" is very similar to the Vivante GPUs and Etnaviv works well
with it with just a few small changes.

v2: Add reference to RESET_NNA (Neil)
v3: Fix indentation (Neil)

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi     | 11 +++++++++++
 .../boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 45947c1031c4..61c8461df614 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/power/meson-g12a-power.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -2484,4 +2485,14 @@ xtal: xtal-clk {
 		#clock-cells = <0>;
 	};
 
+	npu: npu@ff100000 {
+		compatible = "vivante,gc";
+		reg = <0x0 0xff100000 0x0 0x20000>;
+		interrupts = <0 147 4>;
+		clocks = <&clkc CLKID_NNA_CORE_CLK>,
+			 <&clkc CLKID_NNA_AXI_CLK>;
+		clock-names = "core", "bus";
+		resets = <&reset RESET_NNA>;
+		power-domains = <&pwrc PWRC_G12A_NNA_ID>;
+	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
index 124a80901084..73f3d87dcefd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
@@ -15,6 +15,10 @@ / {
 	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
 };
 
+&npu {
+	status = "okay";
+};
+
 /*
  * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
  * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
-- 
2.38.1

