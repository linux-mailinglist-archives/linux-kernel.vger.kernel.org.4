Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9377474F1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjGKOVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjGKOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:21:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D611734
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fba74870abso8664005e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085269; x=1691677269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RT59kaXTgg5sgTQpdgoEwntc5E3q29hk2GymBQEqefk=;
        b=AQPWUshV2DPhAH6FtxoBop1FDYTgaHN5JKSl2ydch4oMjUqPUez+s5K439puSFRJWR
         thALx5tssRdd+6BSRtAiTazZn9vVi6XzEjh5XXWcjjvz7rZ6huduI81XvhlXuAyQtfdi
         ldRcruREpgzVfKsubvo5h7D2eZxr1L+OuEUzjLeEBjdnNqrnTGwkBGRbf3DbeTSBaov1
         jmYMxMqMcX9zZbC0W24P2e/I2d4sT4KLYVVNXuqUb4gKZ2u9LUyyiFPyFtuBuA4rbfF/
         a8OcHVfd6oPl4aI+Ehc4Wo3RYXEQRJWvS8CX+Bz9trDx+XC5yEwG4EAj//48FgxeWCH4
         3QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085269; x=1691677269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT59kaXTgg5sgTQpdgoEwntc5E3q29hk2GymBQEqefk=;
        b=K+trbZesZLkW9LjLE/EhjGMX9UxTa4GjiypuaZi/t3Q8zBOw9RqiI6Xcecvw37HgC+
         utIXDMl7AfnytuwR/cIIk2K9PGMh1mYcrYCXbC2doRhCPXthC/YBovjioZNO45mYe3xV
         ZojatG2qgwiGn37USEW6EDNiDyg+pkcgw5wTVyef8ClVf/Ct9HIAhzalMP6EufYnK/SP
         m6hatHxnTCMiP4+XDc4chdQn2b1+JyEpKrdYGBWq67dvKs4pCznvFumFHnRyuBcpCFrS
         ddfp5vjPJK8+5GmlqjgNdIaPtNrvxDEiPdMr2s1WgzPYCsO0uiWUTgx4+RYiNuO+XrvR
         OF0A==
X-Gm-Message-State: ABy/qLZpjEIquzBH0a/T8iLkc7oF30lCg8SaafGKZor26dlw4LhBRqFj
        DSCKcG07LjFo89+uDRsHlPKJzQ==
X-Google-Smtp-Source: APBJJlERTWUt1nW1R3qthtM4b3NkqQF+8nog8fJNhfRAzWktGBzBiTc3eX6IscM8Ccgn5kp0ki4mwg==
X-Received: by 2002:ac2:505b:0:b0:4f8:5886:1868 with SMTP id a27-20020ac2505b000000b004f858861868mr12413967lfm.24.1689085268998;
        Tue, 11 Jul 2023 07:21:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m23-20020ac24297000000b004fbdd19c926sm336482lfh.284.2023.07.11.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:08 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 06/18] soc: imx: Move power-domain drivers to the genpd dir
Date:   Tue, 11 Jul 2023 16:21:05 +0200
Message-Id: <20230711142105.751611-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the imx power-domain drivers to the
new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: <kernel@pengutronix.de>
Cc: <linux-imx@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/imx/Makefile                   | 7 +++++++
 drivers/{soc => genpd}/imx/gpc.c             | 0
 drivers/{soc => genpd}/imx/gpcv2.c           | 0
 drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c  | 0
 drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c | 0
 drivers/{soc => genpd}/imx/imx93-blk-ctrl.c  | 0
 drivers/{soc => genpd}/imx/imx93-pd.c        | 0
 drivers/soc/imx/Makefile                     | 7 +------
 8 files changed, 8 insertions(+), 6 deletions(-)
 create mode 100644 drivers/genpd/imx/Makefile
 rename drivers/{soc => genpd}/imx/gpc.c (100%)
 rename drivers/{soc => genpd}/imx/gpcv2.c (100%)
 rename drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-pd.c (100%)

diff --git a/drivers/genpd/imx/Makefile b/drivers/genpd/imx/Makefile
new file mode 100644
index 000000000000..5f012717a666
--- /dev/null
+++ b/drivers/genpd/imx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
+obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
+obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX9) += imx93-pd.o
+obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/gpc.c b/drivers/genpd/imx/gpc.c
similarity index 100%
rename from drivers/soc/imx/gpc.c
rename to drivers/genpd/imx/gpc.c
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/genpd/imx/gpcv2.c
similarity index 100%
rename from drivers/soc/imx/gpcv2.c
rename to drivers/genpd/imx/gpcv2.c
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/genpd/imx/imx8m-blk-ctrl.c
similarity index 100%
rename from drivers/soc/imx/imx8m-blk-ctrl.c
rename to drivers/genpd/imx/imx8m-blk-ctrl.c
diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/genpd/imx/imx8mp-blk-ctrl.c
similarity index 100%
rename from drivers/soc/imx/imx8mp-blk-ctrl.c
rename to drivers/genpd/imx/imx8mp-blk-ctrl.c
diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/genpd/imx/imx93-blk-ctrl.c
similarity index 100%
rename from drivers/soc/imx/imx93-blk-ctrl.c
rename to drivers/genpd/imx/imx93-blk-ctrl.c
diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/genpd/imx/imx93-pd.c
similarity index 100%
rename from drivers/soc/imx/imx93-pd.c
rename to drivers/genpd/imx/imx93-pd.c
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index a28c44a1f16a..3ad321ca608a 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -2,10 +2,5 @@
 ifeq ($(CONFIG_ARM),y)
 obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
-obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
-obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
-obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
-obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
-obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX9) += imx93-src.o
-- 
2.34.1

