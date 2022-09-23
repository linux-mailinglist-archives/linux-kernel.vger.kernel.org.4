Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BF75E7397
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIWF7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiIWF7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:59:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D35122633
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:59:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so4686803pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9LiM2RofDkgcHBpqf7dCb07GMbjI1UfSbKFtY4KPro0=;
        b=iEOrJWvagEhwObJaDJ/BlH641R3lsgfInKOBtByVQq4q8BC0/ixrd34RweUDphXH6u
         qqSOCznaD2XW9axktpbpYSQXijb4anDqSwNYIr+tmqpl7cYLiB19BhgMNTbAuUVgg7B7
         1rt/6e63/23LMa2h9yeXsNhjy/Y22M1gaBPp4yEtWRznUjoT/a33CdQwzy9uT+JW2rZX
         OJXeDEL+9uUOVLSunzIcGlFvmq6TZr1dfXnMruc7grzR/KbqO68Vri9dZ+wrfH7Tl1Px
         NpjxvPK5bpxjr/4Rm/lySFUr4phwgXdvR9PhGWvll2h4dzKV8HNzCMC0t/Dz97+JKHEd
         gGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9LiM2RofDkgcHBpqf7dCb07GMbjI1UfSbKFtY4KPro0=;
        b=zPKDObIq0Suaf0JY5ri73h8jiGO0/k575UjX5DU7bj4ohpZrmLjEDZQttZ22KM62EO
         kWnc8Vu7PGh7yJ00qIeifPRqeCFYR+H8uFymLNQtpB5fDaa1vNL8aUO6dtVMt2GHwIW4
         NvqhQHH5jC5666g0jtgpVttblQJR43Z158Th/gMSFzHFzs3hh/mWVX+r8ECj1a4FV0rN
         r/OHyzlnmpV9ZBN7+VxxRCXGFw/QTKmrn7slaOXCgsFO938uIvR8cdDfWf/QbuTp0ORr
         QebS4jI7DlV3DtBnSVu3ExT6RLX96lq1+Q/i22TJ05PKvvNaub8kus4Nb1nwHth4Kov1
         lKmQ==
X-Gm-Message-State: ACrzQf3B4XOmpCPRvzuPbLah53ymBwPwDJEY8TipaCmosBDqQ8SpqszA
        MBbneS1sGUAvNN3Uvi2gOVL5ck8Mhv73aA==
X-Google-Smtp-Source: AMsMyM4uyOkHLeIbl8ljV8HK+u6t2FQkV2u1i25ZMsxEeWWO5HSNuFtpLCxDzxgel3KQleMVERnJFA==
X-Received: by 2002:a17:90b:224e:b0:203:fb9:6d6 with SMTP id hk14-20020a17090b224e00b002030fb906d6mr18871709pjb.208.1663912739433;
        Thu, 22 Sep 2022 22:58:59 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0017532e01e3fsm5075638pls.276.2022.09.22.22.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 22:58:58 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: qcom: Add LTE SKU for sc7280-evoker family
Date:   Fri, 23 Sep 2022 13:58:06 +0800
Message-Id: <20220923135629.2.I1454364ac3d8ecc64677884d6b7d2f3e334e4b4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923055806.2556746-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220923055806.2556746-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

