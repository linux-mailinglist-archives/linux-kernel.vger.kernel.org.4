Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD65F975F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJJEXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiJJEXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:23:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4A5141B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:22:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l4so9336652plb.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 21:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/Vb8/Qi3Qrtb7eH308lY42+cFyKVOa2Ko/edp/2v7Y=;
        b=PJl4mFGBWUCrLZreJMEzvfznQiOC/tpsDg/+08v3ix0Ud5tt6PNBq0nBlTSiO0YJ46
         JIwhPdjl/rx0SzoBQInc1iFxLsQa3LjyqKwsKZn1AX/cpigZt2o9wiTiP2aAMoMM17Qu
         k1l51KLHhqi23QtBMEnCupiffWk+ZNsy6EOuvND53Q8oA8sUJOqOdZAcCv06dbPu2IAR
         ONFOJuKdmhrqwzYQzWknXB6cbjTGZ5as5vAkQTj8M8Ap6Uxi6H49ISUR2JHKPWGCYU99
         mFAtScgGKoHmfqlTB4X6ts6LdKWTY1U8xDw5zwXR83OBRUnF0T4lTd5VhUgjnVe4YrLw
         Hu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/Vb8/Qi3Qrtb7eH308lY42+cFyKVOa2Ko/edp/2v7Y=;
        b=lLuv2mS8+g3ff2x2WSlE5xfo6slgBZeUMSzhWMUkN0Bq8bF4pWCqIrSsuOHeigteA5
         E7pFPRqQxFSTukw7UdHaXugrDtQyp0biKOJkmQ7eMbNh9QRl4kVd79mrXj96IMTXEntq
         Rt5nmBMEqsx+pPLiV7ijzM7/KNpBKNFzLhSnNUJqOBoX26aD52ndDjsXDQrkBKbkO1ri
         FaJyy1qpTeherOhtGAD6rbhWgiHB7vbzLPEG8azI0eGgNIc66LdZy5GI5RPX0mX1iOI9
         wOae1q/M6P2CA8ck3ldCM4THnPSHxMz/W60y0ImKetBfpLdk4mmoP1y3RMBI+JPN4T2T
         VwXQ==
X-Gm-Message-State: ACrzQf2RbBcXrKYcofEyvTYD39t2DzCEM8/yI9n00C9DS5OWy3sMZE52
        wErcD3XqmU7SUVUCu6FfFzttBA==
X-Google-Smtp-Source: AMsMyM7O83K9ENPPV2OKiyYBCXVe0Mh4UCFtMVcfhPOrNfnvPDeTZxJHkz7WbVWxnaJIu64/6k8SXQ==
X-Received: by 2002:a17:90b:4f4d:b0:20d:2225:4275 with SMTP id pj13-20020a17090b4f4d00b0020d22254275mr9141922pjb.191.1665375778778;
        Sun, 09 Oct 2022 21:22:58 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id c8-20020a17090a020800b0020a1f091a0asm7019607pjc.55.2022.10.09.21.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 21:22:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH] clk: spear: Move prototype to accessible header
Date:   Mon, 10 Oct 2022 09:52:37 +0530
Message-Id: <f334e8bcc22fde795de9c8067898d4c0522d44ae.1665375739.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/spear/spear6xx_clock.c:116:13: warning: no previous prototype for function 'spear6xx_clk_init' [-Wmissing-prototypes]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-spear/generic.h      |  3 ---
 arch/arm/mach-spear/spear3xx.c     |  1 +
 arch/arm/mach-spear/spear6xx.c     |  1 +
 drivers/clk/spear/spear3xx_clock.c |  1 +
 drivers/clk/spear/spear6xx_clock.c |  1 +
 include/linux/clk/spear.h          | 14 ++++++++++++++
 6 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index 43b7996ab754..9e36920d4cfd 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -25,11 +25,8 @@ extern struct pl022_ssp_controller pl022_plat_data;
 extern struct pl08x_platform_data pl080_plat_data;
 
 void __init spear_setup_of_timer(void);
-void __init spear3xx_clk_init(void __iomem *misc_base,
-			      void __iomem *soc_config_base);
 void __init spear3xx_map_io(void);
 void __init spear3xx_dt_init_irq(void);
-void __init spear6xx_clk_init(void __iomem *misc_base);
 void __init spear13xx_map_io(void);
 void __init spear13xx_l2x0_init(void);
 
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index 2ba406e92c41..7ef9670d3029 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -13,6 +13,7 @@
 #include <linux/amba/pl022.h>
 #include <linux/amba/pl080.h>
 #include <linux/clk.h>
+#include <linux/clk/spear.h>
 #include <linux/io.h>
 #include <asm/mach/map.h>
 #include "pl080.h"
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index 7a5fff134872..f0a1e704cceb 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -12,6 +12,7 @@
 
 #include <linux/amba/pl08x.h>
 #include <linux/clk.h>
+#include <linux/clk/spear.h>
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index 41717ff707f6..ba8791303156 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/clk/spear.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index 490701ac9e93..c192a9141b86 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clkdev.h>
+#include <linux/clk/spear.h>
 #include <linux/io.h>
 #include <linux/spinlock_types.h>
 #include "clk.h"
diff --git a/include/linux/clk/spear.h b/include/linux/clk/spear.h
index a64d034ceddd..eaf95ca656f8 100644
--- a/include/linux/clk/spear.h
+++ b/include/linux/clk/spear.h
@@ -8,6 +8,20 @@
 #ifndef __LINUX_CLK_SPEAR_H
 #define __LINUX_CLK_SPEAR_H
 
+#ifdef CONFIG_ARCH_SPEAR3XX
+void __init spear3xx_clk_init(void __iomem *misc_base,
+			      void __iomem *soc_config_base);
+#else
+static inline void __init spear3xx_clk_init(void __iomem *misc_base,
+					    void __iomem *soc_config_base) {}
+#endif
+
+#ifdef CONFIG_ARCH_SPEAR6XX
+void __init spear6xx_clk_init(void __iomem *misc_base);
+#else
+static inline void __init spear6xx_clk_init(void __iomem *misc_base) {}
+#endif
+
 #ifdef CONFIG_MACH_SPEAR1310
 void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base);
 #else
-- 
2.31.1.272.g89b43f80a514

