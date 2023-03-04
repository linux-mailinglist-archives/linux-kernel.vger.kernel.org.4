Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C596AA867
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 07:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCDGgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 01:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCDGgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 01:36:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F35B5D4;
        Fri,  3 Mar 2023 22:35:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so8351997pjh.0;
        Fri, 03 Mar 2023 22:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677911753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGsqutyALv7zzkKlKZSw6z7zA7BQ8DDsuhwdYZVmVZE=;
        b=IYIzTm1mKXIlkTu3zFBDs2TE3iNzgZaIFNGqOZnCuC2GiapOkS8dzDJqvsOGLw2nYH
         Z3J0frXxsUGXcxvFqoe3q+AD9sBBgc7ncWN0db7FcrBdZ8xs/5lxHjc1IDT0Cm/xtauc
         1Gs4QkwSb5EOj5U/bagxDX5a5vsnhvWMdJ8R24yYs19NSTxpI/eyanVl8z2FeklCG+wW
         i+ClpT91mzYGf4hFVG+B0za4ZJuiO0tRka4kgXheS1U+xUHK3lJ6bez6X1Wbl1tQJm8G
         VE5mD/eYIdsuh/Pc0H5iupSNnWopz3pQRsVkSqtBuNjZpw1NcI+AZMpAPg8UnQjEt2US
         Dqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677911753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGsqutyALv7zzkKlKZSw6z7zA7BQ8DDsuhwdYZVmVZE=;
        b=OuZcXZb7STmxQZ8zO4uTBS26hKUkmPP9u7T2tXUDFYKKLGTmGDIbLmE/RRWEA5AKCi
         /Hc4RByawQ21fwtNsBXWo/WvUeQh24ZpBUolq3UzkPdeoGROaYSByHDD6NyQjT5bfzHm
         WJQwnuRzVFoyBgtOJxVjT7NhMo6viB8lLU7ubFSve8sqHQbLUEkU87kUCUZGF+nsMon8
         k/sdW7M3rvK0ua0BzTw1qTJX5xUQJjyCI84WaB0+twXUV2yQ/TMmo79pywb8Hw9qj+PZ
         rw/VyB+vrkQKCVMcf2cuiN0p2Vybo64nhgOUPCaf50vAEWhS/aZCItdIWn7fay/1mXxF
         C+bA==
X-Gm-Message-State: AO0yUKVp5+sG9loQz+UcQTA0ulQeLZbwhI+/L3gJFuafggrDyt2EkNF1
        1K+yFnVRqlRrjE1n+c5pwnE=
X-Google-Smtp-Source: AK7set8RmkY/3q/RROCH7gIAnqHIb8K6PQu9HkpUHAHGr7YE+iiORPpS6OC3YT13LvY1kJy37+/N3w==
X-Received: by 2002:a17:903:24f:b0:19c:c8c8:b545 with SMTP id j15-20020a170903024f00b0019cc8c8b545mr4785536plh.50.1677911752853;
        Fri, 03 Mar 2023 22:35:52 -0800 (PST)
Received: from y.ha.lan ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b0019aa6bf4450sm2520938plg.188.2023.03.03.22.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 22:35:52 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] clk: hisilicon: Rename some symbols for Hi3798CV200
Date:   Sat,  4 Mar 2023 14:33:27 +0800
Message-Id: <20230304063333.162309-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304063333.162309-1-mmyangfl@gmail.com>
References: <20230304063333.162309-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols might cause confusion when adding support for other Hi3798
series SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg-hi3798.c | 35 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 9c933172b..b52d44350 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -177,30 +177,31 @@ static void hi3798_sysctrl_clk_unregister(
 
 /* hi3798CV200 */
 
-static const char *const mmc_mux_p[] = {
+static const char *const hi3798cv200_mmc_mux_p[] = {
 		"100m", "50m", "25m", "200m", "150m" };
-static u32 mmc_mux_table[] = {0, 1, 2, 3, 6};
+static u32 hi3798cv200_mmc_mux_table[] = {0, 1, 2, 3, 6};
 
-static const char *const comphy_mux_p[] = {
+static const char *const hi3798cv200_comphy_mux_p[] = {
 		"100m", "25m"};
-static u32 comphy_mux_table[] = {2, 3};
+static u32 hi3798cv200_comphy_mux_table[] = {2, 3};
 
-static const char *const sdio_mux_p[] = {
+static const char *const hi3798cv200_sdio_mux_p[] = {
 		"100m", "50m", "150m", "166p5m" };
-static u32 sdio_mux_table[] = {0, 1, 2, 3};
+static u32 hi3798cv200_sdio_mux_table[] = {0, 1, 2, 3};
 
 static struct hisi_mux_clock hi3798cv200_mux_clks[] = {
-	{ HI3798_MMC_MUX, "mmc_mux", mmc_mux_p, ARRAY_SIZE(mmc_mux_p),
-		CLK_SET_RATE_PARENT, 0xa0, 8, 3, 0, mmc_mux_table, },
-	{ HI3798_COMBPHY0_MUX, "combphy0_mux",
-		comphy_mux_p, ARRAY_SIZE(comphy_mux_p),
-		CLK_SET_RATE_PARENT, 0x188, 2, 2, 0, comphy_mux_table, },
-	{ HI3798_COMBPHY1_MUX, "combphy1_mux",
-		comphy_mux_p, ARRAY_SIZE(comphy_mux_p),
-		CLK_SET_RATE_PARENT, 0x188, 10, 2, 0, comphy_mux_table, },
-	{ HI3798_SDIO0_MUX, "sdio0_mux", sdio_mux_p,
-		ARRAY_SIZE(sdio_mux_p), CLK_SET_RATE_PARENT,
-		0x9c, 8, 2, 0, sdio_mux_table, },
+	{ HI3798_MMC_MUX, "mmc_mux", hi3798cv200_mmc_mux_p,
+		ARRAY_SIZE(hi3798cv200_mmc_mux_p), CLK_SET_RATE_PARENT,
+		0xa0, 8, 3, 0, hi3798cv200_mmc_mux_table, },
+	{ HI3798_COMBPHY0_MUX, "combphy0_mux", hi3798cv200_comphy_mux_p,
+		ARRAY_SIZE(hi3798cv200_comphy_mux_p), CLK_SET_RATE_PARENT,
+		0x188, 2, 2, 0, hi3798cv200_comphy_mux_table, },
+	{ HI3798_COMBPHY1_MUX, "combphy1_mux", hi3798cv200_comphy_mux_p,
+		ARRAY_SIZE(hi3798cv200_comphy_mux_p), CLK_SET_RATE_PARENT,
+		0x188, 10, 2, 0, hi3798cv200_comphy_mux_table, },
+	{ HI3798_SDIO0_MUX, "sdio0_mux", hi3798cv200_sdio_mux_p,
+		ARRAY_SIZE(hi3798cv200_sdio_mux_p), CLK_SET_RATE_PARENT,
+		0x9c, 8, 2, 0, hi3798cv200_sdio_mux_table, },
 };
 
 static u32 mmc_phase_regvals[] = {0, 1, 2, 3, 4, 5, 6, 7};
-- 
2.39.2

