Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27CB63A703
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiK1LSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiK1LSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:18:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E39590;
        Mon, 28 Nov 2022 03:18:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b12so16259713wrn.2;
        Mon, 28 Nov 2022 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ/yfW2uv4L2OBEMjogEawvHGxQ+pctbkljRiIAmmkE=;
        b=hGj6yWExeA6aOxOP28/1HTpYw/34JrQ7Esvqizyi96Ucx4ABRX8kMiUxEHL9qfsiE0
         PqAAPfTyE97mJzH7BnkNxb3dOEga0uSP6vmgicBtIKcXdG99+CaH6p+PH9l+ZDP1e+WW
         bvWsY2p6m6fkKh3/oi+1jwK7HQfx8vQmNaC6gKZjnzqvXx+H47P+7SPY3H4dzQ+Hp74W
         Maf4pZjT7qBSotYev3Ay7J2G570YJp1d3WrXwJaswh4oY7DqJTL4fmuUpeP8Bub2rO05
         5wZiV+82TgrY+Hlq8t5ZQkzqjc34D8BEbJspYKcRy3D3zE9ySXLJoPo7D3c2r6K+cdZp
         qoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MZ/yfW2uv4L2OBEMjogEawvHGxQ+pctbkljRiIAmmkE=;
        b=ZGUsc6qo+W75f8tpb27mSO8gfChXnxmx8ziLFC+jY3fxpWQxvCpfwX8VArdgzItK5C
         4Qse05CJJkhrcOlDwCQr7apEoGSSuX2O+RYLIONGVzSibThcwr/kJirz07ZO3vz8J4qL
         /OVsN2CqHmZnA6Xrt5B663wMa0J+nvXToaU4XU9B8fRuHdHj5w6fcG/9gE71CLv8kAA0
         SniLnLz2ETUQXdEbHXWI6+r4AkF7eZn7Ua/y5JGN1dVn76bTJqKhTjKls6gSu8Zk+pGW
         6Yyd+9+E/cG0x6n9rWyppYi/XQmb0EDfcUIW/r483Vi5j1GAmOZMSH1ynC/jwWV0yNkn
         CRfA==
X-Gm-Message-State: ANoB5plGMjvFZfH4PlA3SqlVO+udmomxf4JF40Wx0YeHgdxEi3o3nbgr
        49X0JGhz6jWFWhLUs6qrbAFeBIFM94w=
X-Google-Smtp-Source: AA0mqf6SjstKcXwXEz6uOwVDgqeAXY8Z2rREjLqZqBUwe7/hkRY+JXxFuZitbclFTEy6qjt90aucIA==
X-Received: by 2002:adf:a1c8:0:b0:236:72f1:f124 with SMTP id v8-20020adfa1c8000000b0023672f1f124mr30428869wrv.161.1669634283786;
        Mon, 28 Nov 2022 03:18:03 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g3-20020adffc83000000b0024207ed4ce0sm7711817wrr.58.2022.11.28.03.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:18:03 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/5] arm64: dts: Add DT node for the VIPNano-QI on the A311D
Date:   Mon, 28 Nov 2022 12:17:37 +0100
Message-Id: <20221128111740.39003-5-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
References: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
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

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi     | 11 +++++++++++
 .../boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 45947c1031c4..aaa629816e41 100644
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
+			<&clkc CLKID_NNA_AXI_CLK>;
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

