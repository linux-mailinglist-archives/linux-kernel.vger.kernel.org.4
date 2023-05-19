Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CFE709FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjESTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjESTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:06:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF26E5E;
        Fri, 19 May 2023 12:06:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510e682795fso3999886a12.3;
        Fri, 19 May 2023 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684523193; x=1687115193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvlL8P3BXIsivHbGh9QFYVvtFqoaF0HpLC5MGBmloE4=;
        b=Fo/J6z6SnSJ8l6YQAH0Ny+72DWy0M/jqOe5WjwXCYqvKmynrmGLaKdA3qzWh7uI81P
         HS/LXSZaSli8WBYHMCBbCCGn906Q99sSpzHcMhsvyDb/EHbs87bv09+HKHalvubENOj4
         21tJ/XStElo+gA+VbEXebIqsWeR7lGddd+EbzrGO7jVFbVOs9CqgVLuwRFUhUJdFa83y
         jdYqMqfystd6uATLM3y6IJjVNvnpe464hjh0Q2CXred0/pH6RDeKdERHqdAgW27JSh5L
         NsIx66tArT6fR4K68X1DDquYjszhNqnYAaXFLN4vuivh2plc0lqCPT0MEae0PPLfY72w
         sQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523193; x=1687115193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvlL8P3BXIsivHbGh9QFYVvtFqoaF0HpLC5MGBmloE4=;
        b=JcaG8kF8P5w4U3ABfMx1hMdipiAbhtkTD0eEQTnq2ul58Dtj8VwvUiZWsBWjH6BYBo
         8bihAcXCYXIBZir74o94hcWOCX9MYE67aSa7WCCX/enIPqi+hiMFGsMckIpYJTIxVKA5
         CcItRlJUF0YWu6mq1IbBsJfv7IuJqEFdzL0XWkH95SrsThCwSiI1HdS6hgLmfJBaBQTJ
         Uc/Wdznjxryi0yDFfc7D0+S9VNYImnwrgRbLJvQ7Spc+CYMKED6UBfU921gQFFFFSjmd
         W8So1Kru4FXNogEqVZzF7WEFT9znqDn1qYwpWZiZL4i1ioFIGOtYZr9j8P3gSVOMgUTe
         2+2A==
X-Gm-Message-State: AC+VfDzCiIIBVwQUoIHDCvHN45oP0fSX6uz9Sz77jQJbVk9oXLsmLCFo
        BR7JCORIVfouRFW/FUDUHh6h/yMwL2U=
X-Google-Smtp-Source: ACHHUZ7lhiD9Qzfz6Ag0HAjMgVi9px3oAZ40uhKstAVBhERj1uo62eOItYFzCOvAqw/4E0LahHvcqw==
X-Received: by 2002:a17:907:1c8b:b0:965:9602:1f07 with SMTP id nb11-20020a1709071c8b00b0096596021f07mr3939514ejc.39.1684523192952;
        Fri, 19 May 2023 12:06:32 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090609a100b0094f1b8901e1sm2624244eje.68.2023.05.19.12.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:06:32 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 1/3] ARM: dts: exynos: Fix some typos in comments
Date:   Fri, 19 May 2023 21:06:23 +0200
Message-Id: <20230519190625.7844-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519190625.7844-1-aweber.kernel@gmail.com>
References: <20230519190625.7844-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/boot/dts/exynos4412.dtsi         | 2 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 4 ++--
 arch/arm/boot/dts/exynos5.dtsi            | 2 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi | 4 ++--
 arch/arm/boot/dts/exynos5250.dtsi         | 2 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi | 2 +-
 arch/arm/boot/dts/exynos5410.dtsi         | 2 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi | 2 +-
 arch/arm/boot/dts/exynos5420.dtsi         | 2 +-
 arch/arm/boot/dts/exynos5800.dtsi         | 2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)

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
index 434025331041..f775b9377a38 100644
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
-- 
2.40.1

