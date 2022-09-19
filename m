Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B95BCC00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiISMjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiISMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:39:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEE2E9D7;
        Mon, 19 Sep 2022 05:39:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso4024621wma.0;
        Mon, 19 Sep 2022 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7UJTc+Y+zTE8URG+9ucJLFfFyaDYsCOkEYM0zdT7dz4=;
        b=AcezqpbLZNagmi9U3AME7SFRiaGBkS0FJnzX00jzJbB61oD18MbQLdCaM7dtEcXsOR
         cxf3bef3XFbZ/H8BF7VljbeTpcTxHQWkS6fTVNkdQol2K6wS6t4uLn2MwBPTzSTQZ7n3
         0qqfmYir8z1uZHH27ZTwCTi1bATKFfIqe3Sipke3G6E/EbcQGSvfxhdEYg8SUbo4FIfp
         sXSg6mO1A3X1Z+tPmAcj0DgoG3FrSaXSsxFOVj4ZWKHQ7bVDXTP3ja5yoDBajhituq3q
         XRqnsJWz5766MXLKUwn12lHjwlhv2i1ZYhyu+dJMHYVjDgZ6NQ1mwxJxxhxh3lumBhRO
         Jyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7UJTc+Y+zTE8URG+9ucJLFfFyaDYsCOkEYM0zdT7dz4=;
        b=JUhbpANjKICDSAP4x7PQOeWHQPVaEvKRKBnRw8GOR6i343pz8l8BvXpKJUm6K5NGFk
         aMgmsmH1fMTYNaIgutn+UnHiDmK2dYKP+fpj37Fl4KYisM2y39czXYfHSfbJocRXmQfh
         7LjDh50alcZQT8NHrzrvTskp8Lw5oMl1MqMEc68w+MShT6jbmjKsQ1GZQE/6fGFnyBwR
         DHF8XAwMBtLwq2npp3HjOKi9GmUGYhiuJ0sHPNgpIy9mARz9M6PtAOMRc5Lzwki/vmWK
         NGrBcbJNLMpHJg9oIYEIO1Wi8spNWDoJUzW8Du/fXd8iyXNS8NB4YwHnsGqv6yTLQnje
         Wysg==
X-Gm-Message-State: ACgBeo20G8e+MErBRpO0H4JMNTtpnS2NlhyONAIAgsSmvpc5sw+dxO4F
        0+FlPTDE83XEgF1PJvWI6zikazJMMgtXdA==
X-Google-Smtp-Source: AA6agR6RTFCipdAEF0bxDh258rmk4T8vHFivtl623nsWm11V1DaKCW+3ay50YwguQJe/F5u1MVZdTg==
X-Received: by 2002:a05:600c:3845:b0:3b4:b187:3d09 with SMTP id s5-20020a05600c384500b003b4b1873d09mr13852619wmr.96.1663591142300;
        Mon, 19 Sep 2022 05:39:02 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id v13-20020adfebcd000000b0022a403954c3sm14071514wrn.42.2022.09.19.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:39:01 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] clk: renesas: r9a07g043: Hide WDT2 clock and reset entries for RZ/Five
Date:   Mon, 19 Sep 2022 13:38:53 +0100
Message-Id: <20220919123853.157883-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Move the WDT2 clock and reset entries under CONFIG_ARM64 so that its only
visible for RZ/G2UL (ARM64) SoC as the RZ/Five (RISC-V) SoC doesn't have
the WDT2 channel.

While at it, add the WDT2 clocks to r9a07g043_crit_mod_clks[] list as WDT
CH2 is specifically to check the operation of Cortex-M33 CPU on the RZ/G2UL
SoC and we dont want to turn off the clocks of WDT2 if it isn't enabled by
Cortex-A55.

Fixes: 95d48d270305 ("clk: renesas: r9a07g043: Add support for RZ/Five SoC")
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1 -> v2
* Moved the entries in existing section of ARM64
* Updated the commit message
---
 drivers/clk/renesas/r9a07g043-cpg.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 37475465100d..e4f7f6ade427 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -137,6 +137,10 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x518, 0),
 	DEF_MOD("ia55_clk",	R9A07G043_IA55_CLK, R9A07G043_CLK_P1,
 				0x518, 1),
+	DEF_MOD("wdt2_pclk",	R9A07G043_WDT2_PCLK, R9A07G043_CLK_P0,
+				0x548, 4),
+	DEF_MOD("wdt2_clk",	R9A07G043_WDT2_CLK, R9A07G043_OSCCLK,
+				0x548, 5),
 #endif
 #ifdef CONFIG_RISCV
 	DEF_MOD("iax45_pclk",	R9A07G043_IAX45_PCLK, R9A07G043_CLK_P2,
@@ -158,10 +162,6 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x548, 0),
 	DEF_MOD("wdt0_clk",	R9A07G043_WDT0_CLK, R9A07G043_OSCCLK,
 				0x548, 1),
-	DEF_MOD("wdt2_pclk",	R9A07G043_WDT2_PCLK, R9A07G043_CLK_P0,
-				0x548, 4),
-	DEF_MOD("wdt2_clk",	R9A07G043_WDT2_CLK, R9A07G043_OSCCLK,
-				0x548, 5),
 	DEF_MOD("spi_clk2",	R9A07G043_SPI_CLK2, R9A07G043_CLK_SPI1,
 				0x550, 0),
 	DEF_MOD("spi_clk",	R9A07G043_SPI_CLK, R9A07G043_CLK_SPI0,
@@ -259,6 +259,7 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A07G043_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A07G043_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A07G043_WDT2_PRESETN, 0x848, 2),
 #endif
 #ifdef CONFIG_RISCV
 	DEF_RST(R9A07G043_IAX45_RESETN, 0x818, 0),
@@ -269,7 +270,6 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_OSTM1_PRESETZ, 0x834, 1),
 	DEF_RST(R9A07G043_OSTM2_PRESETZ, 0x834, 2),
 	DEF_RST(R9A07G043_WDT0_PRESETN, 0x848, 0),
-	DEF_RST(R9A07G043_WDT2_PRESETN, 0x848, 2),
 	DEF_RST(R9A07G043_SPI_RST, 0x850, 0),
 	DEF_RST(R9A07G043_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A07G043_SDHI1_IXRST, 0x854, 1),
@@ -311,6 +311,8 @@ static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
 #ifdef CONFIG_ARM64
 	MOD_CLK_BASE + R9A07G043_GIC600_GICCLK,
 	MOD_CLK_BASE + R9A07G043_IA55_CLK,
+	MOD_CLK_BASE + R9A07G043_WDT2_PCLK,
+	MOD_CLK_BASE + R9A07G043_WDT2_CLK,
 #endif
 #ifdef CONFIG_RISCV
 	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
-- 
2.25.1

