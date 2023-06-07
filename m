Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989F5725C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbjFGK6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbjFGK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649510EC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:57:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f735259fa0so42960685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135396; x=1688727396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnMTB1gQyvEeZp7nZTAM6BVyhIRBWpY4lFqsFPGfZMM=;
        b=yGS9r2A1xgdQzVP4dihVaE8lusnrMU9qumXIEZ+USwaQXiI/Y3/pw0wHKjtSKuOh/p
         IIzwkTH1fhQ1R9gSAEl6xGUAAETAsr5aPVlflmcVeulAuNvYhDsZF940O/kmwThj9kTI
         auSVKiOjFTuBT2g8zix67oQik+EJV+Rvmb3ACEeL/c5Xssa+5JQBIPfp7mHqrcedF3k/
         CPbqF23LwDtOl8062CZsrn/0TTimpMTUNFJKn+TAeLum/Z5eBWfhBiKu95/F4UWOap5J
         /WritJ9fe1hUrNATwQayvnFrsVxIOT/zhwiNzPspvk+Ujie26qhlnEySwHu9DdEDRcXx
         Ehvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135396; x=1688727396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnMTB1gQyvEeZp7nZTAM6BVyhIRBWpY4lFqsFPGfZMM=;
        b=N2RhZTN+1aK2WhkA1kNm5N7WDcZIl5i94dinHsnnSSoHvqEutcd3l6lvtcPcc4Gh34
         GaNU8iRYXLghj4tVxmhoiwX+dRyo0sOMvfu66ZAr2+cXiyJL6YPVAqN4h/nLa+hVeZmZ
         osstCaydUGuGaletGlis/X8i9MR3JDEUcdTkkRdOxKYfH4vdMcD6c8kqRIcQxGE9Ecxy
         2iiVXHpenoYxZdXb7T1Hwm/qEvMsi4y2mLCo+rFVj1X1jDpFa4QiGf/AlXGeMnb3tvf2
         jPKeMUK1+Ujm5xBXKqEBTfTGkRpW1nUpKo6m3sbaWnSAFCRbf3C6ehkybxfHgNqA/CLe
         9xxQ==
X-Gm-Message-State: AC+VfDyjJYh7htKIlNXb/bcz1J1ng+fdcWXLotX7z8bpANEdubWHCs11
        ahCB680qpX4oBnVF+OCQsLnjSA==
X-Google-Smtp-Source: ACHHUZ58EvoPYuC5nZs66WOAPONtdHAb797/8fHYHvmBuwVELAHZs9tvGj3wF0mebUj5GAurl5ARmg==
X-Received: by 2002:a1c:7215:0:b0:3f7:dfdf:36ce with SMTP id n21-20020a1c7215000000b003f7dfdf36cemr6877223wmc.9.1686135396566;
        Wed, 07 Jun 2023 03:56:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:36 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:25 +0200
Subject: [PATCH 14/18] clk: meson: aoclk: move bindings include to main
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-14-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4058;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FAGqTS28vY4TA8ryV7GfqsaTq2wyyajQNS171oDhvXo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJT+mKi8cd1UlKPoKTBHBSQhYVzjPlpEaF7dsBc
 atUX7ZmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiUwAKCRB33NvayMhJ0S+YEA
 Ck1hq8jC1gcmtNViGR6dPVN0ot4jPzoiBmbWPOkJgGCzgXNbmuAhra566hDE+YEFexOU60REdOTyI1
 UkP/WerO+WdJTCK47r/kS7iouqLxYltUmujw5wlSNwuRgjG6NGC3fcS0MUjbfsONZhFexZjr1NM+uS
 H1+lVf+91M4wWUl8enMgPxsYEqqS7Hq3Al6/ALJUkjVN/Y4oaSH+vHZ55h46b+7jJZvNUTBUmclED9
 Tq3oJ6BY+uVCNDeCkdBR5dVZZwgIes2Acm2MUHpHUmrHsR4mhkm4EYef0PTYMqljjn8QevUw0cn87V
 DySnXu20dOFsiUqhfwXJnNPKuW7dnNOWTpi7NOnFVoUt5094la/m4ihv9zJZ/LW7pD06n1bJDZvHmA
 Rgy5xSbute20oPer2lBsx1R4j519ZmZ4uhHB9jgJAvcI9jF8u/eXkFdIFp0vhgALBSbp64j8jfDu8H
 29g5a387liydAp1qmmM2gmn+Hl1M5dFP2Yw9eciMqbatZVw5tlzVnIFUznW4KT+19Y7TUGa0J+v054
 jJsmav68gNlK1kelh8j2wYozuW15TiNJh5BO8jI1GWQqgajCAYX60uUDX+Z4g5u3GVLiSCYlsDTgii
 ew7XaAlaSEVEeHSZCTxxeNn7YsIThHmjYu16If/Hco2qzh6vpv31TYzFCtIw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the clock ids are no more defined in private headers,
