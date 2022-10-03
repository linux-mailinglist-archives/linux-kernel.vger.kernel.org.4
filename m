Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C15F2EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJCK2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJCK2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:28:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA162497C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 03:28:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o59-20020a17090a0a4100b0020a6d5803dfso4769388pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GZF/RIYzZU5gHqugTmczTBwS2A/Y/oQ2QFe1S8xT0YA=;
        b=mBdua7aK0OpaGL0sJ+rMoV63lzT9pxHUfH0GBirICsAIr2OsSGqsI7QptljWJZ7Etc
         3xTtMu7U5mFsUB6XcEnRig2hyI7rcfcQGSJJjWEoDnIV548avkM77u2IU+urXOFkDx8Z
         ey0DR1U+jSdgtaykZB8No6mEpyLgyGyJtnePBAbs/DBv3jab2C6ltmYQDK7dYyGkwzLC
         WsQUTOvq69VRjP0C0baVdkFyfUUxQHpuBKixPX0x65BigfMmn0Y36g/tnM1z9PENmBDG
         CCy4dK5Vnz9Y0NhoXmBfnWtZUVp8dAzfiYiOiaoNmXSKFnLwR3DCIFfazVLkSlOzppiO
         r0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GZF/RIYzZU5gHqugTmczTBwS2A/Y/oQ2QFe1S8xT0YA=;
        b=W6h9fWkmE5AenyQvw2zKWMkYtyYlkJGOTOR5OHoqbWEnLZqyIq0jC89TTXfgROuVqs
         Fi2alcdXXXexPsGvC0lvR4KRTCK3rs6wf3V8rQmcIUN6KkzegxkylkZNtAf9wlWaiEnO
         JLvwYv8Tw7wVprQ1oGL88xOQk9khNLNHJANNaTGiQHA6MmlPIRcdVHn3PkX5uchmYXkO
         99bRBxT85a/bxMyZn7DV5w27lMK3m5vx5w9fVByJKNTrbuIJXTjWHM+qUBIt2uJhmS/I
         r8rhm1ymI+h/hA0GZOShlPyUrH9iBgf9lw+pc9xN4tYCRqvYNzplyNpbmYuP2F2E8N2h
         rVEw==
X-Gm-Message-State: ACrzQf1KmKoFldKihn/HJSN9WKKMW18sB8tuQ5Cz/8246N8z+kDazmnn
        /vGGCZQPEn0+vqe26X4gVL3GKq4TNmkQFtdf
X-Google-Smtp-Source: AMsMyM5BrtTxepMngH87cpejv7ul9sdN0yESw3yLby/s+fFnU1kNIc0AYGJI+0FvGUev1xAr+VGq1g==
X-Received: by 2002:a17:902:6acb:b0:17d:c267:2ad9 with SMTP id i11-20020a1709026acb00b0017dc2672ad9mr10218259plt.10.1664792901076;
        Mon, 03 Oct 2022 03:28:21 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b00172951ddb12sm6860249plr.42.2022.10.03.03.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:28:20 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 2/3] arm64: dts: qcom: Add LTE SKU for sc7280-evoker family
Date:   Mon,  3 Oct 2022 18:27:35 +0800
Message-Id: <20221003182637.v6.2.I1454364ac3d8ecc64677884d6b7d2f3e334e4b4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003102735.39028-1-sheng-liang.pan@quanta.corp-partner.google.com>
References: <20221003102735.39028-1-sheng-liang.pan@quanta.corp-partner.google.com>
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
---

(no changes since v5)

Changes in v5:
- remove unnecessary whitespace

Changes in v4:
- remove change for trackpad and touchscreen

 arch/arm64/boot/dts/qcom/Makefile                 |  3 ++-
 .../boot/dts/qcom/sc7280-herobrine-evoker-lte.dts | 14 ++++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-evoker.dts     | 15 +++++++++++++++
 ...evoker-r0.dts => sc7280-herobrine-evoker.dtsi} |  7 -------
 4 files changed, 31 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
 rename arch/arm64/boot/dts/qcom/{sc7280-herobrine-evoker-r0.dts => sc7280-herobrine-evoker.dtsi} (98%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 65cb0f714ed6b..91153baeeffae 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -95,7 +95,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
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
index ccbe50b6249ab..e78072159d54b 100644
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

