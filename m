Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1394964C2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiLNDsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiLNDsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:48:01 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C1910568;
        Tue, 13 Dec 2022 19:48:00 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 142so1199476pga.1;
        Tue, 13 Dec 2022 19:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HamKy7IR/Br8fqE5z1cuQ1CwgOAI0Xc6SWFCDQRfIlA=;
        b=FstbXrekny+c3fAxfJoD7/51mHIURlQ0qcbL/i7M8JZlpNs2aHSjMhBhAHTwfYk+1J
         h6ntqBDk8En2BU0Hi2b/vrXQ3np6azGHw6raW0g9JjLt0H4k85b+YCr6KKATh/TNZIg5
         fZu/aqLDfHYC7kGci4nLF4mMGXGLAZlTA86kZ262YjxRgvhFnVznU8rMxbAThUTJe/kB
         qedo7RUhRKVqhyEhbBfjtOZ6J/TjW+Neb3+rj1UosNDoez5Icu3kYhmOsAeMWytnilTB
         ERl4GL1exZDcMZVz15tzBTbuBBmhk7L+chSkesaS6iwBMBBgtIcDRtU2cMx6uLx4wuwD
         c9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HamKy7IR/Br8fqE5z1cuQ1CwgOAI0Xc6SWFCDQRfIlA=;
        b=EFz07r4dMolbLxcBflFxDX+3S8TFJ+I/G60JbMNaY110HiVqCMBtxahOmliwx0pS+O
         wL7jt3hkZzvQvoH6aDkP9qkX48uv9IkrvdE28Rsy3bpkBEapRP6jDetlxUOZ4luZrj7y
         8bS6IYpUNCsQPi+jouoz5kJNutSMsMPxYndYwxMw0LbLgwpPbbb9fGOVWV2hxuVsCmOG
         Jy3/4tfz+FE+JBB5FW4KhRiVfhN67fP4kv5p/66gsyjNGfxwAP9BckMBRK8ZuH/zLovP
         3qwuVP+OFiOSo1/5wc/ej/T+BswCZzzuMbzwYb4fIQEEPgBV8XdCzBGBEIaNbAuYAoV/
         pLzQ==
X-Gm-Message-State: ANoB5pnsJXyS1Wm5kPuRluulitRvR1kwWAs8wqFeQXHYC+XoErbzyU+F
        ERJgGmyQ+5CtgmDAUM5VKokXm8uRN40=
X-Google-Smtp-Source: AA0mqf6xlyc3ZOyAxojnSAdmWVg8QyVKvg3vRCqPw10qLcIDqpTzMPVK1pifWg0bfSLNBjW9V6lXug==
X-Received: by 2002:a62:1b94:0:b0:578:f6f:efab with SMTP id b142-20020a621b94000000b005780f6fefabmr18728620pfb.11.1670989679964;
        Tue, 13 Dec 2022 19:47:59 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e28b-7065-982a-58d7-b612-9bf3.emome-ip6.hinet.net. [2001:b400:e28b:7065:982a:58d7:b612:9bf3])
        by smtp.gmail.com with ESMTPSA id o24-20020aa79798000000b005745eb7eccasm8319817pfp.112.2022.12.13.19.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 19:47:59 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Bob Moragues <moragues@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>, Harvey <hunge@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sc7280: Add DT for sc7280-herobrine-zombie with NVMe
Date:   Wed, 14 Dec 2022 11:47:49 +0800
Message-Id: <20221214114706.2.I1a0c709f8ec86cc5b38f0fe9f9b26694b1eb69d6@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
References: <20221214114706.1.Ie4ca64ad56748de5aacd36237d42c80dd003c1a9@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT for sc7280-herobrine-zombie with NVMe

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

 arch/arm64/boot/dts/qcom/Makefile               |  2 ++
 .../dts/qcom/sc7280-herobrine-nvme-sku.dtsi     | 14 ++++++++++++++
 .../qcom/sc7280-herobrine-zombie-nvme-lte.dts   | 17 +++++++++++++++++
 .../dts/qcom/sc7280-herobrine-zombie-nvme.dts   | 17 +++++++++++++++++
 .../boot/dts/qcom/sc7280-herobrine-zombie.dtsi  | 10 ----------
 5 files changed, 50 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-nvme-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 3e79496292e7..5dcb3dd9718f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -121,6 +121,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-lte.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-nvme-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-nvme-sku.dtsi
new file mode 100644
index 000000000000..1aed02297f44
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-nvme-sku.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Herobrine dts fragment for NVMe SKUs
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie1_phy {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dts
new file mode 100644
index 000000000000..e1fcacdccd51
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme-lte.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Zombie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7280-herobrine-zombie.dtsi"
+#include "sc7280-herobrine-lte-sku.dtsi"
+#include "sc7280-herobrine-nvme-sku.dtsi"
+
+/ {
+	model = "Google Zombie with LTE and NVMe";
+	compatible = "google,zombie-sku514", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dts
new file mode 100644
index 000000000000..e3d52c560363
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-nvme.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Zombie board device tree source
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/dts-v1/;
+
+#include "sc7280-herobrine-zombie.dtsi"
+#include "sc7280-herobrine-wifi-sku.dtsi"
+#include "sc7280-herobrine-nvme-sku.dtsi"
+
+/ {
+	model = "Google Zombie with NVMe";
+	compatible = "google,zombie-sku2","google,zombie-sku3","google,zombie-sku515", "qcom,sc7280";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
index 7fc0b6bfc0d6..4c49d14cca47 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
@@ -60,16 +60,6 @@ ap_tp_i2c: &i2c0 {
 	status = "okay";
 };
 
-/* For nvme */
-&pcie1 {
-	status = "okay";
-};
-
-/* For nvme */
-&pcie1_phy {
-	status = "okay";
-};
-
 &pm8350c_pwm_backlight{
 	/* Set the PWM period to 200 microseconds (5kHz duty cycle) */
 	pwms = <&pm8350c_pwm 3 200000>;
-- 
2.17.1

