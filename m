Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EE74B284
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjGGOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjGGOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:04:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C101B6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so3146732e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738686; x=1691330686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeh5/DbFBerqxJsBbnsYRr6PKdng0uv/R2Q5wv9639U=;
        b=jGLVwn36CByMCtipg4d4XALkBRUKqWv0R6HZTUXklQUvDJCclxU+zkrJfwUnRo44Qe
         pW2zszr5s3fk0xHaK2wfVsPmyWtLdTYXuKiKvKMKOA06bG0PaUXzAvBNvb8+9Onh2wQ1
         KXLzplmLECGVgtrwD6mmd7fkyHTUKy6kxTcK/V12edvM6fP6tTHaQ1LTTZ0h9Kroy86I
         jAXka0FZW5Y9jTSJ23RUg4fA6UWNK1PtrrzWg+4QF9a1d/WACYvlNPx0YM4os7nNXclf
         dxEhJDmLqgC5UqiNQsKWpF8Wqly/n71ODUYAKiD6dFXtmP5Hm/Md/cb1hKjYE6rZPYWQ
         joDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738686; x=1691330686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeh5/DbFBerqxJsBbnsYRr6PKdng0uv/R2Q5wv9639U=;
        b=BdtcOdM7X8HaSE5RV8jfRmonhIsWU/Z/bBmXcsOeFG458KgfYNplmzYRROqYPEkj6N
         /+LqDXXvutTacxZM+FFpc1CKIKqEOijDbC8x+xuRyshrSttHkwBOsiAhV1woluQlTuTf
         Avm4ps+b52yGt296uvSt9xoCXg4u8GKC8ETagYDSUa/35YEQRpzQuh0euyNcjKjHJ/cE
         O+xXdg6jDTE/ZKNkmisqvh3lBfNohMhnvNJTPOWhBe71z+nGk4fjjaZb3/2qniDXwrUQ
         ByOzggSltIg1EMLsRo3xqd3m8CZQbR7nr6pv1i901jGCWVjGSiXI9raiEi/Ae7QZwp0k
         YIXQ==
X-Gm-Message-State: ABy/qLYg3o73ARRg4T8EdowOQ/b8GBr7Vtg6QNkEtJpn7MzhcT/tTd12
        zpARGkjLsccAe/9vyyj8/bvmkw==
X-Google-Smtp-Source: APBJJlGU4sWqpzDzusqijcw45XQ/FfxTFm8i0SwYKzBkADAqexI/4PhgDGiNTsaHIZds4E4hrP/oDg==
X-Received: by 2002:a05:651c:201:b0:2b6:dbc5:5ca4 with SMTP id y1-20020a05651c020100b002b6dbc55ca4mr3496861ljn.16.1688738686129;
        Fri, 07 Jul 2023 07:04:46 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:45 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the genpd dir
Date:   Fri,  7 Jul 2023 16:04:19 +0200
Message-Id: <20230707140434.723349-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707140434.723349-1-ulf.hansson@linaro.org>
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: <linux-amlogic@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                        | 1 +
 drivers/genpd/Makefile                             | 1 +
 drivers/genpd/amlogic/Makefile                     | 4 ++++
 drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     | 0
 drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c | 0
 drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c | 0
 drivers/soc/Makefile                               | 1 -
 drivers/soc/amlogic/Makefile                       | 3 ---
 8 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 drivers/genpd/amlogic/Makefile
 rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 588769fab516..9b8c9ae2375d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1843,6 +1843,7 @@ F:	Documentation/devicetree/bindings/phy/amlogic*
 F:	arch/arm/boot/dts/amlogic/
 F:	arch/arm/mach-meson/
 F:	arch/arm64/boot/dts/amlogic/
+F:	drivers/genpd/amlogic/
 F:	drivers/mmc/host/meson*
 F:	drivers/phy/amlogic/
 F:	drivers/pinctrl/meson/
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index a2d5b2095915..cdba3b9f0c75 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= actions/
+obj-y					+= amlogic/
diff --git a/drivers/genpd/amlogic/Makefile b/drivers/genpd/amlogic/Makefile
new file mode 100644
index 000000000000..3d58abd574f9
--- /dev/null
+++ b/drivers/genpd/amlogic/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
+obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
+obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/genpd/amlogic/meson-ee-pwrc.c
similarity index 100%
rename from drivers/soc/amlogic/meson-ee-pwrc.c
rename to drivers/genpd/amlogic/meson-ee-pwrc.c
diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
similarity index 100%
rename from drivers/soc/amlogic/meson-gx-pwrc-vpu.c
rename to drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
similarity index 100%
rename from drivers/soc/amlogic/meson-secure-pwrc.c
rename to drivers/genpd/amlogic/meson-secure-pwrc.c
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c8..dc93e1762ca7 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -23,7 +23,6 @@ obj-y				+= mediatek/
 obj-y				+= microchip/
 obj-y				+= nuvoton/
 obj-y				+= pxa/
-obj-y				+= amlogic/
 obj-y				+= qcom/
 obj-y				+= renesas/
 obj-y				+= rockchip/
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
index 7b8c5d323f5c..c25f835e6a26 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -2,7 +2,4 @@
 obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
 obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
 obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
-obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
-obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
-obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
-- 
2.34.1

