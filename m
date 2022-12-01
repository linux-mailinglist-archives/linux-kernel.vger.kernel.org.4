Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0446563EC54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiLAJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiLAJWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:22:09 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72C88B75;
        Thu,  1 Dec 2022 01:22:06 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n21so2689861ejb.9;
        Thu, 01 Dec 2022 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emFoOM20hOM5X61XhU2Zz+3u4EcYFFGnLjIcqz3xjIc=;
        b=eEKedVMqKjYToTnqqxIEak73Wzz7rW0xVExwfxSdUKfxOp8vkH2NxTqrOtIoQLz4F8
         9exnW6NsirZrwSTRSfprHwDR5nwlpq0pDtbX1yq8dJmnSnKk/KwnLpBVOSkJTcxo147N
         WSyq6IUND9gaNMgFQUZqSGL7RikXSjj4WYPm9AtgEMeUD2wgnXFaZCLy2bwodcAmida4
         ZsaQTs/81oikt/C+1jx4caWjMSbKOOSdBMb3ToqVHQmwU5UbUaLeMMvlB2IlyaAGUTuF
         aaDD5i4nFWyynDYWo15p/tdbfOA0xQJush3cXN4PQMqmOX/dO+Am4L7aSZGKcga+SsZC
         EbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=emFoOM20hOM5X61XhU2Zz+3u4EcYFFGnLjIcqz3xjIc=;
        b=gGwhFrMapEKmtwjXbU6kUSJLdNz+hT7wvr8X4o+1ipXxniqWbfm/FAaXKPJVoPMAel
         EJitaPG+8XBKTR9M/KggjFrU/Twy6AoaXv6pxpwVbOLra3fMsO8oHOPq8jIAZd40DLjy
         UKyq6gx8X7EbKu26F1oTOwo382OGHvUR7huFpBKk9gwpfHHB8dsv0/JkMii1HPDDoCP1
         g5+yvErXRbtK+RsSyzwXzi/4j+NfKxohxr80qWoBWNFk9uU+GmVTmjR0NQE2p5iXbEsX
         BGCO5tAnY4PZ9HTnOFOectMSog/PdLaA7gBQMcfGRErnaVIS6Hn4qJhKzUmEquAP4NEv
         UM2g==
X-Gm-Message-State: ANoB5pl+0SHNNfBVH+sQsQZeSNc7b6Fu+5BONdMj/crMKatC18WRRoxP
        wLKW0D58g/XXuiZJKfRfs40=
X-Google-Smtp-Source: AA0mqf4UyZ0O/AsgAmnpnzeo9TgNMV2FW3qhCZ7iet38KCkJzo/YLs9LD+vUUo9/Xdof/6/2W89Bdg==
X-Received: by 2002:a17:906:4f0b:b0:78d:aaf9:7b8c with SMTP id t11-20020a1709064f0b00b0078daaf97b8cmr56468241eju.229.1669886524515;
        Thu, 01 Dec 2022 01:22:04 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007b29eb8a4dbsm1587879ejt.13.2022.12.01.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:22:04 -0800 (PST)
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
Subject: [PATCH v4 4/7] arm64: dts: Add DT node for the VIPNano-QI on the A311D
Date:   Thu,  1 Dec 2022 10:21:25 +0100
Message-Id: <20221201092131.62867-5-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
References: <20221201092131.62867-1-tomeu.vizoso@collabora.com>
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

