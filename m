Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343A861EF6A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiKGJom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiKGJoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:44:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C7C17A84
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:44:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k7so10563128pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJifRJMD3H6Zwg9dEMB5fXXtWtJk8Fn7PNdc60fysMk=;
        b=2rUVlEhqS58E3yYy81iZwVG4aGUgSqO1Waj/gDha3j9iYtrXiHti5uZObzKFlDw79n
         HQEsnfRZ3cdGNgxymZnJP64vD+17NJDsoAVRkGa+X1KBtfwrr0gnql87xZEmcdoywOuq
         KbGZlxbzg6bJKGTRu+cOjq/jdTgU1IhA0ynT7pveDllzWk2uVN31GYWwHD7dbobfYo3a
         Sb2xyXyOdF6pLdvJp3qA7wJyjBCyuSyM7h+bLVc5S6zkduHL/AU2GrdK6/gH23Oq+qs9
         23Sc7XTyyblAgv26T+0p0LeYw6u6Sfnjxs+jo33IB/oD5jlKSKYjDB4/GcNsUbg8Cfmi
         25zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJifRJMD3H6Zwg9dEMB5fXXtWtJk8Fn7PNdc60fysMk=;
        b=qj8zBcEBHFwamnMNFayCi1e+1YBgUvqGolVI+QaA4UgKOYKES0K7Npk25pxV3X7qaf
         nVsIqN8hPorNdyXXvwx6iWwQXN0BZrSTTEqZSfvKlFSbfHrpRwMU0Uj+caZi6g/p2bJL
         HWl6pE33EBQuBMlTbXmpMxsW1W9fUp9k92i9wA23JWU1qTPzQ5ijyilnJSTmgzbwVHYd
         qbmugnFB+PiFY2S4Gj6ks7jkD2itPKRE/YQm6VW7VZ1YRLMTaFrfCio1/l3Z/y+vrHfl
         yLJwM41P7xrvuZEWWRyonbU6b4bGcVqosnRZWPXlqlq9f0zsTNxXyFU+lqoxK1GdxbdC
         NHsQ==
X-Gm-Message-State: ACrzQf34D1UeEfBXq5XZ27b52o78DYoZtPG+fRQ5G4D6LblA1Evfsx2B
        mRVVool9FE4ESw2MCSGNxNmLT8m5suHXgW35
X-Google-Smtp-Source: AMsMyM4awBx4BdqauFnYo2kSyGWNCuvR/h6TynpVA3A3QZnfFaLuqjh7Ah0DH2hAmb/vtvsqoa1tLg==
X-Received: by 2002:a17:90b:3b43:b0:213:fa1a:5326 with SMTP id ot3-20020a17090b3b4300b00213fa1a5326mr36337079pjb.20.1667814268987;
        Mon, 07 Nov 2022 01:44:28 -0800 (PST)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b00186dcc37e17sm4564936pla.210.2022.11.07.01.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:44:28 -0800 (PST)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v11 2/5] arm64: dts: qcom: sc7280: Add LTE SKU for sc7280-evoker family
Date:   Mon,  7 Nov 2022 17:43:42 +0800
Message-Id: <20221107173954.v11.2.If03e9e85e63ece4b1599db841c90ed785c47a4be@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---

Changes in v8:
- updated patch subjects

Changes in v5:
- recover whitespace change

Changes in v4:
- recover change for trackpad and touchscreen

 arch/arm64/boot/dts/qcom/Makefile                 |  3 ++-
 .../boot/dts/qcom/sc7280-herobrine-evoker-lte.dts | 14 ++++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts     | 15 +++++++++++++++
 ...evoker-r0.dts => sc7280-herobrine-evoker.dtsi} |  7 -------
 4 files changed, 31 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
 rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (98%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b0558d3389e5a..6f234995284b2 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -106,7 +106,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
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
index 0000000000000..dcdd4eecfe670
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
@@ -0,0 +1,15 @@
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
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
similarity index 98%
rename from arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
rename to arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
index 739e81bd6d689..a6015491c6082 100644
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
-- 
2.34.1

