Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC86272BEAA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjFLKTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjFLKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:18:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAEF229D8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:59:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so29625255e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563869; x=1689155869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGABTIXJEtrcII94q40tWwhEkxspimjWoq0DU0S3sQs=;
        b=XOODmW8kd46QALhCoYdKYz0ZKb7h3AW4QLpNC4PvWgdPexSuKGLgDMfq6Uf0DuqcB6
         XlhqBXdMxtmM8lkda8/RpXydmtwagf1e3bqIwxuH8it8Q7pTPbf8p8KkP889fFFlhyy9
         V/IvwrNYPyKmQizdw3wvQnbGoTjaKwOCxnVczbDSbsnmAmIgPe0Wq24EHS6+wEbkFKa5
         Rvzlgq/y+95wkWqDQqkh2r4Ppp2tWF7/kTy4hYETkYsUTxfOXT7vyUtU3JY6/NKdCnxn
         InA61VnTUYBVSpkptW642pAXhprzAG8YzIZxynEqCngjP/SP+wc2uihoN5EsfhY0uJcR
         dXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563869; x=1689155869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGABTIXJEtrcII94q40tWwhEkxspimjWoq0DU0S3sQs=;
        b=W60ZKqJQtsg8/85+h4XZ7dhcJWhoIuq0vpMQD/HqApg/d9y9fWwctyzXa9UrE3aBuJ
         FMWdxb77feype11Qb5u1nwPR5tspSTmzwoOzjKy03TH4musNDL4usYasqjbfsXPWz1p7
         YhvFT5qcY38ur0MdmCB00ZGZ/5LgCOhK5PjTLb44Bt2boXadBLzxwfHvHnL2uViW9hdi
         thAzpTT1N/GFZRxS58lNf++SBlMYvdRR/++QJENJcm2T89ktwfnM9ar4oL6aBeS+w7zl
         Rii8VJqC4CtR59VCsQZiQ02zQ/qrInTw4fyUpPKnbKKpD857hPgjfsENreqpwaD5edzV
         D9eg==
X-Gm-Message-State: AC+VfDyo0VZwtKsKEzJAqiiMHVUizNteKQHg59Prr88DKZ+NJNv3sx91
        4+Edp74uaus7sZWCgtkfSXjFKg==
X-Google-Smtp-Source: ACHHUZ4pZ0mAWfvZT49ejf6jbqhwr+jGyAu7ETXbQsaAdq/C6mOxVunIkRCgPgo8t2VOaLdrt7GYTw==
X-Received: by 2002:a05:600c:ad7:b0:3f7:e6d8:457b with SMTP id c23-20020a05600c0ad700b003f7e6d8457bmr5751929wmr.19.1686563869321;
        Mon, 12 Jun 2023 02:57:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:48 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:32 +0200
Subject: [PATCH v2 15/19] clk: meson: aoclk: move bindings include to main
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-15-38172d17c27a@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
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
 bh=bOuyCBL0/AIXLX6hiE6zgLeDwAQJVgePg34gNgzB9JA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwLupPz9Q3hz6kaxIoBFQCEnvf4lduKXuGyeD33
 3BA5LuaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsCwAKCRB33NvayMhJ0SjXD/
 9kmLr4iXPfj7lRWIz4mwsE+ANIVosQTKAhRXXbYmgrJ+BRF1RgJPe3oj1hnO1pa38i9wRUKDrhCfyq
 sWdgdtn6O5PaXx9OiW0b+8tBzaJ5U8VS62/1A9UEP7cvorPIa/pzokswHLZjoHMzxKgFc9/gdZ3Dgj
 oLCysB01wxopAK5ohMRqOfW1QUP50PsgMWSrsawcUZpnWqHmcyQC8yUAR12/6U5xkL5AQS/KH1RAJR
 ZPOB9/Lo+memVg7zp5QdzmV1HDLp5Lnp9k/UQOT3MUlI1YmIoUPcilWJeO4/ye9c6JPzzVxRLedxyt
 p7LjzyHrwsxIbAi6fG0RZLj6TN0FA/9DNcBuMgccJwIwJrgtJTfkAzuR5CYP9QRebSiFmrwwn1rj8b
 cAoMXJ9TYTTe6ApvLHqHvgvdBYdVOwRpwxgY3YD13ZtIIekJ562OreduBX3JzJ0AJTWMHI/Sss5k5d
 0EQl1tBnkXmE5PfahVIsDXJBUoibWqdv1HafMUHJvf8tEE50OgyXX/n8LipSDEh4vR1CuEqEnO4IEY
 Z7ArwZN95IBdUz4L/XiHfoU2TcWh/+CSW3t6UPRaZ5BbJ8Hb2IzhBzW7Nk4eaBMBQaz/MRepm/ePC0
 lYaUGxbSGFzpPtVwx7eKvcLnbt/cJNq9xdNDuMRGzkWXy/XDoy2aNUEy3Q5Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 2d1dad8657e0..8f42ae899175 100644
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
index 9b258c1bc2d1..6213b3e26318 100644
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
index 736c35d126f5..d7f7dc81fa6d 100644
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

