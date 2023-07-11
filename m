Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482F674F214
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjGKOXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjGKOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0243910FC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so8951380e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085319; x=1691677319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dddDDU7nSqQ7z9wETDWZtkE1+2CRoXBrxvBW6KLelSM=;
        b=X7oBSxLNSV9eqMcmy3tZzy3/UTRucJkeXs+moEwYFgUXzKNvOU/ipXxS5EPF1AjxfZ
         lEatW99aDKtOCV62zWAmlpWt8rcJdtMJHS3TbN8jv1oCh6gkU8arsr82eiRUbFbBtPiy
         +IBf+qVfHIvze2Z6iiTNGXUm/CwvSWSWJEei+XFTfnCsMyCWdzbDZ9xRQQpGZs3DRK+I
         9aYGx7iT4PT2sGRoHm72wGpSlrIZRo21EPR+nO51HuDcJk26heozy7aqo2O3D/AGNM8d
         UGka7ANjBZAaPPoYvbYKTECKfkBg3bf7rt21P1JSW0AayF6lABLN7+2jYOp1fk8xe5Kh
         ERiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085319; x=1691677319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dddDDU7nSqQ7z9wETDWZtkE1+2CRoXBrxvBW6KLelSM=;
        b=Dxo9ZSSiqNcyg/WlVeI8Mzct9mIIrLXQnqCLZS2A7BbaaIA++ZIjaNh8m56oxk2iJv
         Si5YoXMgPNzgyhNpMuFEpWaGnEseaMy6Pi8JvvWcESPfSTfjMUevgjh9iBS87D4+zNvv
         tnxlhhk8pbTMJQDNKx2ldkKwvLz/JYIf7cKMAPHVtzYCRXqVBXmx4tBCNiDeYV4ShEKi
         Ty87lWF7X7pEuxUPoEZWgDXQIUCxH7abY0aITvqokyV71WxKf55b8wA79MAIYZZkbPiJ
         RvV7trkZdV18byISE6nvxVvMnuUUf4oy7J+KjSN5a9WOaKgZ3EhOVuN/r8+V6mzHh2yk
         JKWA==
X-Gm-Message-State: ABy/qLZtFqBEA0WhKl8vj/JILLtwVIbviGlCe3KGOjpZu8NpWNqYj09I
        Dk147OmKvfA69/SL3mJQkSv5/g==
X-Google-Smtp-Source: APBJJlGUSak0mYQbFyzkK6aQ1G1SAqdalSOyq+vu2t6Gv+qmFZj027l2rjTtVGtmGdzfaHwpmXRLKA==
X-Received: by 2002:a05:6512:31d0:b0:4f8:6d54:72fa with SMTP id j16-20020a05651231d000b004f86d5472famr16089053lfe.2.1689085319398;
        Tue, 11 Jul 2023 07:21:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v23-20020ac25937000000b004fb2c1e33b3sm336375lfi.243.2023.07.11.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 12/18] soc: starfive: Move the power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:21:57 +0200
Message-Id: <20230711142157.751733-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the starfive power-domain driver to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Walker Chen <walker.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                                    | 2 +-
 drivers/genpd/Makefile                                         | 1 +
 drivers/genpd/starfive/Makefile                                | 2 ++
 .../{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} | 0
 drivers/soc/starfive/Makefile                                  | 3 ---
 5 files changed, 4 insertions(+), 4 deletions(-)
 create mode 100644 drivers/genpd/starfive/Makefile
 rename drivers/{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} (100%)
 delete mode 100644 drivers/soc/starfive/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index f444285f1792..4be5dc3fd6dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20323,7 +20323,7 @@ STARFIVE JH71XX PMU CONTROLLER DRIVER
 M:	Walker Chen <walker.chen@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
-F:	drivers/soc/starfive/jh71xx_pmu.c
+F:	drivers/genpd/starfive/jh71xx_pmu.c
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 
 STARFIVE SOC DRIVERS
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 1cf0ff26a44f..baf2021235a7 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -8,3 +8,4 @@ obj-y					+= qcom/
 obj-y					+= renesas/
 obj-y					+= rockchip/
 obj-y					+= samsung/
+obj-y					+= starfive/
diff --git a/drivers/genpd/starfive/Makefile b/drivers/genpd/starfive/Makefile
new file mode 100644
index 000000000000..975bba2a29a9
--- /dev/null
+++ b/drivers/genpd/starfive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_JH71XX_PMU)		+= jh71xx-pmu.o
diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/genpd/starfive/jh71xx-pmu.c
similarity index 100%
rename from drivers/soc/starfive/jh71xx_pmu.c
rename to drivers/genpd/starfive/jh71xx-pmu.c
diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
deleted file mode 100644
index 13b589d6b5f3..000000000000
--- a/drivers/soc/starfive/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_JH71XX_PMU)	+= jh71xx_pmu.o
-- 
2.34.1

