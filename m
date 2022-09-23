Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2F5E7789
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiIWJnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiIWJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:43:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBB4105D41
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:42:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d24so11272886pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=k1Ok2pKp1PJzTuNyx2UWy/icamUoRGaVMBaasc2ZnkA=;
        b=s/q3vB56Uajdp7BC3IV/UnCmHK6HC1NSdtPVFRbgAuKl0wYnpgap19teG1ljTzLlxh
         69jn3z4r6DHYphiQlS6BRJ2ud7spGX+3ZdBZve9rOLFsZGSihatF6GFZgahEJc18ddQx
         sD+Cdddu9WCoiiU41Th81TfElQH6vvIYrrAp1iPSMgFWRJHhfnlAfpwlztVOIbkVZ30Q
         sxEv9DuDufNhD7WbyqcEtmxVSxXcbudCkKt/S7x3wdxj7AXpHzz2PXfYf1AvkxRIcud+
         Pxc2isL96rr6m6g3xaUl0txxL0GHBjq/A5Ieirprn8C5kNrY961nh1U5SHRVTb8wu/1V
         d3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k1Ok2pKp1PJzTuNyx2UWy/icamUoRGaVMBaasc2ZnkA=;
        b=igXtwbNX5QlkQQgqMIuBmELWfC1RdR2abJ1nmHXb5xw6iBXi2Y9CaQuA3ZNTB2xBJ7
         DfnlHwa0R879S+XvFUYswrlyW7PVWoiI1cGVUp0nFwaS0ztaGduPGkVUNKCkhzbUsBRb
         9irWXcobArtKywbbExXeMIJcXAJJzXUkekb9LoeigIJPTa93TXKeGJX9/zqRCsoX7lVA
         mP+UnE/ninqVXf3FjhzIK8oBJPpc6JCW9JCuhzV6/WFa+bYE89I2vddT0/WLh2YsSbqC
         q6rXJhfw8yWYxljI1l2rm4qAs3rb4AwApVhtmZfml8qN+Iet6se2DpEHtnDT0DEc19YH
         eMsw==
X-Gm-Message-State: ACrzQf2CYr88R0vaYpJ4KYY6rcrNbLVxOt0aRce/jZt+RHWO6Yl3h5Wp
        MFsLHBpcJlD2t8jPNK2kpUShjTqx2FWU3A==
X-Google-Smtp-Source: AMsMyM5oASv/0MBhygZVy2/E/2TwFmvA6bjdpXDKMDNl+M9hfwFFapHakDeCoO5ujNPF4qlPTOIJsA==
X-Received: by 2002:a17:90b:3910:b0:203:dd3d:5f8a with SMTP id ob16-20020a17090b391000b00203dd3d5f8amr11121086pjb.210.1663926179026;
        Fri, 23 Sep 2022 02:42:59 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902eb8800b0017515e598c5sm5512855plg.40.2022.09.23.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 02:42:58 -0700 (PDT)
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
Subject: [PATCH v3 2/2] arm64: dts: qcom: Add LTE SKU for sc7280-evoker family
Date:   Fri, 23 Sep 2022 17:42:42 +0800
Message-Id: <20220923174224.v3.2.I1454364ac3d8ecc64677884d6b7d2f3e334e4b4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923094242.4361-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20220923094242.4361-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

