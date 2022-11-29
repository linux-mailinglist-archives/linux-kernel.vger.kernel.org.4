Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743E863BC21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiK2Ivt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiK2IvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:51:20 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291D5803A;
        Tue, 29 Nov 2022 00:51:19 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vv4so32074404ejc.2;
        Tue, 29 Nov 2022 00:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emFoOM20hOM5X61XhU2Zz+3u4EcYFFGnLjIcqz3xjIc=;
        b=nhKapcQ66LsxA85JQdzV2oZbWTII+lECh4PRQcH4mDiqEm4ojDHv7H95e1Yu9UhPbu
         qgXFEJe5IBj9/8AlpNKHmA92xYsyC4SZqZLvK6OLaPMuyeq4lmmUx9S6AraqRskOLIc0
         sqDRTVS1XH6eQTpbbz2NXSWwHn2MgMncpfuDlJlmwa1XYivMD6NL9zGnWYa6ijPckc7c
         c2mkdLJpg7sVYVQgFSS+T86beZvtahhhakiO/RCC/l6JEGECGPLz+RSYnW7Oegj286j8
         zPENNFHaBXDfvD0DIMp2vnBNikzzZAbi0CqXctM2F2ra4pGsxVa61JCC589gAilD2WC6
         ju6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=emFoOM20hOM5X61XhU2Zz+3u4EcYFFGnLjIcqz3xjIc=;
        b=0tpv00KUklS1K9yx+aknKP/xctIExTEXDjTN18oJMVEse+BdVxdeGJfzMYU2is0dAt
         lQkwV91TiNJfvXGteY38HbYHfk2VkOIddYR6zxvLCiMz5BymLjoHiyySUEk3Ng38FGEa
         /F7nK1uEJlpS3fg8E0wViROtWanw24QZvLYyVtjpf4o009HwGVpjBIVMvtgy0CvTGQ57
         DWut6mkJhsXNKol5+WxXEw89ifG7NkSk9fy/jiwuXQiVWQNoplnazipbY3sBRfHvyluG
         iUtAdLUtdkcY04X6LUhLejIrKznpLidhmqxLSCuz8xPgs2v2R58k4q7VSAFBVw2MrqnV
         1hhQ==
X-Gm-Message-State: ANoB5pn+r/20A2Eh9P8I6JhsW6832jAIqIhkw8htK6uAPzxSz5Nxs1Bd
        jNP7qlQ9Oj9GoEC3dMO7aK432J9JxJHm/w==
X-Google-Smtp-Source: AA0mqf6g0V291RCuJE/6a7lckAJbDgRfo/msdIC8flyucHI+AJKI3XL0ggAyX2RdNHUyh2wH0hgteQ==
X-Received: by 2002:a17:906:ca18:b0:781:c97c:84d1 with SMTP id jt24-20020a170906ca1800b00781c97c84d1mr46678807ejb.147.1669711878319;
        Tue, 29 Nov 2022 00:51:18 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id kz1-20020a17090777c100b0078de26f66b9sm5873219ejc.114.2022.11.29.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:51:17 -0800 (PST)
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
Subject: [PATCH v3 4/5] arm64: dts: Add DT node for the VIPNano-QI on the A311D
Date:   Tue, 29 Nov 2022 09:50:44 +0100
Message-Id: <20221129085047.49813-5-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
References: <20221129085047.49813-1-tomeu.vizoso@collabora.com>
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