cleanup and include the dt-bindings headers from the main
driver file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/axg-aoclk.c  |  4 +++-
 drivers/clk/meson/axg-aoclk.h  | 16 ----------------
 drivers/clk/meson/g12a-aoclk.c |  4 +++-
 drivers/clk/meson/g12a-aoclk.h | 13 -------------
 drivers/clk/meson/gxbb-aoclk.c |  4 +++-
 drivers/clk/meson/gxbb-aoclk.h | 13 -------------
 6 files changed, 9 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index db5b53146bcc..fb470459aaf8 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -14,11 +14,13 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include "meson-aoclk.h"
-#include "axg-aoclk.h"
 
 #include "clk-regmap.h"
 #include "clk-dualdiv.h"
 
+#include <dt-bindings/clock/axg-aoclkc.h>
+#include <dt-bindings/reset/axg-aoclkc.h>
+
 /*
  * AO Configuration Clock registers offsets
  * Register offsets from the data sheet must be multiplied by 4.
diff --git a/drivers/clk/meson/axg-aoclk.h b/drivers/clk/meson/axg-aoclk.h
deleted file mode 100644
index fe23dc53aa73..000000000000
--- a/drivers/clk/meson/axg-aoclk.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * Copyright (c) 2017 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Copyright (c) 2018 Amlogic, inc.
- * Author: Qiufang Dai <qiufang.dai@amlogic.com>
- */
-
-#ifndef __AXG_AOCLKC_H
-#define __AXG_AOCLKC_H
-
-#include <dt-bindings/clock/axg-aoclkc.h>
-#include <dt-bindings/reset/axg-aoclkc.h>
-
-#endif /* __AXG_AOCLKC_H */
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index 52501ec709f7..392e1805f1c8 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -14,11 +14,13 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include "meson-aoclk.h"
-#include "g12a-aoclk.h"
 
 #include "clk-regmap.h"
 #include "clk-dualdiv.h"
 
+#include <dt-bindings/clock/g12a-aoclkc.h>
+#include <dt-bindings/reset/g12a-aoclkc.h>
+
 /*
  * AO Configuration Clock registers offsets
  * Register offsets from the data sheet must be multiplied by 4.
diff --git a/drivers/clk/meson/g12a-aoclk.h b/drivers/clk/meson/g12a-aoclk.h
deleted file mode 100644
index 9d6eeb24ae0c..000000000000
--- a/drivers/clk/meson/g12a-aoclk.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * Copyright (c) 2019 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef __G12A_AOCLKC_H
-#define __G12A_AOCLKC_H
-
-#include <dt-bindings/clock/g12a-aoclkc.h>
-#include <dt-bindings/reset/g12a-aoclkc.h>
-
-#endif /* __G12A_AOCLKC_H */
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index b08f60f5a73d..f3723c0d6a01 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -7,11 +7,13 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include "meson-aoclk.h"
-#include "gxbb-aoclk.h"
 
 #include "clk-regmap.h"
 #include "clk-dualdiv.h"
 
+#include <dt-bindings/clock/gxbb-aoclkc.h>
+#include <dt-bindings/reset/gxbb-aoclkc.h>
+
 /* AO Configuration Clock registers offsets */
 #define AO_RTI_PWR_CNTL_REG1	0x0c
 #define AO_RTI_PWR_CNTL_REG0	0x10
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
deleted file mode 100644
index 94197b957512..000000000000
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2017 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef __GXBB_AOCLKC_H
-#define __GXBB_AOCLKC_H
-
-#include <dt-bindings/clock/gxbb-aoclkc.h>
-#include <dt-bindings/reset/gxbb-aoclkc.h>
-
-#endif /* __GXBB_AOCLKC_H */

-- 
2.34.1

