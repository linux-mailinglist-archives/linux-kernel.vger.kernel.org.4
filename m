Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5364B5E5B58
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIVGY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIVGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:24:49 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99096773
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1663827885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UNXvlVjo187MWu3yoYckcXbqqs1lHNuMO52iCAYBAu8=;
        b=HeU/+iAQT4AlpAMlWs5EXIZiSC+ZHVlKuMfMaodXlfEtFevPvWtkb4dHTYu+6tnDymJSjB
        7nAlm41LbY6I3XWrzAb//QUn9tCCbY9xkaPahmjiBdTM4BXIeD3RgBl3HQ3OKmG417PUuY
        KWmzWxNXHqOcrXMsctrNuMgez53MzsxC0de5Z07Xl7LqdZj1SaIKp+wsaIBHFQ9gfMZhJo
        dq2vZGrIurRcbO/H/PQnBbyJSLPgFHDjcij0HpbTN8/2atWnKXSZoz0tRrPX7M/7TG5NaT
        JoucmrMMnTg6Xzdr5zuDvDE9sEeb2ptKgvAH4wLkqSuXz/zXWiliAmx3gtBruQ==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-629-2yNlZNWuNEazlUbytXX5-w-1; Thu, 22 Sep 2022 02:24:43 -0400
X-MC-Unique: 2yNlZNWuNEazlUbytXX5-w-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 21 Sep 2022 23:24:39 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH RESEND v2 1/5] clk: mxl: Switch from direct readl/writel based IO to regmap based IO
Date:   Thu, 22 Sep 2022 14:24:24 +0800
Message-ID: <4c56443ecd9041f102681ebf36b6854090ab82e3.1663827071.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663827071.git.rtanwar@maxlinear.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier version of driver used direct io remapped register read
writes using readl/writel. But we need secure boot access which
is only possible when registers are read & written using regmap.
This is because the security bus/hook is written & coupled only
with regmap layer.

Switch the driver from direct readl/writel based register accesses
to regmap based register accesses.

Additionally, update the license headers to latest status.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 drivers/clk/x86/Kconfig       |  5 +++--
 drivers/clk/x86/clk-cgu-pll.c | 10 +++++----
 drivers/clk/x86/clk-cgu.c     |  5 +++--
 drivers/clk/x86/clk-cgu.h     | 38 +++++++++++++++++++----------------
 drivers/clk/x86/clk-lgm.c     | 13 ++++++++----
 5 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/x86/Kconfig b/drivers/clk/x86/Kconfig
index 69642e15fcc1..ced99e082e3d 100644
--- a/drivers/clk/x86/Kconfig
+++ b/drivers/clk/x86/Kconfig
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config CLK_LGM_CGU
 =09depends on OF && HAS_IOMEM && (X86 || COMPILE_TEST)
+=09select MFD_SYSCON
 =09select OF_EARLY_FLATTREE
 =09bool "Clock driver for Lightning Mountain(LGM) platform"
 =09help
-=09  Clock Generation Unit(CGU) driver for Intel Lightning Mountain(LGM)
-=09  network processor SoC.
+=09  Clock Generation Unit(CGU) driver for MaxLinear's x86 based
+=09  Lightning Mountain(LGM) network processor SoC.
diff --git a/drivers/clk/x86/clk-cgu-pll.c b/drivers/clk/x86/clk-cgu-pll.c
index 3179557b5f78..c83083affe88 100644
--- a/drivers/clk/x86/clk-cgu-pll.c
+++ b/drivers/clk/x86/clk-cgu-pll.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2020-2022 MaxLinear, Inc.
  * Copyright (C) 2020 Intel Corporation.
- * Zhu YiXin <yixin.zhu@intel.com>
- * Rahul Tanwar <rahul.tanwar@intel.com>
+ * Zhu Yixin <yzhu@maxlinear.com>
+ * Rahul Tanwar <rtanwar@maxlinear.com>
  */
=20
 #include <linux/clk-provider.h>
@@ -76,8 +77,9 @@ static int lgm_pll_enable(struct clk_hw *hw)
=20
 =09spin_lock_irqsave(&pll->lock, flags);
 =09lgm_set_clk_val(pll->membase, pll->reg, 0, 1, 1);
-=09ret =3D readl_poll_timeout_atomic(pll->membase + pll->reg,
-=09=09=09=09=09val, (val & 0x1), 1, 100);
+=09ret =3D regmap_read_poll_timeout_atomic(pll->membase, pll->reg,
+=09=09=09=09=09      val, (val & 0x1), 1, 100);
+
 =09spin_unlock_irqrestore(&pll->lock, flags);
=20
 =09return ret;
diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index 33de600e0c38..f5f30a18f486 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2020-2022 MaxLinear, Inc.
  * Copyright (C) 2020 Intel Corporation.
- * Zhu YiXin <yixin.zhu@intel.com>
- * Rahul Tanwar <rahul.tanwar@intel.com>
+ * Zhu Yixin <yzhu@maxlinear.com>
+ * Rahul Tanwar <rtanwar@maxlinear.com>
  */
 #include <linux/clk-provider.h>
 #include <linux/device.h>
diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
index 4e22bfb22312..dbcb66468797 100644
--- a/drivers/clk/x86/clk-cgu.h
+++ b/drivers/clk/x86/clk-cgu.h
@@ -1,18 +1,19 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright(c) 2020 Intel Corporation.
- * Zhu YiXin <yixin.zhu@intel.com>
- * Rahul Tanwar <rahul.tanwar@intel.com>
+ * Copyright (C) 2020-2022 MaxLinear, Inc.
+ * Copyright (C) 2020 Intel Corporation.
+ * Zhu Yixin <yzhu@maxlinear.com>
+ * Rahul Tanwar <rtanwar@maxlinear.com>
  */
=20
 #ifndef __CLK_CGU_H
 #define __CLK_CGU_H
=20
-#include <linux/io.h>
+#include <linux/regmap.h>
=20
 struct lgm_clk_mux {
 =09struct clk_hw hw;
-=09void __iomem *membase;
+=09struct regmap *membase;
 =09unsigned int reg;
 =09u8 shift;
 =09u8 width;
@@ -22,7 +23,7 @@ struct lgm_clk_mux {
=20
 struct lgm_clk_divider {
 =09struct clk_hw hw;
-=09void __iomem *membase;
+=09struct regmap *membase;
 =09unsigned int reg;
 =09u8 shift;
 =09u8 width;
@@ -35,7 +36,7 @@ struct lgm_clk_divider {
=20
 struct lgm_clk_ddiv {
 =09struct clk_hw hw;
-=09void __iomem *membase;
+=09struct regmap *membase;
 =09unsigned int reg;
 =09u8 shift0;
 =09u8 width0;
@@ -53,7 +54,7 @@ struct lgm_clk_ddiv {
=20
 struct lgm_clk_gate {
 =09struct clk_hw hw;
-=09void __iomem *membase;
+=09struct regmap *membase;
 =09unsigned int reg;
 =09u8 shift;
 =09unsigned long flags;
@@ -77,7 +78,7 @@ enum lgm_clk_type {
  * @clk_data: array of hw clocks and clk number.
  */
 struct lgm_clk_provider {
-=09void __iomem *membase;
+=09struct regmap *membase;
 =09struct device_node *np;
 =09struct device *dev;
 =09struct clk_hw_onecell_data clk_data;
@@ -92,7 +93,7 @@ enum pll_type {
=20
 struct lgm_clk_pll {
 =09struct clk_hw hw;
-=09void __iomem *membase;
+=09struct regmap *membase;
 =09unsigned int reg;
 =09unsigned long flags;
 =09enum pll_type type;
@@ -300,29 +301,32 @@ struct lgm_clk_branch {
 =09=09.div =3D _d,=09=09=09=09=09\
 =09}
=20
-static inline void lgm_set_clk_val(void __iomem *membase, u32 reg,
+static inline void lgm_set_clk_val(struct regmap *membase, u32 reg,
 =09=09=09=09   u8 shift, u8 width, u32 set_val)
 {
 =09u32 mask =3D (GENMASK(width - 1, 0) << shift);
-=09u32 regval;
=20
-=09regval =3D readl(membase + reg);
-=09regval =3D (regval & ~mask) | ((set_val << shift) & mask);
-=09writel(regval, membase + reg);
+=09regmap_update_bits(membase, reg, mask, set_val << shift);
 }
=20
-static inline u32 lgm_get_clk_val(void __iomem *membase, u32 reg,
+static inline u32 lgm_get_clk_val(struct regmap *membase, u32 reg,
 =09=09=09=09  u8 shift, u8 width)
 {
 =09u32 mask =3D (GENMASK(width - 1, 0) << shift);
 =09u32 val;
=20
-=09val =3D readl(membase + reg);
+=09if (regmap_read(membase, reg, &val)) {
+=09=09WARN_ONCE(1, "Failed to read clk reg: 0x%x\n", reg);
+=09=09return 0;
+=09}
+
 =09val =3D (val & mask) >> shift;
=20
 =09return val;
 }
=20
+
+
 int lgm_clk_register_branches(struct lgm_clk_provider *ctx,
 =09=09=09      const struct lgm_clk_branch *list,
 =09=09=09      unsigned int nr_clk);
diff --git a/drivers/clk/x86/clk-lgm.c b/drivers/clk/x86/clk-lgm.c
index 020f4e83a5cc..4fa2bcaf71c8 100644
--- a/drivers/clk/x86/clk-lgm.c
+++ b/drivers/clk/x86/clk-lgm.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2020-2022 MaxLinear, Inc.
  * Copyright (C) 2020 Intel Corporation.
- * Zhu YiXin <yixin.zhu@intel.com>
- * Rahul Tanwar <rahul.tanwar@intel.com>
+ * Zhu Yixin <yzhu@maxlinear.com>
+ * Rahul Tanwar <rtanwar@maxlinear.com>
  */
 #include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/intel,lgm-clk.h>
@@ -433,9 +435,12 @@ static int lgm_cgu_probe(struct platform_device *pdev)
=20
 =09ctx->clk_data.num =3D CLK_NR_CLKS;
=20
-=09ctx->membase =3D devm_platform_ioremap_resource(pdev, 0);
-=09if (IS_ERR(ctx->membase))
+=09ctx->membase =3D syscon_node_to_regmap(np);
+=09if (IS_ERR_OR_NULL(ctx->membase)) {
+=09=09dev_err(dev, "Failed to get clk CGU iomem\n");
 =09=09return PTR_ERR(ctx->membase);
+=09}
+
=20
 =09ctx->np =3D np;
 =09ctx->dev =3D dev;
--=20
2.17.1

