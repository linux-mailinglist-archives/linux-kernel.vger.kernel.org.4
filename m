Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAD272BF16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjFLKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjFLKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:32:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE55B97
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:13:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so4718967e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564733; x=1689156733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cygOskfWXusdpGUAH4VtoxUGPB85ArQ0tIqjq+ZLZMY=;
        b=nl7JMCr8BC5TQdkD3zaWCL9Fk0CvUq2xGSEoXqV6GV6l5GGQmqiXOYHMWdaHDnQPQM
         omG74RnzO8AVy28bLzrIwcNaOhiH+tr7rWn+Y77LPmpFxfx9AwR2ZIlCropuirw/S/L2
         aByHF6sFeJGCLXO3VI+FPDGyG+23/iHGH/ykL6g1MNigTPUX5e0FDxNQmW8L70vNecOV
         45y1571jLVr2sq0mMJZcdpWuGQKyLArrD1c8Rn0oTGySYuL7tJIc/Rvntaa/SFWpxTli
         2Xhzli5CojJxtxVtyyDE15SbE9UR76kjXoWTfxAatne89bAi18HSz2BkUSeRBNa1CmLk
         ifTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564733; x=1689156733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cygOskfWXusdpGUAH4VtoxUGPB85ArQ0tIqjq+ZLZMY=;
        b=WsS313K7soF8zdqO1s4kxMmFOKS27MQGaMZFSRIUzBGHVvC9eA/O3ZVDQyCRaijb2C
         eEgYFLWvvfyHAudXG9z2dWitEgifn9EKe7Oy6g6fc3qVms3tIaqXmeqmuHpnPsDvFclm
         lIi6/XVAaLHoNEjWrqmtGPQIEh7OEz4eaQii/knHoSWel7dEqprJE+fdlG6bpqMNd1R1
         7xRo496kOZOQDG1LSWlv9oU1H3sEid+H/5HP3Gp18bduEfCRotRKU1PgLlQ4t6yuBi2P
         XH26Ymo61zPkaHeBsN6zGFJvpqyOoQm6BqXI79qjEJY0nEE8g0SBeGOdklZSaTBfMbi7
         hmAQ==
X-Gm-Message-State: AC+VfDxbC3yi67kww6dA9F8s3xT/3yvaC/5mJNPeeGmZIZ8eBbixFOyR
        WPXsw57KUvX/JzseCDuX4epOsD82j5ThKF1xGtvsLA==
X-Google-Smtp-Source: ACHHUZ7YJy6tu64K5FLHKVS3lhMDWbGs93kRlOXDyiti2Ma8AlEo3Y2ZfLIxRyzYFy9oFz6bPMdE0A==
X-Received: by 2002:ac2:464d:0:b0:4f4:c972:981f with SMTP id s13-20020ac2464d000000b004f4c972981fmr4263806lfo.54.1686563872398;
        Mon, 12 Jun 2023 02:57:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:35 +0200
Subject: [PATCH v2 18/19] clk: meson: meson8b: move bindings include to
 main driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-18-38172d17c27a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=F+2Srg/4sQPMMfVWsDuv7F9eteW1x3up035F2/YQpfY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwMMKtWPmeip81lFra9k4LHq4SHD3LGAt3P6j/j
 jdneYnqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsDAAKCRB33NvayMhJ0RZEEA
 CcMf271vDPYofqAE6DHXz9RcQGziswp5v8xT6Mn99BRK/QQMOupQGM83aLXYCVC6ytBxzru/RlmkXc
 TOJO/H0UvdEcR8Scu/lq5WnMKwnZm2K0hem9noz1xeaVbz/JKhAr3wTYaV29FskgXXAJFH64gSPC95
 sEip7dRQmFM8ZKQVPqyaJfuIeeJzWozkkBc4XaQj9W50/V6vi1IpsoVlDqxW3qArXCQmUSynyjUWoA
 po8xRZfUB93zbWFNg/sRuaY8Bf66jVt3GH58AAmtco/i/T1Rj07N9E8u3ofq+jq5vtRRvE7cy9yJgq
 aWPWjV/F3Faa3GSuWOEmoc4A/6NdhZyPJNhrBR6cZGPTYdv/DZW4VOp/xdbBcMBuC1V2OBA2qpurnc
 EwMH9fv15V4iJnvBXHPrFJ5mzOVNLgCp4CGpK1EK1bODBQs1igv7A0QxPLEj2MtvTvGY7prfPY90mh
 SRogtVHXhoW188QV/Z2AXsE3QVorpULU+cbvONLbYRMoIeZDBJHyJ+O+5fuKnhNo5IGKhCTKOPSmWs
 bHtKh/KnTr3cBettR6+ekGP1uuxiJLHfFHMJldc50Zt0IxjRi3ouAu8BVezlqjZ6frFsR/OPgj2PLG
 QIGCV2jW63nnMUXK1c3CSoTRZDWBQfh4ZUoe/yK+kt2MB/yonwZtet5G5sWg==
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
 drivers/clk/meson/meson8b.c | 3 +++
 drivers/clk/meson/meson8b.h | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index cea246daea39..b7417ac262d3 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -22,6 +22,9 @@
 #include "clk-pll.h"
 #include "clk-mpll.h"
 
+#include <dt-bindings/clock/meson8b-clkc.h>
+#include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
+
 static DEFINE_SPINLOCK(meson_clk_lock);
 
 struct meson8b_clk_reset {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 2a9c4fe29ca2..a5b6e67eeefb 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -77,11 +77,4 @@
 #define HHI_MPLL_CNTL9			0x2A0 /* 0xa8 offset in data sheet */
 #define HHI_MPLL_CNTL10			0x2A4 /* 0xa9 offset in data sheet */
 
-/*
- * include the CLKID and RESETID that have
- * been made part of the stable DT binding
- */
-#include <dt-bindings/clock/meson8b-clkc.h>
-#include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
-
 #endif /* __MESON8B_H */

-- 
2.34.1

