Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC066FD129
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjEIVX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbjEIVWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2738A51;
        Tue,  9 May 2023 14:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D854634F7;
        Tue,  9 May 2023 21:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2733DC433A8;
        Tue,  9 May 2023 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667248;
        bh=Oi+gQzDH22UxfWh2JyqJkOQEmh0VRe7t9VVL4UTI+PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwNrdWrdcjF+H9n6b3l4gUmwdO2DKMhz2B7x83ytiTU1UIx3pcK80hDCYZWpRE1ZJ
         jwaM1RzXSr1/xVYtVIkm4ui8CG6WxFElrQ6hnWNikuPCeUUBEndAdtoNlQK+RILTd5
         mPwC/6BIzuQIsuhtw0ffKgrvnhgVMU0/rQ/ycxZeG4bIHVF3zgGjWnDYRSKAUDsLwl
         dKS4H+/D2KadHBhXYVc4lU/Ed3c/hDO+PSwUw8nPFGPkSgjoaXcoLuUc6NhjvQOzz9
         syB3eeQNrJjcFmA//KQN5ZijWNvF4tjZ4oUicBhpzXpoAH1XZiXWN9hdhrbJxVerg2
         IEAhKx0iJ5VDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/5] clk: tegra20: fix gcc-7 constant overflow warning
Date:   Tue,  9 May 2023 17:20:39 -0400
Message-Id: <20230509212044.22294-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212044.22294-1-sashal@kernel.org>
References: <20230509212044.22294-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b4a2adbf3586efa12fe78b9dec047423e01f3010 ]

Older gcc versions get confused by comparing a u32 value to a negative
constant in a switch()/case block:

drivers/clk/tegra/clk-tegra20.c: In function 'tegra20_clk_measure_input_freq':
drivers/clk/tegra/clk-tegra20.c:581:2: error: case label does not reduce to an integer constant
  case OSC_CTRL_OSC_FREQ_12MHZ:
  ^~~~
drivers/clk/tegra/clk-tegra20.c:593:2: error: case label does not reduce to an integer constant
  case OSC_CTRL_OSC_FREQ_26MHZ:

Make the constants unsigned instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230227085914.2560984-1-arnd@kernel.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-tegra20.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index d60ee6e318a55..fb1da5d63f4b2 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -18,24 +18,24 @@
 #define MISC_CLK_ENB 0x48
 
 #define OSC_CTRL 0x50
-#define OSC_CTRL_OSC_FREQ_MASK (3<<30)
-#define OSC_CTRL_OSC_FREQ_13MHZ (0<<30)
-#define OSC_CTRL_OSC_FREQ_19_2MHZ (1<<30)
-#define OSC_CTRL_OSC_FREQ_12MHZ (2<<30)
-#define OSC_CTRL_OSC_FREQ_26MHZ (3<<30)
-#define OSC_CTRL_MASK (0x3f2 | OSC_CTRL_OSC_FREQ_MASK)
-
-#define OSC_CTRL_PLL_REF_DIV_MASK (3<<28)
-#define OSC_CTRL_PLL_REF_DIV_1		(0<<28)
-#define OSC_CTRL_PLL_REF_DIV_2		(1<<28)
-#define OSC_CTRL_PLL_REF_DIV_4		(2<<28)
+#define OSC_CTRL_OSC_FREQ_MASK (3u<<30)
+#define OSC_CTRL_OSC_FREQ_13MHZ (0u<<30)
+#define OSC_CTRL_OSC_FREQ_19_2MHZ (1u<<30)
+#define OSC_CTRL_OSC_FREQ_12MHZ (2u<<30)
+#define OSC_CTRL_OSC_FREQ_26MHZ (3u<<30)
+#define OSC_CTRL_MASK (0x3f2u | OSC_CTRL_OSC_FREQ_MASK)
+
+#define OSC_CTRL_PLL_REF_DIV_MASK	(3u<<28)
+#define OSC_CTRL_PLL_REF_DIV_1		(0u<<28)
+#define OSC_CTRL_PLL_REF_DIV_2		(1u<<28)
+#define OSC_CTRL_PLL_REF_DIV_4		(2u<<28)
 
 #define OSC_FREQ_DET 0x58
-#define OSC_FREQ_DET_TRIG (1<<31)
+#define OSC_FREQ_DET_TRIG (1u<<31)
 
 #define OSC_FREQ_DET_STATUS 0x5c
-#define OSC_FREQ_DET_BUSY (1<<31)
-#define OSC_FREQ_DET_CNT_MASK 0xFFFF
+#define OSC_FREQ_DET_BUSYu (1<<31)
+#define OSC_FREQ_DET_CNT_MASK 0xFFFFu
 
 #define TEGRA20_CLK_PERIPH_BANKS	3
 
-- 
2.39.2

