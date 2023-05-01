Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04A36F38E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjEAT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjEAT4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:56:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCCD3C02;
        Mon,  1 May 2023 12:55:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-95678d891d6so607401166b.1;
        Mon, 01 May 2023 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970954; x=1685562954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOGc04EDBprGbJg+xQxod7skhjSvhIqdrB9AcENrHNw=;
        b=MDFKEJj+fNR9dFy63SUj0w/8qJvYvIdmPdpyRp3KMEmqP2Gqkq7ivo/jYTVKThi403
         voVrlABZkWkdKZUPypiwf6tMBNSPbXcH2cnB4Mn7tK/dqcemgVHC/WW7ieYx0n/0tZYI
         BgeGRCXWsbzqmhQHh7L+REcZe8DRgecIW1I1AuUfMfbHb3VTgHk1GK0VQL4R6OKf4vNr
         05muX+X1250ydN/Jw9X8JW1a+MFyhAkMydtOIJQkwJoNi0nJQl+A6WIPSCqZGjbIcoYt
         8/A8S0EUA1NXj+SlouEcWUXmXyLoOxcIYFJsnoG+rbD4eE9l/+vbAo041ZIQkFY5xmEM
         DDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970954; x=1685562954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOGc04EDBprGbJg+xQxod7skhjSvhIqdrB9AcENrHNw=;
        b=PySPvkSSYoAwgFry0Amxke+AQ8/l7ssP4TNmcFiGvVna+JCOjcg/9tQJV4/IahzrvF
         oYjHvj8oAoXUpO/I/KP3n3H/ShTL9WXtdQ7c/w2qAMlDz/Z1D7J1ckuafP+ccBwYSGEk
         ucr6zgb9ABhqogYMV/wKs8dqdetj2tQ6kLPzgyZ18xdCcA0H6J7VZK35VTBLtFkafYFh
         Sba2Qfe5F3p4Pmcwi8clQHnUcEchM+j0DlAuNzvWyjDFwLHYddQsoMXBoPuDXzSUtZlz
         7pOx6fDKfOAIda4Pf11p+bSSFYKFO9SDGpl3IYD1aMEt8vTcvKM8C9R9R572cbigs3vT
         T16w==
X-Gm-Message-State: AC+VfDwvhuRMRuJnx48EuW1BNibx240uW7tDBOt1APlnflXp26V62lb7
        rOkdhxh+8NydVM9OqCOeTcw=
X-Google-Smtp-Source: ACHHUZ5YT2x0QKzCJJLQq62PFbEPGc3kSht7PP/vDOQLc8119XR8mTn25GSabF+hymsYKVZjXCrHwg==
X-Received: by 2002:a17:907:7215:b0:94a:56ec:7f12 with SMTP id dr21-20020a170907721500b0094a56ec7f12mr14342929ejc.30.1682970953955;
        Mon, 01 May 2023 12:55:53 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:53 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v3 11/13] ARM: dts: exynos: Fix some typos in comments
Date:   Mon,  1 May 2023 21:55:23 +0200
Message-Id: <20230501195525.6268-12-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501195525.6268-1-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'specfic' to 'specific', 'optiosn' to 'options' and remove
duplicated 'are listed' in DTSI heading comments.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 4 ++--
 arch/arm/boot/dts/exynos3250.dtsi         | 2 +-
 arch/arm/boot/dts/exynos4.dtsi            | 2 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi | 4 ++--
 arch/arm/boot/dts/exynos4212.dtsi         | 2 +-
 arch/arm/boot/dts/exynos4412.dtsi         | 2 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 4 ++--
 arch/arm/boot/dts/exynos4x12.dtsi         | 2 +-
 arch/arm/boot/dts/exynos5.dtsi            | 2 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi | 4 ++--
 arch/arm/boot/dts/exynos5250.dtsi         | 2 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi | 2 +-
 arch/arm/boot/dts/exynos5410.dtsi         | 2 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi | 2 +-
 arch/arm/boot/dts/exynos5420.dtsi         | 2 +-
 arch/arm/boot/dts/exynos5800.dtsi         | 2 +-
 arch/arm/boot/dts/s3c6400.dtsi            | 2 +-
 arch/arm/boot/dts/s3c6410.dtsi            | 2 +-
 arch/arm/boot/dts/s3c64xx.dtsi            | 2 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi    | 2 +-
 arch/arm/boot/dts/s5pv210.dtsi            | 2 +-
 21 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index 011ba2eff29e..07828551d4b3 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -5,8 +5,8 @@
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * Samsung's Exynos3250 SoCs pin-mux and pin-config optiosn are listed as device
- * tree nodes are listed in this file.
+ * Samsung's Exynos3250 SoCs pin-mux and pin-config options are listed as device
+ * tree nodes in this file.
  */
 
 #include "exynos-pinctrl.h"
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index bd37f1b587f0..3f1015edab43 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -6,7 +6,7 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos3250 SoC device nodes are listed in this file. Exynos3250
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 8dd6976ab0a7..549e63b51242 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -9,7 +9,7 @@
  *
  * Samsung's Exynos4 SoC series device nodes are listed in this file.  Particular
  * SoCs from Exynos4 series can include this file and provide values for SoCs
- * specfic bindings.
+ * specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4 SoCs. As device tree coverage for Exynos4 increases, additional
diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 76f44ae0de46..70d268f9fcb1 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -7,8 +7,8 @@
  * Copyright (c) 2011-2012 Linaro Ltd.
  *		www.linaro.org
  *
