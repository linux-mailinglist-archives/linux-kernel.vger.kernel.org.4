Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC5F5E73DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiIWGS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiIWGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:18:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183D612518E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:18:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w10so9997043pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=k1Ok2pKp1PJzTuNyx2UWy/icamUoRGaVMBaasc2ZnkA=;
        b=ROWTJ0drnsPC8a77DJkvBYf7pyqF8Pk3gzs+pbtHsFFvE/nL0A8mrYUYzaNoZrg+it
         qNbqKd8hOSkKoK1DNVIxzDJxGgvaRe2owSaSUupMyGfwkOIUSb6b3HGtv+LLCHthCjQL
         SusP8zrHmFFAfmsDJTLz53CzuEmghT5qI0SkIHboaqQ08w03KhLujd0qeesOs0NG6W/x
         UIAJCrxXtlRtaUCHdVPJYLhKDZW34Qjv7IbjpBt0bcw9ZDcEFCc2x/apCuYBWvxvKqF1
         KNsb8k4USIoGK0R6UfO7cZvZVuIDyLHc8jAfkuwhJusSaNjZqgYiRSjY2psrKqrdZnbF
         SNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k1Ok2pKp1PJzTuNyx2UWy/icamUoRGaVMBaasc2ZnkA=;
        b=r2/myU2wZ4UsOVW08YK2KYzys2dGxgxQ3cCADczNrwCWHCTS3gJxErp1J5/d8GrVBP
         w1jRL3YmYW9oK6unuvMnFkLVYBwzVRzuanwzzjHrLtq5+Ll4kezDYfoi8xLJ1A8/H5B0
         SEd6X/8y2eInAmv8eptC8mIv8c7IH21J5KVbEktQpLnW+/AIOrry2q2blx2wWPakQcWT
         9xQPM7qTXDv8zfnDdfVn2NDReLtMIpHgZDIqf3UmBOpbVok0RfJ9F6ZzKs6KpJKYP4tA
         uwwl6eezlH6MuxzVTgSGKpDQ5HsKuN3e36WFyfXz+tBnSJv0kWYYYJR1/n/VMH/neN0Q
         C86Q==
X-Gm-Message-State: ACrzQf1Yi3ulV8T6RwiPrQFRiKJjlOOkXVYEYRQ9CBOFqHu0tiJGmt/l
        fcbdtfakBWUt+FmJVPHEVTMQkhH0ys7xkg==
X-Google-Smtp-Source: AMsMyM4zrECVQG8lTi2qMC8SAzIUhUN+ue0hAX+KzeSnaY4AaWMkG9EDSeKt1n/ALSGBiljeWMrKWg==
X-Received: by 2002:a17:90a:fe6:b0:203:7c29:6e0d with SMTP id 93-20020a17090a0fe600b002037c296e0dmr7595214pjz.181.1663913898328;
        Thu, 22 Sep 2022 23:18:18 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id c190-20020a624ec7000000b00540f3ac5fb8sm5515248pfb.69.2022.09.22.23.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 23:18:17 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: Add LTE SKU for sc7280-evoker family
Date:   Fri, 23 Sep 2022 14:17:56 +0800
Message-Id: <20220923141624.v2.2.I1454364ac3d8ecc64677884d6b7d2f3e334e4b4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923061756.2557403-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220923061756.2557403-1-sheng-liang.pan@quanta.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evoker have wifi/lte sku, add different dts for each sku.

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/Makefile             |  3 ++-
 .../dts/qcom/sc7280-herobrine-evoker-lte.dts  | 14 ++++++++++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts | 16 ++++++++++++
 ...er-r0.dts => sc7280-herobrine-evoker.dtsi} | 26 +++++--------------
 4 files changed, 39 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
 rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (93%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d7669a7cee9f7..76390301a76c0 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -104,7 +104,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-crd.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-r0.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-evoker-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
new file mode 100644
index 0000000000000..3af9224a7492e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Evoker board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include "sc7280-herobrine-evoker.dts"
+#include "sc7280-herobrine-lte-sku.dtsi"
+
+/ {
+	model = "Google Evoker with LTE";
+	compatible = "google,evoker-sku512", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
new file mode 100644
index 0000000000000..f490b2bb26df8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Evoker board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7280-herobrine-evoker.dtsi"
+
+/ {
+	model = "Google Evoker";
+	compatible = "google,evoker", "qcom,sc7280";
+};
+
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
similarity index 93%
rename from arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
rename to arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
index ccbe50b6249ab..561bb1ee77eee 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
@@ -5,15 +5,8 @@
  * Copyright 2022 Google LLC.
  */
 
-/dts-v1/;
-
 #include "sc7280-herobrine.dtsi"
 
-/ {
-	model = "Google Evoker";
-	compatible = "google,evoker", "qcom,sc7280";
-};
-
 /*
  * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
  *
@@ -30,16 +23,15 @@ ap_tp_i2c: &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	trackpad: trackpad@2c {
-		compatible = "hid-over-i2c";
-		reg = <0x2c>;
+	trackpad: trackpad@15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tp_int_odl>;
 
 		interrupt-parent = <&tlmm>;
 		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 
-		hid-descr-addr = <0x20>;
 		vcc-supply = <&pp3300_z1>;
 
 		wakeup-source;
@@ -50,18 +42,15 @@ ts_i2c: &i2c13 {
 	status = "okay";
 	clock-frequency = <400000>;
 
-	ap_ts: touchscreen@10 {
-		compatible = "elan,ekth6915";
-		reg = <0x10>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
+	touchscreen: touchscreen@5d {
+		compatible = "goodix,gt7375p";
+		reg = <0x5d>;
 
 		interrupt-parent = <&tlmm>;
 		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
 
 		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
-
-		vcc33-supply = <&ts_avdd>;
+		vdd-supply = <&ts_avdd>;
 	};
 };
 
@@ -90,7 +79,6 @@ &pcie1 {
 	status = "okay";
 };
 
-/* For nvme */
 &pcie1_phy {
 	status = "okay";
 };
-- 
2.34.1

