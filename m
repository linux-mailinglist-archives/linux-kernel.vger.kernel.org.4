Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3809E6C2923
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCUE0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUE0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:26:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9926587;
        Mon, 20 Mar 2023 21:26:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cn12so9269400edb.4;
        Mon, 20 Mar 2023 21:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679372807;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7LU1YRsXhbsqmPzCrst4NJ9fxlJXbbFdC3pa6Aj3+g=;
        b=KgpA/xvxWtTEC+5M243SNSSdQ/sR5n8aNFQoCvZB980MdYygUQ3vXzNPhDGv+OEZHU
         dJ8Vz0raQjqD76uK2yidCiOhvAH8/mLJrnkDZMFlCWLuWkWS7J0OVpyXsuxUwsg0nuMn
         5yLRwbKNtmjoBK2L/3peR99Cl76PmC+Fpb5ZUUdHMHzmA858hwdrTIx6GHngMZlTKFx3
         ryOsDFwKGAa/5fIw+vXxDPfSFz71jBUWNJb2wTnNW5NcqmIa3yZHq8ZpfTs4Y45x5qOq
         qWbb6fMfAJsDFbdSFWpvnCvD2eiiiZTwTwmkMcX3/L3P8nXQsZwpgsB6ZsisfNzJCIkj
         V8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679372807;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7LU1YRsXhbsqmPzCrst4NJ9fxlJXbbFdC3pa6Aj3+g=;
        b=B1Ejq/aL7P/XXaMLTU8Cr3wEwp7N4g/mHd8z6rvq8u5zoclkr10+NNgbhue8XBLWyc
         quHLcqzkCZF9se2my7p2fpHY3/O7fhseb6KQSnPb9nA1Xqx5IsAOqcxuRp4bTjuzAA6G
         d5rJXFZs4lIMsjKKbUH3/ByGa5QylW7PN1/EqXzfZUBIusadteIEBiJP+oXcUZS0A8Tg
         xnw2/jLynVh7IkXxP5IBqjlXP4kdDztWYQ7ri/h58X/MuHnbnJ5bMThnjWk7oTVpC2//
         6a5TupnXKw28p9vdiyekArgZ8o0sHGgsLgb8U9xM34MyY6QPhQgjCFyeRCV8KDMdG3RR
         bWBw==
X-Gm-Message-State: AO0yUKViqCEjX9jI/g9Au6ioYWZP0kM3tBgr2AngXo97GZILeeO//UXl
        Qug2sXJ/1ZHSSQfgAbMpHholUSOwY95Sww==
X-Google-Smtp-Source: AK7set/w/ExYAxonQFR20l6IlWAqcYeWwQuLWKpIzZRcDzIPrF57OQOXOYBsPxDLANdchya0fH5i5A==
X-Received: by 2002:a17:906:5e43:b0:932:4990:2563 with SMTP id b3-20020a1709065e4300b0093249902563mr1496687eju.24.1679372807043;
        Mon, 20 Mar 2023 21:26:47 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:6c2c:25d2:96b3:40e6])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906961100b009316783c92csm5290434ejx.12.2023.03.20.21.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 21:26:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Owen Chen <owen.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] clk: mediatek: Remove unused configs with COMMON_CLK_MT6765 prefix
Date:   Tue, 21 Mar 2023 05:26:41 +0100
Message-Id: <20230321042641.21592-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support") adds
fourteen configs with COMMON_CLK_MT6765 prefix, but only uses seven of them
to configure inclusion of drivers.

Remove the seven unused COMMON_CLK_MT6765 configs.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/clk/mediatek/Kconfig | 42 ------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 2d14855dd37e..ec87762bfb18 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -144,12 +144,6 @@ config COMMON_CLK_MT6765_CAMSYS
        help
          This driver supports MediaTek MT6765 camsys clocks.
 
-config COMMON_CLK_MT6765_GCESYS
-       bool "Clock driver for MediaTek MT6765 gcesys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 gcesys clocks.
-
 config COMMON_CLK_MT6765_MMSYS
        bool "Clock driver for MediaTek MT6765 mmsys"
        depends on COMMON_CLK_MT6765
@@ -168,48 +162,12 @@ config COMMON_CLK_MT6765_VCODECSYS
        help
          This driver supports MediaTek MT6765 vcodecsys clocks.
 
-config COMMON_CLK_MT6765_MFGSYS
-       bool "Clock driver for MediaTek MT6765 mfgsys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mfgsys clocks.
-
 config COMMON_CLK_MT6765_MIPI0ASYS
        bool "Clock driver for MediaTek MT6765 mipi0asys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi0asys clocks.
 
-config COMMON_CLK_MT6765_MIPI0BSYS
-       bool "Clock driver for MediaTek MT6765 mipi0bsys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mipi0bsys clocks.
-
-config COMMON_CLK_MT6765_MIPI1ASYS
-       bool "Clock driver for MediaTek MT6765 mipi1asys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mipi1asys clocks.
-
-config COMMON_CLK_MT6765_MIPI1BSYS
-       bool "Clock driver for MediaTek MT6765 mipi1bsys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mipi1bsys clocks.
-
-config COMMON_CLK_MT6765_MIPI2ASYS
-       bool "Clock driver for MediaTek MT6765 mipi2asys"
-       depends on COMMON_CLK_MT6765
-      help
-         This driver supports MediaTek MT6765 mipi2asys clocks.
-
-config COMMON_CLK_MT6765_MIPI2BSYS
-       bool "Clock driver for MediaTek MT6765 mipi2bsys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mipi2bsys clocks.
-
 config COMMON_CLK_MT6779
 	tristate "Clock driver for MediaTek MT6779"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
-- 
2.17.1