- * Samsung's Exynos4210 SoC pin-mux and pin-config optiosn are listed as device
- * tree nodes are listed in this file.
+ * Samsung's Exynos4210 SoC pin-mux and pin-config options are listed as device
+ * tree nodes in this file.
  */
 
 #include "exynos-pinctrl.h"
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 0ac3245788fc..aa984601ee06 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -6,7 +6,7 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos4212 SoC device nodes are listed in this file. Exynos4212
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 8660c4c76e3a..dcbe0ce6180f 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -6,7 +6,7 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos4412 SoC device nodes are listed in this file. Exynos4412
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index 9f7ea5f2a91f..04935fbe2f2a 100644
--- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -5,8 +5,8 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * Samsung's Exynos4x12 SoCs pin-mux and pin-config optiosn are listed as device
- * tree nodes are listed in this file.
+ * Samsung's Exynos4x12 SoCs pin-mux and pin-config options are listed as device
+ * tree nodes in this file.
  */
 
 #include "exynos-pinctrl.h"
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index dcbb19824620..84c1db221c98 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -7,7 +7,7 @@
  *
  * Samsung's Exynos4x12 SoC series device nodes are listed in this file.
  * Particular SoCs from Exynos4x12 series can include this file and provide
- * values for SoCs specfic bindings.
+ * values for SoCs specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos4x12 SoCs. As device tree coverage for Exynos4x12 increases, additional
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 48e43b6b3213..4a17a19586bb 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -7,7 +7,7 @@
  *
  * Samsung's Exynos5 SoC series device nodes are listed in this file. Particular
  * SoCs from Exynos5 series can include this file and provide values for SoCs
- * specfic bindings.
+ * specific bindings.
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index 48732edadff1..d956540a2d88 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -5,8 +5,8 @@
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * Samsung's Exynos5250 SoC pin-mux and pin-config optiosn are listed as device
- * tree nodes are listed in this file.
+ * Samsung's Exynos5250 SoC pin-mux and pin-config options are listed as device
+ * tree nodes in this file.
  */
 
 #include "exynos-pinctrl.h"
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 1a4c6c028d03..99c84bebf25a 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -7,7 +7,7 @@
  *
  * Samsung Exynos5250 SoC device nodes are listed in this file.
  * Exynos5250 based board files can include this file and provide
- * values for board specfic bindings.
+ * values for board specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * Exynos5250 SoC. As device tree coverage for Exynos5250 increases,
diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
index 43e4a541f479..d15494b4bda9 100644
--- a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
@@ -6,7 +6,7 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos5260 SoC pin-mux and pin-config options are listed as device
- * tree nodes are listed in this file.
+ * tree nodes in this file.
  */
 
 #include "exynos-pinctrl.h"
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 350b8afa0a3a..546035e78f40 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -7,7 +7,7 @@
  *
  * Samsung Exynos5410 SoC device nodes are listed in this file.
  * Exynos5410 based board files can include this file and provide
- * values for board specfic bindings.
+ * values for board specific bindings.
  */
 
 #include "exynos54xx.dtsi"
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index 14cf9c4ca0ed..93b9873fa84f 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -6,7 +6,7 @@
  *		http://www.samsung.com
  *
  * Samsung's Exynos5420 SoC pin-mux and pin-config options are listed as device
- * tree nodes are listed in this file.
+ * tree nodes in this file.
  */
 
 #include "exynos-pinctrl.h"
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index dd291f1199f2..25ed90374679 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -7,7 +7,7 @@
  *
  * Samsung Exynos5420 SoC device nodes are listed in this file.
  * Exynos5420 based board files can include this file and provide
- * values for board specfic bindings.
+ * values for board specific bindings.
  */
 
 #include "exynos54xx.dtsi"
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 8328ddb3b02f..72d3a3535a7a 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -7,7 +7,7 @@
  *
  * Samsung Exynos5800 SoC device nodes are listed in this file.
  * Exynos5800 based board files can include this file and provide
- * values for board specfic bindings.
+ * values for board specific bindings.
  */
 
 #include "exynos5420.dtsi"
diff --git a/arch/arm/boot/dts/s3c6400.dtsi b/arch/arm/boot/dts/s3c6400.dtsi
index 8c28e8a0c824..7cc785a63866 100644
--- a/arch/arm/boot/dts/s3c6400.dtsi
+++ b/arch/arm/boot/dts/s3c6400.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
  *
  * Samsung's S3C6400 SoC device nodes are listed in this file. S3C6400
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
diff --git a/arch/arm/boot/dts/s3c6410.dtsi b/arch/arm/boot/dts/s3c6410.dtsi
index a766d6de696c..13e9cc69b8a8 100644
--- a/arch/arm/boot/dts/s3c6410.dtsi
+++ b/arch/arm/boot/dts/s3c6410.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
  *
  * Samsung's S3C6410 SoC device nodes are listed in this file. S3C6410
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index c03df6355500..0b59135ffe88 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -6,7 +6,7 @@
  *
  * Samsung's S3C64xx SoC series device nodes are listed in this file.
  * Particular SoCs from S3C64xx series can include this file and provide
- * values for SoCs specfic bindings.
+ * values for SoCs specific bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
  * S3C64xx SoCs. As device tree coverage for S3C64xx increases, additional
diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 6d6daef9fb7a..d5bd506d3ddc 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -8,7 +8,7 @@
  * Tomasz Figa <t.figa@samsung.com>
  *
  * Samsung's S5PV210 SoC device nodes are listed in this file. S5PV210
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 1a9e4a96b2ff..0db5a687a530 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -8,7 +8,7 @@
  * Tomasz Figa <t.figa@samsung.com>
  *
  * Samsung's S5PV210 SoC device nodes are listed in this file. S5PV210
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
-- 
2.40.1

